package com.app.common.base.action;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.Cookie;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.ea.api.InfEa;
import com.app.ea.model.Organize;
import com.app.ea.model.Resource;
import com.app.ea.model.User;

import com.opensymphony.xwork2.ActionContext;

@Component("loginAction")
@Scope("prototype")
public class LoginAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(LoginAction.class);

	public String execute() throws Exception {
		String method = getpara("method");
	    infEa.initData();
		String account = getpara("account");
		String password = getpara("password");
		String sysName = getpara("sysName");
		
		if("logout".equals(method)){//新增登出功能
			putSessionValue("userlogined", null);
			return "fail";
		}
		if("".equals(getSessionValue("lang"))||getSessionValue("lang") == null ){
			putSessionValue("lang", "en");
		}
		if (account.equals("")) {
			rhs.put("tipInfo", "Account can not be empty!");
			
			if("forget".equals(method)){
				return "forget";
			}
			return "fail";
		}
		System.out.println("EA查出用户个数=" + infEa.getAllUser().size());
		User user = (User) infEa.getUserbyAccount(account);
		if (user==null) {
			rhs.put("tipInfo", "Account can not be found!");
			
			if("forget".equals(method)){
				return "forget";
			}
			return "fail";
		}
		//新增忘记密码
		if("forget".equals(method)){
			String content = "The Password has been sent to you by email!";
			
			String mail = "";
			if(user != null){
				if(user.getEmail() != null && !"".equals(user.getEmail())){
					if(!"".equals(mail)){
						mail = mail + "," + user.getEmail();
					}else{
						mail = mail + user.getEmail();
					}
				}
				if(user.getEmail2() != null && !"".equals(user.getEmail2())){
					if(!"".equals(mail)){
						mail = mail + "," + user.getEmail2();
					}else{
						mail = mail + user.getEmail2();
					}
				}
			}
			//send mail
			infEa.sendMailTheadBySmtpList("WEB SAC PASSWORD!", "<font color='red'>Account/Password: " + user.getAccount() + "/" + user.getPasswd() + "</font>", 
					mail, "", "", null);
			
			rhs.put("tipInfo", content);
			return "fail";
		}
		
		String result = "";
		result = infEa.checkLogin(account, password);
	
		
		if (result.equals("0001")) {
			rhs.put("tipInfo", "Account was not exists or Password was incorrectly!");
		}
		if (result.equals("0000")) { // 验证成功

			
			putSessionValue("sysName", sysName);
			Resource resource = (Resource) infEa.getBaseModelByAlias("Resource", sysName);
			/* 为了满足用户查询需要，暂时全部返回，这里需要处理下，以后 */
			putSessionValue("userList", infEa.getAllUser());
			
			Set resourceSet = infEa.getAllVisibleResource(user.getId().toString());
			putSessionValue("menuList", resourceSet);

			List projectList = infEa.getUserAllOrganizeByOrganizegroupAlias(
					user.getId(), "project");
			List departmentList = infEa.getUserAllOrganizeByOrganizegroupAlias(
					user.getId(), "company");
			putSessionValue("projectList", projectList);
			putSessionValue("departmentList", departmentList);
			putSessionValue("userlogined", user);

			if (projectList.size() > 0) {
				Organize projectOrganize = (Organize) projectList.get(0);
				putSessionValue("currnetProject", projectOrganize);
			}
			if (departmentList.size() > 0) {
				Organize departmentOrganize = (Organize) departmentList.get(0);
				putSessionValue("currnetDepartment", departmentOrganize);
			}
			
			
			
			
			if (user.getAccount().equals("admin")) { 
				return "admin";
			}
			
			log.info(user.getName() + " 登录成功");
			return "success";
		}

		return "fail";
	}

	public String changeProject() {
		String id = getpara("id");
		Organize organize = (Organize) baseDao.loadById("Organize",
				Long.parseLong(id));
		setUserCurrentProject(organize);
		log.debug("当前项目ID=" + getCurrentProjectId());
		return "success";
	}

	public String ajaxResetPassword() {
		// 取得旧密码，比较是否正取，比较新密码， password_repeat, password_error,password_change

		String oldpassword = getpara("oldpassword");
		String newpassword = getpara("newpassword");
		Map sessionMap = ActionContext.getContext().getSession();
		User currentuser = (User) sessionMap.get("userlogined");
		String currentpassword = currentuser.getPasswd();
		if (!oldpassword.equals(currentpassword)) {
			String errorinfo = "密码输入错误！请正确输入当前密码";
			rhs.put("info", errorinfo);
		} else {
			// String userId = getpara("userid");
			// User user = (User) baseDao.loadById("User",
			// Long.parseLong(userId));
			infEa.resetPassword(currentuser.account, getpara("newpassword"));
			rhs.put("info", "修改成功");
		}
		return "ajaxResetPassword";
	}

	@javax.annotation.Resource(name = "impEa")
	public void setInfEa(InfEa infEa) {
		this.infEa = infEa;
	}

	public InfEa getInfEa() {
		return infEa;
	}

}
