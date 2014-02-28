package com.app.common.activiti.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.ea.model.User;

@Component("chatAction")
@Scope("prototype")
public class ChatAction extends BaseEaAction {
	public String chat(){
		User u = (User) infEa.getUserbyAccount(getCurrentAccount());
		rhs.put("user", u);
		return "success";
	}
}
