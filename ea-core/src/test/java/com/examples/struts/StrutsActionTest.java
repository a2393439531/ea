package com.examples.struts;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.StrutsSpringTestCase;
import org.hibernate.FlushMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.junit.Test;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.orm.hibernate3.SessionHolder;
import org.springframework.transaction.support.TransactionSynchronizationManager;

public class StrutsActionTest extends StrutsSpringTestCase {
  
    @Override
    protected void setUp() throws Exception {
        super.setUp();
        SessionFactory sessionFactory = lookupSessionFactory(request);
        Session hibernateSession= getSession(sessionFactory);
        TransactionSynchronizationManager.bindResource(sessionFactory, 
                                                     new SessionHolder(hibernateSession));
    }
 
    @Override
    public String[] getContextLocations() {
      String[] str = {"spring.xml"};
      return str;
    }
 
    private Session getSession(SessionFactory sessionFactory) throws DataAccessResourceFailureException {
        Session session = SessionFactoryUtils.getSession(sessionFactory, true);
        FlushMode flushMode = FlushMode.NEVER;
        if (flushMode != null) {
           session.setFlushMode(flushMode);
        }
         return session;
    }
    private SessionFactory lookupSessionFactory(HttpServletRequest request) {
        return (SessionFactory)this.applicationContext.getBean("eaSessionFactory");
   }
    /*
	@Test
    public void testLogin() throws Exception {
       
    	System.out.println("测试action");
        request.setParameter("account", "wanghaiming");
        request.setParameter("password", "abc123");
        request.setContextPath("/");
        String result =  executeAction("/com/app/common/base/action/loginAction.do");
        System.out.println(result);
          
    }
  */
}
