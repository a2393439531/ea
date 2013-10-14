package com.app.manager.template.demo;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.manager.ea.api.ImpEa;
import com.app.manager.ea.api.InfEa;
import com.app.manager.ea.demo.InfDemo;
import com.app.manager.ea.demo.ParentDemo;
import com.app.manager.ea.model.Organize;
import com.app.manager.ea.model.Organizegroup;
import com.app.manager.ea.model.Resource;
import com.app.manager.ea.model.Role;
import com.app.manager.ea.model.Rolegroup;
import com.app.manager.ea.model.Systempara;
import com.app.manager.ea.model.User;
import com.common.spring.ssh.dao.BaseDao;
import com.common.spring.ssh.model.BaseModel;
@Component("impTemplate")
public class ImpTemplate extends ParentDemo implements InfDemo{
	private final Logger log = LoggerFactory.getLogger(ImpTemplate.class);
	public void initData() throws Exception {
		if(baseDao.find(" from User ").size()==0){
			//if(true){
		log.debug("初始化数据");
		User admin = create_user("admin", "系统管理admin", "1324567890","admin@qq.com", "");
		User user_1 = create_user("test", "test", "18688385892","", "");
		
		
		
		Organize o1 = create_organize("部门架构", "department", null);
		Organize o11 = create_sub_organize(o1,"旅馆", "hotel",null );
		Organize o_hotel_1 = create_sub_organize(o11,"民宿旅馆", "hotel-xingsu", null);
		Organizegroup organizegroup_room=create_organizegroup(null, "房间", "room");
		Organize o_hotel_floor1= create_sub_organize(o_hotel_1,"1楼", "floor1",null );
		Organize o_hotel_floor2= create_sub_organize(o_hotel_1,"2楼", "floor2", null);
		Organize o_hotel_floor3= create_sub_organize(o_hotel_1,"3楼", "floor3", null);
		Organize o_hotel_floor4= create_sub_organize(o_hotel_1,"4楼", "floor4", null);
		
		Organize o_hotel_room101= create_sub_organize(o_hotel_floor1,"101", "101", organizegroup_room);
		Organize o_hotel_room201= create_sub_organize(o_hotel_floor2,"201", "201", organizegroup_room);
		Organize o_hotel_room202= create_sub_organize(o_hotel_floor2,"202", "202", organizegroup_room);
		Organize o_hotel_room203= create_sub_organize(o_hotel_floor2,"203", "203", organizegroup_room);
		Organize o_hotel_room204= create_sub_organize(o_hotel_floor2,"204", "204", organizegroup_room);
		Organize o_hotel_room205= create_sub_organize(o_hotel_floor2,"205", "205", organizegroup_room);
		
		
		Organize o_hotel_room301= create_sub_organize(o_hotel_floor3,"301", "301", organizegroup_room);
		Organize o_hotel_room302= create_sub_organize(o_hotel_floor3,"302", "302", organizegroup_room);
		Organize o_hotel_room303= create_sub_organize(o_hotel_floor3,"303", "303", organizegroup_room);
		Organize o_hotel_room304= create_sub_organize(o_hotel_floor3,"304", "304", organizegroup_room);
		Organize o_hotel_room305= create_sub_organize(o_hotel_floor3,"305", "305", organizegroup_room);

		
		Organize o_hotel_room401= create_sub_organize(o_hotel_floor4,"401", "401", organizegroup_room);
		Organize o_hotel_room402= create_sub_organize(o_hotel_floor4,"402", "402", organizegroup_room);
		Organize o_hotel_room403= create_sub_organize(o_hotel_floor4,"403", "403", organizegroup_room);
		Organize o_hotel_room404= create_sub_organize(o_hotel_floor4,"404", "404", organizegroup_room);
		Organize o_hotel_room405= create_sub_organize(o_hotel_floor4,"405", "405", organizegroup_room);
				
		
		Systempara sp1 = create_systempara("hotel_organize_extp", "房间扩展属性");
		Systempara sp11 = create_sub_systempara(sp1, "efee", "电费");
		Systempara sp12 = create_sub_systempara(sp1, "wfee", "水费");
		Systempara sp16 = create_sub_systempara(sp1, "enumber", "电表读数");
		Systempara sp17 = create_sub_systempara(sp1, "wnumber", "水表读数");
		Systempara sp13 = create_sub_systempara(sp1, "begindate", "登记日期");
		Systempara sp14 = create_sub_systempara(sp1, "enddate", "结束日期");
		Systempara sp15 = create_sub_systempara(sp1, "price", "月租金");
		Systempara sp18 = create_sub_systempara(sp1, "wprice", "水价");
		Systempara sp19 = create_sub_systempara(sp1, "eprice", "电价");
		Systempara sp20 = create_sub_systempara(sp1, "nprice", "网费");
		Systempara sp2 = create_systempara("hotel_fee_reason", "收费注释");
		Systempara sp21 = create_sub_systempara(sp2, "checkin", "第一次开房费用");
		Systempara sp22 = create_sub_systempara(sp2, "monthfee", "月结算费用");
		Systempara sp23 = create_sub_systempara(sp2, "deposithfee", "房押金");
		Systempara sp24 = create_sub_systempara(sp2, "deposithrout", "路由器押金");		
		Systempara sp25 = create_sub_systempara(sp2, "ontop", "楼顶费用");		
		
		
		Rolegroup r1 = create_rolegroup("旅馆岗位", "hotel");
		Rolegroup r11 = create_sub_rolegroup(r1, "旅馆管理员", "hotel-manager");
		Rolegroup r12 = create_sub_rolegroup(r1, "入住人", "hotel-tenant");
		
		batCreateRoleByRolegroupId(r12.getId().toString(),o_hotel_room101.getId().toString()
				+ "-"+o_hotel_room201.getId().toString()
				+ "-"+o_hotel_room202.getId().toString()
				+ "-"+o_hotel_room203.getId().toString()
				+ "-"+o_hotel_room204.getId().toString()
				+ "-"+o_hotel_room205.getId().toString()				
				+ "-"+o_hotel_room301.getId().toString()
				+ "-"+o_hotel_room302.getId().toString()
				+ "-"+o_hotel_room303.getId().toString()
				+ "-"+o_hotel_room304.getId().toString()
				+ "-"+o_hotel_room305.getId().toString()
				+ "-"+o_hotel_room401.getId().toString()
				+ "-"+o_hotel_room402.getId().toString()
				+ "-"+o_hotel_room403.getId().toString()
				+ "-"+o_hotel_room404.getId().toString()
				+ "-"+o_hotel_room405.getId().toString()

				);
		
		
		Resource r0 = create_resource("系统管理", "system-admin", null);
		Resource r01 = create_sub_resource(r0, "房间管理","organize-manager", "ea_organize_menu_organize.do");
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
