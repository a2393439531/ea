package com.app.exam.model;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.app.common.spring.ssh.model.BaseModel;

@Entity
@Table(name = "test_template")
public class Template extends BaseModel {
	private Long id;

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	private String title;
	private int singlechoice;
	private int rmdsinglechoice;
	private int multichoice;
	private int rmdmultichoice;
	private int blank;
	private int rmdblank;
	private int essay;
	private int rmdessay;
	
	private Set<Knowledge> knowledge;//知识领域
	
	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Knowledge.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_template_knowledge", joinColumns = { @JoinColumn(name = "template_id") }, inverseJoinColumns = { @JoinColumn(name = "knowledge_id") })
	public Set getKnowledge() {
		return knowledge;
	}

	public void setKnowledge(Set<Knowledge> knowledge) {
		this.knowledge = knowledge;
	}

	private Set<Item> items;//必做题
	
	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Item.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_item_template", joinColumns = { @JoinColumn(name = "template_id") }, inverseJoinColumns = { @JoinColumn(name = "item_id") })
	public Set getItems() {
		return items;
	}

	public void setItems(Set<Item> items) {
		this.items = items;
	}

	private Set<Paper> papers;
	
	@OneToMany(cascade = CascadeType.REFRESH, targetEntity = Paper.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_paper_template", joinColumns = { @JoinColumn(name = "template_id") }, inverseJoinColumns = { @JoinColumn(name = "paper_id") })
	public Set getPapers() {
		return papers;
	}

	public void setPapers(Set<Paper> papers) {
		this.papers = papers;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getSinglechoice() {
		return singlechoice;
	}

	public void setSinglechoice(int singlechoice) {
		this.singlechoice = singlechoice;
	}

	public int getRmdsinglechoice() {
		return rmdsinglechoice;
	}

	public void setRmdsinglechoice(int rmdsinglechoice) {
		this.rmdsinglechoice = rmdsinglechoice;
	}

	public int getMultichoice() {
		return multichoice;
	}

	public void setMultichoice(int multichoice) {
		this.multichoice = multichoice;
	}

	public int getRmdmultichoice() {
		return rmdmultichoice;
	}

	public void setRmdmultichoice(int rmdmultichoice) {
		this.rmdmultichoice = rmdmultichoice;
	}

	public int getBlank() {
		return blank;
	}

	public void setBlank(int blank) {
		this.blank = blank;
	}

	public int getRmdblank() {
		return rmdblank;
	}

	public void setRmdblank(int rmdblank) {
		this.rmdblank = rmdblank;
	}

	public int getEssay() {
		return essay;
	}

	public void setEssay(int essay) {
		this.essay = essay;
	}

	public int getRmdessay() {
		return rmdessay;
	}

	public void setRmdessay(int rmdessay) {
		this.rmdessay = rmdessay;
	}
	
	
}
