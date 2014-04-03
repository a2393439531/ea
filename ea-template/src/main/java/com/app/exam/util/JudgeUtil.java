package com.app.exam.util;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.JavaDelegate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class JudgeUtil implements JavaDelegate {
	private final Logger log = LoggerFactory.getLogger(JudgeUtil.class);
	@Override
	public void execute(DelegateExecution execution) throws Exception {
		log.debug(execution.getCurrentActivityName());
		
	}

}
