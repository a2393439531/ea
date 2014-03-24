package com.app.common.activiti.model;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

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
				processAssigneedName = "Process has not assigneed!";
				processAssigneedTime = "Process has not assigneed!";
			}else{
				if("Done".equals(processInstanceStatus)){
					processTaskName = "Process has been done!";
				}else{
					Task t = infActiviti.getActivitiTaskByProcessInstanceId(para);
					processTaskName = t.getName();
				}
				processAssigneedTime = infActiviti.getAssigneeTimeByProcessInstanceId(para);
				processAssigneedName = infActiviti.getHisVariableByProcessInstanceId(para, "firstAssignee");
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
