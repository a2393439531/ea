package com.app.common.test;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.utils.hardinfo.HardInfo;

@Component("testAction")
@SuppressWarnings("rawtypes")
public class TestAction extends BaseEaAction {
	
	private static final long    serialVersionUID    = 7441785390598480063L;  
	private int                    complete            = 0;   
	// 获取进度值    
	public int getComplete()  
	{        complete += 10;        return complete;    }  

	public String waitexe(){        
		try {            
			Thread.sleep(3000);       
			}      
		catch (InterruptedException e){            
			e.printStackTrace();       
		}       
		return "success"; 
	}
		
	public String zxing() throws Exception{        
		String url ="http:/"+HardInfo.findNonLocalhostIp()+":"+getRequest().getLocalPort()+getRequest().getContextPath();
		String url_apk =url+"/ea-android.apk";
		
		
		int width = 200;
		int height = 200;
		String format = "png";
		Hashtable hints = new Hashtable();
		hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
		genQR(url_apk, width, height, format, hints,getWebroot()+"/url_apk.png");
		genQR(url, width, height, format, hints,getWebroot()+"/url.png");
		String url_moblie =url+"/app_login.ftl";
		genQR(url_moblie, width, height, format, hints,getWebroot()+"/url_mobile.png");
		rhs.put("url", url);
		rhs.put("url_apk", url_apk);
		rhs.put("url_moblie", url_moblie);
		return "success"; 
	}

	private void genQR(String url, int width, int height, String format,
			Hashtable hints,String filename) throws WriterException, IOException {
		BitMatrix bitMatrix = new MultiFormatWriter().encode(url,
				BarcodeFormat.QR_CODE, width, height, hints);
		
		System.out.println("二维码文件保存地址"+filename);
		File outputFile = new File(filename);
		MatrixToImageWriter.writeToFile(bitMatrix, format, outputFile);
	}
			
	public String ckeditor(){
		return "success";
	}
	public String menu_para() throws Exception {
		rhs.put("system_para_map", 	infEa.getParaMap());
		rhs.put("info_type", "success");
		rhs.put("info", "");
		return "success";
	}
   
	public String date() throws Exception {
		
		return "success";
	}
	   
	
	
   public String dialog_jquery() throws Exception {
		
		return "success";
	}
   public String dialog_bootstrap() throws Exception {
		
		return "success";
	}
   public String div() throws Exception {
		
		return "success";
	}
	public String java() throws Exception {
		
		return "success";
	}
	
	public String drag() throws Exception {
		
		return "success";
	}	
	public String pic() throws Exception {
		
		return "success";
	}	
	
	public String select_user() throws Exception {
		
		return "success";
	}
	
    public String push_iframe() throws Exception {
    	rhs.put("runtime", Runtime.getRuntime());
    	return "success";
	}
    public String push_ajax() throws Exception {
    	rhs.put("runtime", Runtime.getRuntime());
    	return "success";
	}
    public String push() throws Exception {
    	rhs.put("runtime", Runtime.getRuntime());
    	return "success";
	}	
	public String upload() throws Exception {
		ServletActionContext.getRequest().getRealPath("");
		System.out.println("webroot路径"+ServletActionContext.getRequest().getRealPath(""));
		return "success";
	}
	
	public String day_grid() throws Exception {
		List<String> dayList = new ArrayList<String>();
		Date currentDate = new Date();
		Calendar c=Calendar.getInstance();   
		DateFormat df=new SimpleDateFormat("MM-dd");
		DateFormat df1=new SimpleDateFormat("yyyy-MM-dd");
		String daysStr = getpara("showDays");
		String dateStr = getpara("startDate");
		int days = 0;
		if (!"".equals(daysStr))
			days = Integer.parseInt(daysStr);
		else 
			days = 10;
		if (!"".equals(dateStr))
			currentDate = df1.parse(dateStr);
		for (int n = 1; n <= days; n++) {
			c.setTime(currentDate);   
			c.add(Calendar.DATE,n);
			Date date=c.getTime();   
			String s=df.format(date); 
			dayList.add(s);
		}
		rhs.put("startDate", "".equals(dateStr) ? df1.format(currentDate) : dateStr);
		rhs.put("showDays", days);
		rhs.put("dayList", dayList);
		return "success";
	}
	
	public String mobile() throws Exception {
		return "success";
	
	}
	
	public String pagedata() throws Exception {
		getPageData("from Item");
		return "success";
	}
	public String UI_demo(){
		return "success";
	}
}
