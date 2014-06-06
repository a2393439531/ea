package com.app.common.edit.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.common.i18n.I18n;
import com.app.common.spring.ssh.model.BaseModel;
import com.opensymphony.xwork2.ActionContext;
import com.utils.hardinfo.HardInfo;
import com.utils.path.PathUtils;

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
	public String file_load() throws IOException, ClassNotFoundException{
		BufferedReader br = null;
		List<String> datalist = new ArrayList<String>();
		String filename = getpara("file");
		String resourcepath = PathUtils.getClassPath(PathUtils.SYSTEM_DATA_CLASS) + "/i18n";
		File conf = new File(resourcepath+ "\\" +filename);
		if(conf != null){
			br = new BufferedReader(new InputStreamReader(new FileInputStream(conf)));
		}
		for (String line = br.readLine(); line != null; line = br.readLine()) {  
            datalist.add(line);  
        }
		br.close();
		rhs.put("datalist", datalist);
		return "success";
	}
	public String file_save() throws ClassNotFoundException, Exception{
		String content = getpara("file_content");
		String filename = getpara("file_name");
		String resourcepath = PathUtils.getClassPath(PathUtils.SYSTEM_DATA_CLASS) + "/i18n";
		
		File deskFile = new File(resourcepath, filename);
		OutputStream os = new FileOutputStream(deskFile);
		
		StringBuffer sb = new StringBuffer();
		for (String line : content.split("\n")) {
			sb.append(line + "\n");
		}
		
		os.write(sb.toString().getBytes());
		os.close();
		if(I18n.siteStrMap != null){
			I18n.siteStrMap = I18n.getMapFromePropFile(PathUtils.getClassPath(PathUtils.SYSTEM_DATA_CLASS) + "/i18n","txt");
		}
		list_file();
		return "success";
	}
	
	public String lang() throws Exception {
		// 如果是第一次，langString=first,则根据，问题是，不一定有我们已经有的语言，所以需要一个MAP
		String url = "http:/" + HardInfo.findNonLocalhostIp() + ":"
				+ getRequest().getLocalPort() + getRequest().getContextPath();
		String langString = getpara("lang");
		if (langString.equals("first")) { // 如果不是第一次，认证错误了的话
			HttpServletRequest requestServelt = ServletActionContext
					.getRequest();
			// zh-cn,zh;q=0.5 FIREFOX又有所不同了,IE是zh-cn
			langString = requestServelt.getHeader("Accept-Language").split(",")[0]
					.toLowerCase();
			// 去后台判断是否需要显示
			HashMap languageMap = I18n.getLanguage();
			if (!languageMap.containsKey(langString)) {
				langString = "en";
			}
		}
		// 如果不是第一次，还有用户名密码
		Map sessionMap = ActionContext.getContext().getSession();
		sessionMap.put("lang", langString);
		rhs.put("url", url);
		return "success"; // login.ftl
	}
	
}
