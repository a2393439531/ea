package com.app.exam.action;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.activiti.model.BusinessWithProcessModel;
import com.app.common.base.action.BaseEaAction;
import com.app.exam.model.Examrecord;
import com.app.exam.model.Item;
import com.app.exam.model.Knowledge;
import com.app.exam.model.Paper;
import com.app.exam.model.Template;

@Scope("prototype")
@Component("paperAction")
public class PaperAction extends BaseEaAction {

	public Collection<String> knowledgevalue = new ArrayList<String>();
	public Paper paper = new Paper();
	public Template template = new Template();

	public String get_list_sql() {
		return "from Paper";
	}

	public String get_template_list_sql() {
		return "from Template";
	}

	public String list() throws Exception {
		String sql = getSearchSql(get_list_sql());
		getPageData(sql);
		
		Set<Paper> list = new HashSet<Paper>();
		if(knowledgevalue.size() != 0){
			for (String knowledge : knowledgevalue) {
				Knowledge kl = (Knowledge)baseDao.loadById("Knowledge", Long.valueOf(knowledge));
				list.addAll(kl.getPapers());
			}
		}else{
			list.addAll((Collection<? extends Paper>) rhs.get("dataList"));
		}
		//rhs.put("dataList", list);
		List paperList = new ArrayList<Paper>();
		paperList.addAll(list);
		List processPaperList = paperToProcessPaper(paperList);
		rhs.put("dataList", processPaperList);
		
		rhs.put("knowledgeRootList", common_get_tree_root("Knowledge"));
		return "success";
	}

	public String save() throws Exception {
		Set<Knowledge> knowledge = new HashSet<Knowledge>();
		List<Knowledge> knowledgerootlist = common_get_tree_root("Knowledge");
		rhs.put("knowledgeRootList", knowledgerootlist);
		String method = getpara("method");
		if ("show".equals(method)) {
			String sql = get_template_list_sql();
			getPageData(sql);
			rhs.put("page", "choicetemplatepage");
			return "success";
		} else {
			if (knowledgevalue.size() > 0) {
				for (String value : knowledgevalue) {
					Knowledge kn = getKnowledgeById(knowledgerootlist, value);
					knowledge.add(kn);
				}
			}
			String templateid = getpara("templateid");
			if (!"".equals(templateid) && templateid != null) {
				template = (Template) baseDao.loadById("Template",
						Long.valueOf(getpara("templateid")));
			}
			if ("choicetemplate".equals(method)) {
				if (paper.getId() == null) {
					baseDao.create(paper);
					paper.setTemplate(template);
					baseDao.update(paper);
				}

				rhs.put("paper", paper);
				rhs.put("page", "addpage");
				return "success";
			} else{ // 保存各各题型的分数,考试时间

				paper.setKnowledge(knowledge);
				paper.setTemplate(template);
				
				if(!Boolean.valueOf(getpara("byexcel"))){
					//设置总分
					int singlecount = paper.getTemplate().getSinglechoice() + paper.getTemplate().getRmdsinglechoice();
					int multicount = paper.getTemplate().getMultichoice() + paper.getTemplate().getRmdmultichoice();
					int blankcount = paper.getTemplate().getBlank() + paper.getTemplate().getRmdblank();
					int essaycount = paper.getTemplate().getEssay() + paper.getTemplate().getRmdessay();
					
					paper.setTotalmark(singlecount
							* Integer.valueOf(paper.getSinglechoicemark())
							+ multicount
							* Integer.valueOf(paper.getMultichoicemark())
							+ blankcount * Integer.valueOf(paper.getBlankmark())
							+ essaycount * Integer.valueOf(paper.getEssaymark()));
				}
				rhs.put("page", "editpage");
			} 
		}
		baseDao.update(paper);
		knowledgevalue.clear();
		return list();
	}

	public String delete() throws Exception {
		String id = getpara("id");
		Paper paper = (Paper) baseDao.loadById("Paper", Long.parseLong(id));
		paper.setTemplate(null);
		
		Set<Examrecord> record = paper.getResultdetail();
		for (Examrecord examrecord : record) {
			examrecord.setPaper(null);
			examrecord.setResult(null);
		}
		paper.setResultdetail(null);
		baseDao.update(paper);
		baseDao.delete(paper);
		return list();
	}

	public String assign(){
		String id = getpara("id");
		Paper paper = (Paper) baseDao.loadById("Paper", Long.parseLong(id));
		Template template = paper.getTemplate();
		if(template.getRmdblank() != 0 || template.getBlank() != 0 || template.getEssay() != 0 || template.getRmdessay() != 0 ){
			rhs.put("autojudge", false);
		}
		rhs.put("paper", paper);
		rhs.put("method", "assign");
		return "success";
	}
	
	public String load() throws Exception {
		boolean byexcel = false;
		rhs.put("knowledgeRootList", common_get_tree_root("Knowledge"));
		if (!getpara("id").equals("")) {
			Paper paper = (Paper) baseDao.loadById("Paper",
					Long.parseLong(getpara("id")));
			rhs.put("paper", paper);
			if ("show".equals(getpara("method"))) {
				rhs.put("readonly", true);
			} else if ("edit".equals(getpara("method"))) {
				rhs.put("readonly", false);
			}
			Set<Item> items = paper.getTemplate().getItems();
			for (Item item : items) {
				if(!"".equals(item.getMark()) && item.getMark() != null){
					byexcel = true;
					break;
				}
			}
			//如果是excel导入的，就把所有题目显示出来
			if(byexcel){
				Template template = paper.getTemplate();
				Set<Item> singleitems = new HashSet<Item>();
				Collection<Item> reqsingleitems = template.getReqItem("1");
				singleitems.addAll(reqsingleitems);
				rhs.put("singleitems", singleitems);
				rhs.put("paper", paper);
				rhs.put("template", template);
			}
		}
		rhs.put("byexcel", byexcel);
		return "success";
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

	private List paperToProcessPaper(List list){
		List retList = new ArrayList();
		if(list != null){
			for(int i = 0; i < list.size(); i++){
				Paper paper = (Paper)list.get(i);
				BusinessWithProcessModel<Paper> processWo = new BusinessWithProcessModel<Paper>(paper);
				retList.add(processWo);
			}
		}
		return retList;
	}
	
	public Collection<String> getKnowledgevalue() {
		return knowledgevalue;
	}

	public void setKnowledgevalue(Collection<String> knowledgevalue) {
		this.knowledgevalue = knowledgevalue;
	}
}
