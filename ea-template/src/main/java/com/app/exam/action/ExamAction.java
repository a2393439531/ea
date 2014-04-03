package com.app.exam.action;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.activiti.engine.task.Task;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.activiti.action.BaseProcessAction;
import com.app.common.activiti.api.OaTask;
import com.app.common.spring.ssh.page.Pagination;
import com.app.exam.model.Item;
import com.app.exam.model.Paper;
import com.app.exam.model.Result;
import com.app.exam.model.Template;

@Scope("prototype")
@Component("examAction")
public class ExamAction extends BaseProcessAction {
	
	public List<Result> result = new ArrayList<Result>();
	
	public String open_exam(){
		String taskId = getpara("taskId");
		String taskPage = getpara("taskPage");
		String paperId = (String)infActiviti.getVariableByTaskId(taskId, "formId");
		String method = getpara("method");
		
		Task task = infActiviti.getTaskById(taskId);
		Paper paper = (Paper) baseDao.loadById("Paper", Long.valueOf(paperId));
		Template template = paper.getTemplate();
		
		
		if("start".equals(method)){
			//先判断eception
			String exception = (String)infActiviti.getVariableByTaskId(taskId, "exception");
			if(!"".equals(exception) && exception != null && Boolean.valueOf(exception)){
				//不是正常完成
				Map<String,Object> var = new HashMap<String, Object>();
				String assignee = (String) infActiviti.getVariableByTaskId(taskId, "assignee");
				//测试注释
				//infActiviti.completeTaskVar(taskId, paperId, assignee, var);
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
				//测试注释
				//String processInstanceId = task.getProcessInstanceId();
				//infActiviti.setVariableByProcessInstanceId(processInstanceId, "exception", true);
			}
			
		}else if("reason".equals(method)){
			
		
		}else if("judge".equals(method)){
			
		
		}
		
		
		rhs.put("paper", paper);
		rhs.put("template", template);
		rhs.put("task", task);
		rhs.put("method", method);
		rhs.put("taskPage", taskPage);
		return "success";
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
		
		if("assign".equals(method)){
			if(paperId == null || "".equals(paperId)){
				paperId = getpara("paperid");
			}
			String judge = getpara("judge"); //拿到判卷人
			String autojudge = getpara("autojudge");
			var.put("auto", Boolean.valueOf(autojudge));
			var.put("judge", judge);
			String[] assignees = getpara("assignee").split(",");//拿到分配考试的人,有可能是多人
			//针对每个人,启动流程
			for (String assignee : assignees) {
				infActiviti.startProcessAssigneeVar("ExamProcess", paperId, getCurrentAccount(), assignee, var);
			}
		}else if("start".equals(method)){
			int itemscount = result.size();
			System.out.println(itemscount);
			
		}else if("reason".equals(method)){
			
		}else if("judge".equals(method)){
			
		}
		
		rhs.put("resultMessage", "成功完成任务。");
		return "success";
		
	}

	public List<Result> getResults() {
		return result;
	}

	public void setResults(List<Result> result) {
		this.result = result;
	}
	
}
