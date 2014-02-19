package com.app.common.activiti.action;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.bpmn.diagram.ProcessDiagramGenerator;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.activiti.api.OaTask;
import com.app.common.activiti.api.ProcessInstanceStatus;
import com.app.common.activiti.model.ProcessModel;
import com.app.common.spring.ssh.model.BaseModel;
import com.app.common.spring.ssh.page.Pagination;


/**
 * @author chenzhijian
 */
@Component("activitiAction")
@Scope("prototype")
public class ActivitiAction extends BaseProcessAction {
	
	private final Logger log = LoggerFactory.getLogger(ActivitiAction.class);
	    
	/**
	 * 开启流程，传入的request必须有以下参数：
	 * id：业务表id
	 * assignee：开始流程后的处理人
	 * processKey：流程key
	 * busiDesc：该流程描述信息
	 * model：业务表类名
	 * @return
	 * @throws Exception
	 */
	public String start_process() throws Exception{
		log.debug("start_process()");
		String id = getpara("id");
		String assignee = getpara("assignee");
		String processKey = getpara("processKey");
		String busiDesc = getpara("busiDesc");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("model", getpara("model"));
		map.put("startUserName", getpara(getCurrentAccount()));
		String pid = infActiviti.startProcessAssigneeVar(processKey, id, getCurrentAccount(), assignee, map);
		Task task = taskService.createTaskQuery().processInstanceId(pid).singleResult();
		String taskid = task.getId();
		String taskUrl = formService.getTaskFormData(taskid).getFormKey();
		
		if(id != null && !"".equals(id)){
			ProcessModel pm = (ProcessModel)baseDao.loadById(getpara("model"), Long.parseLong(id));
			pm.setProcessInstanceId(pid);
			baseDao.update(pm);
		}
		rhs.put("taskId", taskid);
		rhs.put("taskUrl", taskUrl);
		return "success";
	}

