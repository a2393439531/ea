package com.app.manager.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.common.spring.ssh.action.BaseAction;
import com.app.common.spring.ssh.action.BaseBusinessAction;
import com.app.manager.model.Tpltree1;

import org.apache.commons.beanutils.BeanUtils;

@Component("tpltree1Action")
public class Tpltree1Action extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(Tpltree1Action.class);
	public String menu_tpltree1() throws Exception {
		rhs.put("tpltree1RootList", common_get_tree_root("Tpltree1"));
		rhs.put("info_type", "success");
		rhs.put("info", "");
		return "success";
	}

	public String create() throws Exception {
		String id = getpara("id");
		if ("root".equals(id)) {
			Tpltree1 tpltree1 = new Tpltree1();
			tpltree1.setName("");
			baseDao.create(tpltree1);
		} else {
			Tpltree1 parent_org = (Tpltree1) baseDao.loadById("Tpltree1",
					Long.parseLong(id));
			Tpltree1 subtpltree1 = new Tpltree1();
			subtpltree1.setName("");
			subtpltree1.setParentModel(parent_org);
			baseDao.create(subtpltree1);
		}
		rhs.put("tpltree1RootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", " 添加新节点!");
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
		rhs.put("tpltree1RootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", "更新成功!");
		return "success";
	}

	public String delete() throws Exception {
		common_del_tree_node();
		rhs.put("tpltree1RootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", " 删除成功!");
		return "success";
	}
	
	public String change_rank() throws Exception {
		common_change_rank(); 
		rhs.put("tpltree1RootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", "改变顺序成功!");
		return "success";
	}
	public String change_level() throws Exception {
		common_change_level();
		rhs.put("tpltree1RootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", "改变层级成功!");
		return "success";
	}
}