package com.app.manager.ea.action;

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

@Component("eaAction")
public class EaAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(EaAction.class);
	//http://localhost:9090/ea/app/manager/ea_sort.do?object=Organize
	public String sort() throws Exception {
		List olist = baseDao.find(" from  "+getpara("object"));
		for (Iterator iterator = olist.iterator(); iterator
				.hasNext();) {
			Object o = (Object) iterator.next();
			try {
				Long sortNob = Long.parseLong(BeanUtils.getProperty(o, "sortNob"));
				
			} catch (Exception e) {
			    log.debug("sortNob排序字段为空");
				BeanUtils.setProperty(o, "sortNob", BeanUtils.getProperty(o, "id"));
			}	
		  
				String inputtime = BeanUtils.getProperty(o, "inputtime");
			 	if(inputtime==null){
			 		log.debug("createDate字段为空");
			 		BeanUtils.setProperty(o, "inputtime", TimeUtil.getTimeStr("yyyy-MM-dd hh-mm-ss"));
			 	}
						
			log.debug(BeanUtils.getProperty(o, "id")+"."+BeanUtils.getProperty(o, "name")+"."+BeanUtils.getProperty(o, "sortNob")+"."+BeanUtils.getProperty(o, "inputtime"));
			baseDao.update(o);
		}
		olist = baseDao.find(" from  "+getpara("object"));
		rhs.put("olist", olist);		
		return "success";
	}
	public String menuEaInit() {
		List organizeRootList = infEa.getOrganizeRootNods();
		rhs.put("organizeRootList", organizeRootList);
		List roleGroupRootList = infEa.getRolegroupRootNods();
		rhs.put("roleGroupRootList", roleGroupRootList);
		return "menu_ea_init";
	}

	public String menu_relation() {
		List organizeRootList = infEa.getOrganizeRootNods();
		rhs.put("organizeRootList", organizeRootList);
		List roleGroupRootList = infEa.getRolegroupRootNods();
		rhs.put("roleGroupRootList", roleGroupRootList);
		return "success";
	}

	
	public String update() throws Exception {
		try {
			
			common_update();
		} catch (Exception e) {
			rhs.put("info_type", "error");
			rhs.put("info", " 属性更新失败!");
			return "success";
		}
		return "success";
	}	
	
	
	

	
	public String ajax_create_role_in_organize() throws Exception {
		Organize organize = (Organize) baseDao.loadById("Organize",
				Long.parseLong(getpara("organizeId")));
		Rolegroup rolegroup = (Rolegroup) baseDao.loadById("Rolegroup",
				Long.parseLong(getpara("rolegroupId")));
		
	
			Role role = new Role();
			String rolename=organize.getName() + "-" + rolegroup.getName();
			role.setName(rolename);
			role.setAlias(organize.getAlias() + "-" + rolegroup.getAlias());
			role.getOrganizes().add(organize);
			role.getRolegroups().add(rolegroup);
			baseDao.create(role);
		
		rhs.put("info_type", "success");
		rhs.put("info", rolename+":创建成功!");
		return "success";
	}
		
	
	public String ajax_save_new_user_in_role() throws Exception {
		
		User user=new User();
		user.setName(getpara("name"));
		user.setAccount(getpara("account"));
		Role role=(Role)baseDao.loadById("Role",
				Long.parseLong(getpara("roleId")));
		role.getUsers().add(user);
		baseDao.create(user);
		rhs.put("info", user.getName()+ " 添加成功!");
		//load_organize();
		return "success";
	}
	
	public String ajax_bat_create_role() throws Exception {
		String organizeId = getpara("organizeId");
		String rolegroupIdString = getpara("rolegroupIdString");
		log.debug("organizeId=" + organizeId);
		log.debug("rolegroupIdString=" + rolegroupIdString);
		String[] rolegroupId = rolegroupIdString.split("-");
		Organize organize = (Organize) baseDao.loadById("Organize",
				Long.parseLong(organizeId));
		for (int i = 0; i < rolegroupId.length; i++) {
			Rolegroup rolegroup = (Rolegroup) baseDao.loadById("Rolegroup",
					Long.parseLong(rolegroupId[i]));
			log.debug(rolegroup.getName());
			Role role = new Role();
			role.setName(organize.getName() + "-" + rolegroup.getName());
			role.setAlias(organize.getAlias() + "-" + rolegroup.getAlias());
			role.getOrganizes().add(organize);
			role.getRolegroups().add(rolegroup);
			baseDao.create(role);
		}
		rhs.put("info_type", "success");
		rhs.put("info", "'职位'创建成功!");
		ajax_organize_role_list();
		return "success";
	}

	public String delete_role() {
		String roleId = getpara("roleId");
		Role role = (Role) baseDao.loadById("Role", Long.parseLong(roleId));
		role.setOrganizes(null);
		role.setRolegroups(null);
		String organizeId = getpara("organizeId");
		baseDao.update(role);
		baseDao.delete(role);
		Organize organize = (Organize) baseDao.loadById("Organize",
				Long.parseLong(organizeId));
		rhs.put("organize", organize);
		return "success";
	}
	public String change_role_rank() throws Exception {
		common_change_rank(); 
		rhs.put("info_type", "success");
		rhs.put("info", "改变顺序成功!");
		ajax_organize_role_list();
		return "success";
	}            
	public String change_role_delete() throws Exception {
		Role role = (Role) baseDao.loadById("Role",
				Long.parseLong(getpara("id")));
		/*
		Organize organize = (Organize) baseDao.loadById("Organize",
				Long.parseLong(getpara("organizeId")));
		log.debug("是否存在角色："+organize.getRoles().contains(role));
		organize.getRoles().remove(role);
		baseDao.update(organize);
        */
		role.setParentModel(null);
		role.setRolegroups(null);
		role.setUsers(null);
		role.setOrganizes(null);
		baseDao.delete(role);
		rhs.put("info_type", "success");
		rhs.put("info", "删除角色成功!");
		ajax_organize_role_list();
		return "success";
	}	
	
	public String ajax_role_delete() throws Exception {
		Role role = (Role) baseDao.loadById("Role",
				Long.parseLong(getpara("roleId")));
		role.setParentModel(null);
		role.setRolegroups(null);
		role.setUsers(null);
		role.setOrganizes(null);
		baseDao.delete(role);
		rhs.put("info_type", "success");
		rhs.put("info", "删除角色成功!");
		return "success";
	}		
	
	public String change_role_level() throws Exception {
		common_change_level();
		rhs.put("info_type", "success");
		rhs.put("info", "改变层级成功!");
		ajax_organize_role_list();
		return "success";
	}
	public String change_role_update() throws Exception {
		common_update();
		rhs.put("info_type", "success");
		rhs.put("info", "更新成功!");
		ajax_organize_role_list();
		return "success";
	}
	public String ajax_organize_role_list() throws Exception {
		String organizeId = getpara("organizeId");
		Organize organize = (Organize) baseDao.loadById("Organize",
				Long.parseLong(organizeId));
		List roleList=new ArrayList();
		roleList= infEa.getOrganizeRootRoleList(organizeId);
	    rhs.put("roleList", roleList);
	    //rhs.put("roleList", organize.getRoles());
		rhs.put("organize", organize);
		return "success";
	}

	public String menu_person_deploy_by_organize() {
		List organizeRootList = infEa.getOrganizeRootNods();
		rhs.put("organizeRootList", organizeRootList);
		rhs.put("userList", infEa.getAllUser());
		return "success";
	}

	public String menu_person_deploy() {
		List organizeRootList = infEa.getOrganizeRootNods();
		rhs.put("organizeRootList", organizeRootList);
		rhs.put("userList", infEa.getAllUser());
		return "success";
	}

	/*
	 * public String personDeployProject() { List organizeRootList =
	 * infEa.getOrganizeRootNods(); rhs.put("organizeRootList",
	 * organizeRootList); rhs.put("userList", infEa.getAllUser()); return
	 * "menu_person_deploy_project"; }
	 */
	public String ajaxUserToRole() {
		// infEa.roleAddUserById(getpara("roleId"),getpara("userId"));
		rhs.put("role", infEa.userToRole(getpara("roleId"), getpara("userId")));
		return "ajax_user_to_role";
	}
	
	
	public String ajaxOrganizegroupToRole() {
		// infEa.roleAddUserById(getpara("roleId"),getpara("userId"));
		rhs.put("role", infEa.userToRole(getpara("roleId"), getpara("userId")));
		return "ajax_user_to_role";
	}

	public String menu_organize_to_organizegroup() {
		List organizegroupAllList = infEa.getAllOrganizegroup();
		List organizeRootList = infEa.getOrganizeRootNods();
		rhs.put("organizeRootList", organizeRootList);
		rhs.put("organizegroupAllList", organizegroupAllList);
		return "success";
	}

	public String ajax_resource_rolegroup_list() {
		String resourceId = getpara("resourceId");
		com.app.manager.ea.model.Resource resource = (com.app.manager.ea.model.Resource) baseDao
				.loadById("Resource", Long.parseLong(resourceId));
		List roleGroupRootList = infEa.getRolegroupRootNods();
		rhs.put("resource", resource);
		rhs.put("roleGroupRootList", roleGroupRootList);
		rhs.put("rolegroup", resource.getRolegroups());
		return "success";
	}

	public String ajax_resource_role_list() {
		String resourceId = getpara("resourceId");
		List organizeRootList = infEa.getOrganizeRootNods();
		com.app.manager.ea.model.Resource resource = (com.app.manager.ea.model.Resource) baseDao
				.loadById("Resource", Long.parseLong(resourceId));
		rhs.put("resource", resource);
		rhs.put("role", resource.getRoles());
		rhs.put("organizeRootList", organizeRootList);
		return "success";
	}

	public String ajax_resource_user_list() {
		String resourceId = getpara("resourceId");
		List usersList = infEa.getAllUser();
		com.app.manager.ea.model.Resource resource = (com.app.manager.ea.model.Resource) baseDao
				.loadById("Resource", Long.parseLong(resourceId));
		rhs.put("resource", resource);
		rhs.put("usersList", usersList);
		return "success";
	}
	
	public String ajax_role_user_list() {
		String roleId = getpara("roleId");
		List usersList = infEa.getAllUser();
		Role role = (Role) baseDao
				.loadById("Role", Long.parseLong(roleId));
		rhs.put("role", role);
		rhs.put("organizeId", getpara("organizeId"));
		rhs.put("usersList", usersList);
		return "success";
	}	
	

	public String iframe_get_userlist_of_role() {
		String roleId = getpara("roleId");
		Role role = (Role) baseDao.loadById("Role", Long.parseLong(roleId));
		log.debug(role.getName());
		rhs.put("userList", infEa.getAllUser());
		rhs.put("role", role);
		return "success";
	}

	public String iframe_get_rolelist_of_user() throws Exception {
		User user = (User) baseDao.loadById("User", Long.parseLong(getpara("id")));
		rhs.put("user", user);
		//menu_role_view_v();
		rhs.put("rolegroupRootList", common_get_tree_root("Rolegroup"));
		return "success";
	}	
	
	public String create_resource_rolegroup_relation() {

		String resourceId = getpara("resourceId");
		String rolegroupId = getpara("rolegroupId");
		com.app.manager.ea.model.Resource resource = (com.app.manager.ea.model.Resource) baseDao
				.loadById("Resource", Long.parseLong(resourceId));
		Rolegroup rolegroup = (Rolegroup) baseDao.loadById("Rolegroup",
				Long.parseLong(rolegroupId));
		if (rolegroup.getResources().contains(resource)) {
			rolegroup.getResources().remove(resource);
		} else {
			rolegroup.getResources().add(
					(com.app.manager.ea.model.Resource) resource);
		}
		baseDao.update(rolegroup);
		return "success";
	}

	public String create_resource_role_relation() {

		String resourceId = getpara("resourceId");
		String roleId = getpara("roleId");
		com.app.manager.ea.model.Resource resource = (com.app.manager.ea.model.Resource) baseDao
				.loadById("Resource", Long.parseLong(resourceId));
		Role role = (Role) baseDao.loadById("Role", Long.parseLong(roleId));
		if (role.getResources().contains(resource)) {
			role.getResources().remove(resource);
		} else {
			role.getResources().add(
					(com.app.manager.ea.model.Resource) resource);
		}
		baseDao.update(role);
		return "success";
	}

	public String create_user_role_relation() {
		infEa.putUserToRole(getpara("userId"), getpara("roleId"));

		return "success";
	}

	public String create_resource_user_relation() {

		String userId = getpara("userId");
		String resourceId = getpara("resourceId");
		com.app.manager.ea.model.Resource resource = (com.app.manager.ea.model.Resource) baseDao
				.loadById("Resource", Long.parseLong(resourceId));
		User user = (User) baseDao.loadById("User", Long.parseLong(userId));

		if (resource.getUsers().contains(user)) {
			resource.getUsers().remove(user);
		} else {
			resource.getUsers().add(user);
		}
		baseDao.update(resource);
		return "success";
	}

	public String ajax_put_organize_to_organizegroup() {

		String organizegroupId = getpara("organizegroupId");
		String organizeId = getpara("organizeId");
		Organize organize = (Organize) baseDao.loadById("Organize",
				Long.parseLong(organizeId));
		Organizegroup organizegroup = (Organizegroup) baseDao.loadById(
				"Organizegroup", Long.parseLong(organizegroupId));
		infEa.putOrganizeToOrganizegroup(organize, organizegroup);
		List organizegroupAllList = infEa.getAllOrganizegroup();
		List organizeRootList = infEa.getOrganizeRootNods();
		rhs.put("organizeRootList", organizeRootList);
		rhs.put("organizegroupAllList", organizegroupAllList);

		return "success";
	}

	public String update_organize_role_list() {
		String id = getpara("id");
		String column = getpara("column");
		String columnValue = getpara("columnValue");
		Role role = (Role) baseDao.loadById("Role", Long.parseLong(id));
		if (column.equals("name")) {
			role.setName(columnValue);
		}
		if (column.equals("alias")) {
			role.setAlias(columnValue);
		}
		baseDao.update(role);
		return "success";
	}
    
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
	public String report_birt_user() throws Exception {
	
		List userList = (List)Cache.get("userlist");
		 userList =null;
		if (userList == null) {
			userList = baseDao.find(Hsql.All_USER);
			common_get_user_info(userList);
			Cache.set("userlist", userList, "8h"); // 放入缓存
		}
		
		rhs.put("dataList", userList);
		return "success";
	}
	
	public String clean() throws Exception {
		Cache.delete("userlist");
		return "success";
	}
	public String report_assement() throws Exception {
		
		report_birt_user();
		return "success";
	}

	public String report_tech_member() throws Exception {
		List organizeRootList = infEa.getOrganizeRootNods();
		Organize organize=(Organize)infEa.getOrganizeByAlias("tech");
		rhs.put("system_para_map", 	infEa.getParaMap());   
		rhs.put("organizeRootList", organize.getChildOrganizes());
		rhs.put("userList", infEa.getAllUser());
		return "success";
	}
	public String menu_query_inf() {
		return "success";
	}

	public String ajax_query_resource() {
		String name = getpara("username");
		User user = (User) baseDao.loadByFieldValue(User.class, "name", name);
		List list = infEa.getAllResoucesByUserName(name);
		rhs.put("user", user);
		rhs.put("list", list);
		return "success";

	}

	
	// 放在public，主要是不好调试，反正看职责，是要结合2个看的 ,再写入人的任务
	public String edit_bean_property() throws IllegalAccessException,
			InvocationTargetException, NoSuchMethodException {
		System.out.println("");
		String op = getpara("op");
		String id = getpara("id");
		String objectname = getpara("objectname"); // 对象名'
		String propertyname = getpara("propertyname"); // 对象名'
		String content = getpara("content");
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
	
	
	
	
	
	// view 
	
	public String menu_position_define() {
		List roleGroupRootList = baseDao
				.find(" from Rolegroup where parent_id = null");
		rhs.put("roleGroupRootList", roleGroupRootList);
		return "success";

	}

	public String menu_position_view() {
		List roleGroupRootList = baseDao
				.find(" from Rolegroup where parent_id = null");
		rhs.put("roleGroupRootList", roleGroupRootList);
		return "success";

	}

	public String menu_role_view() {
		List roleGroupRootList = baseDao
				.find(" from Rolegroup where parent_id = null");
		rhs.put("roleGroupRootList", roleGroupRootList);
		return "success";

	}

	public String menu_role_define() {
		List roleGroupRootList = baseDao
				.find(" from Rolegroup where parent_id = null");
		rhs.put("roleGroupRootList", roleGroupRootList);
		return "success";

	}

	public String menu_user_handbook() {
		List roleGroupRootList = baseDao
				.find(" from Rolegroup where parent_id = null");
		rhs.put("roleGroupRootList", roleGroupRootList);
		return "success";

	}

	public String menu_user_handbook_define() {
		List roleGroupRootList = baseDao
				.find(" from Rolegroup where parent_id = null");
		rhs.put("roleGroupRootList", roleGroupRootList);
		return "success";

	}

	
	
	public String menu_user_kpi_define() {
		List roleGroupRootList = baseDao
				.find(" from Rolegroup where parent_id = null");
		rhs.put("roleGroupRootList", roleGroupRootList);
		return "success";

	}

	public String menu_view_user_handbook_detail() {
		String id = getpara("id");
		User user = (User) baseDao.loadById("User", Long.parseLong(id));
		rhs.put("user", user);
		return "success";

	}
	
		
	
	public String menu_organize_view_h() {
		List organizeRootList = infEa.getOrganizeRootNods();
		rhs.put("organizeRootList", organizeRootList);
		rhs.put("userList", infEa.getAllUser());
		return "success";
	}

	public String menu_user_duty_define_by_role() {
		List roleGroupRootList = baseDao
				.find(" from Role where parent_id = null");
		rhs.put("roleRootList", roleGroupRootList);
		return "success";

	}

	public String menu_user_duty_define() {
		List roleGroupRootList = baseDao
				.find(" from Rolegroup where parent_id = null");
		rhs.put("roleGroupRootList", roleGroupRootList);
		return "success";
	}


	public String menu_role_view_v() {
		List roleRootList = baseDao
				.find(" from Role where parent_id = null");
		rhs.put("roleRootList", roleRootList);
		return "success";

	}
	public String menu_organize() throws Exception {
		rhs.put("organizeRootList", common_get_tree_root("Organize"));
		rhs.put("rolegroupRootList", common_get_tree_root("Rolegroup"));
		rhs.put("info_type", "success");
		rhs.put("info", "");
		return "success";
	}
	public String menu_workhomepage() {
		List ruleRootList = baseDao
				.find(" from Rule where parent_id = null");
		List viewhistory = baseDao.find("from Viewhistory");
		User user = (User) baseDao.loadById("User", getCurrentUser().getId());
		rhs.put("user", user);
		rhs.put("viewhistory", viewhistory);
		rhs.put("ruleRootList", ruleRootList);
		return "success";

	}
	public String menu_kpi_define() {
		List roleGroupRootList = baseDao
				.find(" from Rolegroup where parent_id = null");
		rhs.put("roleGroupRootList", roleGroupRootList);
		return "success";

	}

	
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}
	public String getFileFileName() {
		return fileFileName;
	}
	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}	
	
}
