package com.app;

import org.hibernate.FlushMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.orm.hibernate3.SessionHolder;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import com.app.manager.ea.api.InfEa;
import com.app.manager.ea.model.User;
import com.common.spring.ssh.dao.BaseDao;

public class ParentTest {
	protected static ApplicationContext applicationContext;
	private static SessionFactory sessionFactory;
	private static Session session;
	public static BaseDao baseDao;
	public static InfEa infEa;
	static Logger log = LoggerFactory.getLogger(ParentTest.class);

	@BeforeClass
	public static void init() throws Exception {
		if (applicationContext == null) {
			try {
				String configFile = "spring.xml";
				applicationContext = new ClassPathXmlApplicationContext(
						configFile);
				sessionFactory = (SessionFactory) applicationContext
						.getBean("eaSessionFactory");
				session = SessionFactoryUtils.getSession(sessionFactory, true);

				session.setFlushMode(FlushMode.COMMIT);
				TransactionSynchronizationManager.bindResource(sessionFactory,
						new SessionHolder(session));

				baseDao = (BaseDao) applicationContext
						.getBean("eaDaoTarget");
				infEa = (InfEa) applicationContext.getBean("impEa");
				
				infEa.initData();
				log.debug("初始化完毕:");

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	public static User create_user(String account, String name, String phonenumber,
			String email, String assessLev) throws Exception {
		User user = new User();
		user.setAccount(account);
		user.setName(name);
		user.setPasswd("abc123");
		user.setAccount(account);
		user.setPhoneNumber(phonenumber);
		user.setEmail(email);
		user.setAssessLev(assessLev);
		baseDao.create(user);
		return user;
	}
	@AfterClass
	public static void close() throws Exception {
		log.debug("运行完毕");
	}

}
