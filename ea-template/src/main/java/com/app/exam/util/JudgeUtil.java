package com.app.exam.util;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
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
import com.utils.cache.Cache;

public class JudgeUtil implements JavaDelegate {
	private final Logger log = LoggerFactory.getLogger(JudgeUtil.class);
	@Override
	public void execute(DelegateExecution execution) throws Exception {
		log.debug("----------------------------------->"+execution.getCurrentActivityName());
		BaseDao baseDao = (BaseDao)SpringContext.getBean("eaDaoTarget");
		InfActiviti infActiviti = (InfActiviti)SpringContext.getBean("infActiviti");
		String processInstanceId = execution.getProcessInstanceId();
		List<Paper> allpaper = new ArrayList<Paper>();
		String[] allrecord = {};
		String assignee = (String)infActiviti.getVariableByProcessInstanceId(processInstanceId, "assignee");
		Map<String, Object> dataMap = (Map<String, Object>) Cache.get(assignee);
		String paperid = String.valueOf(dataMap.get("allpaper"));
		if(paperid.split(",").length == 1){
			paperid = (String) infActiviti.getVariableByProcessInstanceId(processInstanceId, "formId");
			Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(paperid));
			allpaper.add(paper);
		}else{
			String[] tempid = paperid.split(",");
			for (String id : tempid) {
				Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(id));
				allpaper.add(paper);
			}
		}
		

		String recordsId = String.valueOf(dataMap.get("allrecord"));
		if(recordsId.split(",").length == 1){
			recordsId = String.valueOf(infActiviti.getVariableByProcessInstanceId(processInstanceId, "recordsId"));
		}else{
			allrecord = recordsId.split(",");
		}
		
		
		Set<Examrecord> examrecords = null;
		int index = 0;
		Set<Examrecord> allexamrecords = new HashSet<Examrecord>();
		
		for (Paper paper : allpaper) {
			int singlechoicemark = 0;
			int multichoicemark = 0;
			int blankmark = 0;
			int essaymark = 0;
			examrecords = (Set<Examrecord>)paper.getResultdetailByAccountAndRecordId(assignee,allrecord[index]);
			Set<Result> results = new HashSet<Result>();
			Examrecord record = null;
			for (Examrecord examrecord : examrecords) {
				results.addAll(examrecord.getResult());
				record = examrecord;
			}
			index ++;
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
		}
		log.debug("-------------------------->Auto Judge Done<-------------------------");
	}

}