	/**
	 * 打开任务
	 * 传入的request必须有以下参数
	 * taskId：task的Id
	 * taskPage：处理task的页面路径
	 * model：业务表类名
	 * formId：业务表id
	 * formProperties：控制表单的名称
	 * @return
	 * @throws Exception
	 */
	public String open_task() throws Exception{
		log.debug("open_task()");
		List<String> nextTaskList = new ArrayList<String>();
		String taskId = getpara("taskId");
		String taskPage = getpara("taskPage");
		String modelStr = getpara("model");
		//add by hb for only query user task
		String readonly = getpara("readonly");
		//end
		String formId = (String)infActiviti.getVariableByTaskId(taskId, "formId");
		if (formId == null || formId.equals("") || modelStr == null || "".equals(modelStr)) {
			rhs.put("model", null);
		} else {
			BaseModel model = (BaseModel) baseDao.loadById(modelStr, Long.parseLong(formId));
			rhs.put("model", model);
		}
		
		/* add by chenzhijian 20130419 -s */
		// 获取 formProperties 配置文件
		String formProperties = getpara("formProperties");
		HashMap<String, String> formPro = new HashMap<String, String>();
		Properties p = new Properties();
		try{
			//String filepath = System.getProperty("webroot", "./src/main/webapp/");
			String filepath =getWebroot();
			// eg: app/manager/wo/wo.properties
			filepath += "/app/manager/" + modelStr.toLowerCase() + "/" + modelStr.toLowerCase() + ".properties";
			FileInputStream in = new FileInputStream(filepath);
			p.load(in);
			in.close();
			Set<String> set = p.stringPropertyNames();
			for(String s : set){
				if(s.startsWith("default")){
					formPro.put(s.replace("default.", ""), p.getProperty(s));
				}
			}
			for(String s : set){
				if(s.startsWith(formProperties)){
					formPro.put(s.replace(formProperties + ".", ""), p.getProperty(s));
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		rhs.put("formPro", formPro);
		/* add by chenzhijian 20130419 -e */
		
		Task task = infActiviti.getTaskById(taskId);
		/*add by hb for get next task 20140128 start*/
		String nextTask = "";
		String initiator = (String) infActiviti.getVariableByTaskId(task.getId(), "initiator");
		//当前任务获取当前流程的流程定义，然后根据流程定义获得所有的节点
		ProcessDefinitionEntity def = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService)
				.getDeployedProcessDefinition(task.getProcessDefinitionId());
		List<ActivityImpl> activitiList = def.getActivities(); 
		//根据任务获取当前流程执行ID，执行实例以及当前流程节点的ID
		String excId = task.getExecutionId();
		ExecutionEntity execution = (ExecutionEntity) runtimeService
				.createExecutionQuery().executionId(excId).singleResult();
		String activitiId = execution.getActivityId();
		//循环activitiList 并判断出当前流程所处节点，然后得到当前节点实例，
		//根据节点实例获取所有从当前节点出发的路径，然后根据路径获得下一个节点实例
		for (ActivityImpl activityImpl : activitiList) {
			String id = activityImpl.getId();
			if(activitiId.equals(id)){
				log.debug("当前任务：" + activityImpl.getProperty("name")); 
				List<PvmTransition> outTransitions = activityImpl.getOutgoingTransitions();//获取从某个节点出来的所有线路
				for(PvmTransition tr:outTransitions){
					PvmActivity ac = tr.getDestination();//获取线路的终点节点，在这里应该还要加个判断，如果是并行或者相容关口，则需要继续往下找下一个任务。
					if( ac.getProperty("type").equals("parallelGateway") || ac.getProperty("type").equals("inclusiveGateway") ) { //不能包括互斥关口 ac.getProperty("type").equals("exclusiveGateway")
						List<PvmTransition> outTransitions2 = ac.getOutgoingTransitions();//因为是关口，所以继续往下找任务
						for (PvmTransition pvmTransition : outTransitions2) {
							PvmActivity ac2 = pvmTransition.getDestination();
							nextTask = (String)ac2.getId();
							log.debug("下一个任务----->：" + nextTask); 
							nextTaskList.add(nextTask);
						}
					}else {
						nextTask = (String)ac.getId();
						log.debug("下一个任务++++>：" + nextTask); 
						nextTaskList.add(nextTask);
					}
				}
				break;
			}
		}
		
		/*end*/
		rhs.put("task", task);
		rhs.put("initiator", initiator);
		rhs.put("nextTaskList", nextTaskList);
		rhs.put("taskPage", taskPage);
		rhs.put("readonly", readonly);
		getAllUserAndGroupInfo();
		
		return "success";
	}
	
	/**
	 * 代办任务查询，有2中类型的任务
	 * @return
	 */
	public String menu_task_list() {
		String pageId = getpara("pageId");
		String maxSize = getpara("maxSize");
		if(pageId.equals("")) pageId = "1";
		if(maxSize.equals("")) maxSize = "20";

		Map<String, Object> map = infActiviti.getAssignedOaTaskListByAccount(getCurrentAccount(), Integer.parseInt(pageId), Integer.parseInt(maxSize));
		//Map<String, Object> candidateUserMap = infActiviti.getCandidatedOaTaskListByAccount(getCurrentAccount(), Integer.parseInt(pageId), Integer.parseInt(maxSize));
		//Map<String, Object> candidateGroupmap = infActiviti.getCandidatedOaTaskListByGroup(getCurrentUserGroup(), Integer.parseInt(pageId), Integer.parseInt(maxSize));
		
		
		List<OaTask> assigneeList = (List<OaTask>) map.get("dataList");
		//List<OaTask> candidateUserList = (List<OaTask>) candidateUserMap.get("dataList");
		//List<OaTask> candidateGroupList = (List<OaTask>) candidateGroupmap.get("dataList");
		
		
		List<OaTask> allData = new ArrayList<OaTask>();
		
		allData.addAll(assigneeList);
		//allData.addAll(candidateUserList);
		//allData.addAll(candidateGroupList);

		Pagination p = (Pagination)map.get("pagination");
		//rhs.put("oatasklist", map.get("dataList"));
		rhs.put("oatasklist", allData);
		rhs.put("maxSize", p.getMaxSize());
		rhs.put("count", p.getTotalSize());
		rhs.put("maxPage", p.getTotalPage());
		rhs.put("currentPage", p.getCurrentPage());
		return "success";
	}
	
	/**
	 * 打开登录用户的历史任务列表
	 * @return
	 */
	public String menu_history_task_list() {
		rhs.put("oatasklist", infActiviti.getHistoryTaskListByAccount(getCurrentAccount()));
		return "success";
	}
	
	/**
	 * 查询已经部署流程文件
	 * @return
	 */
	public String menu_deployment() {
		List<Deployment> list = repositoryService.createDeploymentQuery().orderByDeploymenTime().desc().list();
		rhs.put("list", list);
		return "success";
	}
	
	/**
	 * 查询已经部署的流程，并且能够active/suspend 它(demo) add by hongbin
	 * */
	public String menu_startProcess() {
		/*List<ProcessDefinition> list = repositoryService
		.createProcessDefinitionQuery().latestVersion().list();*/
		List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery().list();
		rhs.put("list", list);
		return "success";
	}
	
	/**
	 * 显示已经部署的流程  add by hongbin
	 * */
	public String index_demo(){
		return "success";
	}
	
	/**
	 *  接受任务
	 * */
	public String claim_task(){
		String taskId = getpara("taskid");
		
		String assignee = getCurrentAccount();
		String taskUrl = formService.getTaskFormData(taskId).getFormKey();
		infActiviti.claim(taskId, assignee);
		
		
		rhs.put("taskId", taskId);
		rhs.put("taskUrl", taskUrl);
		return "success";
	}
	
	/**
	 * 获得组,用户的相关信息
	 * 
	 * */
	
	public void getAllUserAndGroupInfo(){
		rhs.put("userList", infEa.getAllUser());
		
		rhs.put("rolegroupRootList", infEa.getRolegroupRootNods());
		rhs.put("organizeRootList", infEa.getOrganizeRootNods());
	}
	
	/**
	 * 查询已经部署的流程，并且能够启动他 它(demo) add by hongbin
	 * */
	public String menu_process_list(){
		//List<Deployment> list = repositoryService.createDeploymentQuery().list();
		List<Object[]> list = new ArrayList<Object[]>();
		ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery().orderByDeploymentId().latestVersion().desc();//只需要最新的version就行了
		List<ProcessDefinition> processDefinitionList = processDefinitionQuery.list();
		
		for (ProcessDefinition processDefinition : processDefinitionList) {
			String deploymentId = processDefinition.getDeploymentId();
            Deployment deployment = repositoryService.createDeploymentQuery().deploymentId(deploymentId).singleResult();
            //ProcessDefinitionEntity pde = (ProcessDefinitionEntity)processDefinition;
//            Object model = infActiviti.getVariableByProcessInstanceId(pde.getProcessDefinition().getId(),"model");
            
            list.add(new Object[]{processDefinition,deployment});
		}
		
		
		getAllUserAndGroupInfo();
		rhs.put("list", list);
		return "success";
	}
	
	
	public String menu_query_todotask(){
		return "success";
	}
	
	/**
	 * 查询部署了多少个流程
	 * @return
	 */
	public String menu_process_definition() {
		List<ProcessDefinition> list = repositoryService
				.createProcessDefinitionQuery().latestVersion().list();
		rhs.put("list", list);
		return "success";
	}
	
	/**
	 * 查询Demo add by hongbin
	 * @return
	 */
	public String menu_process_demo() {
		List<ProcessDefinition> list = repositoryService
				.createProcessDefinitionQuery().latestVersion().list();
		rhs.put("list", list);
		return "success";
	}
	
	/**
	 * start Process Demo add by hongbin
	 * @return
	 */
	public String start_demo_process(){
		log.debug("start_demo_process()");
		String id = getpara("id");
		String assignee = getpara("assignee");
		String processKey = getpara("processKey");
		String busiDesc = getpara("busiDesc");
		busiDesc="工单处理";
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("model", getpara("model"));
		map.put("startUserName", getpara(getCurrentAccount()));
		String pid = infActiviti.startProcessAssigneeVar(processKey, id, getCurrentAccount(), assignee, map);
		return "success";
	}
	
	
	/**
	 * 查询候选task add by hongbin
	 * @return
	 */
	public String menu_candidate_task_list(){
		String pageId = getpara("pageId");
		String maxSize = getpara("maxSize");
		if(pageId.equals("")) pageId = "1";
		if(maxSize.equals("")) maxSize = "20";
		Map<String, Object> map = infActiviti.getCandidatedOaTaskListByAccount(getCurrentAccount(), Integer.parseInt(pageId), Integer.parseInt(maxSize));
		
		Pagination p = (Pagination)map.get("pagination");
		rhs.put("candidateoatasklist", map.get("dataList"));
		rhs.put("maxSize", p.getMaxSize());
		rhs.put("count", p.getTotalSize());
		rhs.put("maxPage", p.getTotalPage());
		rhs.put("currentPage", p.getCurrentPage());
		return "success";
	}
	
	
	/**
	 * activate Process Demo add by hongbin
	 * @return
	 */
	public String process_start() {
		
		String processDefinitionId = getpara("processDefinitionId");
		
		repositoryService.activateProcessDefinitionById(processDefinitionId);
		
		List<ProcessDefinition> list = repositoryService
				.createProcessDefinitionQuery().latestVersion().list();
		rhs.put("list", list);
		return "success";
	}
	
	/**
	 * Suspend Process Demo add by hongbin
	 * @return
	 */
	public String process_suspend() {
		
		String processDefinitionId = getpara("processDefinitionId");
		
		repositoryService.suspendProcessDefinitionById(processDefinitionId);
		
		List<ProcessDefinition> list = repositoryService
				.createProcessDefinitionQuery().latestVersion().list();
		rhs.put("list", list);
		return "success";
	}
	
	/**
	 * 上传流程文件
	 * @return
	 */
	public String upload_process_file() {
		try {
			infActiviti.deployByRequest(); // 返回上传历史
		} catch (Exception e) {
			log.error("上传失败");
			rhs.put("info_type", "error");
			rhs.put("info", "上传失败");
		}
		return "success";
	}
	
	/**
	 * 跳转到流程图型显示页面
	 * @return
	 */
	public String process_diagram() {
		String processDefinitionId = getpara("processDefinitionId");
		String processInstanceId = getpara("processInstanceId");
		
		if(processDefinitionId.equals("")){
			ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
			processDefinitionId = processInstance.getProcessDefinitionId();
		}
		ProcessDefinition processDefinition = repositoryService
				.createProcessDefinitionQuery()
				.processDefinitionId(processDefinitionId).singleResult();
		InputStream in = repositoryService.getResourceAsStream(
				processDefinition.getDeploymentId(),
				processDefinition.getDiagramResourceName());
		try {
			rhs.put("imgWidth", ImageIO.read(in).getWidth());
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		rhs.put("processDefinitionId", processDefinitionId);
		rhs.put("processInstanceId", processInstanceId);
		return "success";
	}
	/**
	 * 流程图型显示
	 * @return
	 */
	public String process_diagram_simple() {
		try {
			HttpServletResponse resp = ServletActionContext.getResponse();
			String processDefinitionId = getpara("processDefinitionId");
			ProcessDefinition processDefinition = repositoryService
					.createProcessDefinitionQuery()
					.processDefinitionId(processDefinitionId).singleResult();
			InputStream in = repositoryService.getResourceAsStream(
					processDefinition.getDeploymentId(),
					processDefinition.getDiagramResourceName());
			/*ImageIO.read(in).getWidth();
			resp.setContentType("image/png");
			ServletOutputStream out = resp.getOutputStream();
			BufferedInputStream bin = new BufferedInputStream(in);
			byte[] b = new byte[1024];
			int l = bin.read(b);
			while (l != -1) {
				out.write(b);
				l = bin.read(b);
			}
			bin.close();
			in.close();
			out.flush();
			out.close();*/
			//resp.setContentType("image/png");
	        byte[] b = new byte[1024];
	        int len = -1;
	        while ((len = in.read(b, 0, 1024)) != -1) {
	            resp.getOutputStream().write(b, 0, len);
	        }
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 流程图型显示，高亮流程所在环节
	 * @return
	 */
	public String process_diagram_complex(){
		try {
			HttpServletResponse resp = ServletActionContext.getResponse();
			
			String processInstanceId = getpara("processInstanceId");
			if(!infActiviti.processInstanceStatus(processInstanceId).equals(ProcessInstanceStatus.Done)){
				ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
				String processDefinitionId = processInstance.getProcessDefinitionId();
				
				ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity)((RepositoryServiceImpl)repositoryService).getDeployedProcessDefinition(processDefinitionId);
				log.debug(runtimeService.getActiveActivityIds(processInstanceId).toString());

				
				BpmnModel model = repositoryService.getBpmnModel(processDefinitionId);
				InputStream in = ProcessDiagramGenerator.generateDiagram(model, "png", runtimeService.getActiveActivityIds(processInstanceId));
	

				resp.setContentType("image/png");
				
				BufferedInputStream bin = new BufferedInputStream(in);
				ServletOutputStream out = resp.getOutputStream();
				byte[] b = new byte[1024];
				int l = bin.read(b);
				while(l != -1){
					out.write(b);
					l = bin.read(b);
				}
				bin.close();
				in.close();
				out.flush();
				out.close();
				/**/
			}else{
				PrintWriter out = resp.getWriter();
				out.write("The Process have been completed......");
				out.flush();
				out.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	public String process_definition_activity(){
		String processDefinitionId = getpara("processDefinitionId");
		ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity)((RepositoryServiceImpl)repositoryService).getDeployedProcessDefinition(processDefinitionId);
		List<ActivityImpl> activityImplList = processDefinition.getActivities();
		for(ActivityImpl a : activityImplList){
			log.debug(a.getProperties().toString());
		}
		rhs.put("list", activityImplList);
		return "success";
	}
	
	/* add by chenzhijian 20130423 -s*/
	/**
	 * 获取下一环节的任务名
	 * @return
	 */
	public String next_tasks(){
		String taskId = getpara("taskId");
		List<Map<String, String>> nextTask = infActiviti.getNextTasks(taskId);
		rhs.put("list", nextTask);
		return "success";
	}
	/* add by chenzhijian 20130423 -e*/
	
	public void getPageData(String sql) throws Exception {
		String pageId = getpara("pageId");
		String maxSize = getpara("maxSize");
		
		if (maxSize == null || "".equals(maxSize)) {
			maxSize = (String) getSessionValue("maxSize");
			if (maxSize == null || "".equals(maxSize))
				maxSize = "20";
		}else{
			pagination.setMaxSize(Integer.parseInt(maxSize));
		}
		
		if (pageId == null || "".equals(pageId)) {
			pageId = (String) getSessionValue("pageId");
			if (pageId == null || "".equals(pageId))
				pageId = "1";
		}
		putSessionValue("pageId", pageId);
		putSessionValue("maxSize", maxSize);
		pagination.setCurrentPage(Integer.parseInt(pageId));
		List tpltb1List = baseDao.page(sql, pagination);
		rhs.put("dataList", tpltb1List);
		List countList = baseDao.find(sql);
		rhs.put("maxSize", maxSize);
		rhs.put("count", countList.size());
		rhs.put("maxPage",
				countList.size() % pagination.getMaxSize() > 0 ? countList
						.size() / pagination.getMaxSize() + 1 : countList
						.size() / pagination.getMaxSize());
		rhs.put("currentPage", Integer.parseInt(pageId));
	}
	
	/**
	 * 开启流程前，先新建一个业务记录 ,
	 
	 */
	public String start_process_pre() throws Exception{
		log.debug("start_process()");
		String id = "";
		String assignee = getpara("assignee");
		String processKey = getpara("processKey");
		String busiDesc = "";
		ProcessModel pm = null;
		Map<String, Object> map = new HashMap<String, Object>();
		String moelStr[] = processKey.split("_");
		map.put("model", "");
		//如果流程有表关联，新建记录
		if(moelStr.length >=2){
			pm =  (ProcessModel) Class.forName("com.app.manager.model." + moelStr[moelStr.length-1]).newInstance();
			baseDao.create(pm);
			map.put("model", moelStr[moelStr.length-1]);
		    id=pm.getId().toString();
		}
		map.put("startUserName", getpara(getCurrentAccount()));
		
		String pid = infActiviti.startProcessAssigneeVar(processKey, id,  getCurrentAccount(), assignee, map);
		Task task = taskService.createTaskQuery().processInstanceId(pid).singleResult();
		String taskid = task.getId();	
		String taskUrl = formService.getTaskFormData(taskid).getFormKey();
		
		//如果有表关联
		if(moelStr.length >=2){
			pm.setProcessInstanceId(pid);
			baseDao.update(pm);
		}

		rhs.put("taskId", taskid);
		rhs.put("taskUrl", taskUrl);		
		return "success";

	}
	
	/**
	 * 完成业务记录
	 * id：业务表id
	 * assignee：开始流程后的处理人
	 * processKey：流程key
	 * busiDesc：该流程描述信息
	 * model：业务表类名
	 * @return
	 * @throws Exception
	 */
	public String complete_process_pre() throws Exception {
		String assignee = getpara("assignee");
		String processKey = getpara("processKey");
		String busiDesc = getpara("busiDesc");
		ProcessModel pm = null;
		
		//processkey
		//hello_single_Demo
		
		String moelStr[] = processKey.split("_");
		if(moelStr.length >=2){
			pm =  (ProcessModel) Class.forName("com.app.manager.model." + moelStr[moelStr.length-1]).newInstance();
			rhs.put("model", moelStr[moelStr.length-1]);
			baseDao.create(pm);
			rhs.put("formId", pm.getId());
		}else{
			rhs.put("model", "");
			rhs.put("formId", "");
		}
		rhs.put("assignee", assignee);
		rhs.put("processKey", processKey);
		rhs.put("busiDesc", busiDesc);
		
		return "success";
	}
	
	public static void main(String[] args){
		System.out.println(11/10);
	}
}
