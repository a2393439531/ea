package com.app.webservice.upload;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ConcurrentMap;

import org.activiti.rest.common.api.SecuredResource;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.eclipse.jetty.webapp.WebAppContext;
import org.eclipse.jetty.webapp.WebAppContext.Context;
import org.restlet.data.MediaType;
import org.restlet.ext.fileupload.RestletFileUpload;
import org.restlet.representation.Representation;
import org.restlet.representation.StringRepresentation;
import org.restlet.resource.Get;
import org.restlet.resource.Post;

public class UploadResource extends SecuredResource {
	private String newFileName;
	@Get
	public Representation getAllUploadFile(){
		return new StringRepresentation("测试Upload Web Service ----> Get Method!");
	}
	
	@Post
	public Representation uploadFile(Representation entity) {
		if(authenticate() == false) return null;
		if (entity == null
				|| entity.getMediaType() == null
				|| !MediaType.MULTIPART_FORM_DATA.isCompatible(entity
						.getMediaType())) {
			throw new RuntimeException("The request should be of type"
					+ MediaType.MULTIPART_FORM_DATA + ".");
		}

		RestletFileUpload upload = new RestletFileUpload(
				new DiskFileItemFactory());
		List<FileItem> items = null;
		try {
			items = upload.parseRepresentation(entity);
		} catch (FileUploadException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
		FileItem uploadItem = null;
		if (items != null) {
			for (FileItem fileItem : items) {
				if (fileItem.getName() != null) {
					uploadItem = fileItem;
				}
			}
		}
		if (uploadItem == null) {
			throw new RuntimeException(
					"No file content was found in request body.");
		}

		String fileName = uploadItem.getName();
		String fileType = fileName.substring(fileName.lastIndexOf(".") + 1);

		// 到此住验证完毕，开始读取文件和上传到服务器上 操作对象 uploadItem
		InputStream is;
		try {
			is = uploadItem.getInputStream();
		} catch (IOException e) {
			throw new RuntimeException("Readding file error while upload it.");
		}
		
		ConcurrentMap<String,Object> servletContext = getContext().getAttributes();
		
		Set<String> set = servletContext.keySet();
		Context obj = null;
		
		for (String servlet : set) {
			obj = (Context)servletContext.get(servlet);
		}
		
		String filepath = obj.getRealPath("");
		
		filepath += "/file/" + "webservicefile" + "/";
		newFileName = new Date().getTime() + Math.random() + "." + fileType;
		File deskFile = new File(filepath, newFileName);

		OutputStream os;
		try {
			os = new FileOutputStream(deskFile);
		} catch (FileNotFoundException e) {
			throw new RuntimeException("Writting file error while upload it.",e);
		}
		byte[] bytefer = new byte[1024];
		int length = 0;
		try {
			while ((length = is.read(bytefer)) != -1) {
				try {
					os.write(bytefer, 0, length);
				} catch (IOException e) {
				}
			}
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		try {
			os.close();
			is.close();
		} catch (IOException e) {

		}
		// 结束
		return new StringRepresentation("上传成功");
	}

}
