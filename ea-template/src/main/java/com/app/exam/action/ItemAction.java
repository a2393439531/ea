package com.app.exam.action;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.exam.model.Choiceitem;
import com.app.exam.model.Item;
import com.app.exam.model.Knowledge;

@Scope("prototype")
@Component("itemAction")
public class ItemAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(KnowledgeAction.class);
	public Item item = new Item();
	public List<String> choiceitemvalue = new ArrayList<String>();
	public List<String> knowledgevalue = new ArrayList<String>();
	public List<String> choiceitemid = new ArrayList<String>();

	public String get_list_sql() {
		return "from Item";
	}

	public String list() throws Exception {
		String sql = getSearchSql(get_list_sql());
		getPageData(sql);
		
		rhs.put("knowledgeRootList", common_get_tree_root("Knowledge"));
		return "success";
	}

	public String save() throws Exception {
		Set<Choiceitem> choiceitem = new HashSet<Choiceitem>();
		Set<Knowledge> knowledge = new HashSet<Knowledge>();

		List<Knowledge> knowledgerootlist = common_get_tree_root("Knowledge");
		String method = getpara("method");
		if ("show".equals(method)) {
			rhs.put("knowledgeRootList", knowledgerootlist);
			rhs.put("page", "addpage");
			return "success";
		} else {
			if("".equals(item.getId()) || item.getId() == null){
				baseDao.create(item);
			}
			if (knowledgevalue.size() > 0) {
				for (String klv : knowledgevalue) {
					Knowledge kn = getKnowledgeById(knowledgerootlist, klv);
					knowledge.add(kn);
					item.setKnowledge(knowledge);// 添加知识领域
				}
			}
			if (choiceitemvalue.size() >= 4) {
				int i = 1;
				for (int j = 0; j < choiceitemvalue.size(); j++) {
					Choiceitem ci = null;
					if(choiceitemid.size() >= 4){
						for (int k = j; k < choiceitemid.size(); k++) {
							ci = (Choiceitem) baseDao.loadById("Choiceitem", Long.parseLong(choiceitemid.get(k)));
							ci.setItem(item);
							ci.setValue(choiceitemvalue.get(j));
							baseDao.update(ci);
							choiceitem.add(ci);
							break;
						}
					}else{
						ci = new Choiceitem();
						ci.setItem(item);
						ci.setRefid(i++);
						ci.setValue(choiceitemvalue.get(j));
						baseDao.create(ci);
						choiceitem.add(ci);
					}
				}
				item.setChoiceitem(choiceitem);// 添加选项
			}
			item.setCreateuser(getCurrentAccount());// 添加创建人
			rhs.put("page", "editpage");
		}
		baseDao.update(item);
		return list();
	}

	public String load() throws Exception {
		rhs.put("knowledgeRootList", common_get_tree_root("Knowledge"));
		if (!getpara("id").equals("")) {
			Item item = (Item) baseDao.loadById("Item",
					Long.parseLong(getpara("id")));
			rhs.put("item", item);
			if("show".equals(getpara("method"))){
				rhs.put("readonly", true);
			}else if("edit".equals(getpara("method"))){
				rhs.put("readonly", false);
			}
		} 
		return "success";
	}

	public String delete() throws Exception{
		String id = getpara("id");
		Item item = (Item) baseDao.loadById("Item", Long.parseLong(id));
		/*
		if(item.getType() == 1 || item.getType() == 2){
			Set<Choiceitem> choiceitems = item.getChoiceitem();
			for (Choiceitem choiceitem : choiceitems) {
				baseDao.delete(choiceitem);
			}
		}*/
		baseDao.delete(item);
		return list();
	}
	
	public List<String> getChoiceitemvalue() {
		return choiceitemvalue;
	}

	public void setChoiceitemvalue(List<String> choiceitemvalue) {
		this.choiceitemvalue = choiceitemvalue;
	}

	public List<String> getKnowledgevalue() {
		return knowledgevalue;
	}

	public void setKnowledgevalue(List<String> knowledgevalue) {
		this.knowledgevalue = knowledgevalue;
	}

	public List<String> getChoiceitemid() {
		return choiceitemid;
	}

	public void setChoiceitemid(List<String> choiceitemid) {
		this.choiceitemid = choiceitemid;
	}
	
	protected Knowledge getKnowledgeById(
			Collection<Knowledge> knowledgerootlist, String id)
			throws Exception {
		Knowledge kn = null;
		for (Knowledge knowledge : knowledgerootlist) {
			if (knowledge.getChildKnowledges().size() > 0) {
				Set<Knowledge> knowledges = knowledge.getChildKnowledges();
				kn = getKnowledgeById(knowledges, id);
				if(kn == null){
					continue;
				}
				return kn;
				
			} else {
				if (String.valueOf(knowledge.getId()).equals(id)) {
					return knowledge;
				}
			}
		}
		return kn;
	}

}
