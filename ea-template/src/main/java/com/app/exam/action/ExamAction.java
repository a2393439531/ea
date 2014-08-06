package com.app.exam.action;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.task.Task;
import org.apache.struts2.ServletActionContext;
import org.restlet.representation.Representation;
import org.restlet.resource.ClientResource;
import org.restlet.resource.ResourceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.activiti.action.BaseProcessAction;
import com.app.common.activiti.api.OaTask;
import com.app.common.spring.ssh.page.Pagination;
import com.app.ea.hsql.Hsql;
import com.app.ea.model.User;
import com.app.exam.model.Examarrange;
import com.app.exam.model.Examrecord;
import com.app.exam.model.Item;
import com.app.exam.model.Knowledge;
import com.app.exam.model.Monitor;
import com.app.exam.model.Paper;
import com.app.exam.model.Papergroup;
import com.app.exam.model.Result;
import com.app.exam.util.ExcelUtil;
import com.utils.cache.Cache;
import com.utils.hardinfo.HardInfo;
import com.utils.time.TimeUtil;

@Scope("prototype")
@Component("examAction")
public class ExamAction extends BaseProcessAction {
	private static Logger log = LoggerFactory.getLogger(ExamAction.class);
	public List<Result> result = new ArrayList<Result>();
	public List<String> singlechoicemark = new ArrayList<String>();
	public List<String> multichoicemark = new ArrayList<String>();
	public List<String> blankmark = new ArrayList<String>();
	public List<String> essaymark = new ArrayList<String>();
	public List<String> examrecordIds = new ArrayList<String>();
	
	public String get_template_list_sql() {
		return "from Template";
	}
	
