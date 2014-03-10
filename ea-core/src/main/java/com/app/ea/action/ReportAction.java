package com.app.ea.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.ea.hsql.Hsql;
import com.app.ea.model.Organize;
import com.app.ea.model.Report;
import com.app.ea.model.Role;
import com.app.ea.model.Rolegroup;
import com.app.ea.model.User;
import com.utils.cache.Cache;
import com.utils.time.TimeUtil;

@Component("reportAction")
public class ReportAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(ReportAction.class);
	//private static String hsql_all = "from Report";
	
	public void common_get_user_info(List userList) {
		for (Iterator iterator = userList.iterator(); iterator.hasNext();) {
			User user = (User) iterator.next();
			user.setAllrolegroup("");
			user.setAllrole("");
			try {
				String companyname = "";
				companyname = infEa.getUserFirestOrgNameByOrgGroup(
						user.getId(), "company").getName();
				user.setCompanyname(companyname);
			} catch (Exception e) {
				user.setCompanyname("未分配公司");
			}
			try {
				String teamname = "";
				Organize org=infEa.getOrganzieOfUserByOrganizeGroupAlias(
						user.getId(), "team");
				teamname = org.getName();
				user.setTeamname(teamname);
				user.setGroupname(org.getParentModel().getName());
			} catch (Exception e) {
				user.setTeamname("");
				user.setGroupname("");
			}

			String techname="";
			try {
				for (Iterator iterator2 = user.getRoles().iterator(); iterator2
						.hasNext();) {
					Role role = (Role) iterator2.next();
					if(role.getAlias()!=null){
						user.setAllrole(user.getAllrole()+"-"+role.getAlias());
					}
					for (Iterator iterator3 = role.getOrganizes().iterator(); iterator3
							.hasNext();) {
						Organize organize = (Organize) iterator3.next();
						if(organize.getParentModel()!=null&&organize.getParentModel().getAlias()!=null){
							if(organize.getParentModel().getAlias().equalsIgnoreCase("tech")){
								techname=techname+role.getName()+";";
							}
						}
					}
					for (Iterator iterator3 = role.getRolegroups().iterator(); iterator3
							.hasNext();) {
						Rolegroup rolegroup = (Rolegroup) iterator3.next();
						if(rolegroup.getAlias()!=null){
							user.setAllrolegroup(user.getAllrolegroup()+"-"+rolegroup.getAlias());
						}
					}
						
				}
				
			} catch (Exception e) {
				System.out.println("异常用户："+user.getName()+e.toString());
			
			}		
			user.setTechname(techname);
			/*
			try {
				String techname = "";
				techname = infEa.getOrganzieOfUserByOrganizeGroupAlias(
						user.getId(), "tech").getName();
				user.setTechname(techname);
			} catch (Exception e) {
				user.setTechname("未分配技术领域");
			}
			*/
			continue;
		}
	}

	public String report_user_check() throws Exception {
		List userList = baseDao.find(Hsql.All_USER);
		common_get_user_info(userList);
		rhs.put("userList", userList);
		return "success";
	}
	public String birt_user() throws Exception {
	
		List userList = (List)Cache.get("userlist");
		
		if (userList == null) {
			userList = baseDao.find(Hsql.All_USER);
			common_get_user_info(userList);
			Cache.set("userlist", userList, "8h"); // 放入缓存
		}
		if (getpara("show").equals("")) {
			putSessionValue("show", "none");
		} else {
			putSessionValue("show",  getpara("show"));
		}		
		rhs.put("dataList", userList);
		return "success";
	}
	
	public String assessment() throws Exception {
		
		birt_user();
		return "success";
	}

	public String tech_member() throws Exception {
		List organizeRootList = infEa.getOrganizeRootNods();
		Organize organize=(Organize)infEa.getOrganizeByAlias("tech");
		rhs.put("system_para_map", 	infEa.getParaMap());   
		rhs.put("organizeRootList", organize.getChildOrganizes());
		rhs.put("userList", infEa.getAllUser());
		return "success";
	}	
	
	public String report() throws Exception {
		String year = getpara("year");
		if("".equals(year))
		{
			year = TimeUtil.getCurrentYear().toString();
		}
		
		//add by hb for get All report by year - start 2014/03/10
		String monthDate = "";
		Map<String,Boolean> monthMap = new HashMap<String,Boolean>();
		String weekDate = "";
		Map<String,Boolean> weekMap = new HashMap<String,Boolean>();
		String dayDate = "";
		Map<String,Boolean> dayMap = new HashMap<String,Boolean>();
		
		int weekCount = 1;
		for (int month = 0; month < 12; month++) {
			monthDate = String.valueOf(new Integer(Integer.valueOf(year)*10000 + (month+1)*100 ));
			monthMap.put(monthDate,false);
			int days = TimeUtil.getDayNumByYearMonth(year, month);
			for(int day = 1; day <= days; day++){
				boolean isWeek = TimeUtil.ifFirstDayOfWeek(year,month,day);
				if(isWeek){
					weekDate = String.valueOf(new Integer(Integer.valueOf(year)*10000 + weekCount));
					weekMap.put(weekDate,false);
					weekCount ++;
				}
				dayDate = String.valueOf(new Integer(Integer.valueOf(year)*10000 + (month+1)*100 + day));
				dayMap.put(dayDate,false);
			}
		}
		
		getReportbyDate(monthMap);
		getReportbyDate(weekMap);
		getReportbyDate(dayMap);
		
		rhs.put("monthMap", monthMap);
		rhs.put("weekMap", weekMap);
		rhs.put("dayMap", dayMap);
		
		//-end
		rhs.put("year", year);
		return "success";
	}
	
	public void getReportbyDate(Map dateMap){
		ArrayList reportList;
		Set<String> dateSet = dateMap.keySet();
		Set<String> dayByMonthSet;
		String account = getCurrentAccount();
		
		
		for (String date : dateSet) {
			reportList = (ArrayList) baseDao
					.find("select r from Report r where r.userAccount = '"
							+ account + "' and r.date='" + date + "'");
			if (reportList.size() > 0) {
				dateMap.put(date, true);
			} else {
				dateMap.put(date, false);
			}
		}
	}
	
	public String data_save() throws Exception {
		String date = getpara("date");
		String Content = java.net.URLDecoder.decode(getpara("content"));
		String column = getpara("column");
		String type = getpara("retype");
		String account =getCurrentUser().getAccount();
		ArrayList reportList= (ArrayList) baseDao.find("select r from Report r where r.userAccount = '" + account+"' and r."+column+"='" + date+"' and r.type = '"+type+"'");
		
		if(reportList.size()<1){	
			Report r = new Report();
			r.setDate(date);
			r.setContent(Content);
			r.setUserAccount(account);
			r.setType(type);
			baseDao.create(r);
			rhs.put("content",Content);
		}
		else{
			Report re = (Report) reportList.get(0);
			re.setContent(Content);
			baseDao.update(re);
		}
		report();
		return "success";
	}
	
	public String data_read() throws Exception {	
		String column = getpara("column");
		String date = getpara("value");	
		String account =getCurrentUser().getAccount();
		String type = getpara("retype");
		System.out.println("type "+ type);
		ArrayList reportList= (ArrayList) baseDao.find("select r from Report r where r.userAccount = '" + account+"' and r."+column+"='" + date+"' and r.type = '"+type+"'");

		if(reportList.size()<1){
			rhs.put("content", "");
		}
		else{
			Report re = (Report) reportList.get(0);
			rhs.put("content", re.getContent());
		}
		return "success";
	}
	
	public String sumReport() throws Exception {
		String year = getpara("theYear");
		String type = getpara("type");
		String userA = getpara("userAccount");
		ArrayList reportList;
		
		String account;
		if(userA.equals("")){
			account = getCurrentUser().getAccount();
			//System.out.println("no account here");
		}
		else{
			account = userA;
			//System.out.println("get account here");
		}
		
		if(type.equals("day")){
			String fromDate = getpara("fromDate");
			String toDate = getpara("toDate");
			System.out.println("i am in sumreport from date"+fromDate+"! and to date "+toDate);
			reportList= (ArrayList) baseDao.find("select r from Report r where r.type = '" + type +"' and r.userAccount = '" + account+ "'and date between '"+fromDate+"' and '" + toDate + "'");
			rhs.put("fromDateI",fromDate);
			rhs.put("toDateI", toDate);
			
		}
		else{
			reportList= (ArrayList) baseDao.find("select r from Report r where r.type = '" + type +"' and r.userAccount = '" + account+ "'and date like '"+year+"%'");
		}
		rhs.put("sumReport",reportList);
		rhs.put("year", year);
		rhs.put("type", type);
		return "success";
	}	

	public String ipm() throws Exception {
		List hrworkshopList = baseDao.find("from Hrworkshop");
		rhs.put("workshopList", hrworkshopList);
		rhs.put("organizeRootList",infEa.getOrganizeRootNods());
		if (getpara("show").equals("")) {
			putSessionValue("show", "");
		} else {
			putSessionValue("show",  "report");
		}		
		return "success";
	}		
}
