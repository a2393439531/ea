package com.app.exam.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.common.spring.ssh.action.BaseAction;
import com.app.common.spring.ssh.action.BaseBusinessAction;
import com.app.exam.model.Knowledge;

import org.apache.commons.beanutils.BeanUtils;

@Component("knowledgeAction")
public class KnowledgeAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(KnowledgeAction.class);
	public String menu_knowledge() throws Exception {
		rhs.put("knowledgeRootList", common_get_tree_root("Knowledge"));
		rhs.put("info_type", "success");
		rhs.put("info", "");
		return "success";
	}

	public String create() throws Exception {
		String id = getpara("id");
		if ("root".equals(id)) {
			Knowledge knowledge = new Knowledge();
			knowledge.setName("");
			baseDao.create(knowledge);
		} else {
			Knowledge parent_org = (Knowledge) baseDao.loadById("Knowledge",
					Long.parseLong(id));
			Knowledge subknowledge = new Knowledge();
			subknowledge.setName("");
			subknowledge.setParentModel(parent_org);
			baseDao.create(subknowledge);
		}
		rhs.put("knowledgeRootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", " 添加新节点!");
		return "success";
	}	
	
	public String update() throws Exception {
		try {
			common_update();
		} catch (Exception e) {
			rhs.put("info_type", "error");
			rhs.put("info", " Update failed!");
			return "success";
		}
		rhs.put("knowledgeRootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", "Update successfully!");
		return "success";
	}

	public String delete() throws Exception {
		String id = getpara("id");
		Knowledge knowledge = (Knowledge) baseDao.loadById(getpara("beanname"), Long.valueOf(id));
		boolean find = false;
		if(knowledge.getItems().size() > 0){
			find = true;
			rhs.put("result", "Can not delete the knowledge!");
		}else{
			common_del_tree_node();
			rhs.put("info_type", "success");
			rhs.put("info", " Delete successfully!");
		}
		rhs.put("flag", find);
		rhs.put("knowledgeRootList", common_get_tree_root(getpara("beanname")));
		return "success";
	}
	
	public String change_rank() throws Exception {
		common_change_rank(); 
		rhs.put("knowledgeRootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", "Change Successfully!");
		return "success";
	}
	public String change_level() throws Exception {
		common_change_level();
		rhs.put("knowledgeRootList", common_get_tree_root(getpara("beanname")));
		rhs.put("info_type", "success");
		rhs.put("info", "Change Successfully!");
		return "success";
	}
}