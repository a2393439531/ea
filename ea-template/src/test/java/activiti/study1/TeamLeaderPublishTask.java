package activiti.study1;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import activiti.Process;

import com.app.common.activiti.api.OaTask;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring.xml")
public class TeamLeaderPublishTask extends Process {

	@Test
	public void deploy() throws java.io.FileNotFoundException {
		infActiviti
				.deploy("src/test/resources/acitiviti/study1/TeamLeaderPublishTask.bpmn");
	};

	@Test
	public void startProcess() {
		infActiviti.startProcessAssignee("publishTask", "1",
				 "", "zengzhihui");
	}
	
	@Test
	public void queryProcessTaskbyAccount(){
		List<OaTask> tasks = infActiviti
				.getAssigneeTaskListByAccount("admin");
		super.printOaTaskList(tasks);
	}
	
	@Test
	public void completeTaskAndNextStep() {
		List<OaTask> tasks = infActiviti
				.getAssigneeTaskListByAccount("zengzhihui");
		super.printOaTaskList(tasks);
		Map<String, Object> map = new HashMap<String, Object>();
		for (OaTask oaTask : tasks) {
			String taskId = oaTask.task.getId();
			//for task one
			//infActiviti.completeTaskVar(taskId, "1", "hongbin,panlinglian",map);
			//for task three
			infActiviti.completeTaskVar(taskId,"1","",map);
		}
	}
	
	@Test
	public void queryCandidateTestByAccount(){
		System.out.println("hongbin查询可选任务---> ");
		super.queryCandidateTaskByAccount("hongbin");
		System.out.println("panlinglian查询可选任务--->");
		super.queryCandidateTaskByAccount("panlinglian");
		System.out.println("查询Unfinish任务--->");
		super.queryCandidateTaskByAccount("admin");
	}
	
	@Test
	public void acceptTask() {
		List<OaTask> tasks = infActiviti
				.getCandidateTaskListByAccount("hongbin");
		for (OaTask oaTask : tasks) {
			String taskid = oaTask.task.getId();
			infActiviti.claim(taskid, "hongbin");
		}
	}
	
	@Test
	public void completeTaskAndFinalStep() {
		List<OaTask> tasks = infActiviti
				.getAssigneeTaskListByAccount("hongbin");
		super.printOaTaskList(tasks);
		Map<String, Object> map = new HashMap<String, Object>();
		for (OaTask oaTask : tasks) {
			String taskId = oaTask.task.getId();
			infActiviti.completeTaskVar(taskId, "1", "zengzhihui", map);
		}
	}
	
	
	
}
