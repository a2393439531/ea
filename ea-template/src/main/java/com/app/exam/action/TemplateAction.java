package com.app.exam.action;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.exam.model.Item;
import com.app.exam.model.Knowledge;
import com.app.exam.model.Paper;
import com.app.exam.model.Template;

@Scope("prototype")
@Component("templateAction")
public class TemplateAction extends BaseEaAction {

	public Template template = new Template();
	public Collection<String> knowledgevalue = new ArrayList<String>();
	public Collection<String> reqsinglechoice = new ArrayList<String>();
	public Collection<String> reqmultichoice = new ArrayList<String>();
	public Collection<String> reqblank = new ArrayList<String>();
	public Collection<String> reqessay = new ArrayList<String>();
	public Set<Paper> papers = new HashSet<Paper>();
	
	
	public String get_list_sql() {
		return "from Template";
	}

	public String list() throws Exception {
		String sql = getSearchSql(get_list_sql());
		getPageData(sql);
		Set<Template> list = new HashSet<Template>();
		if(knowledgevalue.size() != 0){
			for (String knowledge : knowledgevalue) {
				Knowledge kl = (Knowledge)baseDao.loadById("Knowledge", Long.valueOf(knowledge));
				list.addAll(kl.getTemplates());
			}
		}else{
			list.addAll((Collection<? extends Template>) rhs.get("dataList"));
		}
		rhs.put("dataList", list);
		rhs.put("knowledgeRootList", common_get_tree_root("Knowledge"));
		return "success";
	}

	public String save() throws Exception {
		Set<Knowledge> knowledge = new HashSet<Knowledge>();
		Set<Item> items = new HashSet<Item>();
		List<Knowledge> knowledgerootlist = common_get_tree_root("Knowledge");
		String method = getpara("method");
		if ("show".equals(method)) {
			rhs.put("knowledgeRootList", knowledgerootlist);
			rhs.put("page", "addpage");
			return "success";
		} else {
			if (knowledgevalue.size() > 0) {
				for (String value : knowledgevalue) {
					Knowledge kn = getKnowledgeById(knowledgerootlist, value);
					knowledge.add(kn);
				}
			}
			if ("savermd".equals(method)) {
				if (template.getId() == null) {
					baseDao.create(template);
				}
				template.setKnowledge(knowledge);// 添加知识领域
				
				rhs.put("knowledgeRootList", knowledgerootlist);
				rhs.put("page", "addpage");
				rhs.put("template", template);

			} else if ("savereq".equals(method)) {
				//添加必选题
				int singlechoice = reqsinglechoice.size();
				int multichoice = reqmultichoice.size();
				int blank = reqblank.size();
				int essay = reqessay.size();
				
				template.setSinglechoice(singlechoice);
				template.setMultichoice(multichoice);
				template.setBlank(blank);
				template.setEssay(essay);
				
				List<String> datalist = new ArrayList<String>();
				datalist.addAll(reqsinglechoice);
				datalist.addAll(reqmultichoice);
				datalist.addAll(reqblank);
				datalist.addAll(reqessay);
				
				for (String itemid : datalist) {
					Item item = (Item) baseDao.loadById("Item", Long.valueOf(itemid));
					items.add(item);
				}
				template.setItems(items);
				template.setKnowledge(knowledge);// 添加知识领域
				rhs.put("page", "editpage");
			}
			//应该还需要更新和模板相关的paper
			Template temp = (Template) baseDao.loadById("Template",template.getId());
			papers = temp.getPapers();
			for (Paper paper : papers) {
				int singlecount = template.getSinglechoice() + template.getRmdsinglechoice();
				int multicount = template.getMultichoice() + template.getRmdmultichoice();
				int blankcount = template.getBlank() + template.getRmdblank();
				int essaycount = template.getEssay() + template.getRmdessay();
				paper.setTotalmark(paper.getSinglechoicemark() * singlecount
						+ paper.getMultichoicemark() * multicount
						+ paper.getBlankmark() * blankcount
						+ paper.getEssaymark() + essaycount);
				baseDao.update(paper);
			}
		}
		baseDao.update(template);
		knowledgevalue.clear();
		return list();
	}

	public String load() throws Exception {
		rhs.put("knowledgeRootList", common_get_tree_root("Knowledge"));
		boolean byexcel = false;
		if (!getpara("id").equals("")) {
			Template template = (Template) baseDao.loadById("Template",
					Long.parseLong(getpara("id")));
			rhs.put("template", template);
			if("show".equals(getpara("method"))){
				rhs.put("readonly", true);
			}else if("edit".equals(getpara("method"))){
				rhs.put("readonly", false);
			}
			Set<Item> items = template.getItems();
			for (Item item : items) {
				if(!"".equals(item.getMark()) && item.getMark() != null){
					byexcel = true;
					break;
				}
			}
			if(byexcel){
				rhs.put("readonly", true);
			}
		} 
		return "success";
	}
	
	public String addreqitem() {
		Set<Item> datalist = new HashSet<Item>();
		String templateid = getpara("templateid");
		String itemtype = getpara("type");
		String itemid = getpara("itemid");
		Set<Item> items = new HashSet<Item>();

		Template template = (Template) baseDao.loadById("Template",
				Long.valueOf(templateid));
		items = template.getItems();

		Item item = (Item) baseDao.loadById("Item", Long.valueOf(itemid));
		
		if(!items.contains(item)){
			items.add(item);
		}else{
			items.remove(item);
		}
		baseDao.update(template);

		
		for (Item reqitem : items) {
			if(itemtype.equals(String.valueOf(reqitem.getType()))){
				datalist.add(reqitem);
			}
		}
		rhs.put("datalist", datalist);
		rhs.put("itemtype", itemtype);
		return "success";
	}

	public String delete() throws Exception{
		String id = getpara("id");
		Template template = (Template) baseDao.loadById("Template", Long.parseLong(id));
		baseDao.delete(template);
		return list();
	}
	
	protected Knowledge getKnowledgeById(
			Collection<Knowledge> knowledgerootlist, String id)
			throws Exception {
		Knowledge kn = null;
		for (Knowledge knowledge : knowledgerootlist) {
			if (knowledge.getChildKnowledges().size() > 0) {
				Set<Knowledge> knowledges = knowledge.getChildKnowledges();
				kn = getKnowledgeById(knowledges, id);
				if (kn == null) {
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

	public Collection<String> getKnowledgevalue() {
		return knowledgevalue;
	}

	public void setKnowledgevalue(Collection<String> knowledgevalue) {
		this.knowledgevalue = knowledgevalue;
	}
	

	public Collection<String> getReqsinglechoice() {
		return reqsinglechoice;
	}

	public void setReqsinglechoice(Collection<String> reqsinglechoice) {
		this.reqsinglechoice = reqsinglechoice;
	}

	public Collection<String> getReqmultichoice() {
		return reqmultichoice;
	}

	public void setReqmultichoice(Collection<String> reqmultichoice) {
		this.reqmultichoice = reqmultichoice;
	}

	public Collection<String> getReqblank() {
		return reqblank;
	}

	public void setReqblank(Collection<String> reqblank) {
		this.reqblank = reqblank;
	}

	public Collection<String> getReqessay() {
		return reqessay;
	}

	public void setReqessay(Collection<String> reqessay) {
		this.reqessay = reqessay;
	}

}