	public String open_exam() throws ParseException{
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
			//Template template = paper.getTemplate();
			
			
			if("start".equals(method)){
				Map<String,Object> dataMap = (Map<String, Object>) Cache.get(getCurrentAccount());
				if(dataMap == null){
					dataMap = new HashMap<String, Object>();
				}
				//首先判断是否达到开考时间
				String examarrangeid = String.valueOf(infActiviti.getVariableByTaskId(taskId, "examarrangeid"));
				if(!"".equals(examarrangeid) && examarrangeid != null){
					Examarrange examarrange = (Examarrange)baseDao.loadById("Examarrange", Long.valueOf(examarrangeid));
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//should be yyyy-MM-dd HH:mm:ss
					String current_str = sdf.format(new Date());
					Date current = sdf.parse(current_str);
					Date start = sdf.parse(examarrange.getStarttime());
					Date end = sdf.parse(examarrange.getEndtime());
					Calendar calendar_current=Calendar.getInstance(); 
					calendar_current.setTime(current);
					
					Calendar calendar_start=Calendar.getInstance(); 
					calendar_start.setTime(start);
					Calendar calendar_end=Calendar.getInstance(); 
					calendar_end.setTime(end);
					
					if(calendar_current.before(calendar_start)|| calendar_current.after(calendar_end)){
						method = "error";
						rhs.put("info", "Invalid Start Time!!");
						taskPage = "exam/error.ftl";
					}else{
						//先判断eception
						String exception = String.valueOf(infActiviti.getVariableByTaskId(taskId, "exception"));
						if(!"".equals(exception) && exception != null && Boolean.valueOf(exception)){
							//不是正常完成
							Map<String,Object> var = new HashMap<String, Object>();
							String assignee = (String) infActiviti.getVariableByTaskId(taskId, "assignee");
							infActiviti.completeTaskVar(taskId, paperId, assignee, var);
							method = "reason";
							taskPage = "exam/reason.ftl";//应该跳转到一个提示页面，提示考试异常结束。而不是直接跳转到原因页面。
						}else{
							//开始考试
							Set<Item> singleitems = new HashSet<Item>();
							Collection<Item> rmdsingleitems = paper.getRmdItem("1", paper.getRmdsinglechoice());
							Collection<Item> reqsingleitems = paper.getReqItem("1");
							singleitems.addAll(reqsingleitems);
							singleitems.addAll(rmdsingleitems);
							
							Set<Item> multiitems = new HashSet<Item>();
							Collection<Item> rmdmultiitems = paper.getRmdItem("2", paper.getRmdmultichoice());
							Collection<Item> reqmultiitems = paper.getReqItem("2");
							multiitems.addAll(reqmultiitems);
							multiitems.addAll(rmdmultiitems);
							
							Set<Item> blankitems = new HashSet<Item>();
							Collection<Item> rmdblankitems = paper.getRmdItem("3", paper.getRmdblank());
							Collection<Item> reqblankitems = paper.getReqItem("3");
							blankitems.addAll(reqblankitems);
							blankitems.addAll(rmdblankitems);
							
							Set<Item> essayitems = new HashSet<Item>();
							Collection<Item> rmdessayitems = paper.getRmdItem("4", paper.getRmdessay());
							Collection<Item> reqessayitems = paper.getReqItem("4");
							essayitems.addAll(reqessayitems);
							essayitems.addAll(rmdessayitems);
							
							rhs.put("singleitems", singleitems);
							rhs.put("multiitems", multiitems);
							rhs.put("blankitems", blankitems);
							rhs.put("essayitems", essayitems);
							
							//以单个题显示,默认显示全部试题
							if(getpara("format").equals("single")){
								//首先跳转页面要改变
								taskPage = "exam/single.ftl";
								//把所有题目放入Cache
								List<Item> alldata = new ArrayList<Item>();
								alldata.addAll(singleitems);
								alldata.addAll(multiitems);
								alldata.addAll(blankitems);
								alldata.addAll(essayitems);
								for (Item item : alldata) {
									if(item.getChoiceitem().size() >0){
										item.getChoiceitem();
									}
								}
								//putSessionValue("items", alldata);
								dataMap.put("items", alldata);
								Cache.set(getCurrentAccount(), dataMap);
								rhs.put("index", dataMap.get("index") == null? 0: dataMap.get("index"));
								//放入第一题
								rhs.put("item", alldata.get(Integer.valueOf(dataMap.get("index") == null? 0:(Integer)dataMap.get("index"))));
								rhs.put("score", dataMap.get("score") == null? 0: dataMap.get("score"));
								if(dataMap.get("paper") != null){
									paper = (Paper) dataMap.get("paper");
								}
								// if(dataMap.get("template") != null){
								// template = (Template) dataMap.get("template");
								// }
								//用于考试异常中断的时候，能够拿到最后一次的examrecordid。以便继续考。(否则会新建一条examrecord，这不合理)。
								if(dataMap.get("allrecord") != null){
									String[] recordsId = ((String) dataMap.get("allrecord")).split(",");
									if(recordsId == null || ((Integer)dataMap.get("index")) == 0){
										rhs.put("examrecordId","");
									}else{
										rhs.put("examrecordId", recordsId[recordsId.length - 1]);
									}
								}
								
							}
							//同时设置exception为true，只有考生正确complete exam，exception才为false。
							//String processInstanceId = task.getProcessInstanceId();
							//infActiviti.setVariableByProcessInstanceId(processInstanceId, "exception", true);
						}
					}
				}else{
					method = "error";
					rhs.put("info", "Invalid Exam!");
					taskPage = "exam/error.ftl";
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
			//rhs.put("template", template);
			rhs.put("task", task);
			rhs.put("method", method);
			rhs.put("taskPage", taskPage);
			return "success";
		}
	}
	
	public String exam_complete(){
		return "success";
	}
	
	public String getstarttime() throws ParseException{
		String taskid = getpara("taskid");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String examarrangeid = String.valueOf(infActiviti.getVariableByTaskId(taskid, "examarrangeid"));
		StringBuffer starttime = new StringBuffer();
		if(!"".equals(examarrangeid) && examarrangeid != null){
			Examarrange examarrange = (Examarrange)baseDao.loadById("Examarrange", Long.valueOf(examarrangeid));
			Date start = sdf.parse(examarrange.getStarttime());
			Date end = sdf.parse(examarrange.getEndtime());
			String current_str = sdf.format(new Date());
			Date current = sdf.parse(current_str);
			if(current.before(start) || (current.before(end) && current.after(start))){
				starttime.append(TimeUtil.compareTwoDate(current, start));
			}else{
				starttime.append("Out of Date");
			}
		}else{
			starttime.append("Start Time was not set!");
		}
		rhs.put("starttime", starttime.toString());
		return "success";
	}
	
	public String monitorexam(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String keycode = getpara("keycode");
		String taskid = getpara("taskid");
		String paperid = (String) infActiviti.getVariableByTaskId(taskid, "formId");
		String assignee = (String)infActiviti.getVariableByTaskId(taskid, "assignee");
		
		
		Monitor monitor = new Monitor();
		monitor.setUserid(assignee);
		monitor.setPaperid(paperid);
		monitor.setTaskid(taskid);
		monitor.setOperation(keycode);
		monitor.setMonitordate(sdf.format(new Date()));
		
		baseDao.create(monitor);
		
		return null;
	}
	
	public String showlog() throws Exception{
		String taskid = getpara("taskid");
		String userid = getpara("userid");
		String paperid = getpara("paperid");
		
		String sql = "from Monitor m where m.userid='" + userid + "' and m.taskid='" + taskid + "' and m.paperid='" + paperid + "'";
		
		getPageData(sql);
		
		List<Monitor> list = (List)rhs.get("dataList");
		
		for (Monitor monitor : list) {
			
		}
		
		return "success";
	}
	
	public String show_miss_exam() throws ParseException{
		List<OaTask> outData = new ArrayList< OaTask>();
		if(!getCurrentAccount().equals("")){
			List<OaTask> assigneeList = infActiviti.getAssigneeTaskListByAccount(getCurrentAccount());
			for (OaTask oaTask : assigneeList) {
				Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(oaTask.getFormId()));
				oaTask.setObj(paper);
				String taskid = oaTask.getTask().getId();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//should be yyyy-MM-dd HH:mm:ss
				String examarrangeid = String.valueOf(infActiviti.getVariableByTaskId(taskid, "examarrangeid"));
				StringBuffer starttime = new StringBuffer();
				if(!"".equals(examarrangeid) && examarrangeid != null){
					Examarrange examarrange = (Examarrange)baseDao.loadById("Examarrange", Long.valueOf(examarrangeid));
					Date start = sdf.parse(examarrange.getStarttime());
					Date end = sdf.parse(examarrange.getEndtime());
					String current_str = sdf.format(new Date());
					Date current = sdf.parse(current_str);
					if(current.before(start) || (current.after(start)&&current.before(end) )){
					}else{
						//过期的使用另一个数组存放
						starttime.append("Out of Date");
						oaTask.setStarttime(starttime.toString());
						outData.add(oaTask);
					}
				}else{
					starttime.append("Start Time was not set!");
				}
			}
		}
		rhs.put("oatasklist_outdate", outData);
		return "success";
	}
	
