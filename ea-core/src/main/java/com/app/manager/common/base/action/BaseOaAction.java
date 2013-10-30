package com.app.manager.common.base.action;

import java.lang.reflect.InvocationTargetException;

import javax.annotation.Resource;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.app.manager.ea.model.Organize;
import com.app.manager.ea.model.User;
import com.common.spring.ssh.dao.BaseDao;
import com.common.spring.ssh.model.BaseModel;

public class BaseOaAction extends BaseCoreAction {
	private final Logger log = LoggerFactory
			.getLogger(BaseOaAction.class);

	@Resource(name = "baseDaoTarget")
	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}

}
