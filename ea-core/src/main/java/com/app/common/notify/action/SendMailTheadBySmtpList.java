package com.app.common.notify.action;

import java.beans.XMLDecoder;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.util.ArrayList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.app.ea.model.Smtp;
import com.utils.mail.SendMail;
import com.utils.time.TimeUtil;

/*******************************************************************************
 * 发送的邮箱线程模块: 需要和静态初始化配合
 * 
 */
public class SendMailTheadBySmtpList extends Thread {
	private static Log log = LogFactory.getLog(SendMailTheadBySmtpList.class);
	String mailtitle;
	String mailcontent;
	String mailaddress;
	//add by hb for cc and bcc
	String ccaddress;
	String bccaddress;
	String[] filenames;
	public static ArrayList emailSmtpList;
	

	public SendMailTheadBySmtpList(ArrayList smtpList,String title, String content, String address, String cc, String bcc,
			String[] filename) {
		try {
			mailtitle = "[Time]" + TimeUtil.getTimeStr("yyyy-MM-dd-hh.mm.ss")
					+ title;
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		emailSmtpList=smtpList;
		filenames = filename;
		mailaddress = address;
		ccaddress = cc;
		bccaddress = bcc;
		mailcontent = content + "<br><br><br> ****PLEASE DO NOT REPLAY THIS EMAIL！****";
	}

	public void run() {
		long begin = System.currentTimeMillis();
		boolean notsendflag = true;
		int stmpNumber = 0;
			while (notsendflag && stmpNumber < emailSmtpList.size()) {
			Smtp smtp=(Smtp)emailSmtpList.get(
					stmpNumber);
			stmpNumber++;
			try {
				SendMail sendMail = new SendMail();
				sendMail.connect(smtp.getHost(), smtp.getAccount(), smtp.getPasswd(), smtp.getPort());
				
				sendMail.send(smtp.getSender(), mailaddress, ccaddress, bccaddress,
						mailtitle, mailcontent, filenames);
				sendMail.close();
				notsendflag = false;
				log.info("Email Send Time = "
						+ (System.currentTimeMillis() - begin));
			} catch (Exception e) {
				//log.error("Email send error = " + smtp.getTitle(), e);
				log.error("<br>使用下面邮箱配置发送失败：" +smtp.getTitle()+smtp.getHost()+":"+smtp.getPort()+":"+smtp.getSender());
				e.printStackTrace();
			}
		}

	}

	// 标题，内容，地址
	public static void sendmail(ArrayList smtpList,String title, String content,
			String mailaddress, String cc, String bcc, String[] filename) {
        
		SendMailTheadBySmtpList sendmail = new SendMailTheadBySmtpList(smtpList,title, content, mailaddress, cc, bcc,
				filename);
		sendmail.start();

	}

}
