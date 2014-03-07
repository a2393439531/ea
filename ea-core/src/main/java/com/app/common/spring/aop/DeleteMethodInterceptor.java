package com.app.common.spring.aop;

import java.util.ArrayList;
import java.util.List;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.ea.model.User;

@Component("deleteMethodInterceptor")
public class DeleteMethodInterceptor implements MethodInterceptor {

	private static Logger log = LoggerFactory
			.getLogger(TimeMethodInterceptor.class);
	
	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {
		// TODO Auto-generated method stub
		log.warn("拦截 [ " + invocation.getMethod().getName() + " ] 方法" );
		
		for (User user : getDeleteUser(invocation.getArguments())) {
			log.warn(" 参数[ " + user.getId() +", " +user.getAccount() + ", " + user.getName() + " ] ");
		}
		return null;
	}

	private List<User> getDeleteUser(Object[] para){
		List<User> deleteList = new ArrayList<User>();
		for (int i = 0; i< para.length; i++) {
			deleteList.add((User)para[i]);
		}
		return deleteList;
	}
}
