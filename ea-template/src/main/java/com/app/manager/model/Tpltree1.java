package com.app.manager.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.app.common.spring.ssh.model.BaseModel;

@Entity
@Table(name = "oa_tpltree1")
public class Tpltree1 extends BaseModel {
	private Long id;

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String name;
	private Long sortNob = 0l;

	private Tpltree1 parentModel;
	private Set<Tpltree1> childTpltree1s = new HashSet<Tpltree1>();

	@OneToMany(mappedBy = "parentModel", cascade = CascadeType.ALL)
	public Set<Tpltree1> getChildTpltree1s() {
		return childTpltree1s;
	}

	public void setChildTpltree1s(Set<Tpltree1> childTpltree1s) {
		this.childTpltree1s = childTpltree1s;
	}

	@ManyToOne(cascade = { CascadeType.ALL })
	@JoinColumn(name = "parent_id", nullable = true)
	public Tpltree1 getParentModel() {
		return parentModel;
	}

	public void setParentModel(Tpltree1 parentModel) {
		this.parentModel = parentModel;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getSortNob() {
		return sortNob;
	}

	public void setSortNob(Long sortNob) {
		this.sortNob = sortNob;
	}
}