package com.app.common.selectuser.action;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.common.selectuser.model.OftenSelectedUsers;
import com.app.ea.model.User;

@Component("selectuserAction")
@Scope("prototype")
public class SelectuserAction extends BaseEaAction {
	
	private static Logger log = LoggerFactory.getLogger(SelectuserAction.class);
	
	public String oftenselectlist(){
		List list = baseDao.find("from OftenSelectedUsers where userId=" + getCurrentUser().getId());
		rhs.put("dataList", list);
		log.debug(list.toString());
		return "success";
	}
	public String select_userlist_by_organize() throws Exception {
		log.debug("aaa");
		rhs.put("organizeRootList",infEa.getOrganizeRootNods());	
	return "success";	
		
		
	}	
	
	//针对有没组织架构的选人
	public String select_userlist() throws Exception {
		log.debug("aaa");
		List data = new ArrayList();
		List<User> list = infEa.getAllUser();
		for (User user : list) {
			if(user.getName() != null && !"".equals(user.getName())){
				data.add(user);
			}
		}
		rhs.put("userList",data);	
	return "success";	
		
		
	}
	
	public String users_for_select() throws Exception {
		String term = getpara("term");
		log.debug("users_for_select() : " + term);
		
		String sql = "from User where name like ? or account like ?";
		Object[] values = new Object[]{'%' + term + '%', '%' + term + '%'};
		List dataList = infEa.getbaseDao().find(sql, values);
		List data = new ArrayList();
		List<User> list = infEa.getAllUser();
		for (Object obj : dataList) {
			User user = null;
			if(obj instanceof User){
				user = (User)obj;
			}
			if(user.getName() != null && !"".equals(user.getName())){
				data.add(user);
			}
		}
		rhs.put("dataList", data);
		return "success";
	}	
	
	public String saveoftenselect(){
		log.debug("save()");
		
		String selectedUserAccount = getpara("selectedUserAccount");
		String selectedUserName = getpara("selectedUserName");
		
		List list = baseDao.find("from OftenSelectedUsers where selectedUserAccount='" + selectedUserAccount + "' and userId=" + getCurrentUser().getId());
		if(list != null && list.size() != 0){
			OftenSelectedUsers o = (OftenSelectedUsers)list.get(0);
			o.setCount(o.getCount() + 1);
			baseDao.update(o);
		}else{
			OftenSelectedUsers o = new OftenSelectedUsers();
			o.setUserId(getCurrentUser().getId());
			o.setUserAccount(getCurrentUser().getAccount());
			o.setSelectedUserAccount(selectedUserAccount);
			o.setSelectedUserName(selectedUserName);
			o.setCount(1);
			baseDao.create(o);
		}
		
		return null;
	}
	
	//added by xiaoqinghong for mobile 2014-6-24
	public String m_select_userlist() throws Exception {
		this.select_userlist();
		return "success";	
	}
	//added by xiaoqinghong for mobile 2014-6-24 end

}
