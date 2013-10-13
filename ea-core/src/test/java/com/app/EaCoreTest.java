package com.app;

import static org.junit.Assert.assertEquals;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.annotation.Rollback;

import com.app.manager.ea.model.Organize;
import com.app.manager.ea.model.Resource;
import com.app.manager.ea.model.Role;
import com.app.manager.ea.model.Rolegroup;
import com.app.manager.ea.model.User;

public class EaCoreTest extends ParentTest {
	static Logger log = LoggerFactory.getLogger(EaCoreTest.class);
	public static final String RESOURCE_BY_USERID = "select r from Resource r  left join r.users u where   u.id =? ";
	public static final String RESOURCE_OF_ROLE_GROUP_BY_USERID = "select distinct res from Resource res left join res.rolegroups rolegroup left join rolegroup.roles role  left join role.users user where user.id=?";

	// 陈永雄 ID:55 要运行2个SQL语句
	@Test
	public void testLeftJoin() throws Exception {
		User user = (User) baseDao.loadById("User", Long.parseLong("55"));
		for (Iterator iterator5 = user.getResources().iterator(); iterator5
				.hasNext();) {
			Resource resource = (Resource) iterator5.next();
			System.out.println(resource.getName());
		}

	}
	
	@Test
	@Rollback
	public void testbaseDao() {
		System.out.println(baseDao);
		System.out.println("用户个数=" + baseDao.find("from User").size());
	}
	@Test
	public void testGetOrganizeRootRoleList() throws Exception {
        infEa.getOrganizeRootRoleList("17");
    	
	}

	public void printResourceList(List listResource) {
		for (Iterator iterator5 = listResource.iterator(); iterator5.hasNext();) {
			Resource resource = (Resource) iterator5.next();
			System.out.println("获得资源：" + resource.getName());
		}
	}

	@Test
	public void testRESOURCE_BY_USERID() throws Exception {
		Long userid = 55l;
		User user = (User) baseDao.loadById("User", userid);

		log.debug(user.getName());
		// 获取用户角色和角色组所拥有的资源
		for (Iterator iterator = user.getRoles().iterator(); iterator.hasNext();) {
			Role role = (Role) iterator.next();
			log.debug(role.getName());
			log.debug("============");
			for (Iterator iterator4 = role.getResources().iterator(); iterator4
					.hasNext();) {
				Resource resource = (Resource) iterator4.next();
				System.out.println("资源：" + resource.getName());
			}
			log.debug("============");
			for (Iterator iterator2 = role.getRolegroups().iterator(); iterator2
					.hasNext();) {
				Rolegroup rolegroup = (Rolegroup) iterator2.next();
				log.debug(rolegroup.getName());
			}
		}
		System.out.println("user可以访问的资源");
		List listResource = baseDao.find(RESOURCE_BY_USERID, 55l);
		printResourceList(listResource);
		System.out.println("role可以访问的资源");
		List listResourceRole = baseDao
				.find(
						"select distinct res from Resource res left join res.roles role  left join role.users user where user.id=?",
						55l);
		printResourceList(listResourceRole);
		System.out.println("rolegroup可以访问的资源");
		List listResourceRolegroup = baseDao
				.find(
						"select distinct res from Resource res left join res.rolegroups rolegroup left join rolegroup.roles role  left join role.users user where user.id=?",
						55l);
		printResourceList(listResourceRolegroup);
		System.out.println("默认可以访问的资源");
		List listResourceNull = baseDao
				.find("select  resource from Resource resource where resource not in ( select  res from Resource res left join res.rolegroups rolegroup left join rolegroup.roles role  )");
		printResourceList(listResourceNull);

	}
	
	@Test
	public void testGetAllVisibleResource() throws Exception {
		/*
		Set resourceSet = infEa.getAllVisibleResource("1");
		 for (Iterator iterator3 = resourceSet.iterator(); iterator3.hasNext();) {
				com.app.manager.ea.model.Resource resource = (com.app.manager.ea.model.Resource) iterator3
						.next();
				log.debug(resource.getName());
			}
			*/
   	    log.debug("admin resource numbers:"+infEa.getUserbyName("admin").getResources().size());

     	 log.debug("admin resource numbers:"+infEa.getAllVisibleResource("1").size());
    	    log.debug("test resource numbers:"+infEa.getUserbyName("test").getResources().size());
        	 log.debug("test resource numbers:"+infEa.getAllVisibleResource("2").size());
		
		// assertEquals("user:admin is 8", 8,  infEa.getAllVisibleResource("1").size()); 
		 //assertEquals("user:test is 0", 0,  infEa.getAllVisibleResource("2").size()); 
		/*
		
		*/

	}
}
