package com.app.exam.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.activiti.model.BusinessWithProcessModel;
import com.app.common.base.action.BaseEaAction;
import com.app.exam.model.Examarrange;
import com.app.exam.model.Examrecord;
import com.app.exam.model.Item;
import com.app.exam.model.Knowledge;
import com.app.exam.model.Paper;
import com.app.exam.model.Papergroup;

import edu.emory.mathcs.backport.java.util.Collections;

@Scope("prototype")
@Component("paperAction")
public class PaperAction extends BaseEaAction {

	public Collection<String> knowledgevalue = new ArrayList<String>();
	public Paper paper = new Paper();
	//public Template template = new Template();
	public Collection<String> reqsinglechoice = new ArrayList<String>();
	public Collection<String> reqmultichoice = new ArrayList<String>();
	public Collection<String> reqblank = new ArrayList<String>();
	public Collection<String> reqessay = new ArrayList<String>();

	public String get_list_sql() {
		return "from Paper";
	}

	public String get_template_list_sql() {
		return "from Template";
	}

	public String list() throws Exception {
		Map<String,List<BusinessWithProcessModel<Paper>>> dataMap = new HashMap<String, List<BusinessWithProcessModel<Paper>>>();
		String sql = getSearchSql(get_list_sql());
		getPageData(sql);
		String formstyle = getpara("formstyle");
		String divstyle = getpara("divstyle");
		Set<Paper> list = new HashSet<Paper>();
		if(knowledgevalue.size() != 0){
			for (String knowledge : knowledgevalue) {
				Knowledge kl = (Knowledge)baseDao.loadById("Knowledge", Long.valueOf(knowledge));
				list.addAll(kl.getAllPaper(kl));
			}
		}else{
			list.addAll((Collection<? extends Paper>) rhs.get("dataList"));
		}
		//rhs.put("dataList", list);
		List paperList = new ArrayList<Paper>();
		paperList.addAll(list);
		List<BusinessWithProcessModel<Paper>> processPaperList = paperToProcessPaper(paperList);
		for (BusinessWithProcessModel<Paper> object : processPaperList) {
			Papergroup pg = object.getBusinessModel().getPapergroup();
			String pgname = "";
			if(pg == null){
				pgname = "null";
			}else{
				pgname = pg.getName();
			}
			List<BusinessWithProcessModel<Paper>> papers = dataMap.get(pgname);
			if(papers == null){
				papers = new ArrayList<BusinessWithProcessModel<Paper>>();
			}
			papers.add(object);
			dataMap.put(pgname, papers);
		}
		List<String> condition = new ArrayList<String>();
		for (String value : knowledgevalue) {
			condition.add(value);
		}
		rhs.put("knowledgevalue", condition);
		rhs.put("dataList", dataMap);
		rhs.put("formstyle", "".equals(formstyle)? "none":formstyle);
		rhs.put("divstyle", "".equals(divstyle)? "0 10px 0 0":divstyle);
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
//			String templateid = getpara("templateid");
//			if (!"".equals(templateid) && templateid != null) {
//				template = (Template) baseDao.loadById("Template",
//						Long.valueOf(getpara("templateid")));
//			}
			if ("choicetemplate".equals(method)) {
				if (paper.getId() == null) {
					baseDao.create(paper);
					//paper.setTemplate(template);
					//baseDao.update(paper);
				}

				rhs.put("paper", paper);
				rhs.put("page", "addpage");
				return "success";
			} else{ // 保存各各题型的分数,考试时间
				Papergroup pg = (Papergroup)baseDao.loadById("Papergroup", paper.getPapergroup().getId());
				paper.setPapergroup(pg);
				paper.setKnowledge(knowledge);
				//paper.setTemplate(template);
				long sortnob = ((Paper)baseDao.loadById("Paper", paper.getId())).getSortNob();
				String processInstanceId = ((Paper)baseDao.loadById("Paper", paper.getId())).getProcessInstanceId();
				paper.setSortNob(sortnob);
				paper.setProcessInstanceId(processInstanceId);
				
				Set<Item> paperItems = ((Paper)baseDao.loadById("Paper", paper.getId())).getItems();
				paper.setItems(paperItems);
				
				if(!Boolean.valueOf(getpara("byexcel"))){
					//设置总分
					int singlecount = paper.getSinglechoice() + paper.getRmdsinglechoice();
					int multicount = paper.getMultichoice() + paper.getRmdmultichoice();
					int blankcount = paper.getBlank() + paper.getRmdblank();
					int essaycount = paper.getEssay() + paper.getRmdessay();
					
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
		boolean find = false;
		Paper paper = (Paper) baseDao.loadById("Paper", Long.parseLong(id));
		//查找examarrange表，如果试卷有记录，则不能被删除。
		String sql = "from Examarrange";
		getPageData(sql);
		List<Examarrange> list = (List<Examarrange>) rhs.get("dataList");
		for(Examarrange examarrange : list){
			if(examarrange.getPaperid().equals(id)){
				find = true;
				break;
			}
		}
		if(!find){
		paper.setPapergroup(null);
		Set<Examrecord> record = paper.getResultdetail();
		for (Examrecord examrecord : record) {
			examrecord.setPaper(null);
			examrecord.setResult(null);
		}
		paper.setResultdetail(null);
		baseDao.update(paper);
		baseDao.delete(paper);
		}else {
			rhs.put("info", "Can not delete this paper!");
		}
		rhs.put("flag", find);
		return list();
	}

	public String create() throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Set<Knowledge> knowledge = new HashSet<Knowledge>();
		List<Knowledge> knowledgerootlist = common_get_tree_root("Knowledge");
		rhs.put("knowledgeRootList", knowledgerootlist);
		if (knowledgevalue.size() > 0) {
			for (String value : knowledgevalue) {
				Knowledge kn = getKnowledgeById(knowledgerootlist, value);
				knowledge.add(kn);
			}
		}
		String method = getpara("method");
		if("newpaper".equals(method)){
			// if (template.getId() == null) {
			// baseDao.create(template);
			// if(paper.getId() == null){
			// paper.setTemplate(template);
			// }
			// }
			baseDao.create(paper);
			rhs.put("page", "setpaper");
			rhs.put("paper", paper);
			//rhs.put("template", template);
		}else if("setpaper".equals(method)){
			//String templateid = getpara("templateid");
			//if (!"".equals(templateid) && templateid != null) {
				//template = (Template) baseDao.loadById("Template",
						//Long.valueOf(getpara("templateid")));
			//}
			//template.setTitle("Temp_template_"+sdf.format(new Date()));
			paper.setKnowledge(knowledge);
			//paper.setTemplate(template);
			//template.setKnowledge(knowledge);
			paper.setCreatedate(sdf.format(new Date()));
			paper.setCreateuser(getCurrentAccount());
			long sortnob = ((Paper)baseDao.loadById("Paper", paper.getId())).getSortNob();
			paper.setSortNob(sortnob);
			
			
			//baseDao.create(paper);
			baseDao.update(paper);
			//knowledgevalue.clear();
			//rhs.put("template", template);
			rhs.put("paper", paper);
		//}else if("setitem".equals(method)){
			String paperid = getpara("paperid");
			Set<Item> items = new HashSet<Item>();
			//添加必选题
			int singlechoice = reqsinglechoice.size();
			int multichoice = reqmultichoice.size();
			int blank = reqblank.size();
			int essay = reqessay.size();
			
			paper.setSinglechoice(singlechoice);
			paper.setMultichoice(multichoice);
			paper.setBlank(blank);
			paper.setEssay(essay);
			
			List<String> datalist = new ArrayList<String>();
			datalist.addAll(reqsinglechoice);
			datalist.addAll(reqmultichoice);
			datalist.addAll(reqblank);
			datalist.addAll(reqessay);
			
			for (String itemid : datalist) {
				Item item = (Item) baseDao.loadById("Item", Long.valueOf(itemid));
				items.add(item);
			}
			paper.setItems(items);
			paper.setKnowledge(knowledge);// 添加知识领域
			baseDao.update(paper);
			Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(paperid));
			int singlecount = paper.getSinglechoice() + paper.getRmdsinglechoice();
			int multicount = paper.getMultichoice() + paper.getRmdmultichoice();
			int blankcount = paper.getBlank() + paper.getRmdblank();
			int essaycount = paper.getEssay() + paper.getRmdessay();
			paper.setTotalmark(singlecount
					* Integer.valueOf(paper.getSinglechoicemark())
					+ multicount
					* Integer.valueOf(paper.getMultichoicemark())
					+ blankcount * Integer.valueOf(paper.getBlankmark())
					+ essaycount * Integer.valueOf(paper.getEssaymark()));
			baseDao.update(paper);
			rhs.put("page", "editpage");
			knowledgevalue.clear();
			list();
		}
		
		rhs.put("knowledgeRootList", knowledgerootlist);
		return "success";
	}
	
