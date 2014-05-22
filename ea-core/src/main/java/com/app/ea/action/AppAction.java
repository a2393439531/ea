package com.app.ea.action;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;


import org.apache.commons.beanutils.BeanUtils;
import org.restlet.engine.util.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.activiti.action.BaseProcessAction;
import com.app.common.activiti.api.OaTask;
import com.app.common.spring.ssh.page.Pagination;
import com.app.ea.api.ImpEa;
import com.app.ea.model.Organize;
import com.app.ea.model.Organizegroup;
import com.app.ea.model.Role;
import com.app.ea.model.Rolegroup;
import com.app.ea.model.User;
import com.utils.cache.Cache;
import com.utils.time.TimeUtil;

@Component("appAction")
@Scope("prototype")
public class AppAction extends ViewAction {
	private final Logger log = LoggerFactory.getLogger(AppAction.class);
	public String show_scope() {
		User user = (User) baseDao.loadById("User", getCurrentUser().getId());
		rhs.put("user", user);
		return "success";

	}
	public String show_power() {
		return picture_role_user_v();
		/*
		Role role=null;
		List roleList = baseDao
				.find(" from Role where parent_id = null");
		role =(Role) roleList.get(0);
		rhs.put("role", role);
		*/
		
			
	}
		
}
