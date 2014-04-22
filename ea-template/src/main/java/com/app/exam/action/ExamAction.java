package com.app.exam.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.task.Task;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.activiti.action.BaseProcessAction;
import com.app.common.activiti.api.OaTask;
import com.app.common.spring.ssh.page.Pagination;
import com.app.exam.model.Examrecord;
import com.app.exam.model.Item;
import com.app.exam.model.Knowledge;
import com.app.exam.model.Paper;
import com.app.exam.model.Result;
import com.app.exam.model.Template;
import com.app.exam.util.ExcelUtil;

@Scope("prototype")
@Component("examAction")
public class ExamAction extends BaseProcessAction {
	
	public List<Result> result = new ArrayList<Result>();
	public List<String> singlechoicemark = new ArrayList<String>();
	public List<String> multichoicemark = new ArrayList<String>();
	public List<String> blankmark = new ArrayList<String>();
	public List<String> essaymark = new ArrayList<String>();
	public Template template = new Template();
	
	public String get_template_list_sql() {
		return "from Template";
	}
	
	public String open_exam(){
		String taskId = getpara("taskId");
		String taskPage = getpara("taskPage");
		String paperId = (String)infActiviti.getVariableByTaskId(taskId, "formId");
		String method = getpara("method");
		
		if("".equals(paperId)){
			taskPage = "exam/exam_list.ftl";
			rhs.put("taskPage", taskPage);
			return exam_list();
		}else{
			Task task = infActiviti.getTaskById(taskId);
			Paper paper = (Paper) baseDao.loadById("Paper", Long.valueOf(paperId));
			Template template = paper.getTemplate();
			
			
			if("start".equals(method)){
				//先判断eception
				String exception = String.valueOf(infActiviti.getVariableByTaskId(taskId, "exception"));
				if(!"".equals(exception) && exception != null && Boolean.valueOf(exception)){
					//不是正常完成
					Map<String,Object> var = new HashMap<String, Object>();
					String assignee = (String) infActiviti.getVariableByTaskId(taskId, "assignee");
					infActiviti.completeTaskVar(taskId, paperId, assignee, var);
					method = "reason";
					taskPage = "exam/reason.ftl";
				}else{
					//开始考试
					Set<Item> singleitems = new HashSet<Item>();
					Collection<Item> rmdsingleitems = template.getRmdItem("1", template.getRmdsinglechoice());
					Collection<Item> reqsingleitems = template.getReqItem("1");
					singleitems.addAll(reqsingleitems);
					singleitems.addAll(rmdsingleitems);
					
					Set<Item> multiitems = new HashSet<Item>();
					Collection<Item> rmdmultiitems = template.getRmdItem("2", template.getRmdmultichoice());
					Collection<Item> reqmultiitems = template.getReqItem("2");
					multiitems.addAll(reqmultiitems);
					multiitems.addAll(rmdmultiitems);
					
					Set<Item> blankitems = new HashSet<Item>();
					Collection<Item> rmdblankitems = template.getRmdItem("3", template.getRmdblank());
					Collection<Item> reqblankitems = template.getReqItem("3");
					blankitems.addAll(reqblankitems);
					blankitems.addAll(rmdblankitems);
					
					Set<Item> essayitems = new HashSet<Item>();
					Collection<Item> rmdessayitems = template.getRmdItem("4", template.getRmdessay());
					Collection<Item> reqessayitems = template.getReqItem("4");
					essayitems.addAll(reqessayitems);
					essayitems.addAll(rmdessayitems);
					
					rhs.put("singleitems", singleitems);
					rhs.put("multiitems", multiitems);
					rhs.put("blankitems", blankitems);
					rhs.put("essayitems", essayitems);
					
					//同时设置exception为true，只有考生正确complete exam，exception才为false。
					String processInstanceId = task.getProcessInstanceId();
					infActiviti.setVariableByProcessInstanceId(processInstanceId, "exception", true);
				}
				
			}else if("reason".equals(method)){
				
			
			}else if("judge".equals(method)){
				Set<Result> singleitems = new HashSet<Result>();
				Set<Result> multiitems = new HashSet<Result>();
				Set<Result> blankitems = new HashSet<Result>();
				Set<Result> essayitems = new HashSet<Result>();
				String assignee = (String) infActiviti.getVariableByTaskId(taskId, "assignee");
				String recordsId = String.valueOf(infActiviti.getVariableByProcessInstanceId(task.getProcessInstanceId(), "recordsId"));
				
				
				Set<Examrecord> allresults = paper.getResultdetailByAccountAndRecordId(assignee,recordsId);
				Set<Result> results = new HashSet<Result>();
				for (Examrecord examrecord : allresults) {
					results.addAll(examrecord.getResult());
				}
				
				//上面拿到指定用户的结果
				for (Result result : results) {
					Item item = result.getItem(); 
					switch (item.getType()) {
					case 1:
						singleitems.add(result);
						break;
					case 2:
						multiitems.add(result);
						break;
					case 3:
						blankitems.add(result);
						break;
					case 4:
						essayitems.add(result);
						break;
					}
				}
				rhs.put("singleitems", singleitems);
				rhs.put("multiitems", multiitems);
				rhs.put("blankitems", blankitems);
				rhs.put("essayitems", essayitems);
			}
			
			
			rhs.put("paper", paper);
			rhs.put("template", template);
			rhs.put("task", task);
			rhs.put("method", method);
			rhs.put("taskPage", taskPage);
			return "success";
		}
	}
	
