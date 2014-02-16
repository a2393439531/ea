package com;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.PrintStream;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
public class CodeGen {
	private final static Logger log = LoggerFactory.getLogger(CodeGen.class);
	/**
	 * 字符串变成新文件2
	 * */
	public static void strToDoc(String filename, String str, boolean flag) {
		FileOutputStream fostemp;
		try {
			fostemp = new FileOutputStream(filename, flag);
			PrintStream out = new PrintStream(
					new BufferedOutputStream(fostemp), false, "utf-8");
			out.print(str);
			out.close();
			fostemp.close();
			log.info("generete " + filename);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 大小写的转换，在JAVA代码里，还是会有大小写的规则，
	public static void genPage(String templatePath, String[] fileArray,
			String modelName, String templateName, String flag)
			throws Exception {
		String firstLowerCaseModelName = modelName.substring(0, 1)
				.toLowerCase() + modelName.substring(1, modelName.length());
		String firstUpperCaseModelName = modelName.substring(0, 1)
				.toUpperCase() + modelName.substring(1, modelName.length());
		String firstLowerCaseTemplateName = templateName.substring(0, 1)
				.toLowerCase()
				+ templateName.substring(1, templateName.length());
		String firstUpperCaseTemplateName = templateName.substring(0, 1)
				.toUpperCase()
				+ templateName.substring(1, templateName.length());
		for (String str : fileArray) {
			FileInputStream fi = new FileInputStream(templatePath + str);
			byte[] b = new byte[fi.available()];
			fi.read(b);
			String tmpFirstlowCase = new String(b).replaceAll(
					firstLowerCaseTemplateName, firstLowerCaseModelName);
			String result = tmpFirstlowCase.replaceAll(
					firstUpperCaseTemplateName, firstUpperCaseModelName);

			if (flag.endsWith("UpperCase")) {
				strToDoc(
						templatePath
								+ str.replace(firstUpperCaseTemplateName,
										firstUpperCaseModelName), result, false);
			} else {
				strToDoc(
						/*
						 * templatePath
						 */
						"src/main/webapp/app/manager/"
								+ modelName.toLowerCase()
								+ "/"

								+ str.replace(firstLowerCaseTemplateName,
										firstLowerCaseModelName), result, false);
			}

			// if(flag.endsWith("UpperCase")){
			// strToDoc("src/"+str.replace(firstUpperCaseTemplateName,
			// firstUpperCaseModelName), result);
			// }else{
			// strToDoc("src/"+str.replace(firstLowerCaseTemplateName,
			// firstLowerCaseModelName), result);
			// }
		}
	}

	/*
	 * System.out.println("新生成模型的名称："+modelName); java.io.File file = new
	 * java.io.File("src/main/webapp/app/imr/"+modelName.toLowerCase());
	 * FileUtils utils = new FileUtils(); utils.deleteDirectory(file);
	 * log.info("删除旧目录(如果存在的话)"+file.getAbsolutePath()); utils.forceMkdir(file);
	 * log.info("建立新目录"+file.getAbsolutePath());
	 */

	public static void genCode(String modelName, String type, String webdir,
			String javadir) throws Exception {
		String template_path_web = "src/main/webapp/" + webdir;
		String template_path_java = "src/main/java/" + javadir;

		FileUtils.deleteDirectory(new File(template_path_web
				+ modelName.toLowerCase()));

		FileUtils.forceMkdir(new File(template_path_web
				+ modelName.toLowerCase()));

		String firstLowerCaseModelName = modelName.substring(0, 1)
				.toLowerCase() + modelName.substring(1, modelName.length());
		String menu_str = "<a href=\"manager_" + firstLowerCaseModelName
				+ "_menu_" + firstLowerCaseModelName
				+ ".do\" target=\"mainFrame\">" + modelName + "</a><br/>\n";
		
		if (type.endsWith("tpltree1")) {
			File filedir = new File(template_path_web + "tpltree1");
			filedir.list();
			genPage(template_path_web + "tpltree1/", filedir.list(), modelName,
					"tpltree1", "");
			String[] file_array_action = new String[] { "Tpltree1Action.java" };
			genPage(template_path_java + "/action/", file_array_action,
					modelName, "tpltree1", "UpperCase");
			String[] file_array_model = new String[] { "Tpltree1.java" };
			genPage(template_path_java + "/model/", file_array_model,
					modelName, "tpltree1", "UpperCase");
		}

		if (type.endsWith("tpltb1")) {
			// 前台统一使用小写
			File filedir = new File(template_path_web + "tpltb1");
			filedir.list();
			genPage(template_path_web + "tpltb1/", filedir.list(), modelName,
					"tpltb1", "");
			// java文件需要区分大小写
			String[] file_array_action = new String[] { "Tpltb1Action.java" };
			genPage(template_path_java + "/action/", file_array_action,
					modelName, "tpltb1", "UpperCase");
			String[] file_array_model = new String[] { "Tpltb1.java" };
			genPage(template_path_java + "/model/", file_array_model,
					modelName, "tpltb1", "UpperCase");
		}
		if (type.endsWith("tpltb2")) {
			// 前台统一使用小写
			File filedir = new File(template_path_web + "tpltb2");
			filedir.list();
			genPage(template_path_web + "tpltb2/", filedir.list(), modelName,
					"tpltb2", "");
			// java文件需要区分大小写
			String[] file_array_action = new String[] { "Tpltb2Action.java" };
			genPage(template_path_java + "/action/", file_array_action,
					modelName, "tpltb2", "UpperCase");
			String[] file_array_model = new String[] { "Tpltb2.java" };
			genPage(template_path_java + "/model/", file_array_model,
					modelName, "tpltb2", "UpperCase");
		}
		if (type.endsWith("tpltb3")) {
			// 前台统一使用小写
			File filedir = new File(template_path_web + "tpltb3");
			filedir.list();
			genPage(template_path_web + "tpltb3/", filedir.list(), modelName,
					"tpltb3", "");
			// java文件需要区分大小写
			String[] file_array_action = new String[] { "Tpltb3Action.java" };
			genPage(template_path_java + "/action/", file_array_action,
					modelName, "tpltb3", "UpperCase");
			String[] file_array_model = new String[] { "Tpltb3.java" };
			genPage(template_path_java + "/model/", file_array_model,
					modelName, "tpltb3", "UpperCase");
			
			menu_str = "<a href=\"manager_" + firstLowerCaseModelName
					+ "_"+ "list.do\" target=\"mainFrame\">" + modelName + "</a><br/>\n";

		}		
				
		strToDoc("src/main/webapp/menu.ftl", menu_str, true);
		System.out.println("代码生成完毕!\n请刷新ECLIPSE查看生成代码");
	}

	/**
	 * 参数1： 对象名，请用小写， 参数2：模板类型 : tpltb1 ajax输入类型 tpltb2 表单形式输入 tpltree1 属性输入
	 * 参数3: java路径 参数4: web路径
	 * */
	// alige-product-backlog ,alige-meeting,alige-sprint
	public static void main(String[] args) throws Exception {
		/*
		CodeGen.genCode("testajax", "tpltb1", "app/manager/",
				"com/app/manager/oa/");
		CodeGen.genCode("testinput", "tpltb2", "app/manager/",
				"com/app/manager/oa/");
		CodeGen.genCode("testtree", "tpltree1", "app/manager/",
				"com/app/manager/oa/");
				
		CodeGen.genCode("systempara", "tpltree1", "app/manager/",
				"com/app/manager/oa/");	*/
		CodeGen.genCode("smtp", "tpltb1", "app/manager/",
				"com/app/manager/template/");
	}

}