	public String edititem() throws Exception{
		//String templateid = getpara("templateid");
		String paperid = getpara("paperid");
		List<Knowledge> knowledgerootlist = common_get_tree_root("Knowledge");
		rhs.put("knowledgeRootList", knowledgerootlist);
		//Template temp = (Template)baseDao.loadById("Template", Long.valueOf(templateid));
		Paper temppaper = (Paper)baseDao.loadById("Paper", Long.valueOf(paperid));
		
		rhs.put("page", "setpaper");
		rhs.put("paper", temppaper);
		//rhs.put("template", temp);
		return "success";
	}
	

	public String addreqitem() {
		int p = 0,j = 0,k = 0,l = 0;
		Set<Item> datalist = new HashSet<Item>();
		String paperid = getpara("paperid");
		String itemtype = getpara("type");
		String itemid = getpara("itemid");
		Set<Item> items = new HashSet<Item>();

		Paper paper = (Paper) baseDao.loadById("Paper",
				Long.valueOf(paperid));
		items = paper.getItems();

		Item item = (Item) baseDao.loadById("Item", Long.valueOf(itemid));
		
		if(!items.contains(item)){
			items.add(item);
		}else{
			items.remove(item);
		}
		paper.setItems(items);
		for (Item tempitem : items) {
			switch(tempitem.getType()){
			case 1:
				p++;
				break;
			case 2:
				j++;
				break;
			case 3:
				k++;
				break;
			case 4:
				l++;
				break;
			}
		}
		paper.setSinglechoice(p);
		paper.setMultichoice(j);
		paper.setBlank(k);
		paper.setEssay(l);
		paper.setTotalmark((p + paper.getRmdsinglechoice())
				* paper.getSinglechoicemark() + (j + paper.getRmdmultichoice())
				* paper.getMultichoicemark() + (k + paper.getRmdblank())
				* paper.getBlankmark() + (l + paper.getRmdessay())
				* paper.getEssaymark());
		baseDao.update(paper);
		
		for (Item reqitem : items) {
			if(itemtype.equals(String.valueOf(reqitem.getType()))){
				datalist.add(reqitem);
			}
		}
		rhs.put("datalist", datalist);
		rhs.put("itemtype", itemtype);
		return "success";
	}
	
