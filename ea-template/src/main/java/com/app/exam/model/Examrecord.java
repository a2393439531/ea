package com.app.exam.model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


import com.app.common.spring.ssh.model.BaseModel;


@Entity
@Table(name = "test_examrecord")
public class Examrecord extends BaseModel {
	private Long id;

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	
	private String userid ;

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	private Paper paper;
	
	@ManyToOne(cascade = { CascadeType.ALL })
	@JoinColumn(name = "paper_id", nullable = true)
	public Paper getPaper() {
		return paper;
	}

	public void setPaper(Paper paper) {
		this.paper = paper;
	}
	
	
}
