package com.app.exam.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
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
import javax.persistence.Table;

import com.app.common.spring.ssh.dao.BaseDao;
import com.app.common.spring.ssh.model.BaseModel;

import edu.emory.mathcs.backport.java.util.Collections;

@Entity
@Table(name = "test_papergroup")
public class Papergroup extends BaseModel {
	private Long id;

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	
	private Set<Paper> papers;
	
	//@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Paper.class, fetch = FetchType.LAZY)
	//@JoinTable(name = "test_paper_papergroup", joinColumns = { @JoinColumn(name = "papergroup_id") }, inverseJoinColumns = { @JoinColumn(name = "paper_id") })
	@OneToMany(mappedBy = "papergroup", cascade = CascadeType.ALL)
	public Set<Paper> getPapers() {
		return papers;
	}

	public void setPapers(Set<Paper> papers) {
		this.papers = papers;
	}
	
	private String name;
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Paper getNextPaper(Set<Paper> papers, Paper currentpaper){
		List<Paper> list = new ArrayList<Paper>();
		list.addAll(papers);
		Collections.sort(list);//已经在paper类重写compare方法
		int index = 0;
		for (Paper paper : list) {
			if(paper.getId() == currentpaper.getId()){
				index ++;
				break;
			}
			index ++ ;
		}
		if(index == 0 || index == list.size()){
			return null;
		}
		return list.get(index);
	}
	
}
