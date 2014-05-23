package com.app.manager.demo;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.common.spring.ssh.dao.BaseDao;
import com.app.common.spring.ssh.model.BaseModel;
import com.app.ea.api.ImpEa;
import com.app.ea.api.InfEa;
import com.app.ea.demo.InfDemo;
import com.app.ea.demo.ParentDemo;
import com.app.ea.model.Organize;
import com.app.ea.model.Organizegroup;
import com.app.ea.model.Resource;
import com.app.ea.model.Role;
import com.app.ea.model.Rolegroup;
import com.app.ea.model.Systempara;
import com.app.ea.model.User;
import com.app.exam.model.Choiceitem;
import com.app.exam.model.Item;
import com.app.exam.model.Knowledge;
@Component("impTemplate")
public class ImpTemplate extends ParentDemo implements InfDemo{
	private final Logger log = LoggerFactory.getLogger(ImpTemplate.class);
	public void initData() throws Exception {
		if(baseDao.find(" from User ").size()==0){
			//if(true){
		log.debug("初始化数据");
		User admin = create_user("admin", "系统管理admin", "1324567890","admin@qq.com", "");
		User user_1 = create_user("test", "test", "18688385892","", "");
		User user_xixi = create_user("xixi", "习席", "323232","", "");
		User user_hujun = create_user("hujun", "胡军", "323232","", "");	
		User user_liuhua = create_user("liuhua", "刘华", "234455","", "");
		User user_limi= create_user("limi", "黎米", "234455","", "");
		
		User user_wangfei = create_user("wangfei", "王非", "323232","", "");
		User user_hanchun= create_user("huchun", "胡春", "234455","", "");
		User user_lili = create_user("lili", "李丽", "234455","", "");		
		User user_zhangli = create_user("zhangli", "张丽", "234455","", "");		
		Organize o1 = create_organize("部门架构", "department", null);
		Organize o11 = create_sub_organize(o1,"xx企业", "xx", null);		
		Organize o111 = create_sub_organize(o11,"生产部", "product",null );
		Organize o112 = create_sub_organize(o11,"客服", "surpport",null );
		
		Rolegroup r1 = create_rolegroup("部门", "rolegroup-department");
		Rolegroup rolegoupr_ceo = create_sub_rolegroup(r1, "CEO", "CEO");
		Rolegroup r10 = create_sub_rolegroup(rolegoupr_ceo, "部门经理", "department-manager");
		Rolegroup r14 = create_sub_rolegroup(r10, "员工", "member");
		
		Role role_product_ceo=createRole(o11.getId().toString(), rolegoupr_ceo.getId().toString());
		Role role_product_manager=createRole(o111.getId().toString(), r10.getId().toString());
		Role role_product_member=createRole(o111.getId().toString(), r14.getId().toString());

		Role role_surpport_manager=createRole(o112.getId().toString(), r10.getId().toString());
		Role role_surpport_member=createRole(o112.getId().toString(), r14.getId().toString());
		
		
		role_product_manager.setParentModel(role_product_ceo);
		role_surpport_manager.setParentModel(role_product_ceo);
		role_product_member.setParentModel(role_product_manager);
		role_surpport_member.setParentModel(role_surpport_manager);
		
	
		role_product_ceo.getUsers().add(user_xixi);
		role_product_manager.getUsers().add(user_hujun);
		role_product_member.getUsers().add(user_liuhua);
		role_product_member.getUsers().add(user_limi);
		
		role_surpport_manager.getUsers().add(user_wangfei);
		role_surpport_member.getUsers().add(user_hanchun);
		role_surpport_member.getUsers().add(user_lili);
		role_surpport_member.getUsers().add(user_zhangli);
		Rolegroup r2 = create_rolegroup("项目", "rolegroup-project");
		Rolegroup r21 = create_sub_rolegroup(r2, "项目经理", "project-manager");
		Rolegroup r211 = create_sub_rolegroup(r21, "领域主管", "group-leader");
		Rolegroup r2111 = create_sub_rolegroup(r211, "组长", "team-leder");
		Rolegroup r21111 = create_sub_rolegroup(r2111, "成员", "team-member");
		Rolegroup r211111 = create_sub_rolegroup(r2111, "第三方成员", "helper");		
		
		
		
		
		Systempara sp1 = create_systempara("user-status", "用户状态");
		Systempara sp11 = create_sub_systempara(sp1, "normal", "在职");
		Systempara sp12 = create_sub_systempara(sp1, "levea", "离职");
		
	
		Resource r0 = create_resource("系统管理", "system-admin", null);
		Resource r01 = create_sub_resource(r0, "组织架构管理","organize-admin","ea_organize_menu_organize.do");
		Resource r02 = create_sub_resource(r0, "岗位管理","positon-admin","ea_rolegroup_menu_rolegroup.do");
		Resource r03 = create_sub_resource(r0, "职位管理","role-admin","ea_ea_menu_relation.do");
		Resource r04 = create_sub_resource(r0, "人员管理","user-admin","ea_user_list.do");
		Resource r05 = create_sub_resource(r0, "权限管理","resource-admin","ea_resource_menu_resource.do");
		Resource r06 = create_sub_resource(r0, "邮件服务器设置 ","smtp_menu_smtp_init", "ea_smtp_menu_smtp_init.do");
		Resource r07 = create_sub_resource(r0, "系统参数 ","smtp_menu_smtp_init", "ea_systempara_menu_systempara.do");	
		
		admin.getResources().add(r0);
		admin.getResources().add(r01);
		admin.getResources().add(r02);
		admin.getResources().add(r03);
		admin.getResources().add(r04);
		admin.getResources().add(r05);
		admin.getResources().add(r06);
		admin.getResources().add(r07);
		
		
		
		//add exam information
		//知识领域
		Knowledge kl1 = new Knowledge();
		kl1.setName("language");
		kl1.setAlias("语言");
		
		Knowledge kl11 = new Knowledge();
		kl11.setName("c");
		kl11.setParentModel(kl1);
		
		Knowledge kl12 = new Knowledge();
		kl12.setName("java");
		kl12.setParentModel(kl1);
		
		Knowledge kl13 = new Knowledge();
		kl13.setName("shell");
		kl13.setParentModel(kl1);
		
		
		Knowledge kl2 = new Knowledge();
		kl2.setName("business");
		kl2.setAlias("业务");
		
		Knowledge kl21 = new Knowledge();
		kl21.setName("短信");
		kl21.setParentModel(kl2);
		
		Knowledge kl22 = new Knowledge();
		kl22.setName("彩信");
		kl22.setParentModel(kl2);

		
		//题目
		Item item1 = new Item();
		item1.setContent("单选测试题目一");
		item1.setType(1);
		item1.setRefkey("3");
		
		Item item2 = new Item();
		item2.setContent("多选测试题目一");
		item2.setType(2);
		item2.setRefkey("2,3,4");
		
		Item item3 = new Item();
		item3.setContent("填空测试题目一");
		item3.setType(3);
		item3.setRefkey("填空测试题目参考答案");
		
		Item item4 = new Item();
		item4.setContent("主观测试题目一");
		item4.setType(4);
		item4.setRefkey("主观测试题目参考答案");
		
		
		//选项
		Choiceitem choiceitem1 = new Choiceitem();
		Choiceitem choiceitem2 = new Choiceitem();
		Choiceitem choiceitem3 = new Choiceitem();
		Choiceitem choiceitem4 = new Choiceitem();
		choiceitem1.setRefid(1);
		choiceitem1.setValue("选项一");
		choiceitem2.setRefid(2);
		choiceitem2.setValue("选项二");
		choiceitem3.setRefid(3);
		choiceitem3.setValue("选项三");
		choiceitem4.setRefid(4);
		choiceitem4.setValue("选项四");
		choiceitem1.setItem(item1);
		choiceitem2.setItem(item1);
		choiceitem3.setItem(item1);
		choiceitem4.setItem(item1);
		
		Choiceitem choiceitem5 = new Choiceitem();
		Choiceitem choiceitem6 = new Choiceitem();
		Choiceitem choiceitem7 = new Choiceitem();
		Choiceitem choiceitem8 = new Choiceitem();
		choiceitem5.setRefid(1);
		choiceitem5.setValue("选项一");
		choiceitem6.setRefid(2);
		choiceitem6.setValue("选项二");
		choiceitem7.setRefid(3);
		choiceitem7.setValue("选项三");
		choiceitem8.setRefid(4);
		choiceitem8.setValue("选项四");
		choiceitem5.setItem(item2);
		choiceitem6.setItem(item2);
		choiceitem7.setItem(item2);
		choiceitem8.setItem(item2);
		
		baseDao.create(kl1);
		baseDao.create(kl2);
		baseDao.create(kl11);
		baseDao.create(kl12);
		baseDao.create(kl13);
		baseDao.create(kl21);
		baseDao.create(kl22);
		
		baseDao.create(item1);
		baseDao.create(item2);
		baseDao.create(item3);
		baseDao.create(item4);
		
		baseDao.create(choiceitem1);
		baseDao.create(choiceitem2);
		baseDao.create(choiceitem3);
		baseDao.create(choiceitem4);
		baseDao.create(choiceitem5);
		baseDao.create(choiceitem6);
		baseDao.create(choiceitem7);
		baseDao.create(choiceitem8);
		
		//end
		
		baseDao.update(admin);
	    
		
		//插入测试试题
		Set<Knowledge> knowledges = new HashSet<Knowledge>();
		knowledges.add(kl12);
		//单选
		Item i1 = new Item();
		i1.setContent("下列哪一种叙述是正确的( )");
		i1.setRefkey("4");
		i1.setType(1);
		i1.setKnowledge(knowledges);
		Choiceitem c1 = new Choiceitem();
		c1.setValue("A． abstract 修饰符可修饰字段、方法和类");
		c1.setRefid(1);
		c1.setItem(i1);
		Choiceitem c2 = new Choiceitem();
		c2.setValue("B． 抽象方法的body 部分必须用一对大括号{ }包住");
		c2.setRefid(2);
		c2.setItem(i1);
		Choiceitem c3 = new Choiceitem();
		c3.setValue("C． 声明抽象方法，大括号可有可无");
		c3.setRefid(3);
		c3.setItem(i1);
		Choiceitem c4 = new Choiceitem();
		c4.setValue("D． 声明抽象方法不可写出大括号");
		c4.setRefid(4);
		c4.setItem(i1);
		
		Item i2 = new Item();
			i2.setContent("如下代码：" + "public class Foo {"
					+ "public static void main(String[] args) {" + "try {"
					+ "return;" + "} finally {" + "System.out.println( "
					+ "'Finally'" + " );" + "}" + "}" + "}");
		i2.setRefkey("1");
		i2.setType(1);
		i2.setKnowledge(knowledges);
		Choiceitem c5 = new Choiceitem();
		c5.setValue("A. Finally");
		c5.setRefid(1);
		c5.setItem(i2);
		Choiceitem c6 = new Choiceitem();
		c6.setValue("B.编译失败");
		c6.setRefid(2);
		c6.setItem(i2);
		Choiceitem c7 = new Choiceitem();
		c7.setValue("C. 代码正常运行但没有任何输出.");
		c7.setRefid(3);
		c7.setItem(i2);
		Choiceitem c8 = new Choiceitem();
		c8.setValue("D. 运行时抛出异常");
		c8.setRefid(4);
		c8.setItem(i2);
		
		Item i3 = new Item();
		i3.setContent("以下关于异常的说法正确的是：");
		i3.setRefkey("4");
		i3.setType(1);
		i3.setKnowledge(knowledges);
		Choiceitem c9 = new Choiceitem();
		c9.setValue("Ａ. 一旦出现异常，程序运行就终止了");
		c9.setRefid(1);
		c9.setItem(i3);
		Choiceitem c10 = new Choiceitem();
		c10.setValue("Ｂ. 如果一个方法申明将抛出某个异常，它就必须真的抛出那个异常");
		c10.setRefid(2);
		c10.setItem(i3);
		Choiceitem c11 = new Choiceitem();
		c11.setValue("Ｃ. 在catch 子句中匹配异常是一种精确匹配");
		c11.setRefid(3);
		c11.setItem(i3);
		Choiceitem c12 = new Choiceitem();
		c12.setValue("Ｄ. 可能抛出系统异常的方法是不需要申明异常的");
		c12.setRefid(4);
		c12.setItem(i3);
		
		Item i4 = new Item();
		i4.setContent("在Servlet 处理请求的方式为: ");
		i4.setRefkey("3");
		i4.setType(1);
		i4.setKnowledge(knowledges);
		Choiceitem c13 = new Choiceitem();
		c13.setValue("A.以进程的方式");
		c13.setRefid(1);
		c13.setItem(i4);
		Choiceitem c14 = new Choiceitem();
		c14.setValue("B.以程序的方式");
		c14.setRefid(2);
		c14.setItem(i4);
		Choiceitem c15 = new Choiceitem();
		c15.setValue("C.以线程的方式");
		c15.setRefid(3);
		c15.setItem(i4);
		Choiceitem c16 = new Choiceitem();
		c16.setValue("D.以响应的方式");
		c16.setRefid(4);
		c16.setItem(i4);
		
		Item i5 = new Item();
		i5.setContent("JDBC 中，用于表示数据库连接的对象是:  ");
		i5.setRefkey("2");
		i5.setType(1);
		i5.setKnowledge(knowledges);
		Choiceitem c17 = new Choiceitem();
		c17.setValue("A.Statement");
		c17.setRefid(1);
		c17.setItem(i5);
		Choiceitem c18 = new Choiceitem();
		c18.setValue("B.Connection");
		c18.setRefid(2);
		c18.setItem(i5);
		Choiceitem c19 = new Choiceitem();
		c19.setValue("C.DriverManager");
		c19.setRefid(3);
		c19.setItem(i5);
		Choiceitem c20 = new Choiceitem();
		c20.setValue("D.PreparedStatement");
		c20.setRefid(4);
		c20.setItem(i5);
		
		Item i6 = new Item();
		i6.setContent("按照MVC 设计模式，JSP 用于实现: ");
		i6.setRefkey("2");
		i6.setType(1);
		i6.setKnowledge(knowledges);
		Choiceitem c21 = new Choiceitem();
		c21.setValue("A.Model");
		c21.setRefid(1);
		c21.setItem(i6);
		Choiceitem c22 = new Choiceitem();
		c22.setValue("B.View");
		c22.setRefid(2);
		c22.setItem(i6);
		Choiceitem c23 = new Choiceitem();
		c23.setValue("C.Controller");
		c23.setRefid(3);
		c23.setItem(i6);
		Choiceitem c24 = new Choiceitem();
		c24.setValue("D.容器");
		c24.setRefid(4);
		c24.setItem(i6);
		
		Item i7 = new Item();
		i7.setContent("在J2EE 中属于Web 层的组件有: ");
		i7.setRefkey("1");
		i7.setType(1);
		i7.setKnowledge(knowledges);
		Choiceitem c25 = new Choiceitem();
		c25.setValue("A.Servlet");
		c25.setRefid(1);
		c25.setItem(i7);
		Choiceitem c26 = new Choiceitem();
		c26.setValue("B.EJB");
		c26.setRefid(2);
		c26.setItem(i7);
		Choiceitem c27 = new Choiceitem();
		c27.setValue("C.Applet");
		c27.setRefid(3);
		c27.setItem(i7);
		Choiceitem c28 = new Choiceitem();
		c28.setValue("D.HTML");
		c28.setRefid(4);
		c28.setItem(i7);
		

		Item i8 = new Item();
		i8.setContent("在Servlet 的生命周期中，容器只调用一次的方法是: ");
		i8.setRefkey("3");
		i8.setType(1);
		i8.setKnowledge(knowledges);
		Choiceitem c29 = new Choiceitem();
		c29.setValue("A.service");
		c29.setRefid(1);
		c29.setItem(i8);
		Choiceitem c30 = new Choiceitem();
		c30.setValue("B.getServletConfig");
		c30.setRefid(2);
		c30.setItem(i8);
		Choiceitem c31 = new Choiceitem();
		c31.setValue("C.init");
		c31.setRefid(3);
		c31.setItem(i8);
		Choiceitem c32 = new Choiceitem();
		c32.setValue("D.destroy");
		c32.setRefid(4);
		c32.setItem(i8);
		
		//多选题
		Item i9 = new Item();
		i9.setContent("下列属于jsp 中注释的有( )");
		i9.setRefkey("1,4");
		i9.setType(2);
		i9.setKnowledge(knowledges);
		Choiceitem c33 = new Choiceitem();
		c33.setValue("A．<%-- 与--%>");
		c33.setRefid(1);
		c33.setItem(i9);
		Choiceitem c34 = new Choiceitem();
		c34.setValue("B． /");
		c34.setRefid(2);
		c34.setItem(i9);
		Choiceitem c35 = new Choiceitem();
		c35.setValue("C． /** 与**/");
		c35.setRefid(3);
		c35.setItem(i9);
		Choiceitem c36 = new Choiceitem();
		c36.setValue("D． <!-- 与-->");
		c36.setRefid(4);
		c36.setItem(i9);
		
		Item i10 = new Item();
		i10.setContent("按照学生平均成绩(avg_grade) 将students 表中的数据检索出来，下面SQL 语句正确的是( )");
		i10.setRefkey("1,3,4");
		i10.setType(2);
		i10.setKnowledge(knowledges);
		Choiceitem c37 = new Choiceitem();
		c37.setValue("A) SELECT * FROM students ORDER BY avg_grade");
		c37.setRefid(1);
		c37.setItem(i10);
		Choiceitem c38 = new Choiceitem();
		c38.setValue("B) SELECT * FROM students GROUP BY avg_grade ASC");
		c38.setRefid(2);
		c38.setItem(i10);
		Choiceitem c39 = new Choiceitem();
		c39.setValue("C) SELECT * FROM students ORDER BY avg_grade DESC");
		c39.setRefid(3);
		c39.setItem(i10);
		Choiceitem c40 = new Choiceitem();
		c40.setValue("D) SELECT * FROM students ORDER by avg_grade asc");
		c40.setRefid(4);
		c40.setItem(i10);
		
		Item i11 = new Item();
		i11.setContent(" 下列是jsp 作用域的通信对象的有( )");
		i11.setRefkey("1,2,3");
		i11.setType(2);
		i11.setKnowledge(knowledges);
		Choiceitem c41 = new Choiceitem();
		c41.setValue("A．Session");
		c41.setRefid(1);
		c41.setItem(i11);
		Choiceitem c42 = new Choiceitem();
		c42.setValue("B. application");
		c42.setRefid(2);
		c42.setItem(i11);
		Choiceitem c43 = new Choiceitem();
		c43.setValue("C.pageContext");
		c43.setRefid(3);
		c43.setItem(i11);
		Choiceitem c44 = new Choiceitem();
		c44.setValue("D.cookie");
		c44.setRefid(4);
		c44.setItem(i11);
		
		Item i12 = new Item();
		i12.setContent(" 下面哪个语句正确地声明一个整型的二维数组？");
		i12.setRefkey("3,4,5");
		i12.setType(2);
		i12.setKnowledge(knowledges);
		Choiceitem c45 = new Choiceitem();
		c45.setValue("A. int a[][] = new int[][]；");
		c45.setRefid(1);
		c45.setItem(i12);
		Choiceitem c46 = new Choiceitem();
		c46.setValue("B. int a[10][10] = new int[][]；");
		c46.setRefid(2);
		c46.setItem(i12);
		Choiceitem c47 = new Choiceitem();
		c47.setValue("C. int a[][] = new int[10][10]；");
		c47.setRefid(3);
		c47.setItem(i12);
		Choiceitem c48 = new Choiceitem();
		c48.setValue("D. int [][]a = new int[10][10]；");
		c48.setRefid(4);
		c48.setItem(i12);
		Choiceitem c49 = new Choiceitem();
		c49.setValue("E. int []a[] = new int[10][10]；");
		c49.setRefid(5);
		c49.setItem(i12);
		
		Item i13 = new Item();
		i13.setContent(" 下面哪些不是java 的简单数据类型? ");
		i13.setRefkey("2,3");
		i13.setType(2);
		i13.setKnowledge(knowledges);
		Choiceitem c50 = new Choiceitem();
		c50.setValue("A. short");
		c50.setRefid(1);
		c50.setItem(i13);
		Choiceitem c51 = new Choiceitem();
		c51.setValue("B. Boolean");
		c51.setRefid(2);
		c51.setItem(i13);
		Choiceitem c52 = new Choiceitem();
		c52.setValue("C. Double ");
		c52.setRefid(3);
		c52.setItem(i13);
		Choiceitem c53 = new Choiceitem();
		c53.setValue("D. float");
		c53.setRefid(4);
		c53.setItem(i13);
		
		Item i14 = new Item();
		i14.setContent("  下面哪些语句能够正确地生成5 个空字符串？ ");
		i14.setRefkey("1,2");
		i14.setType(2);
		i14.setKnowledge(knowledges);
		Choiceitem c54 = new Choiceitem();
		c54.setValue("A.String a[]=new String[5]；for(int i=0；i<5；a[i++]=“”)；");
		c54.setRefid(1);
		c54.setItem(i14);
		Choiceitem c55 = new Choiceitem();
		c55.setValue("B.String a[]={“”，“”，“”，“”，“”}；");
		c55.setRefid(2);
		c55.setItem(i14);
		Choiceitem c56 = new Choiceitem();
		c56.setValue("C.String a[5]；");
		c56.setRefid(3);
		c56.setItem(i14);
		Choiceitem c57 = new Choiceitem();
		c57.setValue("D.String [5]a；");
		c57.setRefid(4);
		c57.setItem(i14);
		Choiceitem c58 = new Choiceitem();
		c58.setValue("E.String []a=new String[5]；for(int i=0；i<5；a[i++]=null)；");
		c58.setRefid(5);
		c58.setItem(i14);
		
		//填空
		Item i15 = new Item();
		i15.setContent("一个double型变量与一个byte型变量进行减法运算，运算的结果类型是________");
		i15.setRefkey("byte");
		i15.setType(3);
		i15.setKnowledge(knowledges);
		
		Item i16 = new Item();
		i16.setContent("表示“变量a的值在0～100之间”的表达式可写成________");
		i16.setRefkey("1..100");
		i16.setType(3);
		i16.setKnowledge(knowledges);
		
		Item i17 = new Item();
		i17.setContent("某人写了一个声明一维数组的语句int smallPrimes[]={2,5,7,11,13};则smallPrimes[2]的值为________");
		i17.setRefkey("7");
		i17.setType(3);
		i17.setKnowledge(knowledges);
		
		//问答题
		Item i18 = new Item();
		i18.setContent("Interface与Abstract Class的区别");
		i18.setRefkey("");
		i18.setType(4);
		i18.setKnowledge(knowledges);
		
		Item i19 = new Item();
		i19.setContent("描述下JAVA反射机制的使用场景");
		i19.setRefkey("");
		i19.setType(4);
		i19.setKnowledge(knowledges);
		
		Item i20 = new Item();
		i20.setContent("Servlet与Jsp的区别");
		i20.setRefkey("");
		i20.setType(4);
		i20.setKnowledge(knowledges);
		
		baseDao.create(i1);
		baseDao.create(i2);
		baseDao.create(i3);
		baseDao.create(i4);
		baseDao.create(i5);
		baseDao.create(i6);
		baseDao.create(i7);
		baseDao.create(i8);
		baseDao.create(i9);
		baseDao.create(i10);
		baseDao.create(i11);
		baseDao.create(i12);
		baseDao.create(i13);
		baseDao.create(i14);
		baseDao.create(i15);
		baseDao.create(i16);
		baseDao.create(i17);
		baseDao.create(i18);
		baseDao.create(i19);
		baseDao.create(i20);
		baseDao.create(c1);
		
		baseDao.create(c1);
		baseDao.create(c2);
		baseDao.create(c3);
		baseDao.create(c4);
		baseDao.create(c5);
		baseDao.create(c6);
		baseDao.create(c7);
		baseDao.create(c8);
		baseDao.create(c9);
		baseDao.create(c10);
		baseDao.create(c11);
		baseDao.create(c12);
		baseDao.create(c13);
		baseDao.create(c14);
		baseDao.create(c15);
		baseDao.create(c16);
		baseDao.create(c17);
		baseDao.create(c18);
		baseDao.create(c19);
		baseDao.create(c20);
		baseDao.create(c21);
		baseDao.create(c22);
		baseDao.create(c23);
		baseDao.create(c24);
		baseDao.create(c25);
		baseDao.create(c26);
		baseDao.create(c27);
		baseDao.create(c28);
		baseDao.create(c29);
		baseDao.create(c30);
		baseDao.create(c31);
		baseDao.create(c32);
		baseDao.create(c33);
		baseDao.create(c34);
		baseDao.create(c35);
		baseDao.create(c36);
		baseDao.create(c37);
		baseDao.create(c38);
		baseDao.create(c39);
		baseDao.create(c40);
		baseDao.create(c41);
		baseDao.create(c42);
		baseDao.create(c43);
		baseDao.create(c44);
		baseDao.create(c45);
		baseDao.create(c46);
		baseDao.create(c47);
		baseDao.create(c48);
		baseDao.create(c49);
		baseDao.create(c50);
		baseDao.create(c51);
		baseDao.create(c52);
		baseDao.create(c53);
		baseDao.create(c54);
		baseDao.create(c55);
		baseDao.create(c56);
		baseDao.create(c57);
		baseDao.create(c58);
		
		}
	}
}
