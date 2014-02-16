package com.app.manager.action;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.common.activiti.action.BaseProcessAction;
import com.app.common.activiti.model.ProcessModel;
import com.app.common.base.action.BaseEaAction;
import com.app.manager.model.Wfcomplaint;
import com.app.manager.model.Wfdemo;
import com.app.manager.model.Wffee;
import com.app.manager.model.Wfproduct;

@Component("wfdemoAction")
@SuppressWarnings("rawtypes")
public class WfdemoAction extends BaseProcessAction {
	private static Logger log = LoggerFactory.getLogger(WfdemoAction.class);


	/**
	 * 完成所选择的任务(Demo) add by hongbin
	 * 
	 * */
	public String complete_task(){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result= true;
		String taskId = getpara("taskid");
		String name = getpara("name");
		String taskAssigneeName = getpara("taskAssigneeName");
		
		String formId = (String)infActiviti.getVariableByTaskId(taskId, "formId");
		String modelStr = (String)infActiviti.getVariableByTaskId(taskId, "model");
		
		infActiviti.completeTaskVar(taskId, formId, taskAssigneeName, map);
		if(modelStr != null & !"".equals(modelStr)){
			//更新业务逻辑，即任务信息Demo表,不应该放在公共类Core里面
			Wfdemo pm = (Wfdemo)baseDao.loadById(modelStr, Long.parseLong(formId));
			pm.setName(name);			
			baseDao.update(pm);
		}
		
		rhs.put("resultMessage", String.valueOf(result));
		return "success";
	}
	
	public String top(){
		
		return "success";
	}	
}
