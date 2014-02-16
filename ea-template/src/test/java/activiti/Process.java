package activiti;

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
import org.activiti.engine.repository.ProcessDefinition;
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

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring.xml")
public abstract class Process {
	private final Logger log = LoggerFactory.getLogger(ProcessTest.class);
	@Autowired
	public RuntimeService runtimeService;

	@Autowired
	public TaskService taskService;
	@Autowired
	public RepositoryService repositoryService;
	@Autowired
	public HistoryService historyService;
	@Autowired
	public ManagementService managementService;
	@Autowired
	public IdentityService identityService;
	@Autowired
	public FormService formService;
	@Autowired
	public BasicDataSource dataSource;
	@Autowired
	public InfActiviti infActiviti;

	public void deploy() throws FileNotFoundException {
		infActiviti.deploy("");
	}

	public void queryUnFinishTask() {
		List<HistoricTaskInstance> tasks = historyService
				.createHistoricTaskInstanceQuery().processUnfinished().list();
		for (HistoricTaskInstance historicTaskInstance : tasks) {
			System.out.println(" UnFinishTask task ID --> " + historicTaskInstance.getId()
					+ " assignee --> " + historicTaskInstance.getAssignee());
		}
	}
	
	public void queryAssigneeTaskByAccount(String account) {
		List<Task> tasks = taskService.createTaskQuery().taskAssignee(account)
				.list();
		for (Task task : tasks) {
			System.out.println("Assignee Task ID ---> " + task.getId()
					+ ", task name --> " + task.getName()
					+ ", task assignee --> " + task.getAssignee()
					+ ", task owner -->" + task.getOwner());
		}
	}

	public void queryCandidateTaskByAccount(String account) {
		/*List<Task> tasks = taskService.createTaskQuery().taskCandidateUser(account)
				.list();
		for (Task task : tasks) {
			System.out.println("Assignee Task ID ---> " + task.getId() + ", task name --> " + task.getName() + ", task assignee --> " + task.getAssignee());
		}*/
		List<OaTask> tasks = infActiviti
				.getCandidateTaskListByAccount(account);
		printOaTaskList(tasks);
	}
	
	public void getDeployedProcess(){
		List<ProcessDefinition> list = repositoryService
				.createProcessDefinitionQuery().latestVersion().list();
		for (ProcessDefinition processDefinition : list) {
			System.out.println("process name:" + processDefinition.getName() + ", process id:" + processDefinition.getId());
		}
	}
	
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

}
