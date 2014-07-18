package com.examples;

import java.net.URI;
import java.util.List;

import com.utils.mail.SendMail;

/**
 * 主要电脑不要限制端口发出信息，
 * 1. new sendmail() 使用GBK的默认编码发送文本信息 new sendmail(编码,文本还是html); sendmail mail =
 * new sendmail("GBK", true); 2. mail.connect (smtp服务器);
 * main.connect(smtp服务器,用户名,密码); 适用于smtp认证的发信服务器 3.
 * main.send(from,to，cc,bcc,主题,正文,附件文件名) to,cc（抄送）,bcc(暗送)可填写多个mail地址
 * 抄送多个的话是要使用，隔开 附件文件名为null，表示不发送附件 定义两个字段，emailleavword , emailorder
 */
public class SendMailSample {
	public static void main(String[] args) throws Exception {
		SendMail sendMail = new SendMail();
		sendMail.connect("se-smtp.ericsson.se", "", "", "25");
		sendMail.send("SAC@ericsson.com", "bin.hong@ericsson.com,tom.ling@ericsson.com,richard.zhai@ericsson.com", "", "",
				"NRJ邮箱测试", "测试正文", null);
		sendMail.close();
		System.out.println("发送完毕");
		//使用APM的webservice发送邮件
//		ClientResource client = new ClientResource("http://localhost:5051/apm/service/mail?maillist=hongbin@gzericsson.com&content=Test Content");
//		 Representation result = client.get();
//		 System.out.println(result.getText());  
		//使用Exchange Web Service
//		List<String> to = new ArrayList<String>();
//		to.add("hongbin@gzericsson.com");
//		SendMailSample sms = new SendMailSample();
//		sms.send("Test", to, null, "Sent using by Exchange Web Service!");
		
	}
	/*private static String username="ericsson\\ebinhon";
	private static String password="19905018Hb";
	private static String demand="mail-ao.internal.ericsson.com";//如不清楚，请联系系统管理员 例：corp.chinacache.com

	*//**
	 * 使用Exchange协议发送
	 * 
	 * @throws Exception
	 *//*
	public static void send(String subject, List<String> to, List<String> cc,
			String bodyText, String realPath) throws Exception {
		// 创建service连接
		ExchangeService service = new ExchangeService(ExchangeVersion.Exchange2010_SP2);// 选择服务器使用的Exchange版本
		ExchangeCredentials credentials = new WebCredentials(username,
				password);// 用户名、密码
		service.setCredentials(credentials);
		service.setUrl(new URI("https://"+demand+"/ews/exchange.asmx"));// 设置协议地址
		
		//创建邮件
		EmailMessage msg = new EmailMessage(service);
		// 设置主题
		msg.setSubject(subject);
		// 邮件内容
		MessageBody body = MessageBody.getMessageBodyFromText(bodyText);
		body.setBodyType(BodyType.HTML);
		msg.setBody(body);
		// to
		if (to != null && to.size() > 0) {
			for (String s : to) {
				msg.getToRecipients().add(s);
			}
		}
		// cc
		if(cc != null && cc.size() > 0){
			for (String s : cc) {
				msg.getCcRecipients().add(s);
			}
		}
		// 附件
		if(realPath!=null&&!"".equals(realPath)){
			msg.getAttachments().addFileAttachment(realPath);
		}
		msg.send();
	}
	
	public static void send(String subject, List<String> to, List<String> cc,
			String bodyText) throws Exception{
		send( subject, to, cc, bodyText, null);
	}*/
}
