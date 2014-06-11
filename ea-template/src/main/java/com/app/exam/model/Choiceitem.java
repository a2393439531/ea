package com.app.exam.model;

import java.util.Random;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.app.common.spring.ssh.model.BaseModel;

@Entity
@Table(name = "test_choiceitem")
public class Choiceitem extends BaseModel {
	private Long id;

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	
	private int refid;
	private String value;

	private Item item;
	
	@ManyToOne(cascade = { CascadeType.ALL })
	@JoinColumn(name = "item_id", nullable = true)
	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	public int getRefid() {
		return refid;
	}


	public void setRefid(int refid) {
		this.refid = refid;
	}

	@Column(length = 2000)
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	

	@Override
	public int compareTo(Object o) {
		String[] seed = {"-1","1"};
		// TODO Auto-generated method stub
		if(o instanceof Choiceitem){
			if(this.id == (((Choiceitem) o).getId())){
				return 0;
			}else{
				int result = Math.random()>0.5?1:0; 
				return Integer.valueOf(seed[result]);
			}
		}
		return super.compareTo(o);
	}
	
	
}
