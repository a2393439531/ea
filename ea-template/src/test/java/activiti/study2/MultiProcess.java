package activiti.study2;

import java.io.FileNotFoundException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.task.Task;
import org.junit.Test;

import activiti.Process;

import com.app.common.activiti.api.OaTask;

public class MultiProcess extends Process {
	@Test
	public void deploy() throws FileNotFoundException { //部署多实例化流程图
		infActiviti
		.deploy("src/test/resources/activiti/MultiTask.bpmn");
	}
	
	@Test
	public void queryDeployedProcess(){ //查询当前已经部署的流程图
		super.getDeployedProcess();
	}
	
	@Test
	public void startProcess() {  //启动multiTask流程图，第一个任务给tom
		infActiviti.startProcessAssignee("multiTask", "1",
				 "tom3", "tom3");
	}
	
	@Test
	public void queryTask(){  //查询assign给tom的任务
		super.queryAssigneeTaskByAccount("tom3");
	}
	
	@Test
	public void TLcompleteTask(){
		Map<String, Object> var = new HashMap<String,Object>();
		List<OaTask> list = infActiviti.getAssigneeTaskListByAccount("tom3");
		for(OaTask oatask: list){
			Task task = oatask.getTask();
			List<String> assigneeList = Arrays.asList("Aperson","Bperson","Cperson"); 
			//var.put("userlist ", assigneeList );
			infActiviti.setVariableByProcessInstanceId(task.getProcessInstanceId(), "userlist", assigneeList);
			infActiviti.completeTaskVar(task.getId(), "1", "tom2", var);
		}
	}
	
	@Test
	public void queryMemberTask(){  //查询assign的任务
		super.queryAssigneeTaskByAccount("Aperson");
		super.queryAssigneeTaskByAccount("Bperson");
		super.queryAssigneeTaskByAccount("Cperson");
	}
	
	@Test
	public void memberCompleteTask() { // 组员完成各自任务
		List<OaTask> aList = infActiviti
				.getAssigneeTaskListByAccount("Aperson");
		List<OaTask> bList = infActiviti
				.getAssigneeTaskListByAccount("Bperson");
		List<OaTask> cList = infActiviti
				.getAssigneeTaskListByAccount("Cperson");
		for (OaTask oaTask : aList) {
			Task task = oaTask.getTask();
			infActiviti.completeTaskVar(task.getId(), "1", "",
					new HashMap<String, Object>());
		}
		for (OaTask oaTask : bList) {
			Task task = oaTask.getTask();
			infActiviti.completeTaskVar(task.getId(), "1", "",
					new HashMap<String, Object>());
		}
		for (OaTask oaTask : cList) {
			Task task = oaTask.getTask();
			infActiviti.completeTaskVar(task.getId(), "1", "",
					new HashMap<String, Object>());
		}
	}
}
