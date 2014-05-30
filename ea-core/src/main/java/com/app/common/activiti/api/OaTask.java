package com.app.common.activiti.api;

import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.task.Task;

import com.app.common.activiti.model.ProcessModel;

public class OaTask{
	public ProcessModel businessModel;
	public Task task;
	public HistoricTaskInstance historyTask;

	public ProcessDefinition processDefinition;

	public String handleTaskUrl;
	public String initiator;
	public String busiDesc;
	public String userName;
	public String createTime;
	public String formId;
	//来定义操作task的button显示名称
	public String method;
	//end
	public Object obj;
	public String assignee;
	
	public OaTask(){
		super();
	}
	
	public OaTask(ProcessModel businessModel){
		super();
		this.businessModel = businessModel;
	}
	
	public ProcessModel getBusinessModel() {
		return businessModel;
	}

	public String getAssignee() {
		return assignee;
	}

	public void setAssignee(String assignee) {
		this.assignee = assignee;
	}

	public void setBusinessModel(ProcessModel businessModel) {
		this.businessModel = businessModel;
	}

	public Task getTask() {
		return task;
	}

	public void setTask(Task task) {
		this.task = task;
	}
	
	public HistoricTaskInstance getHistoryTask() {
		return historyTask;
	}

	public void setHistoryTask(HistoricTaskInstance historyTask) {
		this.historyTask = historyTask;
	}
	
	public String getHandleTaskUrl() {
		return handleTaskUrl;
	}

	public void setHandleTaskUrl(String handleTaskUrl) {
		this.handleTaskUrl = handleTaskUrl;
	}

	public ProcessDefinition getProcessDefinition() {
		return processDefinition;
	}

	public void setProcessDefinition(ProcessDefinition processDefinition) {
		this.processDefinition = processDefinition;
	}

	public String getInitiator() {
		return initiator;
	}

	public void setInitiator(String initiator) {
		this.initiator = initiator;
	}

	public String getBusiDesc() {
		return busiDesc;
	}

	public void setBusiDesc(String busiDesc) {
		this.busiDesc = busiDesc;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getFormId() {
		return formId;
	}

	public void setFormId(String formId) {
		this.formId = formId;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}
	
	
}
