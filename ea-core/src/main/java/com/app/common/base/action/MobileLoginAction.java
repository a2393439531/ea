package com.app.common.base.action;

import javax.servlet.http.Cookie;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.ea.model.User;

/*
 * create by xiaoqinghong 2014-6-26
 */

@Component("mobileloginAction")
@Scope("prototype")
public class MobileLoginAction extends LoginAction{
	private final Logger log = LoggerFactory.getLogger(MobileLoginAction.class);
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		super.execute();
		String terType = getpara("terType"); // app 端登录
		String success = "success";
		String fail = "fail";
		if(terType != null && terType.length() > 0){
			success = terType + "_" + success;
			fail = terType + "_" + fail;
		}
		boolean saveCookie = false;
		if(getpara("saveCookie") != null && !"".equals(getpara("saveCookie"))) saveCookie = Boolean.parseBoolean(getpara("saveCookie"));
		
		User user = (User) infEa.getUserbyAccount(getpara("account"));

		if(saveCookie){
			Cookie c1 = new Cookie("accountInfo", user.getAccount());
			c1.setMaxAge(60*60*24*365);  //1年
			ServletActionContext.getResponse().addCookie(c1);
			Cookie c2 = new Cookie("pwdInfo", user.getPasswd());
			c2.setMaxAge(60*60*24*365); //1年
			ServletActionContext.getResponse().addCookie(c2);
			log.debug("cookie 添加完毕..");
		}
		if(rhs.get("tipInfo") != null) return fail;
		return success;
		
		
	}
}
