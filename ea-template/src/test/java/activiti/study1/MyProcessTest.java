package activiti.study1;

import java.io.FileNotFoundException;
import java.util.Iterator;
import java.util.List;

import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.ManagementService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.dbcp.BasicDataSource;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.app.common.activiti.api.InfActiviti;
import com.app.common.activiti.api.OaTask;
import com.app.common.activiti.api.ProcessConfig;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring.xml")
public class MyProcessTest {
	private final Logger log = LoggerFactory.getLogger(MyProcessTest.class);
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private RepositoryService repositoryService;
	@Autowired
	private HistoryService historyService;
	@Autowired
	private ManagementService managementService;
	@Autowired
	private IdentityService identityService;
	@Autowired
	private FormService formService;
	@Autowired
	private BasicDataSource dataSource;
	@Autowired
	private InfActiviti infActiviti;

	public void printTaskList(List<Task> taskList) {
		for (Iterator iterator = taskList.iterator(); iterator.hasNext();) {
			Task task = (Task) iterator.next();
			log.debug("id:" + task.getId() + " 分配人:" + task.getAssignee()
					+ " 拥有者:" + task.getOwner() + " 优先级:" + task.getPriority()
					+ " 任务名:" + task.getName()

					+ " 描述:"
					+ task.getDescription()
					// +" 时间"+DateUtil.getTimeStrByDate(task.getCreateTime(),
					// "yyyy-MM-dd hh-mm-ss")
					+ " 到期时间:" + task.getDueDate() + " 拥ExecutionId者:"
					+ task.getExecutionId() + "getTaskDefinitionKey:"
					+ task.getTaskDefinitionKey() + "父任务ID:"
					+ task.getParentTaskId()

			);
		}
	}

	public void printOaTaskList(List<OaTask> taskList) {

		for (Iterator iterator = taskList.iterator(); iterator.hasNext();) {
			OaTask oaTask = (OaTask) iterator.next();
			log.debug("id:" + oaTask.task.getId() + " 分配人:"
					+ oaTask.task.getAssignee() + " 拥有者:"
					+ oaTask.task.getOwner() + " 优先级:"
					+ oaTask.task.getPriority() + " 任务名:"
					+ oaTask.task.getName() + " 描述:"
					+ oaTask.task.getDescription()
					// +" 时间"+DateUtil.getTimeStrByDate(oaTask.task.getCreateTime(),
					// "yyyy-MM-dd hh-mm-ss")
					+ " 到期时间:" + oaTask.task.getDueDate());
		}
	}

	@Test
	public void deploy() throws FileNotFoundException {
		infActiviti.deploy("src/test/resources/acitiviti/study1/MyProcess.bpmn");

		// runtimeService.startProcessInstanceByKey("myProcess");
		// 没必要如此启动，可以通过infActiviti里面的startProcess方法来按照我们业务逻辑启动
	}

	@Test
	public void startProcess() {
		infActiviti.startProcessAssignee("myProcess", "1", 
				"admin", "huangjunhui");
	}

	@Test
	public void processTaskList() {
		List<OaTask> tasks = infActiviti
				.getCandidateTaskListByAccount("huangjunhui");
		printOaTaskList(tasks);
	}
	
	@Test
	public void queryAssigneeTask() {
		List<Task> tasks = taskService.createTaskQuery().taskAssignee("huangjunhui")
				.list();
		for (Task task : tasks) {
			System.out.println("Assignee Task ID ---> " + task.getId() + ", task name --> " + task.getName() + ", task assignee --> " + task.getAssignee());
		}
	}
	
	
	//@Test
	public void queryUnFinishTask(){
		List<HistoricTaskInstance> tasks = historyService.createHistoricTaskInstanceQuery().processUnfinished().list();
		for (HistoricTaskInstance historicTaskInstance : tasks) {
			System.out.println("task ID --> " + historicTaskInstance.getId()+ " assignee --> "  + historicTaskInstance.getAssignee());
		}
		
	}
	
}
