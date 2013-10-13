package com.app.manager.ea.demo;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.manager.ea.api.ImpEa;
import com.app.manager.ea.api.InfEa;
import com.app.manager.ea.model.Organize;
import com.app.manager.ea.model.Organizegroup;
import com.app.manager.ea.model.Resource;
import com.app.manager.ea.model.Role;
import com.app.manager.ea.model.Rolegroup;
import com.app.manager.ea.model.Systempara;
import com.app.manager.ea.model.User;
import com.common.spring.ssh.dao.BaseDao;
import com.common.spring.ssh.model.BaseModel;

@Component("impItCompany")
public class ImpItCompany extends ParentDemo implements InfDemo {
	private final Logger log = LoggerFactory.getLogger(ImpItCompany.class);

	public void initData() throws Exception {
		if (baseDao.find(" from User ").size() == 0) {
			log.debug("初始化数据");
			User admin = create_user("admin", "admin", "1234567890",
					"3436070@qq.com", "");
			User test = create_user("test", "test", "1234567890",
					"test@qq.com", "");

			Resource r0 = create_resource("系统管理", "system-admin", null);
			Resource r07 = create_sub_resource(r0, "企业使命 ", "why-what-how",
					"why-what-how");
			Resource r070 = create_sub_resource(r07, "愿景 ", "rule_menu_rule",
					"ea_edit_ftl.do?filefoldname=ftl&op=r&filename=version.ftl");
			Resource r071 = create_sub_resource(r07, "战略 ", "rule_menu_rule",
					"ea_edit_ftl.do?filefoldname=ftl&op=r&filename=strategy.ftl");
			Resource r072 = create_sub_resource(r07, "目标 ", "rule_menu_rule",
					"ea_edit_ftl.do?filefoldname=ftl&op=r&filename=target.ftl");

			Resource r01 = create_sub_resource(r0, "组织架构管理", "organize",
					"organize");
			Resource r010 = create_sub_resource(r01, "组织架构管理", "organize",
					"organize_menu_organize.do");
			Resource r011 = create_sub_resource(r01, "类别管理",
					"organize_menu_organize",
					"organizegroup_menu_organizegroup.do");
			Resource r012 = create_sub_resource(r01, "类别设置",
					"organize_menu_organize",
					"ea_menu_organize_to_organizegroup.do");

			Resource r02 = create_sub_resource(r0, "岗位管理", "positon-admin",
					"positon-admin");
			Resource r020 = create_sub_resource(r02, "岗位管理 ",
					"rolegroup_menu_rolegroup", "rolegroup_menu_rolegroup.do");

			Resource r03 = create_sub_resource(r0, "职位管理", "role-admin",
					"role-admin");
			Resource r030 = create_sub_resource(r03, "职位管理 ",
					"ea_menu_relation", "ea_menu_relation.do");

			Resource r04 = create_sub_resource(r0, "人员管理", "user-admin",
					"user-admin");
			Resource r040 = create_sub_resource(r04, "人员管理 ",
					"ea_menu_person_deploy", "user_menu_user.do");
			Resource r041 = create_sub_resource(r04, "人员部署 ", "user_menu_user",
					"ea_menu_person_deploy.do");
			Resource r042 = create_sub_resource(r04, "部署合理性检查 ",
					"user_menu_user",
					"ea_report_user_check.do?resultftl=menu_check_deploy_error");

			Resource r05 = create_sub_resource(r0, "资源管理", "resource-admin",
					"resource-admin");
			Resource r050 = create_sub_resource(r05, "人员管理 ",
					"resource_menu_resource", "resource_menu_resource.do");
			Resource r051 = create_sub_resource(r05, "邮件服务器设置 ",
					"smtp_menu_smtp_init", "smtp_menu_smtp_init.do");

			Resource r06 = create_sub_resource(r0, "规章制度", "rule-admin",
					"rule-admin");
			Resource r060 = create_sub_resource(r06, "规章制度录入 ",
					"rule_menu_rule", "rule_menu_rule.do");

			Resource r08 = create_sub_resource(r0, "视图-组织架构", "view-organize",
					"view-organize");
			Resource r080 = create_sub_resource(r08, "竖向 ",
					"ea_menu_organize_view_v", "ea_menu_organize_view_v.do");
			Resource r081 = create_sub_resource(r08, "横向 ",
					"ea_menu_organize_view_h", "ea_menu_organize_view_h.do");

			Resource r09 = create_sub_resource(r0, "员工工作手册", "handbook",
					"handbook");
			Resource r090 = create_sub_resource(r09, "员工手册 ", "ea_menu_home",
					"ea_menu_home.do");
			Resource r091 = create_sub_resource(r09, "审查下属工作手册 ",
					"ea_menu_view_sub_user_handbook",
					"ea_menu_view_sub_user_handbook.do");

			admin.getResources().add(r01);
			admin.getResources().add(r02);
			admin.getResources().add(r03);
			admin.getResources().add(r04);
			admin.getResources().add(r05);
			admin.getResources().add(r06);
			admin.getResources().add(r07);

			User u01 = create_user("Humphrey Xiao", "萧景汉",
					" +86 1866 6082 662 ", "humphrey.xiao@ericsson.com", " ");
			User u02 = create_user("Tom Ling", "凌黎", " +86 1379 8067 488",
					"tom.ling@ericsson.com", " ");
			User u03 = create_user("Qiang Fu", "付强", " +86 1392 2440 836",
					"fuqiang@gzericsson.com", " ");
			User u04 = create_user("Yifu Guo", "郭一夫", " +86 1360 0325 560",
					"guoyifu@gzericsson.com", " ");
			User u05 = create_user("Richard Zhai", "翟景坤", "+86 1392 9511 484",
					"zhaijingkun@gzericsson.com", "B");
			User u06 = create_user("Li CaiYing", "李彩英", "+86 1371 0522 587",
					"licaiying@gzericsson.com", "B");
			User u07 = create_user("Rocky Zhou", "周儒軒", "+86 1592 0908 586",
					"zhouruxuan@gzericsson.com", "B");
			User u08 = create_user("Ye Bohua", "叶波华", " +86 1532 3953 016",
					"yebohua@gzericsson.com", " ");
			User u09 = create_user("Feng Yongsen", "冯永森", " +86 1345 0358 357",
					"fengyongsen@gzericsson.com", " ");
			User u10 = create_user("Xing LuLiang", "刑吕亮", " +86 1371 0267 882",
					"xingluliang@gzericsson.com", "B");
			User u11 = create_user("Lin WeiGuo", "林衛國", " +86 1372 5299 829",
					"chenmingjin@gzericsson.com", "B");
			User u12 = create_user("Zhang Ping", "张萍", " +86 1502 4295 845",
					"zhangping@gzericsson.com", "B");
			User u13 = create_user("Liu HongHai", "刘宏海", " +86 1343 1029 803",
					"liuhonghai@gzericsson.com", "B");
			User u14 = create_user("Junhui Huang", "黃俊輝", "+86 1363 2240 896",
					"huangjunhui@gzericsson.com", "B");
			User u15 = create_user("Linglian Pan", "潘嶺廉", "+86 1358 0338 840",
					"panlinglian@gzericsson.com", "B");
			User u16 = create_user("Qinghong Xiao", "肖慶紅", "+86 1372 5144 864",
					"xiaoqinghong@gzericsson.com", "B");
			User u17 = create_user("Chen Zhijian", "陈智建", " +86 13760647664",
					"chenzhijian@gzericsson.com", " ");
			User u18 = create_user("Cherry Zhang", "張麗婷", "+86 1592 0384 607",
					"zhangliting@gzericsson.com", "C");
			User u19 = create_user("Meng Yang", "楊孟", "+86 1376 0873 908",
					"yangmeng@gzericsson.com", "C");
			User u20 = create_user("Chen Mingjin", "陈明锦", " +86 1372 5299 829",
					"chenmingjin@gzericsson.com", " ");
			User u21 = create_user("Mai RuiXiang", "麦瑞翔", " +86 1343 0397 913",
					"mairuixiang@gzericsson.com", "B");
			User u22 = create_user("Bin Yan", "楊斌", "+86 1363 2349 245",
					"yanbin@gzericsson.com", "B");
			User u23 = create_user("Feng Hao", "冯昊", "+86 1376 0685 554",
					"fenghao@gzericsson.com", "B");
			User u24 = create_user("Hong Bin", "洪彬", " +86 1356 0079 730",
					"hongbin@gzericsson.com", " ");
			User u25 = create_user("Li Rongjian", "黎榮堅", "+86 1591 4309 283",
					"lirongjian@gzericsson.com", "B");
			User u26 = create_user("Jingjing Zhang", "張晶晶",
					"+86 1382 4425 923", "zhangjingjing@gzericsson.com", "B");
			User u27 = create_user("Lu Wen Zhu", "陆文柱", "+86 1590 2092 223",
					"luwenzhu@gzericsson.com", " ");
			User u28 = create_user("Cai Yongjie", "蔡詠潔", "+86 1358 0364 668",
					"caiyongjie@gzericsson.com", "B");
			User u29 = create_user("Lin Jiefeng", "林潔豐", " +86 1371 0267 882",
					"linjiefeng@gzericsson.com", "B");
			User u30 = create_user("Li Lin", "李林", " +86 1581 8839 338",
					"linlin@gzericsson.com", " ");
			User u31 = create_user("Guisheng Liu", "刘桂生", "+86 1353 3374 648",
					"Liuguisheng@gzericsson.com", "C");
			User u32 = create_user("Wang HaiMing", "王海明", "+86 1356 0359 817",
					"wanghaiming@gzericsson.com", "B");
			User u33 = create_user("Huang ZhiZhong", "黄志钟",
					"+86 1375 1840 821", "huangzhizhong@gzericsson.com", "B");
			User u34 = create_user("Fu ChuanFen", "符传奋", " +86 1870 2081 227",
					"fuchuanfen@gzericsson.com", "B");
			User u35 = create_user("Li Xin Jun", "李新军 ", " +86 1591 5774 960",
					"lixinjun@gzericsson.com", "B");
			User u36 = create_user("Zhang Xu", "张旭", "+86 1599 2443 236",
					"zhangxu@gzericsson.com", "B");
			User u37 = create_user("Peng Zhixi", "彭志希", "+86 1355 6079 684",
					"pengzhixi@gzericsson.com", "B");
			User u38 = create_user("Yang Huajun", "杨华钧", "+86 1363 2392 198",
					"yanghuajun@gzericsson.com", "B");
			User u39 = create_user("Jiang Jianjun", "蒋建军 ",
					" +86 1598 6845 625", "jiangjianjun@gzericsson.com", "B");
			User u40 = create_user("Chen Guanwei", "陈冠伟", " +86 1331 6159 316",
					"chenguawei@gzericsson.com", " ");
			User u41 = create_user("Zou huaixue", "邹怀学", " +86 1582 0234 654",
					"zouhuaixue@gzericsson.com", " ");
			User u42 = create_user("zeng zhihui", "曾志辉", "+86 1375 1753 107",
					"zengzhihui@gzericsson.com", "B");
			User u43 = create_user("Tina Huang", "黄洁华", "+86 1501 1815 446",
					"huangjiehua@gzericsson.com", "B");
			User u44 = create_user("Liu JiGuang", "刘际广", "+86 1588 9855 461",
					"liujiguang@gzericsson.com", "B");
			User u45 = create_user("Chen Zhitian", "陈植钿", "86 1598 9092 072",
					"chenzhitian@gzericsson.com", " ");
			User u46 = create_user("Lin RiHe", "林日鹤", "+86 1371 9046 753",
					"linrihe@gzericsson.com", "C");
			User u47 = create_user("Xu YuanDa", "许远达", " +86 1342 8814 906",
					"xuyuanda@gzericsson.com", "B");
			User u48 = create_user("Zhang Hong Kui", "张宏奎 ",
					" +86 1501 7553 920", "zhanghongkui@gzericsson.com", "B");
			User u49 = create_user("Tom Zhong", "钟文星", "  +86 1376 0665 755",
					"zhongwenxing@gzericsson.com", " ");
			User u50 = create_user("Zuoyu Kuang", "邝作煜", "+86 1356 0053 742",
					"Kuangzuoyu@gzericsson.com", "B");
			User u51 = create_user("Weiqing Liao", "廖渭清", "+86 1363 2472 590",
					"Liaoweiqing@gzericsson.com", "B");
			User u52 = create_user("Zheng Xin Zhu", "郑心竹", "+86 1380 8874 975",
					"zhengxinzhu@gzericsson.com", "A+");
			User u53 = create_user("Cai Yang Peng", "蔡仰鹏", "+86 1343 0292 183",
					"caiyangpeng@gzericsson.com", "B");
			User u54 = create_user("Chen Yong Xiong", "陈永雄",
					"+86 1392 2432 014", "chenyongxiong@gzericsson.com", "B");
			User u55 = create_user("Zhu Ruiping", "朱锐萍", " +86 1501 7597 492",
					"zhuruiping@gzericsson.com", " ");
			User u56 = create_user("Zeng Wei", "曾威", " +86 1378 6221 482",
					"zengwei@gzericsson.com", " ");
			User u57 = create_user("Zhou Taoyan", "周道炎 ", "+86 1382 8429 591",
					"zhoutaoyan@gzericsson.com", " ");
			User u58 = create_user("Zheng Qingqiang", "曾庆强",
					" +86 1866 5717 454", "zhengqingqiang@gzericsson.com", " ");
			User u59 = create_user("Cai Longfeng", "蔡龙丰", "+86 1371 0314 147",
					"cailongfeng@gzericsson.com", " ");
			User u60 = create_user("Paul Lin", "林蓬蓬", "+86 1363 1328 845",
					"Linpengpeng@gzericsson.com", "B");
			User u61 = create_user("Chen Chong Zhang", "陈崇章",
					"+86 1354 0319 824", "chenchongzhang@gzericsson.com", "A+");
			User u62 = create_user("Huang Baorong", "黄荣宝", "+86 1357 0233 147",
					"huangrongbao@gzericsson.com", "B-");
			User u63 = create_user("Liu Huiwen", "刘惠文", "+86 1342 6828 107",
					"liuhuiwen@gzericsson.com", "A");
			User u64 = create_user("Lin Biying", "林碧英", " +86 1866 5627 712",
					"linbiying@gzericsson.com", " ");
			User u65 = create_user("Zheng Zhuneng", "郑主能", "+86 1592 0885 626",
					"zhengzhuneng@gzericsson.com", "B");
			User u66 = create_user("Yin Fan", "殷凡", " +86 1598 9194 236",
					"yinfan@gzericsson.com", " ");
			User u67 = create_user("Chen Ming", "陈明", " +86 1598 9266 842",
					"chenming@gzericsson.com", " ");
			User u68 = create_user("Chen Lincong", "陈林聪", " +86 1348 0205 423",
					"chenlincong@gzericsson.com", "B");
			User u69 = create_user("Shi XingHua", "史兴华", " +86 1501 3266 860",
					"shixinghua@gzericsson.com", "B");
			User u70 = create_user("Huang Junheng", "黄均恒 ",
					" +86 1392 2269 110", "huangjunheng@gzericsson.com", " ");
			// 部门
			Organizegroup organizegroup1 = create_organizegroup(null, "公司",
					"company");
			Organizegroup organizegroup11 = create_organizegroup(
					organizegroup1, "group", "group");
			Organizegroup organizegroup111 = create_organizegroup(
					organizegroup11, "team", "team");

			Organize o1 = create_organize("部门", "organize-department", null);
			Organize o0000 = create_sub_organize(o1, "爱立信全球", "gtc", null);

			Organize o11 = create_sub_organize(o0000, "爱立信东北亚GSC", "gtc", null);
			Organize o01 = create_sub_organize(o11, "爱立信中国GSC", "gtc", null);
			Organize o012 = create_sub_organize(o01, "GSC中国广州", "gtc", null);
			Organize o111 = create_sub_organize(o012, " GSC-GZ-应用程序开发部",
					"application-design", null);
			Organize o1111 = create_sub_organize(o111, "爱立信CBC", "CBC",
					organizegroup1);
			Organize o1112 = create_sub_organize(o111, "爱立信广州GTC", "GTC",
					organizegroup1);

			Organize o0001 = create_sub_organize(o1, "第三方合作公司", "arp", null);
			Organize o12 = create_sub_organize(o0001, "纬创odc", "odc",
					organizegroup1);
			Organize o13 = create_sub_organize(o0001, "瑞友rayoo", "rayoo",
					organizegroup1);

			// 项目
			Organize o2 = create_organize("项目", "organize-project", null);
			Organize o21 = create_sub_organize(o2, "香港ehms", "ehms", null);
			Organize o211 = create_sub_organize(o21, "fixed", "fixed",
					organizegroup11);
			Organize o212 = create_sub_organize(o21, "mobile", "mobile",
					organizegroup11);

			Organize o2111 = create_sub_organize(o211, "bss", "fixed-bss",
					organizegroup111);
			Organize o2112 = create_sub_organize(o211, "oss", "fixed-oss",
					organizegroup111);
			Organize o2113 = create_sub_organize(o211, "billing",
					"fixed-billing", organizegroup111);
			Organize o2114 = create_sub_organize(o211, "mp", "fixed-mp",
					organizegroup111);
			Organize o2115 = create_sub_organize(o211, "dss", "fixed-dss",
					organizegroup111);

			Organize o2121 = create_sub_organize(o212, "billing",
					"mobile-billing", organizegroup111);
			Organize o2122 = create_sub_organize(o212, "bss", "mobile-bss",
					organizegroup111);
			Organize o2123 = create_sub_organize(o212, "ps", "mobile-ps",
					organizegroup111);
			Organize o2124 = create_sub_organize(o212, "fw", "mobile-fw",
					organizegroup111);
			Organize o2125 = create_sub_organize(o212, "vas", "mobile-vas",
					organizegroup111);
			Organize o2126 = create_sub_organize(o212, "dba", "mobile-dba",
					organizegroup111);

			Rolegroup r1 = create_rolegroup("部门", "rolegroup-department");
			Rolegroup r10 = create_sub_rolegroup(r1, "部门经理DM", "DM");
			Rolegroup r11 = create_sub_rolegroup(r10, "技术经理TM", "TM");
			Rolegroup r12 = create_sub_rolegroup(r10, "预算经理SDM", "SDM");
			Rolegroup r13 = create_sub_rolegroup(r10, "秘书", "secretary");
			Rolegroup r14 = create_sub_rolegroup(r10, "员工", "member");
			Rolegroup r15 = create_sub_rolegroup(r10, "APR接口人", "inf");

			Rolegroup r2 = create_rolegroup("项目", "rolegroup-project");
			Rolegroup r21 = create_sub_rolegroup(r2, "项目经理", "projectmanager");
			Rolegroup r211 = create_sub_rolegroup(r21, "领域主管", "groupleader");
			Rolegroup r2111 = create_sub_rolegroup(r211, "组长", "teamleder");
			Rolegroup r21111 = create_sub_rolegroup(r2111, "成员", "teammember");
			Rolegroup r211111 = create_sub_rolegroup(r2111, "外派成员", "helper");

			Resource rs0 = create_resource("企业架构", "infEa", "");
			Resource rs01 = create_sub_resource(rs0, "人员录入",
					"infEa-testpage-dir-admin",
					"app/manager/user!menuUserInit.do");
			Resource rs02 = create_sub_resource(rs0, "组织架构定义",
					"infEa-testpage-dir-admin",
					"app/manager/organize!menuOrganizeInit.do");
			Resource rs03 = create_sub_resource(rs0, "角色组定义",
					"infEa-testpage-dir-admin",
					"app/manager/rolegroup!menuRolegroupInit.do");
			Resource rs04 = create_sub_resource(rs0, "创建角色",
					"infEa-testpage-dir-admin", "app/manager/infEa!relation.do");
			Resource rs05 = create_sub_resource(rs0, "人员部署",
					"infEa-testpage-dir-admin",
					"app/manager/infEa!personDeploy.do");
			Resource rs06 = create_sub_resource(rs0, "资源管理",
					"infEa-testpage-dir-admin",
					"app/manager/resource!menuResourceInit.do");
			Resource rs07 = create_sub_resource(rs0, "发送服务器配置",
					"infEa-testpage-dir-admin",
					"app/manager/smtp!menuSmtpInit.do");

			Resource rs1 = create_resource("试卷系统", "infEa-testpage", "");
			Resource rs11 = create_sub_resource(rs1, "试卷目录管理",
					"infEa-testpage-dir-admin", "");
			Resource rs12 = create_sub_resource(rs1, "试卷编辑",
					"infEa-testpage-edit", "");
			Resource rs13 = create_sub_resource(rs1, "打印试卷",
					"infEa-testpage-print", "");
			Resource rs14 = create_sub_resource(rs1, "查询试卷答案",
					"infEa-testpage-query-answer", "");

			Resource rs2 = create_resource("招聘系统", "infEa-recruit", "");
			Resource rs21 = create_sub_resource(rs2, "岗位要求发布",
					"infEa-recruit-position",
					"app/manager/position!menuPositionInit.do");
			Resource rs22 = create_sub_resource(rs2, "应聘者管理",
					"infEa-recruit-position",
					"app/manager/candidate!menuCandidateInit.do");
			Resource rs23 = create_sub_resource(rs2, "提交候选人简历",
					"infEa-recruit-candication",
					"app/manager/recruit!menuCommitCandidateInit.do");
			Resource rs24 = create_sub_resource(rs2, "评价候选人",
					"infEa-recruit-assess",
					"app/manager/recruit!menuAssessCandidateInit.do");

			batCreateRole(o1112.getId().toString(), r14.getId().toString());

			batCreateRole(o12.getId().toString(), r14.getId().toString());
			batCreateRole(o13.getId().toString(), r14.getId().toString());

			batCreateRole(o2111.getId().toString(), r2111.getId().toString()
					+ "-" + r21111.getId().toString());
			batCreateRole(o2112.getId().toString(), r2111.getId().toString()
					+ "-" + r21111.getId().toString());
			batCreateRole(o2113.getId().toString(), r2111.getId().toString()
					+ "-" + r21111.getId().toString());
			batCreateRole(o2114.getId().toString(), r2111.getId().toString()
					+ "-" + r21111.getId().toString());
			batCreateRole(o2115.getId().toString(), r2111.getId().toString()
					+ "-" + r21111.getId().toString());

			batCreateRole(o2121.getId().toString(), r2111.getId().toString()
					+ "-" + r21111.getId().toString());
			batCreateRole(o2122.getId().toString(), r2111.getId().toString()
					+ "-" + r21111.getId().toString());
			batCreateRole(o2123.getId().toString(), r2111.getId().toString()
					+ "-" + r21111.getId().toString());
			batCreateRole(o2124.getId().toString(), r2111.getId().toString()
					+ "-" + r21111.getId().toString());
			batCreateRole(o2125.getId().toString(), r2111.getId().toString()
					+ "-" + r21111.getId().toString());
			batCreateRole(o2126.getId().toString(), r2111.getId().toString()
					+ "-" + r21111.getId().toString());

			batCreateRole(o12.getId().toString(), r15.getId().toString());
			batCreateRole(o13.getId().toString(), r15.getId().toString());
			create_smtp("gscsystem@163.com", "smtp.163.com", "gscsystem",
					"abc123", "25", "网易邮箱");
		}
	}
}
