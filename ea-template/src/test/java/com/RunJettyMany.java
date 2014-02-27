/*
package com;

import java.net.ServerSocket;

import org.eclipse.jetty.server.Connector;
import org.eclipse.jetty.server.Handler;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.handler.ContextHandlerCollection;
import org.eclipse.jetty.server.nio.SelectChannelConnector;
import org.eclipse.jetty.webapp.WebAppContext;

public class RunJettyMany {
	public static void main(String[] args) throws Exception {

		Server server = new Server();
		Connector connector = new SelectChannelConnector();

		int lastPort = findFreePort(9090);
		connector
				.setPort(Integer.getInteger("jetty.port", lastPort).intValue());
		server.setConnectors(new Connector[] { connector });

		WebAppContext webapp1 = new WebAppContext();
		webapp1.setDefaultsDescriptor("src/main/resources/webdefault.xml");
		webapp1.setContextPath("/infEa");
		webapp1.setWar("./src/main/webapp");
		WebAppContext webapp2 = new WebAppContext();
		webapp2.setContextPath("/birt");
		webapp2.setWar("./birt");
		webapp2.setDefaultsDescriptor("src/main/resources/webdefault.xml");
		ContextHandlerCollection contexts = new ContextHandlerCollection();

		contexts.setHandlers(new Handler[] { webapp1, webapp2 });

		server.setHandler(contexts);
		server.start();
		// server.join();
		Runtime.getRuntime().exec(
				"cmd   /c   start  iexplore.exe http://localhost:" + lastPort
						+ "/infEa");

	}

	public static int findFreePort(int initPort) {
		ServerSocket tmpSocket = null;
		while (tmpSocket == null) {
			try {
				tmpSocket = new ServerSocket(initPort);
			} catch (Exception e) {
				initPort++;
			}
		}
		return initPort;

	}
}
*/