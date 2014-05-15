package com.app.common.svn.servlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.app.common.svn.util.SVNUtil;

public class CommitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String url = SVNServlet.url;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		ByteArrayOutputStream swapStream = new ByteArrayOutputStream(); 
		String filePath = null;
		String fileName = null;
		try {
			
			List<FileItem> items = upload.parseRequest(request);
			for (FileItem item : items) {
				if (!item.isFormField()) {
					String name = item.getName();
					fileName = name.substring(name.lastIndexOf("\\") + 1, name.length());
					InputStream in = item.getInputStream();
					String str;
					byte[] buffer = new byte[4096];
					int len;
					while ((len = in.read(buffer)) > 0) {
						swapStream.write(buffer, 0, len);
					}
				} else {
					String name = item.getFieldName();
					if (("url").equals(name)) {
						filePath = item.getString("UTF-8");
						System.out.println("filePath : " + filePath);
					}

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		String usrName = "jiangpeng";
		String password = "abc123";
		SVNUtil svnUtil = new SVNUtil(url, usrName, password);
		if (svnUtil.login()) {
			svnUtil.commit(filePath + "/" + fileName, swapStream.toByteArray());
		} else {
			System.out.println("验证失败");
		}
		
		response.sendRedirect("/svnkit");

	}

	public static void main(String[] args) throws Exception {

		String usrName = "jiangpeng";
		String password = "abc123";
		String filePath = "beans/ia";
		String fileName = "webfile.txt";
		SVNUtil svnUtil = new SVNUtil(url, usrName, password);
		if (svnUtil.login()) {
			svnUtil.commit(filePath + "/" + fileName, "This is a new file".getBytes());
		} else {
			System.out.println("验证失败");
		}
	}
}
