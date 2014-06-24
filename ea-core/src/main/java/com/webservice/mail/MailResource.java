package com.webservice.mail;

import org.activiti.rest.common.api.SecuredResource;
import org.restlet.data.Form;
import org.restlet.representation.Representation;
import org.restlet.representation.StringRepresentation;
import org.restlet.resource.Get;

import com.app.common.activiti.api.SpringContext;
import com.app.ea.api.InfEa;

public class MailResource extends SecuredResource {
	private InfEa infEa = (InfEa) SpringContext.getBean("infEa");
	@Get
	public Representation sendMail(){
		//if(authenticate() == false) return null; //不能开启验证
		Form form = getRequest().getResourceRef().getQueryAsForm() ;    //获取查询参数
		String maillist = form.getFirstValue("maillist");     //获取key=maillist的参数值
		String content = form.getFirstValue("content");     //获取key=maillist的参数值  
		infEa.sendMailTheadBySmtpList("Exam has been Started!", content , maillist, "", "", null);
		return new StringRepresentation("Send Successfully! "+ maillist + "|" + content);
	}
	
	
//	@Post
//	public Representation sendMail(Representation entity){
//		
//		return new StringRepresentation("测试Send Mail Web Service ----> Post Method!");
//	}
}
