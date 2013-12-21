package com.app.manager.common.monitor.action;


import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.manager.common.base.action.BaseEaAction;
import com.app.manager.ea.model.User;
import com.common.path.Path;

@Component("monitorAction")
public class MonitorAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(MonitorAction.class);
	public User user = new User();
	public String jvm() throws Exception {
		rhs.put("runtime", Runtime.getRuntime());
	
		
		Map  hashmap_system=new HashMap();
	
		for (Iterator iterator = System.getenv().keySet().iterator(); iterator.hasNext();) {
			String key = (String) iterator.next();
			
			hashmap_system.put(key, System.getenv().get(key));
		}
		hashmap_system.put("classpath", System.getProperty("java.class.path"));
		//System.out.println(resourceExists("database-${online}.properties"));
	
		hashmap_system.put("spring-version",Path.getLocation( Class.forName("org.springframework.orm.hibernate3.support.OpenSessionInViewFilter")));
		hashmap_system.put("hibernate-version",Path.getLocation( Class.forName("org.hibernate.dialect.H2Dialect")));
		hashmap_system.put("struts-version",Path.getLocation( Class.forName("org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter")));
		hashmap_system.put("freemarker-version",Path.getLocation( Class.forName("freemarker.ext.servlet.FreemarkerServlet")));
		hashmap_system.put("h2-version",Path.getLocation( Class.forName("org.h2.Driver")));
		hashmap_system.put("servlet-version",getServletVersion());
		hashmap_system.put("xml-sax-parser-version", getXmSAXlParserName());
		try{
		hashmap_system.put("jetty-version", Path.getLocation( Class.forName("org.eclipse.jetty.server.Server")));
			
		} catch (Exception e) {
			hashmap_system.put("jetty-version", "");
		}
		hashmap_system.put("database-filename", System.getProperty("online", "db-${online}.properties"));
		
		
		
		rhs.put("hashmap_system",hashmap_system);
    	return "success";
	}
       //servlet版本
	  public String getServletVersion() {
		    ServletContext context=ServletActionContext.getServletContext();
		   
	        int major = context.getMajorVersion();
	        int minor = context.getMinorVersion();
	        return "server info:"+ context.getServerInfo()+" servlet version:"+Integer.toString(major) + '.' + Integer.toString(minor);
	    }
	  /**
	     * what parser are we using.
	     * @return the classname of the parser
	     */
	    private String getXmSAXlParserName() {
	        SAXParser saxParser = getSAXParser();
	        if (saxParser == null) {
	            return "Could not create an XML Parser";
	        }

	        // check to what is in the classname
	        String saxParserName = saxParser.getClass().getName();
	        return saxParserName;
	    }
	    /**
	     * Create a JAXP SAXParser
	     * @return parser or null for trouble
	     */
	    private SAXParser getSAXParser() {
	        SAXParserFactory saxParserFactory = SAXParserFactory.newInstance();
	        if (saxParserFactory == null) {
	            return null;
	        }
	        SAXParser saxParser = null;
	        try {
	            saxParser = saxParserFactory.newSAXParser();
	        } catch (Exception e) {
	        }
	        return saxParser;
	    }

}