	public String setitem() throws Exception{
		Set<Knowledge> knowledge = new HashSet<Knowledge>();
		List<Knowledge> knowledgerootlist = common_get_tree_root("Knowledge");
		rhs.put("knowledgeRootList", knowledgerootlist);
		if (knowledgevalue.size() > 0) {
			for (String value : knowledgevalue) {
				Knowledge kn = getKnowledgeById(knowledgerootlist, value);
				knowledge.add(kn);
			}
		}
		String paperid = getpara("paperid");
		Set<Item> items = new HashSet<Item>();
		//添加必选题
		int singlechoice = reqsinglechoice.size();
		int multichoice = reqmultichoice.size();
		int blank = reqblank.size();
		int essay = reqessay.size();
		
		paper.setSinglechoice(singlechoice);
		paper.setMultichoice(multichoice);
		paper.setBlank(blank);
		paper.setEssay(essay);
		
		List<String> datalist = new ArrayList<String>();
		datalist.addAll(reqsinglechoice);
		datalist.addAll(reqmultichoice);
		datalist.addAll(reqblank);
		datalist.addAll(reqessay);
		
		for (String itemid : datalist) {
			Item item = (Item) baseDao.loadById("Item", Long.valueOf(itemid));
			items.add(item);
		}
		paper.setItems(items);
		paper.setKnowledge(knowledge);// 添加知识领域
		//baseDao.update(template);
		Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(paperid));
		int singlecount = paper.getSinglechoice() + paper.getRmdsinglechoice();
		int multicount = paper.getMultichoice() + paper.getRmdmultichoice();
		int blankcount = paper.getBlank() + paper.getRmdblank();
		int essaycount = paper.getEssay() + paper.getRmdessay();
		paper.setTotalmark(singlecount
				* Integer.valueOf(paper.getSinglechoicemark())
				+ multicount
				* Integer.valueOf(paper.getMultichoicemark())
				+ blankcount * Integer.valueOf(paper.getBlankmark())
				+ essaycount * Integer.valueOf(paper.getEssaymark()));
		baseDao.update(paper);
		//rhs.put("page", "editpage");
		knowledgevalue.clear();
		list();
		rhs.put("knowledgeRootList", knowledgerootlist);
		rhs.put("page", "editpage");
		return "success";
	}
	
	public String assign(){
		String id = getpara("id");
		Paper paper = (Paper) baseDao.loadById("Paper", Long.parseLong(id));
		//Template template = paper.getTemplate();
		if(paper.getRmdblank() != 0 || paper.getBlank() != 0 || paper.getEssay() != 0 || paper.getRmdessay() != 0 ){
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
			// Set<Item> items = paper.getItems();
			// for (Item item : items) {
			// if(!"0".equals(item.getMark()) && item.getMark() != null){
			// byexcel = true;
			// break;
			// }
			// }
			//如果是excel导入的，就把所有题目显示出来//目前只显示了单选。因为，目前通过excel导入只能是单选题
			//if(byexcel){
				//Template template = paper.getTemplate();
				Set<Item> singleitems = new HashSet<Item>();
				Set<Item> multiitems = new HashSet<Item>();
				Set<Item> blankitems = new HashSet<Item>();
				Set<Item> essayitems = new HashSet<Item>();
				Collection<Item> reqsingleitems = paper.getReqItem("1");
				Collection<Item> rmdsingleitems = paper.getRmdItem("1", paper.getRmdsinglechoice());
				Collection<Item> reqmultiitems = paper.getReqItem("2");
				Collection<Item> rmdmultiitems = paper.getRmdItem("2", paper.getRmdmultichoice());
				Collection<Item> reqblankitems = paper.getReqItem("3");
				Collection<Item> rmdblankitems = paper.getRmdItem("3", paper.getRmdblank());
				Collection<Item> reqessayitems = paper.getReqItem("4");
				Collection<Item> rmdessayitems = paper.getRmdItem("4", paper.getRmdessay());
				singleitems.addAll(reqsingleitems);
				singleitems.addAll(rmdsingleitems);
				multiitems.addAll(reqmultiitems);
				multiitems.addAll(rmdmultiitems);
				blankitems.addAll(reqblankitems);
				blankitems.addAll(rmdblankitems);
				essayitems.addAll(reqessayitems);
				essayitems.addAll(rmdessayitems);
				rhs.put("singleitems", singleitems);
				rhs.put("multiitems", multiitems);
				rhs.put("blankitems", blankitems);
				rhs.put("essayitems", essayitems);
				rhs.put("paper", paper);
				//rhs.put("template", template);
			//}
			Set<Knowledge> knowledges = paper.getKnowledge();
			int maxsinglechoicecount = 0;
			int maxmultichoicecount = 0;
			for (Knowledge knowledge : knowledges) {
				Set<Item> tmpitems = knowledge.getItems();
				for (Item item : tmpitems) {
					switch(item.getType()){
					case 1:
						maxsinglechoicecount ++;
						break;
					case 2:
						maxmultichoicecount ++;
						break;
					case 3:
						break;
					case 4:
						break;
					}
				}
			}
			rhs.put("maxmultichoicecount", maxmultichoicecount);
			rhs.put("maxsinglechoicecount", maxsinglechoicecount);
		}
		rhs.put("byexcel", byexcel);
		rhs.put("method", getpara("method"));
		return "success";
	}

	public String getmaxitem() throws Exception{
		int maxsinglechoicecount = 0;
		int maxmultichoicecount = 0;
		Set<Knowledge> knowledges = new HashSet<Knowledge>();
		List<Knowledge> knowledgerootlist = common_get_tree_root("Knowledge");
		String[] knowledgesid = getpara("knowledgesid").split(",");
		if (knowledgesid.length > 0) {
			for (String value : knowledgesid) {
				Knowledge kn = getKnowledgeById(knowledgerootlist, value);
				if(kn != null){
					knowledges.add(kn);
				}
			}
			for (Knowledge knowledge : knowledges) {
				Set<Item> tmpitems = knowledge.getItems();
				for (Item item : tmpitems) {
					switch (item.getType()) {
					case 1:
						maxsinglechoicecount++;
						break;
					case 2:
						maxmultichoicecount++;
						break;
					case 3:
						break;
					case 4:
						break;
					}
				}
			}
		}
		rhs.put("maxsinglechoicecount", maxsinglechoicecount);
		rhs.put("maxmultichoicecount", maxmultichoicecount);
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
		Collections.sort(list);
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

	public Paper getPaper() {
		return paper;
	}

	public void setPaper(Paper paper) {
		this.paper = paper;
	}
	
}
