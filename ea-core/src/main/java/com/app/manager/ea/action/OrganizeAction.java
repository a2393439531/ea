package com.app.manager.ea.action;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.manager.ea.model.Extv;
import com.app.manager.ea.model.Organize;
@Component("organizeAction")
@Scope("prototype")
public class OrganizeAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(OrganizeAction.class);

	public String menu_organize() throws Exception {
		rhs.put("organizeRootList", common_get_tree_root("Organize"));
		rhs.put("system_para_map", 	infEa.getParaMap());
		rhs.put("info_type", "success");
		rhs.put("info", "");
		return "success";
	}

	public String create() throws Exception {
		String id = getpara("id");
		if ("root".equals(id)) {
			Organize organize = new Organize();
			organize.setName("");
			baseDao.create(organize);
		} else {
			Organize parent_org = (Organize) baseDao.loadById("Organize",
					Long.parseLong(id));
			Organize suborganize = new Organize();
			suborganize.setName("");
			suborganize.setParentModel(parent_org);
			baseDao.create(suborganize);
		}
		rhs.put("organizeRootList", common_get_tree_root(getpara("beanname")));
		
		rhs.put("info_type", "success");
		rhs.put("info", " 添加新节点成功!");
		return "success";
	}	

	public String admin() throws Exception {
		common_get_extp("Organize");
		rhs.put("rolegroupRootList", common_get_tree_root("Rolegroup"));
		Organize organize = (Organize) baseDao.loadById("Organize",
				Long.parseLong(getpara("organizeId")));
		rhs.put("organize", organize);
		rhs.put("rolegroupList", baseDao.find("from Rolegroup"));
		rhs.put("userList", infEa.getAllUser());
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
		rhs.put("organizeRootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", "更新成功!");
		return "success";
	}

	public String delete() throws Exception {
		common_del_tree_node();
		rhs.put("organizeRootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", " 删除成功!");
		return "success";
	}
	
	public String change_rank() throws Exception {
		common_change_rank(); 
		rhs.put("organizeRootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", "改变顺序成功!");
		return "success";
	}
	public String change_level() throws Exception {
		common_change_level();
		rhs.put("organizeRootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", "改变层级成功!");
		return "success";
	}
	
	
	 public String updateExtp() throws Exception {
		 common_update_extp();
		 rhs.put("organizeRootList", common_get_tree_root(getpara("beanname")));
		 rhs.put("info_type", "success");
		 rhs.put("info", "更新成功!");
		 return "success";
	    }
	
	
}
