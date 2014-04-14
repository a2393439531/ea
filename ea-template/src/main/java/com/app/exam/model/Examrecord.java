package com.app.exam.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
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
	private int singlechoicemark;
	private int multichoicemark;
	private int blankmark;
	private int essaymark;
	
	private String remark;
	
	@Column(length = 2000)
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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
	
	private Set<Result> result = new HashSet();

	
	@OneToMany(mappedBy = "examrecord", cascade = CascadeType.ALL)
	public Set<Result> getResult() {
		return result;
	}

	public void setResult(Set<Result> result) {
		this.result = result;
	}
	
}
