package com.app.exam.action;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.exam.model.Knowledge;
import com.app.exam.model.Paper;
import com.app.exam.model.Papergroup;
import com.app.exam.model.Template;

@Scope("prototype")
@Component("papergroupAction")
public class PapergroupAction extends BaseEaAction {

	public Collection<String> knowledgevalue = new ArrayList<String>();
	public Papergroup papergroup = new Papergroup();
	public Collection<String> paperid = new ArrayList<String>();
	
	public String get_list_sql() {
		return "from Papergroup";
	}

	public String get_paperlist_sql() {
		return "from Paper";
	}
	
	public String list() throws Exception {
		Set<Papergroup> list = new HashSet<Papergroup>();
		String sql = getSearchSql(get_list_sql());
		getPageData(sql);
		list.addAll((Collection<? extends Papergroup>) rhs.get("dataList"));
		rhs.put("dataList", list);
		rhs.put("knowledgeRootList", common_get_tree_root("Knowledge"));
		return "success";
	}
	
	public String save() throws Exception{
		String method = getpara("method");
		Set<Paper> papers = new HashSet<Paper>();
		if("show".equals(method)){
			rhs.put("page", "initpapergroup");
			return "success";
		}else if("initpapergroup".equals(method)){
			if(papergroup.getId() == null){
				baseDao.create(papergroup);
			}else{
				baseDao.update(papergroup);
			}
			
			rhs.put("papergroup", papergroup);
			rhs.put("page", "addpage");
			rhs.put("readonly", false);
		}else if("edit".equals(method)){
			rhs.put("page", "editpage");
			for (String paperId : paperid) {
				Paper paper = (Paper) baseDao.loadById("Paper", Long.valueOf(paperId));
				papers.add(paper);
			}
			papergroup.setPapers(papers);
			baseDao.update(papergroup);
			list();
		}
		
		return "success";
	}

	public String listpaper() throws Exception {
		Set<Papergroup> list = new HashSet<Papergroup>();
		String sql = getSearchSql(get_paperlist_sql());
		getPageData(sql);
		list.addAll((Collection<? extends Papergroup>) rhs.get("dataList"));
		rhs.put("paperlist", list);
		Papergroup papergroup = (Papergroup) baseDao.loadById("Papergroup",
				Long.valueOf(getpara("papergroupid")));
		rhs.put("papergroup", papergroup);
		return "success";
	}

	public String addreqpaper() {
		String papergroupid = getpara("papergroupid");
		String paperid = getpara("paperid");

		Papergroup papergroup = (Papergroup) baseDao.loadById("Papergroup",
				Long.valueOf(papergroupid));
		Set<Paper> papers = new HashSet<Paper>();
		papers = papergroup.getPapers();
		
		Paper paper = (Paper) baseDao.loadById("Paper", Long.valueOf(paperid));
		
		if (!papers.contains(paper)) {
			papers.add(paper);
			paper.setPapergroup(papergroup);
		} else {
			papers.remove(paper);
			paper.setPapergroup(null);
		}
		//papergroup.setPapers(papers);
		
		baseDao.update(papergroup);
		rhs.put("datalist", papers);
		return "success";
	}

	public String load() {
		if (!getpara("id").equals("")) {
			Papergroup papergroup = (Papergroup) baseDao.loadById("Papergroup",
					Long.parseLong(getpara("id")));
			rhs.put("papergroup", papergroup);
			if ("show".equals(getpara("method"))) {
				rhs.put("readonly", true);
			} else if ("edit".equals(getpara("method"))) {
				rhs.put("readonly", false);
			}
		}
		return "success";
	}

	public String delete() throws Exception {
		String papergroupid = getpara("id");
		Papergroup papergroup = (Papergroup) baseDao.loadById("Papergroup",
				Long.valueOf(papergroupid));
		for (Paper paper : papergroup.getPapers()) {
			paper.setPapergroup(null);
		}
		papergroup.setPapers(null);
		baseDao.delete(papergroup);
		list();
		return "success";
	}
	public String change_rank() throws Exception {
		common_change_rank(); 
		load();
		rhs.put("info_type", "success");
		rhs.put("info", "改变顺序成功!");
		return "success";
	}
	
}
