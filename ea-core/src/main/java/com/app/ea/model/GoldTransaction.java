package com.app.ea.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.app.common.spring.ssh.model.BaseModel;

@Entity
@Table(name = "manager_ea_goldtransaction")
public class GoldTransaction extends BaseModel {

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

	
	private String goldNumber;
	private String toUsrAccount;
	private String fromUsrAccount;
	private String payRemarks;
	private String payDate;
	
	
	
	
	public String getPayDate() {
		return payDate;
	}

	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}

	public String getGoldNumber() {
		return goldNumber;
	}

	public void setGoldNumber(String goldNumber) {
		this.goldNumber = goldNumber;
	}

	public String getToUsrAccount() {
		return toUsrAccount;
	}

	public void setToUsrAccount(String toUsrAccount) {
		this.toUsrAccount = toUsrAccount;
	}

	public String getFromUsrAccount() {
		return fromUsrAccount;
	}

	public void setFromUsrAccount(String fromUsrAccount) {
		this.fromUsrAccount = fromUsrAccount;
	}

	public String getPayRemarks() {
		return payRemarks;
	}

	public void setPayRemarks(String payRemarks) {
		this.payRemarks = payRemarks;
	}
	
	
	

	

}