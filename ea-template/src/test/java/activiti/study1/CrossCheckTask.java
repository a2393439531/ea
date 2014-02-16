package activiti.study1;

import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;

import activiti.Process;

import com.app.common.activiti.api.OaTask;

public class CrossCheckTask extends Process {

	
	@Test
	public void deploy() throws FileNotFoundException {
		infActiviti
		.deploy("src/test/resources/acitiviti/study1/CrossCheckTask.bpmn");
	}
	
	
	@Test
	public void startProcess() {
		/*Map<String, Object> map = new HashMap<String, Object>();
		map.put("initiator","zengzhihui");
		map.put("assignee","zengzhihui");
		map.put("processKey", "crossCheckTask");*/
		infActiviti.startProcessAssignee("crossCheckTask", "1",
				 "zengzhihui", "zengzhihui");
	}
	
	@Test
	public void queryAssigneeAndComplete(){
		List<OaTask> tasks = infActiviti.getAssigneeTaskListByAccount("zengzhihui");
		super.printOaTaskList(tasks);
		//complete task
		Map<String, Object> map = new HashMap<String, Object>();
		//for step one --> start cross check
		map.put("member1", "hongbin");
		map.put("member2", "panlinglian");
		// end
		for (OaTask oaTask : tasks) {
			String taskId = oaTask.task.getId();
			oaTask.task.setOwner("zengzhihui");
			infActiviti.completeTaskVar(taskId, "1", "", map);
		}
	}
	
	@Test
	public void queryAssigneeTaskByAccount(){
		System.out.println("hongbin查询任务---> ");
		super.queryAssigneeTaskByAccount("hongbin");
		System.out.println("panlinglian查询任务--->");
		super.queryAssigneeTaskByAccount("panlinglian");
		System.out.println("zengzhihui查询任务--->");
		super.queryAssigneeTaskByAccount("zengzhihui");
	}
	
	@Test
	public void completeTask() {
		Map<String, Object> map = new HashMap<String, Object>();
		// hongbin Complete task
		List<OaTask> tasksHB = infActiviti
				.getAssigneeTaskListByAccount("hongbin");
		super.printOaTaskList(tasksHB);
		for (OaTask oaTask : tasksHB) {
			String taskId = oaTask.task.getId();
			infActiviti.completeTaskVar(taskId, "1", "zengzhihui5", map); //没有影响
		}
		// panlinglian Complete task
		List<OaTask> tasksPLL = infActiviti
				.getAssigneeTaskListByAccount("panlinglian");
		super.printOaTaskList(tasksPLL);
		for (OaTask oaTask : tasksPLL) {
			String taskId = oaTask.task.getId();
			//因为是并行关系，所以以最后一个完成task的assignee为准。
			infActiviti.completeTaskVar(taskId, "1", "zengzhihui4", map); 
		}
	}
	
}
