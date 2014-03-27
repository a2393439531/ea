package com.acme;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;
import java.util.concurrent.atomic.AtomicReference;

import javax.servlet.AsyncContext;
import javax.servlet.AsyncEvent;
import javax.servlet.AsyncListener;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.eclipse.jetty.util.log.Log;
import org.eclipse.jetty.util.log.Logger;

import com.app.ea.model.User;

public class ChatServlet extends HttpServlet {
	private static final Logger LOG = Log.getLogger(ChatServlet.class);

	private long asyncTimeout = 60000L;

	Map<String, Map<String, Member>> _rooms = new HashMap();

	public void init() {
		String parameter = getServletConfig().getInitParameter("asyncTimeout");
		if (parameter != null)
			this.asyncTimeout = Long.parseLong(parameter);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		boolean join = Boolean.parseBoolean(request.getParameter("join"));
		String message = request.getParameter("message");
		String username = request.getParameter("user");


	     HttpSession session = request.getSession();
	     User u = (User) session.getAttribute("userlogined");
	     String imgPath = "";
	     
	     if("".equals(u.getImgfilename()) || u.getImgfilename() == null ){
	    	 imgPath = "/common/images/face.jpg";
	     }else{
	    	 imgPath = "/file/photo/" + u.getImgfilename();
	     }
	     
	     username = "<img src='"+ request.getContextPath() + imgPath +"' width=50 height=50></img>" + username;
	     
		
		LOG.debug("doPost called. join={},message={},username={}",
				new Object[] { Boolean.valueOf(join), message, username });
		if (username == null) {
			LOG.debug("no paramter user set, sending 503", new Object[0]);
			response.sendError(503, "user==null");
			return;
		}

		Map room = getRoom(request.getPathInfo());
		Member member = getMember(username, room);

		if (message != null) {
			sendMessageToAllMembers(message, username, room);
		}

		if ((message == null) || (join)) {
			synchronized (member) {
				LOG.debug("Queue size: {}", member._queue.size());
				if (member._queue.size() > 0) {
					sendSingleMessage(response, member);
				} else {
					LOG.debug("starting async", new Object[0]);
					AsyncContext async = request.startAsync();
					async.setTimeout(this.asyncTimeout);
					async.addListener(member);
					member._async.set(async);
				}
			}
		}
	}

	private Member getMember(String username, Map<String, Member> room) {
		Member member = (Member) room.get(username);
		if (member == null) {
			LOG.debug("user: {} in room: {} doesn't exist. Creating new user.",
					new Object[] { username, room });
			member = new Member(username);
			room.put(username, member);
		}
		return member;
	}

	private Map<String, Member> getRoom(String path) {
		Map room = (Map) this._rooms.get(path);
		if (room == null) {
			LOG.debug("room: {} doesn't exist. Creating new room.",
					new Object[] { path });
			room = new HashMap();
			this._rooms.put(path, room);
		}
		return room;
	}

	private void sendSingleMessage(HttpServletResponse response, Member member)
			throws IOException {
		response.setContentType("text/json;charset=utf-8");
		StringBuilder buf = new StringBuilder();

		buf.append("{\"from\":\"");
		buf.append((String) member._queue.poll());
		buf.append("\",");

		String returnMessage = (String) member._queue.poll();
		int quote = returnMessage.indexOf(34);
		while (quote >= 0) {
			returnMessage = new StringBuilder()
					.append(returnMessage.substring(0, quote)).append('\\')
					.append(returnMessage.substring(quote)).toString();
			quote = returnMessage.indexOf(34, quote + 2);
		}
		buf.append("\"chat\":\"");
		buf.append(returnMessage);
		buf.append("\"}");
		byte[] bytes = buf.toString().getBytes("utf-8");
		response.setContentLength(bytes.length);
		response.getOutputStream().write(bytes);
	}

	private void sendMessageToAllMembers(String message, String username,
			Map<String, Member> room) {
		LOG.debug("Sending message: {} from: {}", new Object[] { message,
				username });
		for (Member m : room.values()) {
			synchronized (m) {
				m._queue.add(username);
				m._queue.add(message);

				AsyncContext async = (AsyncContext) m._async.get();
				LOG.debug("Async found: {}", new Object[] { async });
				if ((async != null & m._async.compareAndSet(async, null))) {
					LOG.debug("dispatch", new Object[0]);
					async.dispatch();
				}
			}
		}
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("action") != null)
			doPost(request, response);
		else
			getServletContext().getNamedDispatcher("default").forward(request,
					response);
	}

	class Member implements AsyncListener {
		final String _name;
		final AtomicReference<AsyncContext> _async = new AtomicReference();
		final Queue<String> _queue = new LinkedList();

		Member(String name) {
			this._name = name;
		}

		public void onTimeout(AsyncEvent event) throws IOException {
			ChatServlet.LOG.debug("resume request", new Object[0]);
			AsyncContext async = (AsyncContext) this._async.get();
			if ((async != null) && (this._async.compareAndSet(async, null))) {
				HttpServletResponse response = (HttpServletResponse) async
						.getResponse();
				response.setContentType("text/json;charset=utf-8");
				response.getOutputStream()
						.write("{action:\"poll\"}".getBytes());
				async.complete();
			}
		}

		public void onStartAsync(AsyncEvent event) throws IOException {
			event.getAsyncContext().addListener(this);
		}

		public void onError(AsyncEvent event) throws IOException {
		}

		public void onComplete(AsyncEvent event) throws IOException {
		}
	}
}
