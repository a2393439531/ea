package com.app.manager.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.app.common.spring.ssh.model.BaseModel;



@Entity
@Table(name = "oa_tpltb3")
public class Tpltb3 extends BaseModel {
	private static final long serialVersionUID = 1L;
	private Long id;
	public String projectId;
	private String title;
	private String requestid;
	private String startTime;
	private String requestDesc;
	private String priority;
	

	public Tpltb3() {
		super();
	}

	public Tpltb3(String projectId, String title, String requestid, String startTime, String requestDesc, String priority) {
		super();
		this.projectId = projectId;
		this.title = title;
		this.requestid = requestid;
		this.startTime = startTime;
		this.requestDesc = requestDesc;
		this.priority = priority;
	}

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRequestid() {
		return requestid;
	}

	public void setRequestid(String requestid) {
		this.requestid = requestid;
	}

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getRequestDesc() {
		return requestDesc;
	}

	public void setRequestDesc(String requestDesc) {
		this.requestDesc = requestDesc;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	

	@Override
	public String toString() {
		return "Tpltb3 [id=" + id + ", projectId=" + projectId + ", title=" + title + ", requestid=" + requestid + ", startTime=" + startTime + ", requestDesc=" + requestDesc + ", priority="
				+ priority + "]";
	}
	
}