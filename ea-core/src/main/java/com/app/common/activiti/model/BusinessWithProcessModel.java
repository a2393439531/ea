package com.app.common.activiti.model;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

import org.activiti.engine.task.Task;

import com.app.common.activiti.api.InfActiviti;
import com.app.common.activiti.api.SpringContext;

public class BusinessWithProcessModel<T> {
	
	private T businessModel;
	private String processInstanceStatus = "";
	private String processTaskName = "";
	private String processAssigneedName = "";
	private String processAssigneedTime = "";
	
	public BusinessWithProcessModel(T businessModel){
		this.businessModel = businessModel;
		
		InfActiviti infActiviti = (InfActiviti)SpringContext.getBean("impActiviti");
		Class<?> c = businessModel.getClass();
		try {
			String para = "";
			Method method = c.getMethod("getProcessInstanceId", null);
			Object ret = method.invoke(businessModel, null);
			if(ret != null)
				para = (String)ret;
			processInstanceStatus = infActiviti.processInstanceStatus(para);
			if("New".equals(processInstanceStatus)){
				processTaskName = "Process not started!";
				processAssigneedName = "Not assigneed!";
				processAssigneedTime = "Not assigneed!";
			}else{
				if("Done".equals(processInstanceStatus)){
					processTaskName = "Process has been done!";
					processAssigneedName = (String) infActiviti.getHisVariableByProcessInstanceId(para, "assignee");
				}else{
					List<Task> t = infActiviti.getActivitiTaskByProcessInstanceId(para);
					for (Task task : t) {
						if(task != null){
							if(!"".equals(processTaskName) && processTaskName != null){
								processTaskName = processTaskName + "," + task.getName();
							}else{
								processTaskName = task.getName();
							}
						}
						if(!"".equals(processAssigneedName) && processAssigneedName != null){
							processAssigneedName = processAssigneedName + "," +(String) infActiviti.getVariableByTaskId(task.getId(), "assignee");
						}else{
							processAssigneedName = (String) infActiviti.getVariableByTaskId(task.getId(), "assignee");
						}
					}
					processAssigneedTime = infActiviti.getAssigneeTimeByProcessInstanceId(para);
				}
			}
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}
	
	public String getProcessInstanceStatus(){
		return this.processInstanceStatus;
	}
	
	public String getProcessTaskName() {
		return processTaskName;
	}

	public String getProcessAssigneedName() {
		return processAssigneedName;
	}

	public String getProcessAssigneedTime() {
		return processAssigneedTime;
	}

	public T getBusinessModel(){
		return this.businessModel;
	}
}
