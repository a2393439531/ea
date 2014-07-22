package com.examples.spring;

import java.util.Iterator;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.app.common.activiti.api.SpringContext;
import com.app.common.spring.ssh.dao.BaseDao;
import com.app.ea.action.ViewAction;
import com.app.ea.api.InfEa;
import com.app.ea.model.User;
import com.examples.junit.AbstractTestSpringHibernate;
/*
 每个方法之前会重新将数据库重新建一次，这样比较好，每个方法之间没有数据关联性
 */
public class SpringGetBeanTest extends AbstractTestSpringHibernate {
	private final Logger log = LoggerFactory.getLogger(SpringGetBeanTest.class);
	@Test
	public void getSpringBean() {
		InfEa infEa = (InfEa) SpringContext.getBean("impEa");
		System.out.println(infEa);
	}

	

}
