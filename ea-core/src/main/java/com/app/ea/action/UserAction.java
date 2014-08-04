package com.app.ea.action;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.common.spring.ssh.model.BaseModel;
import com.app.ea.hsql.Hsql;
import com.app.ea.model.Organize;
import com.app.ea.model.User;
import com.opensymphony.util.BeanUtils;
import com.utils.math.MathUtil;
@Component("userAction")
@Scope("prototype")
@SuppressWarnings("unchecked")
public class UserAction extends BaseEaAction {
	static Logger log = LoggerFactory.getLogger(UserAction.class);
	public User user = new User();

	public String menu_user() throws Exception {
		getPageData(Hsql.All_USER);
		rhs.put("system_para_map", 	infEa.getParaMap());
		return "success";
	}

	public String create() throws Exception {
		//随机生成6位密码。
		String[] num = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a",
				"b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
				"n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y",
				"z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
				"L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W",
				"X", "Y", "Z" };
		StringBuilder sb = new StringBuilder();
		List<Integer> list = MathUtil.generateRmdNum(0, num.length, 6);
		for (Integer i : list) {
			sb.append(num[i]);
		}
		
		infEa.createUser("", sb.toString());
		getPageData(Hsql.All_USER);
		rhs.put("system_para_map", 	infEa.getParaMap());
		return "success";
	}
   /*
	public String regedit() throws Exception {
		User who =(User) infEa.getbaseDao().loadById("User", Long.parseLong(getpara("id")));
		List<Organize> organizelist = infEa
				.getOrganizeByOrganizegroupAlias("tech");
		
		rhs.put("organizelist", organizelist);
		rhs.put("user", who);
		rhs.put("system_para_map", 	infEa.getParaMap());
		return "success";
	}
	*/

	public String resume() throws Exception {
		return profile();

	}	
	public String profile_edit() throws Exception {
		return profile();

	}
	public String profile() throws Exception {
		 User u = null;
		    if(!(getpara("id").equals("")))
		    	 u = (User) infEa.getbaseDao().loadById("User", Long.parseLong(getpara("id")));
		    if(!(getpara("account").equals("")))
		    	 u = (User)  infEa.getUserbyAccount(getpara("account"));
			if(u==null)	
		     u = (User) infEa.getUserbyAccount(getCurrentAccount());
		
	    List<Organize> organizelist = infEa
				.getOrganizeByOrganizegroupAlias("tech");
		rhs.put("organizelist", organizelist);
		rhs.put("user", u);
		return "success";

	}
	public String photo_upload() throws Exception {
		User who =(User) infEa.getbaseDao().loadById("User", Long.parseLong(getpara("id")));
		rhs.put("user", who);
		return "success";
	}
	
	/*
	 * Add by liuhuiping
	 */
	public String list() throws Exception {
		getPageData(Hsql.All_USER);
		return "list";
	}
	
	public String menu_save() throws Exception {
		if (user.getId() == null || user.getId().toString().equals("")) { // create
			baseDao.create(user);
		} 
		return list();
	}

	
	public String link_account() throws Exception {
		User user = (User) baseDao.loadById("User", Long.parseLong(getpara("id")));
		if ("".equals(getpara("parentId"))) {
			user.setParentModel(null);
		}else{
			
			User user_parent = (User) baseDao.loadById("User", Long.parseLong(getpara("parentId")));
			user.setParentModel(user_parent);
		}
			getPageData(Hsql.All_USER);
		return "success";
	}	
	public String load() throws Exception {
		String id = getpara("id");
		if ("".equals(getpara("id"))) {
			rhs.put("user", null);
		} else {
			User user = (User) baseDao.loadById("User", Long.parseLong(id));
			rhs.put("user", user);
		}
		return "success";
	}
	/*
	public String photo_save() throws Exception {
		User who =(User) infEa.getbaseDao().loadById("User", Long.parseLong(getpara("id")));
		String imagefilename = who.getImgfilename();
		try {
			InputStream is = new FileInputStream(file);
			String fileName = this.getFileFileName();
			imagefilename = DateUtil.getTimeStr("yyyyMMddhhmmssSSS")
					+ fileName.substring(fileName.lastIndexOf("."));
			File deskFile = new File(SystemInit.WEB_ROOT + "/file/photo/", imagefilename);
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
		who.setImgfilename(imagefilename);
		baseDao.updateObject(who);
		rhs.put("user", who);
		return "success";
	}	
	
	public String regeditSave() throws Exception {
	
		User who =(User) infEa.getbaseDao().loadById("User", user.getId());
		String imagefilename = who.getImgfilename();
		user.setRoles(who.getRoles());
		user.setResources(who.getResources());
		try {
			InputStream is = new FileInputStream(file);
			String fileName = this.getFileFileName();
			imagefilename = DateUtil.getTimeStr("yyyyMMddhhmmssSSS")
					+ fileName.substring(fileName.lastIndexOf("."));
			File deskFile = new File(SystemInit.WEB_ROOT + "/file/photo/", imagefilename);
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
		baseDao.updateObject(who);
		rhs.put("user", who);
		return "success";
	}
*/
	/*
	public String uploadPhoto() throws Exception {
		User who = (User) infEa.getUserbyAccount(getpara("account"));
		String msg = "";
		try {
			InputStream is = new FileInputStream(file);
			String fileName = this.getFileFileName();
			String saveName = who.getAccount();
			File deskFile = new File(SystemInit.WEB_ROOT  + "/file/photo/", saveName);
			who.setImgfilename(saveName);
			OutputStream os = new FileOutputStream(deskFile);
			byte[] bytefer = new byte[1024];
			int length = 0;
			while ((length = is.read(bytefer)) != -1) {
				os.write(bytefer, 0, length);
			}
			os.close();
			is.close();
			baseDao.update(who);
		} catch (NullPointerException e) {
			msg = "{'StatusCode':'-1','message':'文件上传失败! 失败原因:文件过大'}";
			rhs.put("info", msg);
		} catch (Exception e) {
			msg = "{'StatusCode':'-2','message':'文件上传失败! 失败原因:"
					+ e.getMessage() + "'}";
			rhs.put("info", msg);
		}
		rhs.put("user", who);
		return "success";
	}
	*/
	
	public String regedit_sum() throws Exception {
		List organizeRootList = infEa.getOrganizeRootNods();
		rhs.put("organizeRootList", organizeRootList);
		return "success";
	}

	public String delete() throws Exception {
		User userdata = (User) baseDao.loadById("User", Long.parseLong(getpara("id")));
		if("admin".equals(userdata.getAccount())){
			rhs.put("result", "The admin account can not be deleted!");
			rhs.put("find", true);
		}else{
			infEa.deleteUser(userdata);
			rhs.put("find", false);
			rhs.put("info_type", "success");
			rhs.put("info", "delete success!");	
		}
		getPageData(Hsql.All_USER);
		rhs.put("system_para_map", 	infEa.getParaMap());
		return "success";
	}
	public String update() throws Exception {
		String id = getpara("id");
		String column = getpara("column");
		// String columnValue = getpara("columnValue");
		String columnValue = java.net.URLDecoder.decode(getpara("columnValue"));
		if (column.equals("maxSize")) {
			int pageNum = Integer.parseInt(columnValue);
			if (pageNum != pagination.getMaxSize() && pageNum > 0) {
				pagination.setMaxSize(pageNum);
			}
		} else {
			BaseModel model = (BaseModel) baseDao.loadById(getpara("beanname"),
					Long.parseLong(id));
			//加入对account的唯一性判断和admin的account不能修改
			if(model instanceof User){
				User user = (User)model;
				if("admin".equals(user.getAccount()) && "account".equals(column)){
					rhs.put("result", "The admin account can not be changed!");
					rhs.put("find", true);
					return "success";
				}
			}
			BaseModel existsModel = null;
			if(column.equals("account") || column.equals("email") || column.equals("name") ||column.equals("passwd")){
				if("".equals(columnValue.trim()) || columnValue.trim().length() == 0){
					rhs.put("result", "The "+column+" should not be empty!");
					rhs.put("find", true);
					return "success";
				}
				if(!column.equals("email") && !column.equals("passwd")){
					existsModel = (BaseModel) baseDao.loadByFieldValue(User.class, column, columnValue.trim());
				}
			}
			if(existsModel == null ){
				BeanUtils.setValue(model, column, columnValue);
				rhs.put("find", false);
			}else{
				rhs.put("result", "The " + column + " '"+columnValue.trim() + "' " +" already exists!");
				rhs.put("find", true);
			}
			baseDao.update(model);
		}

		
		rhs.put("info_type", "success");
		rhs.put("info", "update success!");
		getPageData("from User u ");
		return "success";
	
	}
    //修改每页显示的个数
	public String change_page_number() throws Exception {
		putSessionValue("maxSize", getpara("maxSize"));
		getPageData(Hsql.All_USER);
		rhs.put("system_para_map", 	infEa.getParaMap());
		rhs.put("info_type", "success");
		rhs.put("info", "");
		return "success";
	}
     //翻页
	public String ajax_page_data() throws Exception {
		getPageData(Hsql.All_USER);
		rhs.put("info_type", "success");
		rhs.put("info", "success!");
		return "success";
	}
	
	
	public String menu_query_user_resource() throws Exception {
		getPageData(Hsql.All_USER);
		return "success";
	}

	public String ajax_query_user_by_name() {
		String name = getpara("username");
		List list = infEa.getAllResoucesByUserName(name);
		
		rhs.put("name", name);
		rhs.put("list", list);
		return "success";
	}
	
	public String search_by_level() throws Exception {
		
		String hsql = Hsql.All_USER + "where  upper(assessLev) like '%"+ getpara("assessLev")+"%'";
		getPageData(hsql);
		rhs.put("system_para_map", 	infEa.getParaMap());
		rhs.put("info_type", "success");
		rhs.put("info", "");
		return "success";
	}
	public String search_by_status() throws Exception {
		
		String hsql = Hsql.All_USER + "where  nvl(status, 'normal') like '%"+ getpara("status")+"%'  ";
		getPageData(hsql);
		rhs.put("system_para_map", 	infEa.getParaMap());
		rhs.put("info_type", "success");
		rhs.put("info", "");
		return "success";
	}

	
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
