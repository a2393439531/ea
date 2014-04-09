package com.app.exam.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.app.common.activiti.model.ProcessModel;
import com.app.ea.model.User;

@Entity
@Table(name = "test_paper")
public class Paper extends ProcessModel {
	private Long id;

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	private Set<Knowledge> knowledge = new HashSet<Knowledge>();

	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Knowledge.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_paper_knowledge", joinColumns = { @JoinColumn(name = "paper_id") }, inverseJoinColumns = { @JoinColumn(name = "knowledge_id") })
	public Set getKnowledge() {
		return knowledge;
	}

	public void setKnowledge(Set<Knowledge> knowledge) {
		this.knowledge = knowledge;
	}
	
	private Template template; //引用的模板
	
	@ManyToOne(cascade = { CascadeType.ALL })
	@JoinColumn(name = "template_id", nullable = true)	
	public Template getTemplate() {
		return template;
	}

	public void setTemplate(Template template) {
		this.template = template;
	}

	
	//public Set<Result> resultdetail = new HashSet<Result>();
	
	//(cascade = CascadeType.REFRESH, targetEntity = Result.class, fetch = FetchType.LAZY)
	//@JoinTable(name = "test_paper_result", joinColumns = { @JoinColumn(name = "paper_id") }, inverseJoinColumns = { @JoinColumn(name = "result_id") })
	//@OneToMany(mappedBy = "paper", cascade = CascadeType.ALL)
	//	public Set<Result> getResultdetail() {
	//		return resultdetail;
	//	}
	//
	//	public void setResultdetail(Set<Result> resultdetail) {
	//		this.resultdetail = resultdetail;
	//	}

	public Set<Examrecord> resultdetail = new HashSet<Examrecord>();
	
	@OneToMany(mappedBy = "paper", cascade = CascadeType.ALL)
	public Set<Examrecord> getResultdetail() {
		return resultdetail;
	}

	public void setResultdetail(Set<Examrecord> resultdetail) {
		this.resultdetail = resultdetail;
	}
	
	public Set<Examrecord> getResultdetailByAccountAndRecordId(String account,String id) {
		Set<Examrecord> results = new HashSet<Examrecord>();
		for (Examrecord result : resultdetail) {
			if(account.equals(result.getUserid())){
				if(id.equals(String.valueOf(result.getId()))){
					results.add(result);
				}
			}
		}
		return results;
	}
	
	public Set<User> assignedUser = new HashSet<User>();
	
	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = User.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_paper_user", joinColumns = { @JoinColumn(name = "paper_id") }, inverseJoinColumns = { @JoinColumn(name = "user_id") })
	public Set<User> getAssignedUser() {
		return assignedUser;
	}

	public void setAssignedUser(Set<User> assignedUser) {
		this.assignedUser = assignedUser;
	}

	private String name;
	private int totalmark;
	private int singlechoicemark;
	private int multichoicemark;
	private int blankmark;
	private int essaymark;
	private int passmark;
	private int time;
	
	private String createuser;
	private String createdate;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getTotalmark() {
		return totalmark;
	}

	public void setTotalmark(int totalmark) {
		this.totalmark = totalmark;
	}

	public int getSinglechoicemark() {
		return singlechoicemark;
	}

	public void setSinglechoicemark(int singlechoicemark) {
		this.singlechoicemark = singlechoicemark;
	}

	public int getMultichoicemark() {
		return multichoicemark;
	}

	public void setMultichoicemark(int multichoicemark) {
		this.multichoicemark = multichoicemark;
	}

	public int getBlankmark() {
		return blankmark;
	}

	public void setBlankmark(int blankmark) {
		this.blankmark = blankmark;
	}

	public int getEssaymark() {
		return essaymark;
	}

	public void setEssaymark(int essaymark) {
		this.essaymark = essaymark;
	}

	public int getPassmark() {
		return passmark;
	}

	public void setPassmark(int passmark) {
		this.passmark = passmark;
	}

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
	}

	public String getCreateuser() {
		return createuser;
	}

	public void setCreateuser(String createuser) {
		this.createuser = createuser;
	}

	public String getCreatedate() {
		return createdate;
	}

	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	// for process
	public String getProcessInstanceId() {
		return processInstanceId;
	}

	public void setProcessInstanceId(String processInstanceId) {
		this.processInstanceId = processInstanceId;
	}
}