	public String exam_list() throws ParseException{
		/*String pageId = getpara("pageId");
		String maxSize = getpara("maxSize");
		if(pageId.equals("")){
			pageId = getpara("historypageId");
		}
		if(maxSize.equals("")){
			maxSize = getpara("historymaxSize");
		}
		if(pageId.equals("")) pageId = "1";
		if(maxSize.equals("")) maxSize = "20";*/

		List<OaTask> assigneeList = infActiviti.getAssigneeTaskListByAccount(getCurrentAccount());
		// Map<String, Object> map = infActiviti.getAssignedOaTaskListByAccount(getCurrentAccount(), Integer.parseInt(pageId), Integer.parseInt(maxSize));
		 //List<OaTask> assigneeList = (List<OaTask>) map.get("dataList");
		List<Examarrange> examarranges = baseDao.find("from Examarrange");
		
		List<OaTask> allData = new ArrayList< OaTask>();
		List<OaTask> outData = new ArrayList< OaTask>();
		
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
			
			String taskid = oaTask.getTask().getId();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//should be yyyy-MM-dd HH:mm:ss
			String examarrangeid = String.valueOf(infActiviti.getVariableByTaskId(taskid, "examarrangeid"));
			StringBuffer starttime = new StringBuffer();
			if(!"".equals(examarrangeid) && examarrangeid != null){
				//Examarrange examarrange = (Examarrange)baseDao.loadById("Examarrange", Long.valueOf(examarrangeid));
				for(Examarrange examarrange: examarranges){
					if(!examarrangeid.equals(String.valueOf(examarrange.getId()))){
						continue;
					}else{
						Date start = sdf.parse(examarrange.getStarttime());
						Date end = sdf.parse(examarrange.getEndtime());
						String current_str = sdf.format(new Date());
						Date current = sdf.parse(current_str);
						if(current.before(start) || (current.after(start)&&current.before(end) )){
							starttime.append(TimeUtil.compareTwoDate(current, start));
							oaTask.setStarttime(starttime.toString());
							allData.add(oaTask);
						}else{
							//过期的使用另一个数组存放
							starttime.append("Out of Date");
							oaTask.setStarttime(starttime.toString());
							outData.add(oaTask);
						}
					}
				}
			}else{
				starttime.append("Start Time was not set!");
			}
		}

