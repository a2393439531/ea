package com.app.webservice.util;

import org.restlet.routing.Router;

import com.app.webservice.upload.UploadResource;

public class TempletWebServiceInit {
	public static void attachResources(Router router) {
		//attach upload for templet
		 router.attach("/upload", UploadResource.class);
		 
	}
}
