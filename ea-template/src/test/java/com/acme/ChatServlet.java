 package com.acme;
 
 import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.app.ea.model.User;
import org.eclipse.jetty.continuation.Continuation;
import org.eclipse.jetty.continuation.ContinuationSupport;
 
 public class ChatServlet extends HttpServlet
 {
   Map<String, Map<String, Member>> _rooms = new HashMap();
 
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     String action = request.getParameter("action");
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
     
     if (action.equals("join"))
       join(request, response, username);
     else if (action.equals("poll"))
       poll(request, response, username);
     else if (action.equals("chat"))
       chat(request, response, username, message);
   }
 
   private synchronized void join(HttpServletRequest request, HttpServletResponse response, String username)
     throws IOException
   {
     Member member = new Member();
     member._name = username;
     Map room = (Map)this._rooms.get(request.getPathInfo());
     if (room == null)
     {
       room = new HashMap();
       this._rooms.put(request.getPathInfo(), room);
     }
     room.put(username, member);
     response.setContentType("text/json;charset=utf-8");
     PrintWriter out = response.getWriter();
     out.print("{action:\"join\"}");
   }
 
   private synchronized void poll(HttpServletRequest request, HttpServletResponse response, String username)
     throws IOException
   {
     Map room = (Map)this._rooms.get(request.getPathInfo());
     if (room == null)
     {
       response.sendError(503);
       return;
     }
     Member member = (Member)room.get(username);
     if (member == null)
     {
       response.sendError(503);
       return;
     }
 
     synchronized (member)
     {
       if (member._queue.size() > 0)
       {
         response.setContentType("text/json;charset=utf-8");
         StringBuilder buf = new StringBuilder();
 
         buf.append("{\"action\":\"poll\",");
         buf.append("\"from\":\"");
         buf.append((String)member._queue.poll());
         buf.append("\",");
 
         String message = (String)member._queue.poll();
         int quote = message.indexOf(34);
         while (quote >= 0)
         {
           message = new StringBuilder().append(message.substring(0, quote)).append('\\').append(message.substring(quote)).toString();
           quote = message.indexOf(34, quote + 2);
         }
         buf.append("\"chat\":\"");
         buf.append(message);
         buf.append("\"}");
         byte[] bytes = buf.toString().getBytes("utf-8");
         response.setContentLength(bytes.length);
         response.getOutputStream().write(bytes);
       }
       else
       {
         Continuation continuation = ContinuationSupport.getContinuation(request);
         if (continuation.isInitial())
         {
           continuation.setTimeout(20000L);
           continuation.suspend();
           member._continuation = continuation;
         }
         else
         {
           response.setContentType("text/json;charset=utf-8");
           PrintWriter out = response.getWriter();
           out.print("{action:\"poll\"}");
         }
       }
     }
   }
 
   private synchronized void chat(HttpServletRequest request, HttpServletResponse response, String username, String message)
     throws IOException
   {
     Map<Object,Member> room = (Map)this._rooms.get(request.getPathInfo());
     if (room != null)
     {
       for (Member m : room.values())
       {
         synchronized (m)
         {
           m._queue.add(username);
           m._queue.add(message);
 
           if (m._continuation != null)
           {
        	   m._continuation.resume();
        	   //m._continuation.complete();
             //m._continuation = null;
           }
         }
       }
     }
 
     response.setContentType("text/json;charset=utf-8");
     PrintWriter out = response.getWriter();
     out.print("{action:\"chat\"}");
   }
 
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
   {
     if (request.getParameter("action") != null)
       doPost(request, response);
     else
       getServletContext().getNamedDispatcher("default").forward(request, response);
   }
 
   class Member
   {
     String _name;
     Continuation _continuation;
     Queue<String> _queue = new LinkedList();
 
     Member()
     {
     }
   }
 }
