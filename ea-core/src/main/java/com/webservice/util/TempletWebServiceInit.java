package com.webservice.util;

import org.restlet.routing.Router;

import com.app.webservice.upload.UploadResource;
import com.webservice.mail.MailResource;


public class TempletWebServiceInit {
	public static void attachResources(Router router) {
		//attach send mail resource
		 router.attach("/mail", MailResource.class);
		//attach upload for templet
		router.attach("/upload", UploadResource.class);
	}
}
