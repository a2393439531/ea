package com.app.exam.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.app.common.spring.ssh.model.BaseModel;

@Entity
@Table(name = "test_result")
public class Result extends BaseModel {
	private Long id;

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
//	private Paper paper;
//	
//	@ManyToOne(cascade = { CascadeType.ALL })
//	@JoinColumn(name = "paper_id", nullable = true)
//	public Paper getPaper() {
//		return paper;
//	}
//
//	public void setPaper(Paper paper) {
//		this.paper = paper;
//	}
	
	
	private Item item;
	
	@ManyToOne(cascade = { CascadeType.ALL })
	@JoinColumn(name = "item_id", nullable = true)
	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	private String answer;
	private int mark;
	private String user;
	
	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	private Examrecord examrecord;
	


	@Column(length = 2000)
	public String getAnswer() {
		return answer;
	}
	@ManyToOne(cascade = { CascadeType.ALL })
	@JoinColumn(name = "examrecord_id", nullable = true)
	public Examrecord getExamrecord() {
		return examrecord;
	}

	public void setExamrecord(Examrecord examrecord) {
		this.examrecord = examrecord;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public int getMark() {
		return mark;
	}

	public void setMark(int mark) {
		this.mark = mark;
	}
	
	
}
