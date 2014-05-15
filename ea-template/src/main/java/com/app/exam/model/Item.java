package com.app.exam.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.app.common.spring.ssh.model.BaseModel;

@Entity
@Table(name = "test_item")
public class Item extends BaseModel {
	private Long id;

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	private String content;
	// 01:single choice, 02:multi choice, 03:blank, 04:essay
	private int type;
	private String refkey; // 参考答案
	private String createuser;
	
	//分值,如果item的分值不为空，则以该值为计算分数，否则则以试卷对象里面定义的分值来计算。
	private String mark;
	
	private Set<Choiceitem> choiceitem = new HashSet();
	
	//@OneToMany(cascade = CascadeType.REFRESH, targetEntity = Choiceitem.class, fetch = FetchType.LAZY)
	//@JoinTable(name = "test_item_choiceitem", joinColumns = { @JoinColumn(name = "item_id") }, inverseJoinColumns = { @JoinColumn(name = "itemchoice_id") })
	@OneToMany(mappedBy = "item", cascade = CascadeType.ALL)
	public Set<Choiceitem> getChoiceitem() {
		return choiceitem;
	}

	public void setChoiceitem(Set<Choiceitem> choiceitem) {
		this.choiceitem = choiceitem;
	}
	
	private Set<Knowledge> knowledge = new HashSet<Knowledge>();//知识领域
	
	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Knowledge.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_item_knowledge", joinColumns = { @JoinColumn(name = "item_id") }, inverseJoinColumns = { @JoinColumn(name = "knowledge_id") })
	public Set getKnowledge() {
		return knowledge;
	}

	public void setKnowledge(Set<Knowledge> knowledge) {
		this.knowledge = knowledge;
	}
	
	private Set<Template> templates = new HashSet<Template>();
	
	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Template.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_item_template", joinColumns = { @JoinColumn(name = "item_id") }, inverseJoinColumns = { @JoinColumn(name = "template_id") })
	public Set getTemplates() {
		return templates;
	}

	public void setTemplates(Set<Template> templates) {
		this.templates = templates;
	}

	@Column(length = 2000)
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getRefkey() {
		return refkey;
	}

	public void setRefkey(String refkey) {
		this.refkey = refkey;
	}

	public String getCreateuser() {
		return createuser;
	}

	public void setCreateuser(String createuser) {
		this.createuser = createuser;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	
	
	
}