		//Pagination p = (Pagination)map.get("pagination");
		rhs.put("oatasklist", allData);
		rhs.put("oatasklist_outdate", outData);
		/*rhs.put("maxSize", p.getMaxSize());
		rhs.put("count", p.getTotalSize());
		rhs.put("maxPage", p.getTotalPage());
		rhs.put("currentPage", p.getCurrentPage());*/
		return "success";
	}
	
	public String exam_home() throws Exception{
		exam_record_list();
		exam_list();
		return "success";
	}
	//修改每页显示的个数
	public String change_page_number() throws Exception {
		putSessionValue("maxSize", getpara("maxSize"));
		exam_list();
		rhs.put("system_para_map", infEa.getParaMap());
		rhs.put("info_type", "success");
		rhs.put("info", "");
		return "success";
	}
    //翻页
	public String ajax_page_data() throws Exception {
		exam_list();
		rhs.put("info_type", "success");
		rhs.put("info", "success!");
		return "success";
	}

	// 修改每页显示的个数
	public String change_historypage_number() throws Exception {
		putSessionValue("maxSize", getpara("maxSize"));
		exam_list();
		exam_record_list();
		rhs.put("system_para_map", infEa.getParaMap());
		rhs.put("info_type", "success");
		rhs.put("info", "");
		return "success";
	}

	// 翻页
	public String ajax_historypage_data() throws Exception {
		exam_list();
		exam_record_list();
		rhs.put("info_type", "success");
		rhs.put("info", "success!");
		return "success";
	}
	public String complete_task() throws Exception{
		Map<String, Object> var = new HashMap<String, Object>();
		//完成task后的跳转页面
		String page = "exam_exam_exam_record_list.do";
		String taskId = getpara("taskId"); //如果method为assigne，则taskid为空
		String paperId = (String)infActiviti.getVariableByTaskId(taskId, "formId");
		String method = getpara("method");
		Task task = infActiviti.getTaskById(taskId);
		
		if(paperId == null || "".equals(paperId)){
			paperId = getpara("paperid");
		}
		
		if("assign".equals(method)){
			Map<String,String> result = new HashMap<String,String>();
			Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(paperId));
			String autojudge = getpara("autojudge");
			if("".equals(autojudge) || autojudge == null){
				var.put("auto", true);
			}else{
				var.put("auto", false);
				String judge = getpara("judge"); //拿到判卷人
				var.put("judge", judge);
			}
			String[] assignees = getpara("assignee").split(",");//拿到分配考试的人,有可能是多人
			String starttime = getpara("starttime");
			String endtime = getpara("endtime");
			//针对每个人,启动流程
			String processInstanceId = "";
			if(assignees.length > 1){
				Examarrange examarrange = new Examarrange();
				examarrange.setStarttime(starttime);
				examarrange.setEndtime(endtime);
				examarrange.setPaperid(paperId);
				examarrange.setUserid(getpara("assignee"));
				baseDao.create(examarrange);
				for (String assignee : assignees) {
					var.put("examarrangeid", examarrange.getId());
					if("".equals(processInstanceId)){
						processInstanceId = infActiviti.startProcessAssigneeVar("ExamProcess", paperId, getCurrentAccount(), assignee, var);
					}else{
						processInstanceId = processInstanceId + ","+ infActiviti.startProcessAssigneeVar("ExamProcess", paperId, getCurrentAccount(), assignee, var);
					}
					//add send email function at 2014/06/09 by HB
					String url ="http:/"+HardInfo.findNonLocalhostIp()+":"+getRequest().getLocalPort()+getRequest().getContextPath();
					String content = "<br/>The exam paper:<font color='red'>"
							+ paper.getName()
							+ "</font><br/>The exam enter time starts at <font color='red'>"
							+ starttime
							+ "</font>" + "<br/><font color='red'>URL:<a href='"+url+"'>"+url+"</a></font><br/><br/>Please attend the exam on time!";
					Map<String,String> data = sendStartEmail(assignee, content);
					Set<String> mails = data.keySet();
					for (String mail : mails) {
						result.put(assignee + ",Mail: "+ mail, data.get(mail));
					}
					//end
				}
			}else{
				Examarrange examarrange = new Examarrange();
				examarrange.setStarttime(starttime);
				examarrange.setEndtime(endtime);
				examarrange.setPaperid(paperId);
				examarrange.setUserid(assignees[0]);
				baseDao.create(examarrange);
				var.put("examarrangeid", examarrange.getId());
				processInstanceId = infActiviti.startProcessAssigneeVar("ExamProcess", paperId, getCurrentAccount(), assignees[0], var);
				//add send email function at 2014/06/09 by HB
				String url ="http:/"+HardInfo.findNonLocalhostIp()+":"+getRequest().getLocalPort()+getRequest().getContextPath();
				String content = "<br/>The exam paper:<font color='red'>"
						+ paper.getName()
						+ "</font><br/>The exam enter time starts at <font color='red'>"
						+ starttime
						+ "</font>" + "<br/><font color='red'>URL:<a href='"+url+"'>"+url+"</a></font><br/><br/>Please attend the exam on time!";
				Map<String,String> data = sendStartEmail(assignees[0], content);
				Set<String> mails = data.keySet();
				for (String mail : mails) {
					result.put(assignees[0] + ",Mail: "+ mail, data.get(mail));
				}
				//end
			}
			paper.setProcessInstanceId(processInstanceId);
			baseDao.update(paper);
			rhs.put("result", result);
			page = "exam_paper_list.do";
		}else if("start".equals(method)){
			Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(paperId));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Examrecord record = new Examrecord();
			record.setUserid(getCurrentAccount());
			record.setRecorddate(sdf.format(new Date()));
			record.setPaper(paper);
			record.setTaskid(taskId);
			record.setExamarrangeid(String.valueOf(infActiviti.getVariableByTaskId(taskId, "examarrangeid")));
			record.setRemark("Wait for judge");
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
			page = "exam_exam_exam_home.do";
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
			//page = "exam_exam_exam_home.do";
		}
		
		rhs.put("page", page);
		rhs.put("resultMessage", "成功完成任务。");
		return "success";
		
	}

	//计算当前一个题目的分数，并且继续下一题，该方法只能被用于以single方式打开试卷的时候。
	public String complete_task_single(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		boolean finsh = false;
		Examrecord examrecord = null;
		String allrecordid = "";
		Map<String, Object> var = new HashMap<String, Object>();
		Map<String, Object> dataMap = (Map<String, Object>) Cache.get(getCurrentAccount());
		String taskId = getpara("taskId");
		List<Item> items = (List<Item>) dataMap.get("items");
		int index = Integer.valueOf(((getpara("index").equals(""))?"0":getpara("index")));
		int score = Integer.valueOf(((getpara("score").equals(""))?"0":getpara("score")));
		String examrecordId = getpara("examrecordId");
		allrecordid = String.valueOf(dataMap.get("allrecord"));
		if("".equals(examrecordId)){
			examrecord = new Examrecord();
			examrecord.setTaskid(taskId);
			examrecord.setExamarrangeid((String)infActiviti.getVariableByTaskId(taskId, "examarrangeid"));
			examrecord.setUserid(getCurrentAccount());
			examrecord.setRecorddate(sdf.format(new Date()));
			examrecord.setRemark("Wait for judge");
			baseDao.create(examrecord);
			if(!"".equals(allrecordid) &&!"null".equals(allrecordid)&& allrecordid != null){
				allrecordid = allrecordid + "," + examrecord.getId();
				dataMap.put("allrecord", allrecordid);
			}else{
				allrecordid = String.valueOf(examrecord.getId());
				dataMap.put("allrecord", allrecordid);
			}
		}else{
			examrecord = (Examrecord)baseDao.loadById("Examrecord", Long.valueOf(examrecordId));
		}
		
		Task task = infActiviti.getTaskById(taskId);
		String paperId = (String)infActiviti.getVariableByTaskId(taskId, "formId");
		Paper paper = (Paper) dataMap.get("paper");
		if(paper == null){
			paper = (Paper) baseDao.loadById("Paper", Long.valueOf(paperId));
			Papergroup papergroup = paper.getPapergroup();
			if(papergroup != null){
				Set<Paper> papers = papergroup.getPapers();
				for (Paper paper2 : papers) {
				}
			}
			dataMap.put("paper", paper);
			dataMap.put("allpaper", paper.getId());
		}
		//Template template = (Template)getSessionValue("template");
		// Template template = (Template) dataMap.get("template");
		// if(template == null){
		// template = paper.getTemplate();
		// dataMap.put("template", template);
		// }
		//计算结果
		Set<Result> resultset = new HashSet<Result>();
		for (Result res : result) {
			if(res == null){
				continue;
			}
			Item item = (Item) baseDao.loadById("Item", res.getItem().getId());
			if(res.getAnswer()!=null&&res.getAnswer().equals(item.getRefkey())){
				if("0".equals(item.getMark()) || "".equals(item.getMark()) || item.getMark() == null){
					switch (item.getType()) {
					case 1:
						score += paper.getSinglechoicemark();
						break;
					case 2:
						score += paper.getMultichoicemark();
						break;
					case 3:
						score += paper.getBlankmark();
						break;
					case 4:
						score += paper.getEssaymark();
						break;
					}
				}else{
					score += Integer.valueOf(item.getMark());
				}
			}else{
				res.setMark(0);
			}
			res.setItem(item);
			res.setExamrecord(examrecord);
			res.setUser(getCurrentAccount());
			baseDao.create(res);
			resultset.add(res);
		}
		resultset.addAll(examrecord.getResult());
		
		examrecord.setResult(resultset);
		examrecord.setPaper(paper);
		examrecord.setUserid(getCurrentAccount());
		
		baseDao.update(examrecord);
		examrecordId = String.valueOf(examrecord.getId());
		
		//putSessionValue("score", score);
		//当score大于该paper的通过分数后，应该查询paper的下一组paper和tamplate。放入rhs。
		//然后根据template拿到item，更新session中的items,还有把index址零
		//同时应该新建一条examrecord来记录下一个试卷的result
		if(score > paper.getPassmark()){
			Papergroup papergroup = paper.getPapergroup();
			if(papergroup != null){
				//下一个试卷是由试卷组的所有试卷，按照sortnob从小到大排列，来定义的
				Paper temppaper = papergroup.getNextPaper(papergroup.getPapers(), paper);
				if(temppaper != null){
					String allpaperid = "";
					index = -1;
					score = 0;
					//该试卷记录完毕，应该把examrecordId变为空，从而新建一个examrecord。参考line382
					examrecordId = "";
					paper = temppaper;
					//template = (Template)baseDao.loadById("Template", paper.getTemplate().getId());
					items = paper.getAllItem(paper);
					for (Item item : items) {
						if(item.getChoiceitem().size() >0){
							item.getChoiceitem();
						}
					}
					allpaperid = String.valueOf( dataMap.get("allpaper"));
					if(!"".equals(allpaperid) && allpaperid != null){
						allpaperid = allpaperid + "," + paper.getId();
					}
					dataMap.put("allpaper", allpaperid);
					dataMap.put("items", items);
					dataMap.put("paper", paper);
					//dataMap.put("template", template);
					
				}else{
					log.debug("Last paper!!");
				}
			}
		}
		
		rhs.put("score", score);
		//rhs.put("template", template);
		rhs.put("paper", paper);
		
		if(index == items.size()-1){
			//已经答完所有题目
			//设置异常为false
			String processInstanceId = task.getProcessInstanceId();
			infActiviti.setVariableByProcessInstanceId(processInstanceId, "exception", false);
			//设置recordId，方便自动评卷拿到
			infActiviti.setVariableByProcessInstanceId(processInstanceId, "recordsId", allrecordid);
			infActiviti.completeTaskVar(taskId, paperId, getCurrentAccount(), var);
			rhs.put("finsh", true);
			//把缓存清空
			finsh = true;
		}else{
			index ++;
			rhs.put("finsh", false);
			rhs.put("item", items.get(index));
		}
		rhs.put("index", index);
		rhs.put("score",score);
		rhs.put("task", task);
		rhs.put("examrecordId", examrecordId);
		dataMap.put("index", index);
		dataMap.put("score", score);
		if(finsh){
			Cache.delete(getCurrentAccount());
		}else{
			Cache.set(getCurrentAccount(), dataMap);
		}
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

//	public String show_record() throws Exception {
//		String templateid = getpara("templateid");
//		String useraccount = getCurrentAccount();
//		List<Examrecord> dataList = new ArrayList<Examrecord>();
//		if (!"".equals(templateid) && templateid != null) {
//			String sql = " from Template t where t.id=" + "'" + templateid
//					+ "'";
//			getPageData(sql);
//			template = ((List<Template>) rhs.get("dataList")).get(0);
//		}
//		Set<Paper> papers = template.getPapers();
//
//		for (Paper paper : papers) {
//			Set<Examrecord> examrecords = paper.getResultdetail();
//			for (Examrecord examrecord : examrecords) {
//				if (examrecord.getUserid().equals(useraccount)) {
//					dataList.add(examrecord);
//				}
//			}
//		}
//		for (Knowledge knowledge : template.getKnowledge()) {
//			if(knowledge.getName().equals("职业性格测试")){
//				rhs.put("page", "psychology");
//			}else{
//				rhs.put("page", "normal");
//			}
//		}
//		rhs.put("datalist", dataList);
//		return "success";
//	}

	//目前屏蔽了groupby = paper 的这种呈现，只有user，schedule
	public String exam_record_list() throws Exception{
		int maxPage = 0;
		int count = 0;
		int currentPage = 0;
		int maxSize = 0;
		//为了普通用户显示结果分页
		int historymaxPage = 0;
		int historycount = 0;
		int historycurrentPage = 0;
		int historymaxSize = 0;
		//结束
		String useraccount = getCurrentAccount();
		List<Examrecord> dataList = new ArrayList<Examrecord>();
		Map<String,List<Examrecord>> dataMap = new HashMap<String, List<Examrecord>>();
		List<Paper> paperList = new ArrayList<Paper>();
		String sql = ""; 
		String paper_sql = "";//add by hb at 2014/08/06 for group by paper
		if(!"admin".equals(getCurrentUser().getAccount())){
			sql = " from Examrecord r where r.userid=" + "'" +useraccount+"'";
		}else{
			sql = "from Examrecord r";
			paper_sql = "from Paper p  where p.resultdetail is not empty";
			getPageData(paper_sql);
			paperList = (List)rhs.get("dataList");
			maxPage = (Integer) rhs.get("maxPage");
			count = (Integer) rhs.get("count");
			currentPage = (Integer) rhs.get("currentPage");
			maxSize = Integer.valueOf((String) rhs.get("maxSize"));
		}
		
		String groupby = getpara("groupby");
		if("".equals(groupby)){
			groupby = "paper";
		}
		if("schedule".equals(groupby)){
			exam_arrange_list();
			rhs.put("groupby", "schedule");
			return "success";
		}
		getPageData(sql);
		List<Examrecord> recordList = (List)rhs.get("dataList");
		maxPage = (Integer) rhs.get("maxPage");
		count = (Integer) rhs.get("count");
		currentPage = (Integer) rhs.get("currentPage");
		maxSize = Integer.valueOf((String) rhs.get("maxSize"));
		Map<String, List<Monitor>> monitorData = new HashMap<String, List<Monitor>>();
		if ("admin".equals(getCurrentUser().getAccount())) {
			for (Examrecord examrecord : recordList) {
				String paperid = String.valueOf(examrecord.getPaper().getId());
				String taskid = examrecord.getTaskid();
				String userid = examrecord.getUserid();

				String monitor_sql = "from Monitor m where m.userid='" + userid
						+ "' and m.taskid='" + taskid + "' and m.paperid='"
						+ paperid + "'";

				//getPageData(monitor_sql);

				//List<Monitor> monitorList = (List) rhs.get("dataList");
				List<Monitor> monitorList = (List)baseDao.find(monitor_sql);
				monitorData
						.put(String.valueOf(examrecord.getId()), monitorList);
			}
		}
		if ("paper".equals(groupby)) {
			if (!"admin".equals(getCurrentUser().getAccount())) {
				for (Examrecord examrecord : recordList) {
					if (useraccount.equals(examrecord.getUserid())
							&& examrecord.getPaper() != null) {
						String papername = examrecord.getPaper().getName();
						List<Examrecord> examrecords = dataMap.get(papername);
						if (examrecords == null) {
							examrecords = new ArrayList<Examrecord>();
						}
						examrecords.add(examrecord);
						dataMap.put(papername, examrecords);
					}
				}
				rhs.put("export", false);
			} else {
				for (Paper paper : paperList) {
					String papername = paper.getName();
					for (Examrecord examrecord : recordList) {
						if (examrecord.getPaper() != null && examrecord.getPaper().getId() == paper.getId()) {
							List<Examrecord> examrecords = dataMap
									.get(papername);
							if (examrecords == null) {
								examrecords = new ArrayList<Examrecord>();
							}
							examrecords.add(examrecord);
							dataMap.put(papername, examrecords);
						}
					}
				}
				rhs.put("export", true);
			}
			rhs.put("groupby", "user");
		}else{
			//按照user分组
			List<User> users = infEa.getAllUser();
			if (!"admin".equals(getCurrentUser().getAccount())) {
				for (Examrecord examrecord : recordList) {
					if (useraccount.equals(examrecord.getUserid())
							&& examrecord.getPaper() != null) {
						String username = examrecord.getUserid();
						List<Examrecord> examrecords = dataMap.get(username);
						if (examrecords == null) {
							examrecords = new ArrayList<Examrecord>();
						}
						examrecords.add(examrecord);
						dataMap.put(username, examrecords);
					}
				}
				rhs.put("export", false);
			} else {
				String usersql = "from User u ";
				getPageData(usersql);
				maxPage = (Integer) rhs.get("maxPage");
				count = (Integer) rhs.get("count");
				currentPage = (Integer) rhs.get("currentPage");
				maxSize = Integer.valueOf((String) rhs.get("maxSize"));
				users = (List<User>) rhs.get("dataList");
				for (User user : users) {
					String account = user.getAccount();
					String username = user.getName();
					if(account.trim().length() == 0 || username.trim().length() == 0){
						continue;
					}
					String datasql = "from Examrecord e where e.userid='" + account + "'";
					//getPageData(datasql);
					//List<Examrecord> list = (List<Examrecord>) rhs.get("dataList");
					List<Examrecord> list = (List<Examrecord>) baseDao.find(datasql);
					dataMap.put(account, list);
				}
				rhs.put("export", true);
			}
			rhs.put("groupby", "paper");
		}
		historymaxPage = maxPage;
		historycount = count;
		historycurrentPage = currentPage;
		historymaxSize = maxSize;
		rhs.put("monitorlist", monitorData);
		rhs.put("datalist", dataMap);
		rhs.put("maxSize", maxSize);
		rhs.put("count", count);
		rhs.put("maxPage", maxPage);
		rhs.put("currentPage", currentPage);
		rhs.put("historymaxSize", historymaxSize);
		rhs.put("historycount", historycount);
		rhs.put("historymaxPage", historymaxPage);
		rhs.put("historycurrentPage", historycurrentPage);
		return "success";
	}
	
	public String exam_arrange_list() throws Exception{
		int maxPage = 0;
		int count = 0;
		int currentPage = 0;
		int maxSize = 0;
		String sql = "from Examarrange";
		Map<String,Paper> paperList = new HashMap<String, Paper>();
		Map<String,List<Examrecord>> recordList = new HashMap<String, List<Examrecord>>();
		getPageData(sql);
		maxPage = (Integer) rhs.get("maxPage");
		count = (Integer) rhs.get("count");
		currentPage = (Integer) rhs.get("currentPage");
		maxSize = Integer.valueOf((String) rhs.get("maxSize"));
		List<Examarrange> arrangeList = (List<Examarrange>) rhs.get("dataList");
		for (Examarrange examarrange : arrangeList) {
			List<Examrecord> examrecordList = new ArrayList<Examrecord>();
			String paperid = examarrange.getPaperid();
			String arrangeid = String.valueOf(examarrange.getId());
			String[] userid = examarrange.getUserid().split(",");
			Paper paper = (Paper) baseDao.loadById("Paper", Long.valueOf(paperid));
			paperList.put(arrangeid, paper);
			
			if(userid.length > 1){
				for (String user : userid) {
					examrecordList.addAll(getExamRecord(user,paperid,arrangeid));
				}
			}else{
				examrecordList.addAll(getExamRecord(userid[0],paperid,arrangeid));
			}
			recordList.put(arrangeid, examrecordList);
		}
		
		rhs.put("export", true);
		rhs.put("recordlist", recordList);
		rhs.put("paperlist", paperList);
		rhs.put("datalist", arrangeList);
		rhs.put("maxSize", maxSize);
		rhs.put("count", count);
		rhs.put("maxPage", maxPage);
		rhs.put("currentPage", currentPage);
		return "success";
	}
	
	
	public List<Examrecord> getExamRecord(String userid,String paperid,String examarrangeid) throws Exception{
		String sql = "from Examrecord e where e.examarrangeid='"
				+ examarrangeid + "' and e.userid='" + userid + "'";
		
		//getPageData(sql);
		
		
		
		//List<Examrecord> recordlist = (List<Examrecord>) rhs.get("dataList");
		List<Examrecord> recordlist = (List<Examrecord>) baseDao.find(sql);
		//Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(paperid));
		// Set<Examrecord> recordlisttmp = paper.getResultdetail();
		// List<Examrecord> datalist = new ArrayList<Examrecord>();
		//
		// for (Examrecord examrecord : recordlisttmp) {
		// for (Examrecord record : recordlist) {
		// if(examrecord.getId() == record.getId()){
		// datalist.add(examrecord);
		// }
		// }
		// }
		
		return recordlist;
	}
	
	public String export_record() throws IOException{
		String paperId = getpara("paperId");
		
		Paper paper = (Paper) baseDao.loadById("Paper", Long.valueOf(paperId));
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-disposition", 
                "attachment; filename="+ java.net.URLEncoder.encode(paper.getName(), "UTF-8") +"_result.xls");
        ServletOutputStream os = response.getOutputStream();
		ExcelUtil.exportToExcel(paper, os);
		os.close();
		return null;
	}
	
	public String export_arrange_record() throws Exception{
		String arrangeid = getpara("arrangeid");
		String paperid = getpara("paperid");
		Examarrange examarrange = (Examarrange) baseDao.loadById("Examarrange", Long.valueOf(arrangeid));
		String userid = examarrange.getUserid();
		String[] userstr = userid.split(",");
		List<Examrecord> datalist = new ArrayList<Examrecord>();
		for (String user : userstr) {
			String sql = "from Examrecord e where e.examarrangeid='" + arrangeid + "' and e.userid='" +  user +"'";
			getPageData(sql);
			datalist.addAll((Collection<? extends Examrecord>) rhs.get("dataList"));
		}
		
		Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(paperid));
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-disposition", 
                "attachment; filename="+ java.net.URLEncoder.encode(paper.getName(), "UTF-8") +"_result.xls");
        ServletOutputStream os = response.getOutputStream();
        if(datalist.size() != 0){
        	ExcelUtil.exportArrangeToExcel(datalist, os);
        }
		os.close();
		return null;
	}
	
	public String exam_record_detail(){
		String paperId = getpara("paperId");
		String recordsId = getpara("recordsId");
		Paper paper = (Paper) baseDao.loadById("Paper", Long.valueOf(paperId));
		//Template template = paper.getTemplate();
		Set<Result> singleitems = new HashSet<Result>();
		Set<Result> multiitems = new HashSet<Result>();
		Set<Result> blankitems = new HashSet<Result>();
		Set<Result> essayitems = new HashSet<Result>();
		String assignee = getpara("user"); 
				//getCurrentAccount();
		Set<Examrecord> allresults = paper.getResultdetailByAccountAndRecordId(assignee, recordsId);
		
		Set<Result> results = new HashSet<Result>();
		for (Examrecord examrecord : allresults) {
			results.addAll(examrecord.getResult());
			rhs.put("examrecord", examrecord);
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
		//rhs.put("template", template);
		
		return "success";
	}
	public String show_answer(){
		String paperId = getpara("paperId");
		Paper paper = (Paper) baseDao.loadById("Paper", Long.valueOf(paperId));
		Set<Result> list = null;
		Map<String,Set<Result>> singleitems = new HashMap<String,Set<Result>>();
		Map<String,Set<Result>> multiitems = new HashMap<String,Set<Result>>();
		Map<String,Set<Result>> blankitems = new HashMap<String,Set<Result>>();
		Map<String,Set<Result>> essayitems = new HashMap<String,Set<Result>>();
		
		Set<Examrecord> allresults = paper.getResultdetail();
		
		Set<Result> results = new HashSet<Result>();
		for (Examrecord examrecord : allresults) {
			results.addAll(examrecord.getResult());
			rhs.put("examrecord", examrecord);
		}
		//上面拿到指定用户的结果
		for (Result result : results) {
			Item item = result.getItem(); 
			Long itemid = item.getId();
			switch (item.getType()) {
			case 1:
				list = (Set<Result>) singleitems.get(String.valueOf(itemid));
				if(list == null){
					list = new HashSet<Result>();
				}
				list.add(result);
				singleitems.put(String.valueOf(itemid), list);
				break;
			case 2:
				list = (Set<Result>) multiitems.get(String.valueOf(itemid));
				if(list == null){
					list = new HashSet<Result>();
				}
				list.add(result);
				multiitems.put(String.valueOf(itemid), list);
				break;
			case 3:
				list = (Set<Result>) blankitems.get(String.valueOf(itemid));
				if(list == null){
					list = new HashSet<Result>();
				}
				list.add(result);
				blankitems.put(String.valueOf(itemid), list);
				break;
			case 4:
				list = (Set<Result>) essayitems.get(String.valueOf(itemid));
				if(list == null){
					list = new HashSet<Result>();
				}
				list.add(result);
				essayitems.put(String.valueOf(itemid), list);
				break;
			}
		}
		rhs.put("singleitems", singleitems);
		rhs.put("multiitems", multiitems);
		rhs.put("blankitems", blankitems);
		rhs.put("essayitems", essayitems);
		rhs.put("paper", paper);
		return "success";
	}
	//获得当前系统中，所有用户的考试情况
	public String export_user_record() throws Exception{
		List<User> users = infEa.getAllUser();
		Map<String,List<Examrecord>> datamap = new HashMap<String, List<Examrecord>>();
		for (User user : users) {
			String username = user.getName();
			String account = user.getAccount();
			if(account.trim().length() == 0 || username.trim().length() == 0){
				continue;
			}
			String sql = "from Examrecord e where e.userid='" + account + "'";
			getPageData(sql);
			List<Examrecord> list = (List<Examrecord>) rhs.get("dataList");
			datamap.put(username, list);
		}
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-disposition", 
                "attachment; filename="+ java.net.URLEncoder.encode("All_User", "UTF-8") +"_result.xls");
        ServletOutputStream os = response.getOutputStream();
        if(datamap.size() != 0){
        	ExcelUtil.exportUserToExcel(datamap, os);
        }
		os.close();
		return null;
	}
	
	public List<Result> getResults() {
		return result;
	}

	public void setResults(List<Result> result) {
		this.result = result;
	}
	
	public Map<String,String> sendStartEmail(String account,String content){
		User user = (User)baseDao.loadByFieldValue(User.class, "account", account);
		String mail = "";
		if(user != null){
			if(user.getEmail() != null && !"".equals(user.getEmail())){
				if(!"".equals(mail)){
					mail = mail + "," + user.getEmail();
				}else{
					mail = mail + user.getEmail();
				}
			}
			if(user.getEmail2() != null && !"".equals(user.getEmail2())){
				if(!"".equals(mail)){
					mail = mail + "," + user.getEmail2();
				}else{
					mail = mail + user.getEmail2();
				}
			}
		}
		content = content + "<br/><font color='red'>Account/Password: " + user.getAccount() + "/" + user.getPasswd() + "</font>";
		//send mail
		Map<String,String> result = infEa.sendMailBySmtpList("SAC Examination Notice!", content , mail, "", "", null);
//		ClientResource client = new ClientResource("http://localhost:5051/apm/service/mail?maillist="+ mail + "&content=" + content);
//		 try {
//			Representation result = client.get();
//		} catch (ResourceException e) {
//			e.printStackTrace();
//		}
		return result;
	}
	
}