	public String exam_list(){
		String pageId = getpara("pageId");
		String maxSize = getpara("maxSize");
		if(pageId.equals("")) pageId = "1";
		if(maxSize.equals("")) maxSize = "20";

		Map<String, Object> map = infActiviti.getAssignedOaTaskListByAccount(getCurrentAccount(), Integer.parseInt(pageId), Integer.parseInt(maxSize));
		
		List<OaTask> assigneeList = (List<OaTask>) map.get("dataList");
		
		List<OaTask> allData = new ArrayList< OaTask>();
		
		for (OaTask oaTask : assigneeList) {
			Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(oaTask.getFormId()));
			oaTask.setObj(paper);
			String taskname = oaTask.getTask().getTaskDefinitionKey();
			if("usertask4".equals(taskname)){
				oaTask.setMethod("Judge");
			}else if("usertask2".equals(taskname)){
				oaTask.setMethod("Start");
			}else if("usertask3".equals(taskname)){
				oaTask.setMethod("Input Reason");
			}
			allData.add(oaTask);
		}

		Pagination p = (Pagination)map.get("pagination");
		rhs.put("oatasklist", allData);
		rhs.put("maxSize", p.getMaxSize());
		rhs.put("count", p.getTotalSize());
		rhs.put("maxPage", p.getTotalPage());
		rhs.put("currentPage", p.getCurrentPage());
		return "success";
	}
	
	public String complete_task(){
		Map<String, Object> var = new HashMap<String, Object>();
		String taskId = getpara("taskId"); //如果method为assigne，则taskid为空
		String taskPage = getpara("taskPage");
		String paperId = (String)infActiviti.getVariableByTaskId(taskId, "formId");
		String method = getpara("method");
		Task task = infActiviti.getTaskById(taskId);
		
		if(paperId == null || "".equals(paperId)){
			paperId = getpara("paperid");
		}
		
		
		if("assign".equals(method)){
			String autojudge = getpara("autojudge");
			if("".equals(autojudge) || autojudge == null){
				var.put("auto", true);
			}else{
				var.put("auto", false);
				String judge = getpara("judge"); //拿到判卷人
				var.put("judge", judge);
			}
			String[] assignees = getpara("assignee").split(",");//拿到分配考试的人,有可能是多人
			//针对每个人,启动流程
			for (String assignee : assignees) {
				infActiviti.startProcessAssigneeVar("ExamProcess", paperId, getCurrentAccount(), assignee, var);
			}
		}else if("start".equals(method)){
			Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(paperId));
			Examrecord record = new Examrecord();
			record.setUserid(getCurrentAccount());
			record.setPaper(paper);
			//record.setRemark("Wait for judge");
			baseDao.create(record);
			for (Result res : result) {
				//res.setPaper(paper);
				res.setExamrecord(record);
				res.setUser(getCurrentAccount());
				Item item = (Item) baseDao.loadById("Item", res.getItem().getId());
				res.setItem(item);
				baseDao.create(res);
			}
			Set<Result> resultset = new HashSet<Result>();
			resultset.addAll(result);
			record.setResult(resultset);
			baseDao.update(record);
			//设置异常为false
			String processInstanceId = task.getProcessInstanceId();
			infActiviti.setVariableByProcessInstanceId(processInstanceId, "exception", false);
			//设置recordId，方便自动评卷拿到
			infActiviti.setVariableByProcessInstanceId(processInstanceId, "recordsId", record.getId());
			//end
			infActiviti.completeTaskVar(taskId, paperId, getCurrentAccount(), var);
		}else if("reason".equals(method)){
			String reason = getpara("reason");
			Examrecord record = new Examrecord();
			record.setUserid((String) infActiviti.getVariableByTaskId(taskId, "assignee"));
			record.setSinglechoicemark(0);
			record.setMultichoicemark(0);
			record.setBlankmark(0);
			record.setEssaymark(0);
			record.setResult(null);
			record.setPaper((Paper)baseDao.loadById("Paper", Long.valueOf(paperId)));
			record.setRemark("Failed, reason: "+reason);
			baseDao.create(record);
			infActiviti.completeTaskVar(taskId, paperId, getCurrentAccount(), var);
		}else if("judge".equals(method)){
			int singlechoicetotalmark = 0;
			int multichoicetotalmark = 0;
			int blanktotalmark = 0;
			int essaytotalmark = 0;
			String recordsId = String.valueOf(infActiviti.getVariableByProcessInstanceId(task.getProcessInstanceId(), "recordsId"));
			Examrecord record = (Examrecord)baseDao.loadById("Examrecord", Long.valueOf(recordsId));
			
			for (Result res : result) {
				Result result = (Result)baseDao.loadById("Result", res.getId());
				result.setMark(res.getMark());
				baseDao.update(result);
				switch (result.getItem().getType()) {
				case 1:
					singlechoicetotalmark += res.getMark();
					break;
				case 2:
					multichoicetotalmark += res.getMark();
					break;
				case 3:
					blanktotalmark += res.getMark();
					break;
				case 4:
					essaytotalmark += res.getMark();
					break;
				}
			}
			record.setSinglechoicemark(singlechoicetotalmark);
			record.setMultichoicemark(multichoicetotalmark);
			record.setBlankmark(blanktotalmark);
			record.setEssaymark(essaytotalmark);
			record.setUserid((String) infActiviti.getVariableByTaskId(taskId, "assignee"));
			record.setPaper((Paper)baseDao.loadById("Paper", Long.valueOf(paperId)));
			record.setRemark("Success, judged by " + getCurrentUser().getName());
			record.setResult(record.getResult());
			baseDao.update(record);
			
			infActiviti.completeTaskVar(taskId, paperId, getCurrentAccount(), var);
		}
		
		rhs.put("resultMessage", "成功完成任务。");
		return "success";
		
	}
	
	public String choicetemplate() throws Exception{
		List<Knowledge> knowledgerootlist = common_get_tree_root("Knowledge");
		String method = getpara("method");
		String sql = get_template_list_sql();
		getPageData(sql);
		rhs.put("knowledgeRootList", knowledgerootlist);
		return "success";
	}

	public String show_record() throws Exception {
		String templateid = getpara("templateid");
		String useraccount = getCurrentAccount();
		List<Examrecord> dataList = new ArrayList<Examrecord>();
		if (!"".equals(templateid) && templateid != null) {
			String sql = " from Template t where t.id=" + "'" + templateid
					+ "'";
			getPageData(sql);
			template = ((List<Template>) rhs.get("dataList")).get(0);
		}
		Set<Paper> papers = template.getPapers();

		for (Paper paper : papers) {
			Set<Examrecord> examrecords = paper.getResultdetail();
			for (Examrecord examrecord : examrecords) {
				if (examrecord.getUserid().equals(useraccount)) {
					dataList.add(examrecord);
				}
			}
		}
		for (Knowledge knowledge : template.getKnowledge()) {
			if(knowledge.getName().equals("职业性格测试")){
				rhs.put("page", "psychology");
			}else{
				rhs.put("page", "normal");
			}
		}
		rhs.put("datalist", dataList);
		return "success";
	}

	public String exam_record_list() throws Exception{
		String useraccount = getCurrentAccount();
		List<Examrecord> dataList = new ArrayList<Examrecord>();
		Map<String,List<Examrecord>> dataMap = new HashMap<String, List<Examrecord>>();
		String sql = " from Examrecord r ";//where r.userid=" + "'" +useraccount+"'
		
		getPageData(sql);
		
		List<Examrecord> recordList = (List)rhs.get("dataList");
		
		if(!getCurrentUser().getAccount().equals("admin")){
			for (Examrecord examrecord : recordList) {
				if(examrecord.getUserid().equals(useraccount)&&examrecord.getPaper() != null){
					String papername = examrecord.getPaper().getName();
					List<Examrecord> examrecords = dataMap.get(papername);
					if(examrecords == null){
						examrecords = new ArrayList<Examrecord>();
					}
					examrecords.add(examrecord);
					dataMap.put(papername, examrecords);
				}
			}
			rhs.put("export", false);
		}else{
			for (Examrecord examrecord : recordList) {
				if(examrecord.getPaper() != null){
					String papername = examrecord.getPaper().getName();
					List<Examrecord> examrecords = dataMap.get(papername);
					if(examrecords == null){
						examrecords = new ArrayList<Examrecord>();
					}
					examrecords.add(examrecord);
					dataMap.put(papername, examrecords);
				}
			}
			rhs.put("export", true);
		}
		rhs.put("datalist", dataMap);
		return "success";
	}
	
	public String export_record() throws IOException{
		String paperId = getpara("paperId");
		
		Paper paper = (Paper) baseDao.loadById("Paper", Long.valueOf(paperId));
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-disposition", 
                "attachment; filename=export_result.xls");
        ServletOutputStream os = response.getOutputStream();
		ExcelUtil.exportToExcel(paper, os);
		os.close();
		return null;
	}
	
	public String exam_record_detail(){
		String paperId = getpara("paperId");
		String recordsId = getpara("recordsId");
		Paper paper = (Paper) baseDao.loadById("Paper", Long.valueOf(paperId));
		Template template = paper.getTemplate();
		Set<Result> singleitems = new HashSet<Result>();
		Set<Result> multiitems = new HashSet<Result>();
		Set<Result> blankitems = new HashSet<Result>();
		Set<Result> essayitems = new HashSet<Result>();
		String assignee = getCurrentAccount();
		Set<Examrecord> allresults = paper.getResultdetailByAccountAndRecordId(assignee, recordsId);
		
		Set<Result> results = new HashSet<Result>();
		for (Examrecord examrecord : allresults) {
			results.addAll(examrecord.getResult());
		}
		//上面拿到指定用户的结果
		for (Result result : results) {
			Item item = result.getItem(); 
			switch (item.getType()) {
			case 1:
				singleitems.add(result);
				break;
			case 2:
				multiitems.add(result);
				break;
			case 3:
				blankitems.add(result);
				break;
			case 4:
				essayitems.add(result);
				break;
			}
		}
		rhs.put("singleitems", singleitems);
		rhs.put("multiitems", multiitems);
		rhs.put("blankitems", blankitems);
		rhs.put("essayitems", essayitems);
		rhs.put("paper", paper);
		rhs.put("template", template);
		
		return "success";
	}
	
	public List<Result> getResults() {
		return result;
	}

	public void setResults(List<Result> result) {
		this.result = result;
	}
	
}
