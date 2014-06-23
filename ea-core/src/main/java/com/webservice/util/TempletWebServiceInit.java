package com.webservice.util;

import org.restlet.routing.Router;

import com.app.webservice.upload.UploadResource;


public class TempletWebServiceInit {
	public static void attachResources(Router router) {
		//attach send mail resource
		 //router.attach("/upload", UploadResource.class);
		//attach upload for templet
		router.attach("/upload", UploadResource.class);
	}
}
