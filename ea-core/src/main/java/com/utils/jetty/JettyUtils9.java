package com.utils.jetty;
//
//  ========================================================================
//  Copyright (c) 1995-2014 Mort Bay Consulting Pty. Ltd.
//  ------------------------------------------------------------------------
//  All rights reserved. This program and the accompanying materials
//  are made available under the terms of the Eclipse Public License v1.0
//  and Apache License v2.0 which accompanies this distribution.
//
//      The Eclipse Public License is available at
//      http://www.eclipse.org/legal/epl-v10.html
//
//      The Apache License v2.0 is available at
//      http://www.opensource.org/licenses/apache2.0.php
//
//  You may elect to redistribute this code under either of these licenses.
//  ========================================================================
//


import java.lang.management.ManagementFactory;
import java.net.ServerSocket;
import java.util.Properties;

import org.eclipse.jetty.jmx.MBeanContainer;
import org.eclipse.jetty.security.HashLoginService;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.webapp.WebAppContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class JettyUtils9
{   
	static Logger log = LoggerFactory.getLogger(JettyUtils9.class);
	static public String url;
	
	public static void run(String context, int port) throws Exception {

   
		int lastPort = findFreePort(port);
        Server server = new Server(lastPort);
        
        // Setup JMX
        MBeanContainer mbContainer=new MBeanContainer(ManagementFactory.getPlatformMBeanServer());
        server.addBean(mbContainer);

       
        WebAppContext webapp = new WebAppContext();
        webapp.setContextPath("/"+context);
      //  webapp.setWar("../../jetty-distribution/target/distribution/demo-base/webapps/test.war");
    	webapp.setWar("./src/main/webapp");
		webapp.setDefaultsDescriptor("src/test/resources/webdefault.xml");
       
        server.setHandler(webapp);

       
        server.start();
    //    server.join();
		url = "http://localhost:" + lastPort + "/" + context;
		Runtime.getRuntime().exec("cmd   /c   start  iexplore.exe " + url);
		Properties p = System.getProperties();
		System.out.println("db file:"
				+ p.getProperty("online", "db-${online}.properties"));        
    }
	
	
	public static int findFreePort(int initPort) {
		ServerSocket tmpSocket = null;
		while (tmpSocket == null) {
			try {
				tmpSocket = new ServerSocket(initPort);
			} catch (Exception e) {

				initPort++;
				log.info(initPort + "is used, then try new port：" + initPort);
			}
		}
		return initPort;

	}
}
