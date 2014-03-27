package com.app.common.i18n;



import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.utils.freemark.GetObject;
import com.utils.freemark.GetObject;
import com.utils.freemark.StringbyPerlFreemark;
import com.utils.path.PathUtils;
import com.utils.path.SystemInit;
import com.utils.string.StringProcess;


public class I18n {
	private static Logger log = LoggerFactory.getLogger(I18n.class);
	public static HashMap siteStrMap = new HashMap(); // 网站的多国语言MAP
	public static HashMap snpStrMap = new HashMap(); // 后台的多国语言配置，全部加载到一个文件中
	public I18n() {
	}

	public static String getStringbyfile(String lang, String keyname) {
		try {
		if(siteStrMap.size()==0){
			 siteStrMap = getMapFromePropFile(PathUtils.getClassPath(PathUtils.SYSTEM_DATA_CLASS) + "/i18n",
			"txt");
		}
		return (String) siteStrMap.get(lang + "_"+ keyname);			
		} catch (Exception e) {
			log.error(""+e);
		return "";
		}
	}

	public static HashMap getMapFromePropFile(String filepath, String file_dx) throws Exception {
		try {
			HashMap MapData = new HashMap();
			String[] extensions = { file_dx };
			Collection files = FileUtils.listFiles(new File(filepath), extensions, false);
			for (Iterator iter = files.iterator(); iter.hasNext();) {
				File element = (File) iter.next();
				String filename = StringUtils.substringBefore(element.getName(), ".").toLowerCase();
				BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(element), "utf-8"));
				String strvalue = "";
				while (strvalue != null) {
					strvalue = br.readLine();
					String[] mapValue = StringUtils.split(strvalue, "=");
					if (mapValue != null && mapValue.length > 1) {
						MapData.put(filename + "_" + mapValue[0].trim(), StringUtils.trim(mapValue[1]));
					}
				}

			}
			return MapData;
		} catch (Exception e) {
			throw e;
		}

	}
	
	public static HashMap getLanguage() {
		HashMap languageMap = new HashMap();
		String filename = PathUtils.getWebrootPath(PathUtils.SYSTEM_DATA_CLASS)+"/common/freemarker/include_map_language_title.ftl";
		try {
			
			String src = StringProcess.getformfile(filename);
			src = src.replaceAll("\r", "");
			src = src.replaceAll("\n", "");
			String strvarreg = "1;2;3;4;5;6;7;8;";
			String strReg = "\"(.*?)\":\"(.*?)\"";
			List rslList = StringbyPerlFreemark.getlistbyPerl(src, strReg, strvarreg);
			for (Iterator iter = rslList.iterator(); iter.hasNext();) {
				GetObject element = (GetObject) iter.next();
				languageMap.put(element.a0, element.a1);
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return languageMap;

	}
	 
	public static HashMap getSnpLanguageList() {
	
		return getLanguage();
		

	}


}
