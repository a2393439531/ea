package com.app;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.app.manager.ea.api.InfEa;
import com.app.manager.ea.model.Resource;
import com.app.manager.ea.model.User;
import com.app.model.Tb1;

import com.common.spring.ok.AbstractBaseTestCase;
import com.common.spring.ssh.dao.BaseDao;
import com.common.spring.ssh.page.Pagination;

/*
 每个方法之前会重新将数据库重新建一次，这样比较好，每个方法之间没有数据关联性
 */
public class EaTest extends AbstractBaseTestCase {
	static Logger log = LoggerFactory.getLogger(EaTest.class);
	private BaseDao baseDao;
	private InfEa infEa;
  
	@Before
	public void prepare() throws Exception {
		baseDao = (BaseDao) applicationContext.getBean("eaDaoTarget");
		infEa = (InfEa) applicationContext.getBean("impEa");
		infEa.initData();
	}
	
	@Test
	public void getAllVisibleResource() throws Exception {
		//log.debug("admin resource numbers:"+infEa.getAllVisibleResource("1").size());
    	//log.debug("test resource numbers:"+infEa.getAllVisibleResource("2").size());
		// assertEquals("user:admin is 8", 8,  infEa.getAllVisibleResource("1").size()); 
		 assertEquals("user:test is 0", 0,  infEa.getAllVisibleResource("2").size()); 
	
	}
	
	@Test
	public void email() throws Exception {
	     infEa.sendMail("gscsystem@163.com", "3436070@qq.com", "tom.ling@ericsson.com", "","组长录入REQ101:更新SVN解决方案", "请", null);
	    
	}
	
}
