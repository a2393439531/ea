package com.app.ea.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.utils.path.PathUtils;


import org.apache.commons.beanutils.BeanUtils;


@Component("goldtaskAction")
@Scope("prototype")
public class GoldTaskAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(GoldTaskAction.class);
	public GoldTask goldtask = new GoldTask();
	public GoldTransaction goldtran = new GoldTransaction();
	public User user = new User();
	

	//读取登录日志文件 
	public String menu_log() throws Exception{
		String path = PathUtils.getHomePath(PathUtils.SYSTEM_DATA_CLASS) + "log_login.txt";
		RandomAccessFile raf = null;
		List<String> list = new ArrayList<String>();
		try{
			
			raf = new RandomAccessFile(path, "r");
			long start = raf.getFilePointer();
			long len = raf.length();
			long cur = start + len - 1;
			raf.seek(cur);
			int c = -1;
			while(cur>=start && ( c = raf.read()) != -1){
				if(c == 10 || c == 13){
					String str = raf.readLine();
					if(str != null && str.length() > 0) {
						str = new String(str.getBytes("8859_1"),"utf-8");
						list.add(str);
					}
				}
				if(list.size() >= 5) break;
				cur-=1;
				if(cur <0 ) {
					raf.seek(0);
					list.add(raf.readLine());
					break;
				}else raf.seek(cur);
	        }			
			rhs.put("datalist", list);
		}finally{
			raf.close();
		}
		
		return "success";
	}
	
	//获取当前Task 根据　taskid
	public String get_task() throws Exception{
			
		rhs.put("datalist", baseDao.find("from GoldTask where id = ?", Long.parseLong(getpara("taskId"))));
		return "success";
	}
	
	public String menu_allgoldtask() throws Exception{
		getPageData("from GoldTask order by createDate desc");
		return "success";
	}
	public String menu_usrgoldtask() throws Exception{
		if("-1".equals(getpara("maxSize")) && "1".equals(getpara("isUsrRel"))){
			List datalist = baseDao.find("from GoldTask where usrAccount = '"+getCurrentAccount()+"' order by createDate desc");
			rhs.put("dataList", datalist);
			return "success";
		}
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
		log.info(getCurrentUser().getName() + " 投标了 " + gt.getTitle());
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
		log.info(getCurrentUser().getName() + "发布了 " + goldtask.getTitle());
		return "success";
	}
	
	
	//获取所有用户
	public String menu_usr() throws Exception {
		
//		List datalist =infEa.getUserNotAdmin();
		List datalist =baseDao.find("from User");
	
		ComparatorUser cu = new ComparatorUser();
		Collections.sort(datalist, cu);
		rhs.put("datalist", datalist);
		
		return "success";
	}
	
	//交易记录
	public String goldrecords() throws Exception {
		rhs.put("datalist", baseDao.find("from GoldTransaction order by payDate desc"));
		return "success";
	}
	
	//所有交易记录(财产公开)
	public String allgoldrecords() throws Exception {
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
		log.info(fu.getName() + " 支付了" + goldtran.getGoldNumber() + " 块金币给 " + tu.getName());
		
		
		rhs.put("result", "0000");
		return "success";
	}
	
	//结束投标
		public String finish_bid() throws Exception {
			String taskId = getpara("taskId");
			String bidUsrAccount = getpara("bidUsrAccount");
			
			rhs.put("result", "-1");
			GoldTask gt = (GoldTask) (baseDao.find("from GoldTask gt where id = ?", Long.parseLong(taskId)).get(0));
			if(gt.getBidUsrAccount() != null && gt.getBidUsrAccount().length() >= 1){
				rhs.put("result", "这个任务已经终止投标, 请刷新数据");
				return "success";
			}
			
			gt.setBidUsrAccount(bidUsrAccount);
			baseDao.update(gt);
			rhs.put("result", "0000");
			log.info(getCurrentUser().getName() + " 结束了　" + gt.getTitle());
			return "success";
		}
	
		
		//修改用户信息
		public String updateuser(){
			
			User logineduser = (User)getSessionValue("userlogined");
			copyProperties(user,logineduser);
			baseDao.update(logineduser);
			rhs.put("result", "0000");
			putSessionValue("userlogined", logineduser);
			return "success";
		}
		
		
		/**
		 * 属性拷贝
		 * 
		 * @param source
		 * @param target
		 */
		public void copyProperties(Object source, Object target) {

			Class sourceClz = source.getClass();
			Class targetClz = target.getClass();
			// 得到Class对象所表征的类的所有属性(包括私有属性)
			Field[] fields = sourceClz.getDeclaredFields();
			for (int i = 0; i < fields.length; i++) {
				String fieldName = fields[i].getName();
				Field targetField = null;
				Field sourceField = null;
				try {
					// 得到targetClz对象所表征的类的名为fieldName的属性，不存在就进入下次循环
					sourceField = fields[i];
					targetField = targetClz.getDeclaredField(fieldName);
					
					sourceField.setAccessible(true);
					targetField.setAccessible(true);
					Object v = sourceField.get(source);
					if(v != null){
						targetField.set(target, v);
					}
				} catch (SecurityException e) {
					e.printStackTrace();
					break;
				} catch (NoSuchFieldException e) {
					e.printStackTrace();
					continue;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
	
}

class ComparatorUser implements Comparator{
	@Override
	public int compare(Object arg0, Object arg1) {
		User u1 = (User)arg0;
		User u2 = (User)arg1;
		if(Integer.parseInt(u1.getGoldnumber()) > Integer.parseInt(u2.getGoldnumber())){
			return -1;
		}
		return 1;
	}
}