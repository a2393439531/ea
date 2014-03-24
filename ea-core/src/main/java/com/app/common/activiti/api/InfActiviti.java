package com.app.common.activiti.api;

import java.io.FileNotFoundException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.task.Task;
public interface InfActiviti {
	
	public abstract String startProcess(Map<String, Object> map);
	public abstract String startProcessNoAssigee(String processKey, String formId,String initiator) ;
	public abstract String startProcessAssignee(String processKey, String formId,  String initiator, String assignee) ;	
	public abstract String startProcessAssigneeVar(String processKey, String formId,  String initiator, String assignee, Map<String, Object> map);
	public abstract String startProcessVarNOAssigee(String processKey, String formId,String initiator,Map<String, Object> map);

	
	public abstract void deploy(String filepath) throws FileNotFoundException;	
	public abstract void deployByRequest() throws Exception;		
	public abstract void claim(String taskId,String accout) ;	
	public abstract String getDatabase();
	public abstract List<OaTask> getCandidateTaskListByAccount(String account) ;
	//add by hb start
	public abstract List<OaTask> getAssigneeTaskListByAccount(String account) ;
	//add by hb end
	public Map<String, Object> getAssignedOaTaskListByAccount(String account, int page, int maxSize);
	public Map<String, Object> getCandidatedOaTaskListByAccount(String account, int page, int maxSize);
	public Map<String, Object> getCandidatedOaTaskListByGroup(List<String> group, int page, int maxSize);
	public abstract List<OaTask> getHistoryTaskListByAccount(String account);
	
	
	public abstract List<Task> getTaskListByAccountAndProcessKey(String account, String ProcessKey);
	public abstract String processInstanceStatus(String processInstanceId);
	public abstract void completeTask(ProcessConfig config);
	public abstract void completeTaskVar(String taskId, String formId, String assignee, Map<String, Object> var);
	public abstract void changeAssignee(String processInstanceId,String assignee);
	public abstract void deleteProcessInstance(String processInstanceId);
	public abstract Object getVariableByTaskId(String taskId, String varName);
	public abstract Object getVariableByProcessInstanceId(
			String processInstanceId, String varName);
	public abstract void setVariableByProcessInstanceId(
			String processInstanceId, String varName, Object value);
	public abstract ProcessDefinition getProcessDefinitionByTask(Task task);
	
	public abstract Task getTaskById(String taskId);
	
	/*add by hb 2014/03/13*/
	public abstract Task getActivitiTaskByProcessInstanceId(String processInstanceId);
	public abstract String getHisVariableByProcessInstanceId(String processInstanceId, String variable);
	public abstract String getAssigneeTimeByProcessInstanceId(String processInstanceId);
	/* add by chenzhijian 20130423 -s*/
	public abstract List<Map<String, String>> getNextTasks(String taskId);
	public abstract void completeTaskForBusinessAction(HttpServletRequest request,String taskId, String formId, Map<String, Object> var);
	
}