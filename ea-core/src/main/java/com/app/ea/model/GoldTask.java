package com.app.ea.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.app.common.spring.ssh.model.BaseModel;

@Entity
@Table(name = "manager_ea_goldtask")
public class GoldTask extends BaseModel {

	private static final long serialVersionUID = 1L;
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
	private String detail;
	private String endDate;
	private String createDate; //发布日期
	private String goldNumber;
	private String usrAccount;		//任务发布者
	private String usrAccountArray = ""; //投票成员
	private String bidUsrAccount; //中标人员
	
	
	

	public String getBidUsrAccount() {
		return bidUsrAccount;
	}

	public void setBidUsrAccount(String bidUsrAccount) {
		this.bidUsrAccount = bidUsrAccount;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getUsrAccount() {
		return usrAccount;
	}

	public void setUsrAccount(String usrAccount) {
		this.usrAccount = usrAccount;
	}

	public String getUsrAccountArray() {
		return usrAccountArray;
	}

	public void setUsrAccountArray(String usrAccountArray) {
		this.usrAccountArray = usrAccountArray;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getGoldNumber() {
		return goldNumber;
	}

	public void setGoldNumber(String goldNumber) {
		this.goldNumber = goldNumber;
	}
	
	

	

}