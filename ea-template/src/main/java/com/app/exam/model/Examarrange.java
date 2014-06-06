package com.app.exam.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.app.common.spring.ssh.model.BaseModel;

@Entity
@Table(name = "test_examarrange")
public class Examarrange extends BaseModel {
	private Long id;

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	private String paperid;
	private String userid;
	private String starttime;
	private String endtime;

	public String getPaperid() {
		return paperid;
	}

	public void setPaperid(String paperid) {
		this.paperid = paperid;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	
}
