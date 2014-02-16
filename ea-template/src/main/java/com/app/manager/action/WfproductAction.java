package com.app.manager.action;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.common.activiti.action.BaseProcessAction;
import com.app.manager.model.Wfdemo;
import com.app.manager.model.Wfproduct;

@Component("wfproductAction")
@SuppressWarnings("rawtypes")
public class WfproductAction extends BaseProcessAction {
	private static Logger log = LoggerFactory.getLogger(WfproductAction.class);


	/**
	 * 完成所选择的任务(Demo) add by hongbin
	 * 
	 * */
	public String complete_task(){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean result= true;
		String taskId = getpara("taskid");
		String name = getpara("name");
		String purpose = getpara("purpose");
		
		String approve = getpara("approve");
		
		//拿到批准信息
		map.put("approve", Boolean.valueOf(approve));
		
		String taskAssigneeName = getpara("taskAssigneeName");
		
		String formId = (String)infActiviti.getVariableByTaskId(taskId, "formId");
		String modelStr = (String)infActiviti.getVariableByTaskId(taskId, "model");
		
		if(modelStr != null & !"".equals(modelStr)){
			//更新业务逻辑，即业务信息表,不应该放在公共类Core里面
			Wfproduct pm = (Wfproduct)baseDao.loadById(modelStr, Long.parseLong(formId));
			pm.setName(name);
			pm.setPurpose(purpose);
			baseDao.update(pm);
		}
		infActiviti.completeTaskVar(taskId, formId, taskAssigneeName, map);
		
		rhs.put("resultMessage", String.valueOf(result));
		return "success";
	}
	
	/**
	 * 开启流程前，先新建一个业务记录
	 * id：业务表id
	 * assignee：开始流程后的处理人
	 * processKey：流程key
	 * busiDesc：该流程描述信息
	 * model：业务表类名
	 * @return
	 * @throws Exception
	 */
	public String start_process_pre() throws Exception{
		log.debug("start_process()");
		//String id = getpara("id");
		String assignee = getpara("assignee");
		String processKey = getpara("processKey");
		String busiDesc = getpara("busiDesc");
		busiDesc="工单处理";
		
		//Map<String, Object> map = new HashMap<String, Object>();
		//map.put("model", getpara("model"));
		//map.put("startUserName", getpara(getCurrentAccount()));
		//String pid = infActiviti.startProcessAssigneeVar(processKey, id, busiDesc, getCurrentAccount(), assignee, map);
		rhs.put("assignee", assignee);
		rhs.put("processKey", processKey);
		rhs.put("busiDesc", busiDesc);
		
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
		String name = getpara("name");
		String assignee = getpara("assignee");
		String processKey = getpara("processKey");
		String busiDesc = getpara("busiDesc");
		
		Wfdemo pm = new Wfdemo();
		pm.setName(name);			
		baseDao.create(pm);
		
		rhs.put("formId", pm.getId());
		rhs.put("model", "Demo");
		rhs.put("assignee", assignee);
		rhs.put("processKey", processKey);
		rhs.put("busiDesc", busiDesc);
		
		return "success";
	}
}
