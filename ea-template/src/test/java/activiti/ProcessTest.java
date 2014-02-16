package activiti;

import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.ManagementService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.apache.commons.dbcp.BasicDataSource;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.app.common.activiti.api.InfActiviti;
import com.app.common.activiti.api.OaTask;
import com.app.common.activiti.api.ProcessConfig;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring.xml")
public class ProcessTest {
	private final Logger log = LoggerFactory.getLogger(ProcessTest.class);
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
  /*
  ClassPathXmlApplicationContext applicationContext = 
		    new ClassPathXmlApplicationContext("org/activiti/examples/spring/SpringTransactionIntegrationTest-context.xml");
  */
  @Autowired
  private InfActiviti infActiviti;
  
 
  @Test
  public void printDatabase() {
	 log.debug("测试启动的api");
	 log.debug(dataSource.getUrl());
	 //log.debug(impActiviti.getDatabase());
  }
 
  public void printOaTaskList(List<OaTask> taskList) {
	
	  for (Iterator iterator = taskList.iterator(); iterator.hasNext();) {
			OaTask oaTask = (OaTask) iterator.next();
			log.debug("id:"+oaTask.task.getId()
					+" 分配人:"+oaTask.task.getAssignee()
					+" 拥有者:"+oaTask.task.getOwner()
					+" 优先级:"+oaTask.task.getPriority()
					+" 任务名:"+oaTask.task.getName()
					+" 描述:"+oaTask.task.getDescription()
					//+" 时间"+DateUtil.getTimeStrByDate(oaTask.task.getCreateTime(), "yyyy-MM-dd hh-mm-ss")
		            +" 到期时间:"+oaTask.task.getDueDate()
			);
		}
  } 
  
  
  public void printTaskList(List<Task> taskList) {
	  for (Iterator iterator = taskList.iterator(); iterator.hasNext();) {
			Task task = (Task) iterator.next();
			log.debug("id:"+task.getId()
					+" 分配人:"+task.getAssignee()
					+" 拥有者:"+task.getOwner()
					+" 优先级:"+task.getPriority()
					+" 任务名:"+task.getName()
					
					+" 描述:"+task.getDescription()
				//	+" 时间"+DateUtil.getTimeStrByDate(task.getCreateTime(), "yyyy-MM-dd hh-mm-ss")
		            +" 到期时间:"+task.getDueDate()
		            +" 拥ExecutionId者:"+task.getExecutionId()
		            +"getTaskDefinitionKey:"+task.getTaskDefinitionKey()
		            +"父任务ID:"+task.getParentTaskId()
		           
		           
			);
		}
  } 
  @Test
  public void getDatabase() {
	 log.debug("测试启动的api"+infActiviti.getDatabase());
	
  }
  
  //	public abstract String startProcessNoAssigee(String processKey, String formId,String initiator, String busi_desc) ;

  @Test
  public void startProcessNoAssigee() {
	 log.debug("startProcessNoAssigee:"+infActiviti.startProcessNoAssigee("helloProcess","1","zhansan"));
	
  }
  
  
  @Test
  public void deploy() throws FileNotFoundException {
	  infActiviti.deploy("src/test/resources/acitiviti/hello_print.bpmn20.xml");
	  /*
	  String deploymentId = repositoryService
	    .createDeployment()
	    .addClasspathResource("com/app/manager/oa/bpmn/hello.bpmn20.xml")
	    .deploy()
	    .getId();
	  }
	  */
  }
  @Test
  public void helloprocess() {
	  runtimeService.startProcessInstanceByKey("helloProcess");
  }
  
  
  @Test
  public void RewardTaskProcessDeploy() throws FileNotFoundException {
	//  infActiviti.deploy("com/app/manager/oa/bpmn/RewardTaskProcess.bpmn");
	  infActiviti.deploy("src/test/resources/acitiviti/RewardTaskProcess.bpmn");
	//runtimeService.startProcessInstanceByKey("RewardTaskProcess");
  }
  
  @Test
  public void RewardTaskProcessListTask() throws FileNotFoundException {
	 // runtimeService.startProcessInstanceByKey("RewardTaskProcess");
  //  infActiviti.startProcessNoAssigee("RewardTaskProcess", "1", "zhangsan", "研究搜索引擎");
	 // List<Task> CandidateGroup = taskService.createTaskQuery().taskCandidateGroup("accountancy").list();
	 // List<Task> candidateTaskList = taskService.createTaskQuery().taskCandidateUser("zhansan").list();
	  List<OaTask> candidateTaskList =infActiviti.getCandidateTaskListByAccount("zhangsan");
	  log.debug("zhangsan候选人的可待选任务：");
	  printOaTaskList(candidateTaskList);
	  candidateTaskList =infActiviti.getCandidateTaskListByAccount("lisi");
	  log.debug("lisi的可待选任务：");
	  printOaTaskList(candidateTaskList);
	  candidateTaskList =infActiviti.getCandidateTaskListByAccount("wanger");
	  log.debug("wanger的可待选任务：");
	  printOaTaskList(candidateTaskList);

  }  
  
 
  
  
}      

