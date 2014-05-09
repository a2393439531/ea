package com.app.common.edit.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.common.spring.ssh.model.BaseModel;

@Component("editAction")
public class editAction extends BaseEaAction {

	private final Logger log = LoggerFactory.getLogger(editAction.class);

	public String edit_bean_property() throws IllegalAccessException,
			InvocationTargetException, NoSuchMethodException {
		System.out.println("");
		String op = getpara("op");
		String id = getpara("id");
		String objectname = getpara("objectname"); // 对象名'
		String propertyname = getpara("propertyname"); // 对象名'

		String content = java.net.URLDecoder.decode(getpara("content"));
		BaseModel object = (BaseModel) baseDao.loadById(objectname,
				Long.parseLong(id));
		if (op.equals("r")) {
			content = BeanUtils.getProperty(object, propertyname);
		}

		if (op.equals("w")) {
			try {
				BeanUtils.setProperty(object, propertyname, content);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
			baseDao.update((BaseModel) object);
		}
		rhs.put("content", content);

		rhs.put("objectname", objectname);
		rhs.put("propertyname", propertyname);
		rhs.put("id", id);
		rhs.put("op", op);
		return "success";
	}
	//新增修改配置文件方法
	public String list_file() throws IOException{
		List<File> fileList = new ArrayList<File>();
		String webapppath = ServletActionContext.getServletContext().getRealPath("");
		String resourcepath = webapppath.substring(0, webapppath.lastIndexOf("\\")) + "\\resources\\i18n";
		
		File dir = new File(resourcepath);
		File[] files = dir.listFiles();
		for (File file : files) {
			fileList.add(file);
		}
		
		rhs.put("datalist", fileList);
		return "success";
	}
	public String file_load() throws IOException{
		BufferedReader br = null;
		List<String> datalist = new ArrayList<String>();
		String file = getpara("file");
		String webapppath = ServletActionContext.getServletContext().getRealPath("");
		String resourcepath = webapppath.substring(0, webapppath.lastIndexOf("\\")) + "\\resources\\i18n";
		File conf = new File(resourcepath+ "\\" +file);
		if(conf != null){
			br = new BufferedReader(new InputStreamReader(new FileInputStream(conf)));
		}
		for (String line = br.readLine(); line != null; line = br.readLine()) {  
            datalist.add(line);  
        }
		rhs.put("datalist", datalist);
		br.close();
		return "success";
	}
	public String file_save() throws IOException{
		String conten = getpara("file_content");
		
		
		list_file();
		return "success";
	}
}
