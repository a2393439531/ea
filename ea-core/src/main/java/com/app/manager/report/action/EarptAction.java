package com.app.manager.report.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.manager.common.base.action.BaseEaAction;
import com.app.manager.ea.hsql.Hsql;
import com.app.manager.ea.model.Organize;
import com.app.manager.ea.model.Organizegroup;
import com.app.manager.ea.model.Role;
import com.app.manager.ea.model.Rolegroup;
import com.app.manager.ea.model.User;


import com.common.cache.Cache;
import com.common.file.FileProcessor;
import com.common.spring.ssh.model.BaseModel;
import com.common.time.TimeUtil;

@Component("earptAction")
public class EarptAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(EarptAction.class);
	
	
	public void common_get_user_info(List userList) {
		for (Iterator iterator = userList.iterator(); iterator.hasNext();) {
			User user = (User) iterator.next();
			user.setAllrolegroup("");
			user.setAllrole("");
			try {
				String companyname = "";
				companyname = infEa.getUserFirestOrgNameByOrgGroup(
						user.getId(), "company").getName();
				user.setCompanyname(companyname);
			} catch (Exception e) {
				user.setCompanyname("未分配公司");
			}
			try {
				String teamname = "";
				Organize org=infEa.getOrganzieOfUserByOrganizeGroupAlias(
						user.getId(), "team");
				teamname = org.getName();
				user.setTeamname(teamname);
				user.setGroupname(org.getParentModel().getName());
			} catch (Exception e) {
				user.setTeamname("");
				user.setGroupname("");
			}

			String techname="";
			try {
				for (Iterator iterator2 = user.getRoles().iterator(); iterator2
						.hasNext();) {
					Role role = (Role) iterator2.next();
					if(role.getAlias()!=null){
						user.setAllrole(user.getAllrole()+"-"+role.getAlias());
					}
					for (Iterator iterator3 = role.getOrganizes().iterator(); iterator3
							.hasNext();) {
						Organize organize = (Organize) iterator3.next();
						if(organize.getParentModel()!=null&&organize.getParentModel().getAlias()!=null){
							if(organize.getParentModel().getAlias().equalsIgnoreCase("tech")){
								techname=techname+role.getName()+";";
							}
						}
					}
					for (Iterator iterator3 = role.getRolegroups().iterator(); iterator3
							.hasNext();) {
						Rolegroup rolegroup = (Rolegroup) iterator3.next();
						if(rolegroup.getAlias()!=null){
							user.setAllrolegroup(user.getAllrolegroup()+"-"+rolegroup.getAlias());
						}
					}
						
				}
				
			} catch (Exception e) {
				System.out.println("异常用户："+user.getName()+e.toString());
			
			}		
			user.setTechname(techname);
			/*
			try {
				String techname = "";
				techname = infEa.getOrganzieOfUserByOrganizeGroupAlias(
						user.getId(), "tech").getName();
				user.setTechname(techname);
			} catch (Exception e) {
				user.setTechname("未分配技术领域");
			}
			*/
			continue;
		}
	}

	public String report_user_check() throws Exception {
		List userList = baseDao.find(Hsql.All_USER);
		common_get_user_info(userList);
		rhs.put("userList", userList);
		return "success";
	}
	public String birt_user() throws Exception {
	
		List userList = (List)Cache.get("userlist");
		
		if (userList == null) {
			userList = baseDao.find(Hsql.All_USER);
			common_get_user_info(userList);
			Cache.set("userlist", userList, "8h"); // 放入缓存
		}
		if (getpara("show").equals("")) {
			putSessionValue("show", "none");
		} else {
			putSessionValue("show",  getpara("show"));
		}		
		rhs.put("dataList", userList);
		return "success";
	}
	
	public String assessment() throws Exception {
		
		birt_user();
		return "success";
	}

	public String tech_member() throws Exception {
		List organizeRootList = infEa.getOrganizeRootNods();
		Organize organize=(Organize)infEa.getOrganizeByAlias("tech");
		rhs.put("system_para_map", 	infEa.getParaMap());   
		rhs.put("organizeRootList", organize.getChildOrganizes());
		rhs.put("userList", infEa.getAllUser());
		return "success";
	}	
	

	public String ipm() throws Exception {
		List hrworkshopList = baseDao.find("from Hrworkshop");
		rhs.put("workshopList", hrworkshopList);
		rhs.put("organizeRootList",infEa.getOrganizeRootNods());
		if (getpara("show").equals("")) {
			putSessionValue("show", "");
		} else {
			putSessionValue("show",  "report");
		}		
		return "success";
	}	
	
	
}
