package com.app.common.svn.servlet;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.common.svn.util.SVNUtil;

public class DownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String url = SVNServlet.url;
	private static String path = SVNServlet.path;
//	beans/asrAlertExclusion/AsrAlertExclusionBean.java
	private String contentType = "application/x-msdownload";
	private String enc = "utf-8";
	private String fileRoot = "";

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		int version = new Integer(request.getParameter("revision"));
		String filename = request.getParameter("name");
		String subFilePath = request.getParameter("url");
		String usrName = "jiangpeng";
		String password = "abc123";
		SVNUtil svnUtil = new SVNUtil(url, usrName, password);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		if (svnUtil.login()) {
			svnUtil.getFile(version, subFilePath, baos);
		}
		response.reset();
		response.setContentType(contentType);
		response.addHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
		ServletOutputStream servletOS = response.getOutputStream();
		baos.writeTo(servletOS);
		servletOS.flush();
		servletOS.close();

	}

	public static void main(String[] args) throws Exception {

		String usrName = "jiangpeng";
		String password = "abc123";
		SVNUtil svnUtil = new SVNUtil(url, usrName, password);
		if (svnUtil.login()) {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			svnUtil.getFile(1, path, baos);
		} else {
			System.out.println("验证失败");
		}
	}
}
