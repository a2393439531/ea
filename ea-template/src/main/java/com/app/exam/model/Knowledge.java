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

import com.app.common.spring.ssh.model.BaseModel;

@Entity
@Table(name = "test_knowledge")
public class Knowledge extends BaseModel {
	private Long id;

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	private String name;
	private String alias;
	private String value;
	
	
	private Set<Template> templates = new HashSet<Template>();
	
	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Template.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_template_knowledge", joinColumns = { @JoinColumn(name = "knowledge_id") }, inverseJoinColumns = { @JoinColumn(name = "template_id") })
	public Set getTemplates() {
		return templates;
	}

	public void setTemplates(Set<Template> template) {
		this.templates = template;
	}


	private Knowledge parentModel;
	private Set<Knowledge> childKnowledges = new HashSet<Knowledge>();

	@OneToMany(mappedBy = "parentModel", cascade = CascadeType.ALL)
	public Set<Knowledge> getChildKnowledges() {
		return childKnowledges;
	}

	public void setChildKnowledges(Set<Knowledge> childKnowledges) {
		this.childKnowledges = childKnowledges;
	}

	@ManyToOne(cascade = { CascadeType.ALL })
	@JoinColumn(name = "parent_id", nullable = true)
	public Knowledge getParentModel() {
		return parentModel;
	}

	public void setParentModel(Knowledge parentModel) {
		this.parentModel = parentModel;
	}

	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	private Set<Item> items = new HashSet<Item>();
	
	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Item.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_item_knowledge", joinColumns = { @JoinColumn(name = "knowledge_id") }, inverseJoinColumns = { @JoinColumn(name = "item_id") })
	public Set getItems() {
		return items;
	}

	public void setItems(Set<Item> items) {
		this.items = items;
	}

	private Set<Paper> papers = new HashSet<Paper>(); //被哪些试卷引用
	
	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Paper.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_paper_knowledge", joinColumns = { @JoinColumn(name = "knowledge_id") }, inverseJoinColumns = { @JoinColumn(name = "paper_id") })
	public Set getPapers() {
		return papers;
	}

	public void setPapers(Set<Paper> papers) {
		this.papers = papers;
	}
	
	
}
