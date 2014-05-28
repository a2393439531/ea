package com.app.ea.action;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.common.spring.ssh.action.BaseAction;
import com.app.common.spring.ssh.action.BaseBusinessAction;
import com.app.common.spring.ssh.dao.BaseDaoHibernate;
import com.app.ea.model.GoldTransaction;
import com.app.ea.model.GoldTask;
import com.app.ea.model.Rule;
import com.app.ea.model.User;


import org.apache.commons.beanutils.BeanUtils;

@Component("goldtaskAction")
@Scope("prototype")
public class GoldTaskAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(GoldTaskAction.class);
	public GoldTask goldtask = new GoldTask();
	public GoldTransaction goldtran = new GoldTransaction();




	public GoldTask getGoldtask() {
		return goldtask;
	}

	public void setGoldtask(GoldTask goldtask) {
		this.goldtask = goldtask;
	}
	
	public String menu_allgoldtask() throws Exception{
		getPageData("from GoldTask order by createDate desc");
		return "success";
	}
	public String menu_usrgoldtask() throws Exception{
		getPageData("from GoldTask where usrAccount = '"+getCurrentAccount()+"' or usrAccountArray like '%"+getCurrentAccount()+"%'  order by createDate desc");
		return "success";
	}
	public String menu_bidgoldtask() throws Exception{
		getPageData("from GoldTask where bidUsrAccount is null and usrAccountArray not like '%"+getCurrentAccount()+"%' and usrAccount != '"+getCurrentAccount()+"' order by createDate desc");
		return "success";
	}

	
	//投标
	public String bid() throws Exception {
		String taskId = getpara("taskId");
//		String usrAccount = getpara("usrAccount");
		String usrAccount = getCurrentAccount();
		log.info("bid_goldtask==> taskId=" + taskId + " usrAccount=" + usrAccount);
		rhs.put("result", "-1");
		GoldTask gt = (GoldTask) (baseDao.find("from GoldTask gt where id = ?", Long.parseLong(taskId)).get(0));
		if(gt.getBidUsrAccount() != null && gt.getBidUsrAccount().length() >= 1){
			rhs.put("result", "这个任务已经终止投标");
			return "success";
		}
		if(gt.getUsrAccountArray() != null && gt.getUsrAccountArray().contains(usrAccount)){
			rhs.put("result", "您已经投过了, 请刷新数据..");
			return "success";
		}
		
		
		if(gt.getUsrAccountArray() != null && !"".equals(gt.getUsrAccountArray())) gt.setUsrAccountArray(gt.getUsrAccountArray() + "," + usrAccount);
		else gt.setUsrAccountArray(usrAccount);
		baseDao.update(gt);
		rhs.put("result", "0000");
		log.info("done............");
		return "success";
	}
	
	//修改
	public String update() throws Exception{
		baseDao.update(goldtask);
		rhs.put("result", "0000");
		return "success";
	}
	//删除
	public String delete() throws Exception{
		baseDao.delete(goldtask);
		rhs.put("result", "0000");
		return "success";
	}
	
	//发布task
	public String release() throws Exception {
		System.out.println("xxxx: " + goldtask.getTitle());
		goldtask.setUsrAccount(getCurrentAccount());
		if(goldtask.getEndDate() != null){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date d = sdf.parse(goldtask.getEndDate());
			goldtask.setEndDate(sdf.format(d));
		}
		if(goldtask.getUsrAccount() == null || "".equals(goldtask.getUsrAccount().trim())){
			rhs.put("result", "-1");
			rhs.put("tipInfo", "noAccount");
			return "success";
		}
		
		goldtask.setCreateDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		
		if(goldtask.getTitle() != null){
			long l =  baseDao.create(goldtask);
			rhs.put("result", "0000");
		}
		
		
		
		return "success";
	}
	
	
	//获取所有用户
	public String menu_usr() throws Exception {
		
		List datalist = baseDao.find("from User");
		rhs.put("datalist", datalist);
		return "success";
	}
	
	//交易记录
	public String goldrecords() throws Exception {
		String[] params = {getCurrentAccount(),getCurrentAccount()};
		rhs.put("datalist", baseDao.find("from GoldTransaction where fromUsrAccount = ? or toUsrAccount = ? order by payDate desc",params));
		return "success";
	}
	
	//所有交易记录(财产公开)
	public String allgoldrecords() throws Exception {
				//String[] params = {getCurrentAccount(),getCurrentAccount()};
				rhs.put("datalist", baseDao.find("from GoldTransaction order by payDate desc"));
				return "success";
	}
	
	//金币支付
	public String pay() throws Exception {
		
		if(getCurrentAccount() == null || "".equals(getCurrentAccount())){
			rhs.put("result", "你还未登录");
			return "success";
		}
		
		User fu = (User) (baseDao.find("from User gt where account = ?", getCurrentAccount()).get(0));
		if(fu.getGoldnumber() == null || "".equals(fu.getGoldnumber()) || Integer.parseInt(fu.getGoldnumber()) < Integer.parseInt(goldtran.getGoldNumber())){
			rhs.put("result", "您的金币不足");
			return "success";
		}
		goldtran.setPayDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		
		fu.setGoldnumber((Integer.parseInt(fu.getGoldnumber()) - Integer.parseInt(goldtran.getGoldNumber()))+"");
		
		User tu = (User) (baseDao.find("from User gt where account = ?", goldtran.getToUsrAccount()).get(0));
		if(tu.getGoldnumber() == null) tu.setGoldnumber("0");
		tu.setGoldnumber((Integer.parseInt(tu.getGoldnumber()) + Integer.parseInt(goldtran.getGoldNumber()))+"");
	
		goldtran.setFromUsrAccount(getCurrentAccount());
		
		baseDao.create(goldtran);
		baseDao.update(fu);
		baseDao.update(tu);
		
		putSessionValue("userlogined", fu);
		
		System.out.println("fu: " + fu.getGoldnumber() + " tu: " + tu.getGoldnumber());
		
		rhs.put("result", "0000");
		return "success";
	}
	
	//结束投标
		public String finish_bid() throws Exception {
			String taskId = getpara("taskId");
			String bidUsrAccount = getpara("bidUsrAccount");
			String usrAccount = getCurrentAccount();
			log.info("finish_bid==> taskId=" + taskId + " usrAccount=" + usrAccount);
			rhs.put("result", "-1");
			GoldTask gt = (GoldTask) (baseDao.find("from GoldTask gt where id = ?", Long.parseLong(taskId)).get(0));
			if(gt.getBidUsrAccount() != null && gt.getBidUsrAccount().length() >= 1){
				rhs.put("result", "这个任务已经终止投标, 请刷新数据");
				return "success";
			}
			
			gt.setBidUsrAccount(bidUsrAccount);
			baseDao.update(gt);
			rhs.put("result", "0000");
			log.info("done............");
			return "success";
		}
	

	
	
	
	
	
	
	
}