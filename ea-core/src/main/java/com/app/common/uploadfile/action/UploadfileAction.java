package com.app.common.uploadfile.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.common.spring.ssh.model.BaseModel;
import com.app.common.uploadfile.model.Uploadfile;
import com.app.ea.model.User;

@Component("uploadfileAction")
public class UploadfileAction extends BaseEaAction {
	
	private final Logger log = LoggerFactory.getLogger(UploadfileAction.class);
	
	private File[] upload;
    private String[] uploadContentType;
    private String[] uploadFileName;
    
	@SuppressWarnings("unchecked")
	public String iframe_uploadfile(){
	
		String foreignId = getpara("foreignId");
		String folder = getpara("folder");
		if(folder.equals(""))
			folder = "no_name_folder";
		rhs.put("readonly", getpara("readonly"));
		try {
			File[] files = this.getUpload();
			if(files != null && files.length != 0){
				log.debug("create_uploadfile()");
				for(int i = 0; i < files.length; i++){
					File file = files[i];
					
					//String filepath = System.getProperty("webroot", "./src/main/webapp/");
					String filepath =ServletActionContext.getRequest().getRealPath("");
					InputStream is = new FileInputStream(file);
					String fileName = getUploadFileName()[i];
					filepath += "/file/" + folder + "/";
					File fileDir = new File(filepath);
					if (!fileDir.exists())
						FileUtils.forceMkdir(new File(filepath));
					String fileType = fileName.substring(fileName.lastIndexOf(".") + 1);
					String newFileName = new Date().getTime() + Math.random() + "." + fileType;
					File deskFile = new File(filepath, newFileName);
					OutputStream os = new FileOutputStream(deskFile);
					byte[] bytefer = new byte[1024];
					int length = 0;
					while ((length = is.read(bytefer)) != -1) {
						os.write(bytefer, 0, length);
					}
					os.close();
					is.close();
					
					Uploadfile uploadFile = new Uploadfile(fileType, fileName, fileName, foreignId, "file/" + folder + "/"  + newFileName);
					baseDao.create(uploadFile);
				}
			}else{
				log.debug("list_uploadfile()");
			}
		} catch (Exception e) {
			log.debug(e.toString());
		}
		rhs.put("contextPath", ServletActionContext.getRequest().getContextPath() + "/");
		rhs.put("uploadFiles", baseDao.find("from Uploadfile where foreignId='" + foreignId + "'"));
		return "success";
	}
	
	
	public String get_file_list(){
		rhs.put("uploadFiles", baseDao.find("from Uploadfile where foreignId='" + getpara("foreignId") + "'"));
		return "success";
	}
	public String delete_uploadfile(){
		log.debug("delete_uploadfile()");
		try {
			HttpServletResponse resp = ServletActionContext.getResponse();
			Uploadfile uploadfile = (Uploadfile)baseDao.loadById("Uploadfile", Long.parseLong(getpara("primaryId")));
			
			String filepath = System.getProperty("webroot", "./src/main/webapp/");
			filepath += uploadfile.getUrl();
			File file = new File(filepath);
			if(file.exists()){
				file.delete();
			}
			
			baseDao.delete(uploadfile);
			
			PrintWriter out = resp.getWriter();
			out.write("OK");
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public File[] getUpload() {
		return upload;
	}

	public void setUpload(File[] upload) {
		this.upload = upload;
	}

	public String[] getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String[] uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public String[] getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String[] uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	
	//added by xiaoqinghong for mobile 2014-6-24
	public String m_iframe_uploadfile(){
		this.iframe_uploadfile();
		return "success";
	}
	//added by xiaoqinghong for mobile 2014-6-24 end
	
	
	public String uploaddb() throws Exception {
		int len = (int)file.length();
		byte[] data = new byte[len];
		InputStream is = new FileInputStream(file);
		int rlen = is.read(data);
		is.close();
		Uploadfile uf = new Uploadfile();
		uf.setFileType(getFileContentType());
		uf.setContent(data);
		uf.setFileName(getFileFileName());
		baseDao.create(uf);
		return "success";
	}
	
	
	public void show_image() throws Exception {
		String id = getpara("id");
		Uploadfile uf = (Uploadfile)baseDao.loadById(Uploadfile.class, Long.parseLong(id));
		byte[] data = uf.getContent();
		if(data != null){
			ServletActionContext.getResponse().setContentType("image/jpeg");
			ServletActionContext.getResponse().setHeader("Cache-control", "no-cache ");
			ServletActionContext.getResponse().getOutputStream().write(data);
			ServletActionContext.getResponse().getOutputStream().flush();
		}else{
			System.out.println("无图片...");
		}
	}
	
	public void file_download() throws Exception {
		String id = getpara("id");
		Uploadfile uf = (Uploadfile)baseDao.loadById(Uploadfile.class, Long.parseLong(id));
		byte[] data = uf.getContent();
        ServletActionContext.getResponse().reset();
        ServletActionContext.getResponse().setContentType("application/octet-stream;charset=utf-8");
        ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment;filename=" +new String(uf.getFileName().getBytes("utf-8"),"iso8859-1") );
        ServletActionContext.getResponse().setHeader("Content-Length", "" + data.length);
        ServletActionContext.getResponse().getOutputStream().write(data);
        ServletActionContext.getResponse().getOutputStream().flush();
	}
}
