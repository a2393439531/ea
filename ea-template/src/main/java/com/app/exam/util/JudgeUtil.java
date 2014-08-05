package com.app.exam.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		BaseDao baseDao = (BaseDao)SpringContext.getBean("eaDaoTarget");
		InfActiviti infActiviti = (InfActiviti)SpringContext.getBean("infActiviti");
		String processInstanceId = execution.getProcessInstanceId();
		List<Paper> allpaper = new ArrayList<Paper>();
		String[] allrecord = {};
		String assignee = (String)infActiviti.getVariableByProcessInstanceId(processInstanceId, "assignee");
		Map<String, Object> dataMap = (Map<String, Object>) Cache.get(assignee);
		String paperid = null;
		String recordsId = null;
		if(dataMap != null){
			paperid = String.valueOf(dataMap.get("allpaper"));
			if(paperid.split(",").length == 1){
				
			}else{
				String[] tempid = paperid.split(",");
				for (String id : tempid) {
					Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(id));
					allpaper.add(paper);
				}
			}
			
	
		    recordsId = String.valueOf(dataMap.get("allrecord"));
			if(recordsId.split(",").length == 1){
			
			}
		}else{
			paperid = (String) infActiviti.getVariableByProcessInstanceId(processInstanceId, "formId");
			Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(paperid));
			allpaper.add(paper);
			recordsId = String.valueOf(infActiviti.getVariableByProcessInstanceId(processInstanceId, "recordsId"));
		}
		
		allrecord = recordsId.split(",");
		
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
				boolean flag = false;
				if(item.getType() == 2){ //多选答案判断
					String[] keys = item.getRefkey().split(",");
					String[] answers = result.getAnswer() == null? new String[0]:result.getAnswer().split(",");
					if(answers.length == keys.length){
						for(String answer: answers){
							flag = false;
							for(String key: keys){
								if(answer.trim().equals(key)){
									flag = true;
									break;
								}
							}
						}
					}
					if(flag){
						multichoicemark += result.getMark();
					}else{
						result.setMark(0);
					}
				}else if(result.getAnswer()!= null && result.getAnswer().equals(item.getRefkey())){//单选答案判断
					switch(item.getType()){
					case 1:
						singlechoicemark += result.getMark();
						break;
					// case 2:
					// multichoicemark += result.getMark();
					// break;
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
			record.setRecorddate(sdf.format(new Date()));
			baseDao.update(record);
		}
		log.debug("-------------------------->Auto Judge Done<-------------------------");
	}

}
