package com.app.manager.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.app.common.activiti.model.ProcessModel;
import com.app.common.spring.ssh.model.BaseModel;

@Entity
@Table(name = "oa_wffee")
public class Wffee extends ProcessModel {
	private static final long serialVersionUID = 1L;
	private Long id;
	private Long sortNob = 0l;

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	private String count;

	public Long getSortNob() {
		return sortNob;
	}

	public void setSortNob(Long sortNob) {
		this.sortNob = sortNob;
	}
}