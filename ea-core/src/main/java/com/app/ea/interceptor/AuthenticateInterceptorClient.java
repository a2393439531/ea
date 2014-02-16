/*
 * Universial Enterprise Authenticate And Authority Center
 * 
 * Copyright(c) 2005 SunRise Inc. Ricsson Group All rights reserved.
 * 
 * @created: 2005-06-21 @author: Andy
 */

package com.app.ea.interceptor;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Component;

import com.app.common.spring.ssh.dao.BaseDao;
import com.app.ea.model.Resource;
import com.app.ea.model.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

@Component("authenticateInterceptorClient")
public class AuthenticateInterceptorClient implements Interceptor {
	private final static Log log = LogFactory
			.getLog(AuthenticateInterceptorClient.class);
	public BaseDao baseDao;
	public final static String UNAUTHENTICATED_USER_CODE = "unauthenticated.user";

	public BaseDao getBaseDao() {
		return baseDao;
	}

	@javax.annotation.Resource(name = "eaDaoTarget")
	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}

	public void destroy() {
	}

	public void init() {
	}

	Set getResourceActionUrlSet() {
		Set allResourceSet = new HashSet();
		ArrayList allResource = (ArrayList) baseDao.find("from Resource");
		for (Iterator iterator = allResource.iterator(); iterator.hasNext();) {
			Resource res = (Resource) iterator.next();
			allResourceSet.add(res.getActionUrl());
			log.debug("res.url=" + res.getActionUrl());
		}
		return allResourceSet;
	}

	/*
	 * 规则
	 * 登录才能访问
	 * admin 拥有所有的权限
	 * 如果资源没有登记，是任何人都能访问，如果登记了，就需要拥有权限
	 * */
	boolean checkUrlVisit(String url) {
		Map<String, Object> sessionMap = ActionContext.getContext()
				.getSession();
		if (sessionMap.get("userlogined") == null)
			return false;
		User user = (User) sessionMap.get("userlogined");
		if (user.getAccount().equals("admin")) {
			return true;
		}
		Set currentUserResourceSet = (Set) sessionMap.get("menuList");
		Set allResourceActionUrlSet = getResourceActionUrlSet();
		try {
			if (currentUserResourceSet != null) {
				log.debug("访问的url=" + url+ " rigedit："+allResourceActionUrlSet
						.contains(ServletActionContext
								.getRequest().getServletPath()));
				for (Iterator iterator = currentUserResourceSet.iterator(); iterator
						.hasNext();) {
					Resource resource = (Resource) iterator.next();
					if (resource.getActionUrl() != null
							&& resource.getActionUrl().length() > 0) { // 空字符串。会影响判断
						log.debug("用户资源=" + resource.getActionUrl() + ":"
								+ url.indexOf(resource.getActionUrl()));
						if (url.indexOf(resource.getActionUrl()) >= 0
								|| !(allResourceActionUrlSet
										.contains(ServletActionContext
												.getRequest().getServletPath()))) { //
							return true;
						}
					}
				}
			}
		} catch (Exception e) {
			log.debug(url);
			e.printStackTrace();
		}

		return false;
	}

	public String intercept(ActionInvocation ai) throws Exception {
		log.info("权限拦截器");
		log.info("访问的缩写路径="
				+ ServletActionContext.getRequest().getServletPath());
		
		String url = ServletActionContext.getRequest().getServletPath() + "?"
				+ ServletActionContext.getRequest().getQueryString();
		
		
		if (checkUrlVisit(url))
			return ai.invoke();
		else {
			return "can_not_access";
		}

	}

}