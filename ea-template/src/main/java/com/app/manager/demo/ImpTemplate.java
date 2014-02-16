package com.app.manager.demo;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.common.spring.ssh.dao.BaseDao;
import com.app.common.spring.ssh.model.BaseModel;
import com.app.ea.api.ImpEa;
import com.app.ea.api.InfEa;
import com.app.ea.demo.InfDemo;
import com.app.ea.demo.ParentDemo;
import com.app.ea.model.Organize;
import com.app.ea.model.Organizegroup;
import com.app.ea.model.Resource;
import com.app.ea.model.Role;
import com.app.ea.model.Rolegroup;
import com.app.ea.model.Systempara;
import com.app.ea.model.User;
@Component("impTemplate")
public class ImpTemplate extends ParentDemo implements InfDemo{
	private final Logger log = LoggerFactory.getLogger(ImpTemplate.class);
	public void initData() throws Exception {
		if(baseDao.find(" from User ").size()==0){
			//if(true){
		log.debug("初始化数据");
		User admin = create_user("admin", "系统管理admin", "1324567890","admin@qq.com", "");
		User user_1 = create_user("test", "test", "18688385892","", "");
		User user_xixi = create_user("xixi", "习席", "323232","", "");
		User user_hujun = create_user("hujun", "胡军", "323232","", "");	
		User user_liuhua = create_user("liuhua", "刘华", "234455","", "");
		User user_limi= create_user("limi", "黎米", "234455","", "");
		
		User user_wangfei = create_user("wangfei", "王非", "323232","", "");
		User user_hanchun= create_user("huchun", "胡春", "234455","", "");
		User user_lili = create_user("lili", "李丽", "234455","", "");		
		User user_zhangli = create_user("zhangli", "张丽", "234455","", "");		
		Organize o1 = create_organize("部门架构", "department", null);
		Organize o11 = create_sub_organize(o1,"xx企业", "xx", null);		
		Organize o111 = create_sub_organize(o11,"生产部", "product",null );
		Organize o112 = create_sub_organize(o11,"客服", "surpport",null );
		
		Rolegroup r1 = create_rolegroup("部门", "rolegroup-department");
		Rolegroup rolegoupr_ceo = create_sub_rolegroup(r1, "CEO", "CEO");
		Rolegroup r10 = create_sub_rolegroup(rolegoupr_ceo, "部门经理", "department-manager");
		Rolegroup r14 = create_sub_rolegroup(r10, "员工", "member");
		
		Role role_product_ceo=createRole(o11.getId().toString(), rolegoupr_ceo.getId().toString());
		Role role_product_manager=createRole(o111.getId().toString(), r10.getId().toString());
		Role role_product_member=createRole(o111.getId().toString(), r14.getId().toString());

		Role role_surpport_manager=createRole(o112.getId().toString(), r10.getId().toString());
		Role role_surpport_member=createRole(o112.getId().toString(), r14.getId().toString());
		
		
		role_product_manager.setParentModel(role_product_ceo);
		role_surpport_manager.setParentModel(role_product_ceo);
		role_product_member.setParentModel(role_product_manager);
		role_surpport_member.setParentModel(role_surpport_manager);
		
	
		role_product_ceo.getUsers().add(user_xixi);
		role_product_manager.getUsers().add(user_hujun);
		role_product_member.getUsers().add(user_liuhua);
		role_product_member.getUsers().add(user_limi);
		
		role_surpport_manager.getUsers().add(user_wangfei);
		role_surpport_member.getUsers().add(user_hanchun);
		role_surpport_member.getUsers().add(user_lili);
		role_surpport_member.getUsers().add(user_zhangli);
		Rolegroup r2 = create_rolegroup("项目", "rolegroup-project");
		Rolegroup r21 = create_sub_rolegroup(r2, "项目经理", "project-manager");
		Rolegroup r211 = create_sub_rolegroup(r21, "领域主管", "group-leader");
		Rolegroup r2111 = create_sub_rolegroup(r211, "组长", "team-leder");
		Rolegroup r21111 = create_sub_rolegroup(r2111, "成员", "team-member");
		Rolegroup r211111 = create_sub_rolegroup(r2111, "第三方成员", "helper");		
		
		
		
		
		Systempara sp1 = create_systempara("user-status", "用户状态");
		Systempara sp11 = create_sub_systempara(sp1, "normal", "在职");
		Systempara sp12 = create_sub_systempara(sp1, "levea", "离职");
		
	
		Resource r0 = create_resource("系统管理", "system-admin", null);
		Resource r01 = create_sub_resource(r0, "组织架构管理","organize-admin","ea_organize_menu_organize.do");
		Resource r02 = create_sub_resource(r0, "岗位管理","positon-admin","ea_rolegroup_menu_rolegroup.do");
		Resource r03 = create_sub_resource(r0, "职位管理","role-admin","ea_ea_menu_relation.do");
		Resource r04 = create_sub_resource(r0, "人员管理","user-admin","ea_user_list.do");
		Resource r05 = create_sub_resource(r0, "权限管理","resource-admin","ea_resource_menu_resource.do");
		Resource r06 = create_sub_resource(r0, "邮件服务器设置 ","smtp_menu_smtp_init", "ea_smtp_menu_smtp_init.do");
		Resource r07 = create_sub_resource(r0, "系统参数 ","smtp_menu_smtp_init", "ea_systempara_menu_systempara.do");	
		
		admin.getResources().add(r0);
		admin.getResources().add(r01);
		admin.getResources().add(r02);
		admin.getResources().add(r03);
		admin.getResources().add(r04);
		admin.getResources().add(r05);
		admin.getResources().add(r06);
		admin.getResources().add(r07);
		
		baseDao.update(admin);
	    
		
		}
	}
}
