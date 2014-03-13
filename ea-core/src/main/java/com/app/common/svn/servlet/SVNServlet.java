package com.app.common.svn.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonFactory;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.map.ObjectMapper;

import com.app.common.svn.util.SVNUtil;
public class SVNServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
//	public static String url = "http://113.105.13.195:8980/svn/gsc/project/ehms/fixed/oss/02-task/2012-09285_ASR_Alert_Exclusion/to_hk/src/docroot";
	public static String url = "http://113.105.13.195:8980/svn/gsc/project/manage";
	public static String path = "";
	/**
	 * 将java对象转换为json字符串
	 * 
	 * @param obj
	 *            :可以为map,list,javaBean等
	 * @return json字符串
	 * @createTime 2010-11-23 下午07:42:58
	 */
	public static String object2Json(Object obj) {
		try {
			StringWriter sw = new StringWriter();
			ObjectMapper mapper = new ObjectMapper();
			JsonGenerator gen = new JsonFactory().createJsonGenerator(sw);
			mapper.writeValue(gen, obj);
			gen.close();
			return sw.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Object svns = null;
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String path = request.getParameter("pid");

//		String path = "to_hk";
		String usrName = "jiangpeng";
		String password = "abc123";
		if (path == null) {
			path = "";
		}
		path = new String(path.getBytes("ISO-8859-1"), "UTF-8");
		
		if (path.startsWith("/")){
			path = path.substring(1);
		}
		
		PrintWriter out = response.getWriter();
		SVNUtil svnUtil = new SVNUtil(url, usrName, password);
		if (svnUtil.login()) {
			svns = svnUtil.listEntries(path);
			String json = SVNServlet.object2Json(svns);
			System.out.println(json);
			out.print(json);
		} else {
			out.print("登陆失败！！！");
		}
		out.flush();
		out.close();
	}

	public static void main(String[] args) throws Exception {
		Object svns = null;
		String usrName = "jiangpeng";
		String password = "abc123";
		SVNUtil svnUtil = new SVNUtil(url, usrName, password);
		if (svnUtil.login()) {
			svns = svnUtil.listEntries(path);
			String json = SVNServlet.object2Json(svns);
			System.out.println(json);
		} else {
			System.out.println("验证失败");
		}
	}
}
