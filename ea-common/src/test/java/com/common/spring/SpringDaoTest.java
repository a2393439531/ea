package com.common.spring;
import static org.junit.Assert.*;

import java.util.List;

import org.hibernate.FlushMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.orm.hibernate3.SessionHolder;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import com.app.model.Tb1;
import com.common.spring.ssh.dao.BaseDao;
import com.common.spring.ssh.page.Pagination;
public class SpringDaoTest {
	static Logger log = LoggerFactory.getLogger(SpringDaoTest.class);	
	protected static ApplicationContext applicationContext;
	private static SessionFactory sessionFactory;
	private static Session session;
	public static BaseDao eaDaoTarget;
	

    static void create_tb1(String name,String password){
    	 Tb1 tb1=new Tb1();
	    tb1.setName(name);
	    tb1.setPassword(password);
	    eaDaoTarget.create(tb1);
    }
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
				eaDaoTarget = (BaseDao) applicationContext
						.getBean("eaDaoTarget");
                
				//System.err.println("红色 ");
                // 开始初始化数据
				create_tb1("tom","123");
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	
	@Test
	public void create() {
	    Tb1 tb1=new Tb1();
	    eaDaoTarget.create(tb1);
	    assertEquals("加上初始化的1条，应该是2条", 2,  eaDaoTarget.find("from Tb1").size()); 
		assertEquals("加上初始化的1条，应该是2条", 2, eaDaoTarget.loadAll(Tb1.class).size()); 
	}
	@Test
	public void load() {
		 Tb1 tb1=(Tb1)eaDaoTarget.loadById("Tb1", Long.parseLong("1"));
		 assertEquals("记录1的name是tom","tom" ,tb1.getName());
		 tb1=(Tb1)eaDaoTarget.loadById(Tb1.class, Long.parseLong("1"));
		 assertEquals("记录1的name是tom","tom" ,tb1.getName());
	}
	@Test
	public void find() {
		assertEquals("模糊查询", 1, eaDaoTarget.find("select tb1 from Tb1 tb1 where tb1.name  like ?", "%tom%").size()); 
		assertEquals("单个参数查询", 1, eaDaoTarget.find("select tb1 from Tb1 tb1 where tb1.name=?", "tom").size()); 
		assertEquals("多参数查询 ", 1, eaDaoTarget.find("select tb1 from Tb1 tb1 where tb1.name=? and tb1.password=?", new String[]{"tom", "123"}).size()); 
	}
	
	
	@Test
	public void page() throws Exception {
		Pagination pagination=new Pagination();
		pagination.setCurrentPage(0);
		pagination.setMaxSize(1);
		List tpltb1List = eaDaoTarget.page("from Tb1", pagination);
		assertEquals("", 1,  tpltb1List.size()); 
		pagination.setMaxSize(2);
		tpltb1List = eaDaoTarget.page("from Tb1", pagination);
		assertEquals("", 2,  tpltb1List.size()); 
	}	
	
	
	
	@AfterClass
	public static void close() throws Exception {
		log.info("测试结束");
	}

}
