package com.app.common.activiti.action;

import java.util.List;

import org.activiti.engine.task.Task;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.activiti.model.TaskLog;
import com.app.ea.model.User;
import com.utils.time.TimeUtil;

/**
 * @author chenzhijian
 */
@Component("tasklogAction")
@Scope("prototype")
public class TaskLogAction extends BaseProcessAction {

	//private final Logger log = LoggerFactory.getLogger(TaskLogAction.class);
	public TaskLog model = new TaskLog();
	private Task task;
	
	public Task getTask(String taskId){
		if(task == null){
			task = infActiviti.getTaskById(taskId);
		}
		return task;
	}
	
	public String list(){
		String taskId = getpara("taskId");
		String processInstanceId = getpara("processInstanceId");
		String woid = getpara("woid");
		
		//if(processInstanceId.equals("") || "undefined".equals(processInstanceId))
			//processInstanceId = getTask(taskId).getProcessInstanceId();

		rhs.put("list", baseDao.find("from TaskLog where woid='" + woid + "' order by createTime desc"));
		rhs.put("taskId", taskId);
		rhs.put("processInstanceId", processInstanceId);
		return "list";
	}
	
//	public String load() throws Exception {
//		String id = getpara("id");
//		if ("".equals(getpara("id"))) {
//			rhs.put("bugFix", null);
//		} else {
//			BugFix bugFix = (BugFix) baseDao.loadById("BugFix", Long.parseLong(id));
//			rhs.put("bugFix", bugFix);
//		}
//		return "success";
//	}
	
	public String save() throws Exception {
		Task t = getTask(getpara("taskId"));
		String woid = getpara("woid");
		String processInstanceId = getpara("processInstanceId");
		if(("undefined".equals(processInstanceId) || "".equals(processInstanceId)) && t != null){
			processInstanceId = t.getProcessInstanceId();
		}
		if(t == null){
			t = infActiviti.getActivitiTaskByProcessInstanceId(processInstanceId).get(0);
		}
		User user = (User) getSessionValue("userlogined");
		model = new TaskLog();
		model.setLog(getpara("log"));
		if(t != null){
			model.setTaskId(t.getId());
			model.setTaskName(t.getName());
		}
		model.setProcessInstanceId(processInstanceId);
		model.setWoid(woid);
		model.setCreateTime(TimeUtil.getTimeStr("yyyy-MM-dd HH:mm:ss"));
		model.setUserAccount(user.getAccount());
		model.setUserName(user.getName());
		baseDao.create(model);
//		if (model.getId() == null || model.getId().toString().equals("")) { // create
//			baseDao.create(model);
//		} else { // edit
//			baseDao.update(model);
//		}
		//send Email after log has been insert. start at 2014/03/17
		if (t != null) {

			String initiator = (String) infActiviti.getVariableByTaskId(
					t.getId(), "initiator");
			User initiatorUser = (User) baseDao.loadByFieldValue(User.class,
					"account", initiator);
			String mail = "";
			if (initiatorUser.getEmail() != null
					&& !"".equals(initiatorUser.getEmail())) {
				mail += initiatorUser.getEmail();
			}
			if (initiatorUser.getEmail2() != null
					&& !"".equals(initiatorUser.getEmail2())) {
				mail = "," + initiatorUser.getEmail2();
			}
			String assignee = (String) infActiviti.getVariableByTaskId(
					t.getId(), "assignee");
			User assigneeUser = (User) baseDao.loadByFieldValue(User.class,
					"account", assignee);
			if (assigneeUser != null) {
				if (assigneeUser.getEmail() != null
						&& !"".equals(assigneeUser.getEmail())) {
					mail = mail + "," + assigneeUser.getEmail();
				}
				if (assigneeUser.getEmail2() != null
						&& !"".equals(assigneeUser.getEmail2())) {
					mail = "," + assigneeUser.getEmail2();
				}
			}
			String content = user.getName()
					+ "has add log for task: <font color='red'>"
					+ t.getName()
					+ "</font>!<br/><br/>The log information as below:<br/><br/>"
					+ "Log content: <font color='red'>" + model.getLog()
					+ "</font>";

			infEa.sendMailTheadBySmtpList(" Log added! ", content, mail, "",
					"", null);
		}
		//end
		
		return list();
	}
	
	public String export(){
		String taskId = getpara("taskId");
		String processInstanceId = getpara("processInstanceId");
		if(processInstanceId.equals(""))
			processInstanceId = getTask(taskId).getProcessInstanceId();
		
		rhs.put("list", baseDao.find("from TaskLog where processInstanceId='" + processInstanceId + "' order by createTime desc"));
		return "success";
	}

	public String delete() throws Exception {
		TaskLog model = new TaskLog();
		model.setId(Long.parseLong(getpara("id")));
		baseDao.delete(model);
		return list();
	}
	
	//added by xiaonqinghong for mobile 2014-6-24
	public String m_list(){
		this.list();
		return "success";
	}
	
	public String m_save() throws Exception {
		this.save();
		return m_list();
	}
	
	public String m_delete() throws Exception {
		this.delete();
		return m_list();
	}
	//added by xiaonqinghong for mobile 2014-6-24 end
}
