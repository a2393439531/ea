package com.app.ea.action;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.ea.model.Systempara;

import com.opensymphony.util.BeanUtils;

@Component("systemparaAction")
@Scope("prototype")
public class SystemparaAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(SystemparaAction.class);
	public String menu_systempara() throws Exception {
		rhs.put("systemparaRootList", common_get_tree_root("Systempara"));
		//rhs.put("system_config", SystemInit.SYSTEM_CONFIG);
		rhs.put("info_type", "success");
		rhs.put("info", "");
		return "success";
	}

	public String create() throws Exception {
		String id = getpara("id");
		boolean findResult = true;
		if ("root".equals(id)) {
			String type = getpara("type");
			if("constellation".equals(type)){
				if(create_constellation(type)){
					findResult = false;
				}
			}else if("user-status".equals(type)){
				if(create_user_status(type)){
					findResult = false;
				}
			}else{
				Systempara systempara = new Systempara();
				systempara.setName("");
				baseDao.create(systempara);
			}
		} else {
			Systempara parent_org = (Systempara) baseDao.loadById("Systempara",
					Long.parseLong(id));
			Systempara subsystempara = new Systempara();
			subsystempara.setName("");
			subsystempara.setParentModel(parent_org);
			baseDao.create(subsystempara);
		}
		rhs.put("systemparaRootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		if(findResult){
			rhs.put("info", " 节点已经存在!");
		}else{
			rhs.put("info", " 添加新节点!");
		}
		return "success";
	}	

	public String updateSystemConfig() throws Exception {
		String paraname = getpara("paraname");
		String value = getpara("value");
		
		try {
			//BeanUtils.setValue(SystemInit.SYSTEM_CONFIG, paraname, value);
		} catch (Exception e) {
			log.error("属性修改有问题" + paraname + "=" + value);
			e.printStackTrace();
		}
	//	log.debug("编辑模式："+SystemInit.SYSTEM_CONFIG.woEditModel);
	//	SystemInit.saveSystemConfigXml(SystemInit.system_config_path, SystemInit.SYSTEM_CONFIG);
		rhs.put("info_type", "success");
		rhs.put("info", " 设置成功!");
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
		rhs.put("systemparaRootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", "更新成功!");
		return "success";
	}

	public String delete() throws Exception {
		common_del_tree_node();
		rhs.put("systemparaRootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", " 删除成功!");
		return "success";
	}
	
	public String change_rank() throws Exception {
		common_change_rank(); 
		rhs.put("systemparaRootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", "改变顺序成功!");
		return "success";
	}
	public String change_level() throws Exception {
		common_change_level();
		rhs.put("systemparaRootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", "改变层级成功!");
		return "success";
	}
	
	public boolean create_constellation(String type) throws Exception{
		Systempara systempara = (Systempara)baseDao.loadByFieldValue(Systempara.class, "keyname", type);
		if(systempara == null){
			Systempara sp1 = infEa.create_systempara("constellation", "星座信息");
			Systempara sp11 = infEa.create_sub_systempara(sp1, "0", "魔羯座");
			Systempara sp12 = infEa.create_sub_systempara(sp1, "2", "水瓶座");
			Systempara sp13 = infEa.create_sub_systempara(sp1, "4", "双鱼座");
			Systempara sp14 = infEa.create_sub_systempara(sp1, "6", "牡羊座");
			Systempara sp15 = infEa.create_sub_systempara(sp1, "8", "金牛座");
			Systempara sp16 = infEa.create_sub_systempara(sp1, "10", "双子座");
			Systempara sp17 = infEa.create_sub_systempara(sp1, "12", "巨蟹座");
			Systempara sp18 = infEa.create_sub_systempara(sp1, "14", "狮子座");
			Systempara sp19 = infEa.create_sub_systempara(sp1, "16", "处女座");
			Systempara sp110 = infEa.create_sub_systempara(sp1, "18", "天秤座");
			Systempara sp111 = infEa.create_sub_systempara(sp1, "20", "天蝎座");
			Systempara sp112 = infEa.create_sub_systempara(sp1, "22", "射手座");
			Systempara sp113 = infEa.create_sub_systempara(sp1, "24", "魔羯座");
			return true;
		}else{
			return false;
		}
		
	}
	
	public boolean create_user_status(String type) throws Exception{
		Systempara systempara = (Systempara)baseDao.loadByFieldValue(Systempara.class, "keyname", type);
		if(systempara == null){
			Systempara sp1 = infEa.create_systempara("user-status", "用户状态");
			Systempara sp11 = infEa.create_sub_systempara(sp1, "normal", "在职");
			Systempara sp12 = infEa.create_sub_systempara(sp1, "leavel", "离职");
			return true;
		}else{
			return false;
		}
	}
	
}