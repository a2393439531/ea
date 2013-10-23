package com.app.manager.common.file.action;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.manager.common.base.action.BaseEaAction;
import com.app.manager.ea.api.InfEa;
import com.app.manager.ea.model.Organize;
import com.app.manager.ea.model.Resource;
import com.app.manager.ea.model.User;
import com.common.spring.ssh.model.BaseModel;

import com.common.time.TimeUtil;
import com.opensymphony.xwork2.ActionContext;

@Component("fileAction")
public class FileAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(FileAction.class);
	public User user = new User();
	public String execute() throws Exception {
    	return "success";
	}
	
	public String image_upload() throws Exception {
		String id = getpara("id");
		String beanname = getpara("beanname");
		BaseModel baseModel = (BaseModel) baseDao.loadById(beanname,
				Long.parseLong(id));
		if(getpara("op").equals("w")){
			InputStream is = new FileInputStream(file);
			String fileName = this.getFileFileName();
			String imagefilename = TimeUtil.getTimeStr("yyyyMMddhhmmssSSS")
						+ fileName.substring(fileName.lastIndexOf("."));
			File deskFile = new File(getWebroot() + "/file/photo/", imagefilename);
			OutputStream os = new FileOutputStream(deskFile);
			byte[] bytefer = new byte[1024];
			int length = 0;
			while ((length = is.read(bytefer)) != -1) {
				os.write(bytefer, 0, length);
			}
			os.close();
			is.close();
			rhs.put("imgfilename", BeanUtils.getProperty(baseModel, "imgfilename"));
			BeanUtils.setProperty(baseModel, getpara("propertyname"), imagefilename);
			baseDao.update(baseModel);
			rhs.put("beanname", beanname);
			rhs.put("propertyname", getpara("propertyname"));
						
		}else{
			rhs.put("propertyname", getpara("propertyname"));
			rhs.put("beanname", getpara("beanname"));
			
		}	
		rhs.put("object", baseModel);
		rhs.put("op", "w");
		return "success";
	}	
		
		
	public String regedit() throws Exception {
		User who = (User) infEa.getUserbyAccount(getCurrentAccount());
		List<Organize> organizelist = infEa
				.getOrganizeByOrganizegroupAlias("tech");
		rhs.put("organizelist", organizelist);
		return "success";
	}

	public String regeditSave() throws Exception {
		User who = (User) infEa.getUserbyAccount(user.getAccount());
		String imagefilename = who.getImgfilename();
		user.setRoles(who.getRoles());
		user.setResources(who.getResources());
		try {
			String filepath = System.getProperty("webroot",
					"./src/main/webapp/");
			InputStream is = new FileInputStream(file);
			String fileName = this.getFileFileName();

			imagefilename = who.getAccount()
					+ fileName.substring(fileName.lastIndexOf("."));
			File deskFile = new File(filepath + "file/photo/", imagefilename);
			OutputStream os = new FileOutputStream(deskFile);
			byte[] bytefer = new byte[1024];
			int length = 0;
			while ((length = is.read(bytefer)) != -1) {
				os.write(bytefer, 0, length);
			}
			os.close();
			is.close();

		} catch (Exception e) {
			log.debug(e.toString());
		}

		BeanUtils.copyProperties(who, user);
		who.setImgfilename(imagefilename);
		infEa.updateOjbect(who);
		rhs.put("user", who);

		putSessionValue("userlogined", user);
		// return "regedit";
		return "success";
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}	

}
