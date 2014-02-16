package com.app.old;


import java.util.Iterator;
import java.util.List;
import java.util.Set;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;
import org.springframework.test.context.support.DirtiesContextTestExecutionListener;

import com.app.common.spring.ssh.dao.BaseDao;
import com.app.ea.api.InfEa;
import com.app.ea.model.Organize;
import com.app.ea.model.Organizegroup;
import com.app.ea.model.Resource;
import com.app.ea.model.Role;
import com.app.ea.model.Rolegroup;
import com.app.ea.model.User;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring.xml")
public class JunitHello  {
	static Logger log = LoggerFactory.getLogger(JunitHello.class);
	@Autowired
	private BaseDao eaDaoTarget;
	@Autowired
	private InfEa infEa;

	@Test
	public void eaDaoTarget() {
		log.debug("用户个数=" + eaDaoTarget.find("from User").size());
	}

	@Test
	public void getAllUser() {
		log.debug("EA查出用户个数=" + infEa.getAllUser().size());
	}

	

}
