package activiti.study1;

import java.io.FileNotFoundException;

import org.activiti.engine.repository.ProcessDefinition;
import org.junit.Test;

import activiti.Process;

public class Leave extends Process {
	@Test
	@Override
	public void deploy() throws FileNotFoundException {
		infActiviti.deploy("src/test/resources/acitiviti/study1/leave.bpmn");
	}
	
	@Test
	public void getDeployedProcess(){
		super.getDeployedProcess();
	}
	
}
