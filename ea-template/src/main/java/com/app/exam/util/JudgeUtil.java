package com.app.exam.util;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.JavaDelegate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.app.common.activiti.api.InfActiviti;
import com.app.common.activiti.api.SpringContext;
import com.app.common.spring.ssh.dao.BaseDao;
import com.app.exam.model.Examrecord;
import com.app.exam.model.Item;
import com.app.exam.model.Paper;
import com.app.exam.model.Result;

public class JudgeUtil implements JavaDelegate {
	private final Logger log = LoggerFactory.getLogger(JudgeUtil.class);
	@Override
	public void execute(DelegateExecution execution) throws Exception {
		log.debug("----------------------------------->"+execution.getCurrentActivityName());
		int singlechoicemark = 0;
		int multichoicemark = 0;
		int blankmark = 0;
		int essaymark = 0;
		BaseDao baseDao = (BaseDao)SpringContext.getBean("eaDaoTarget");
		InfActiviti infActiviti = (InfActiviti)SpringContext.getBean("infActiviti");
		
		String processInstanceId = execution.getProcessInstanceId();
		
		String paperid = (String) infActiviti.getVariableByProcessInstanceId(processInstanceId, "formId");
		String assignee = (String)infActiviti.getVariableByProcessInstanceId(processInstanceId, "assignee");
		String recordsId = String.valueOf(infActiviti.getVariableByProcessInstanceId(processInstanceId, "recordsId"));
		
		Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(paperid));
		
		Set<Examrecord> examrecords = (Set<Examrecord>)paper.getResultdetailByAccountAndRecordId(assignee,recordsId);
		Set<Result> results = new HashSet<Result>();
		
		for (Examrecord examrecord : examrecords) {
			results.addAll(examrecord.getResult());
		}
		
		Examrecord record = (Examrecord) baseDao.loadById("Examrecord", Long.valueOf(recordsId));
		
		record.setUserid(assignee);
		record.setPaper(paper);
		
		for (Result result : results) {
			//String itemid = String.valueOf(result.getItemId());
			//(Item)baseDao.loadById("Item", Long.valueOf(itemid));
			Item item = result.getItem(); 
			if(result.getAnswer()!= null && result.getAnswer().equals(item.getRefkey())){
				switch(item.getType()){
				case 1:
					singlechoicemark += result.getMark();
					break;
				case 2:
					multichoicemark += result.getMark();
					break;
				case 3:
					blankmark += result.getMark();
					break;
				case 4:
					essaymark += result.getMark();
					break;
				}
			}else{
				result.setMark(0);
			}
			result.setExamrecord(record);
			baseDao.update(result);
		}
		record.setSinglechoicemark(singlechoicemark);
		record.setMultichoicemark(multichoicemark);
		record.setBlankmark(blankmark);
		record.setEssaymark(essaymark);
		record.setRemark("Success, auto judge");
		baseDao.update(record);
		
		log.debug("-------------------------->Auto Judge Done<-------------------------");
	}

}
