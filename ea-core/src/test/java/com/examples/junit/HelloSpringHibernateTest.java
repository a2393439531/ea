package com.examples.junit;

import java.util.Iterator;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.app.common.spring.ssh.dao.BaseDao;
import com.app.ea.action.ViewAction;
import com.app.ea.api.InfEa;
import com.app.ea.model.User;
/*
 每个方法之前会重新将数据库重新建一次，这样比较好，每个方法之间没有数据关联性
 */
public class HelloSpringHibernateTest extends AbstractTestSpringHibernate {
	private final Logger log = LoggerFactory.getLogger(HelloSpringHibernateTest.class);
	private BaseDao baseDao;
	private InfEa infEa;
	@Before
	public void prepare() {
		baseDao = (BaseDao) applicationContext.getBean("eaDaoTarget");
		infEa = (InfEa) applicationContext.getBean("impEa");
	}
	@Test
	public void testgetUserNotAdmin() throws Exception {
		log.debug("查询非管理员用户：");
		if(infEa.getUserNotAdmin().size()>0){
			for (Iterator iterator = infEa.getUserNotAdmin().iterator(); iterator
					.hasNext();) {
				User user = (User) iterator.next();
				System.out.println((user.getName()));
			}
		}
	}
	

}
