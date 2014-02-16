package com.app.manager.action;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.manager.model.Tpltb3;

@Component("tpltb3Action")
@Scope("prototype")
public class Tpltb3Action extends BaseEaAction {
	
	private static Logger log = LoggerFactory.getLogger(Tpltb3Action.class);
	public Tpltb3 bfobject = new Tpltb3();

	public String get_list_sql() {
		return "from Tpltb3 where projectId='" + getCurrentProjectId() + "'";
	}

	public String list() throws Exception {
		String sql = getSearchSql(get_list_sql());
		getPageData(sql);
		return "list";
	}
	
	public String load() throws Exception {
		String id = getpara("id");
		if ("".equals(getpara("id"))) {
			rhs.put("tpltb3", null);
		} else {
			Tpltb3 tpltb3 = (Tpltb3) baseDao.loadById("Tpltb3", Long.parseLong(id));
			rhs.put("tpltb3", tpltb3);
		}
		return "success";
	}
	
	public String save() throws Exception {
		if (bfobject.getId() == null || bfobject.getId().toString().equals("")) { // create
			bfobject.setProjectId(getCurrentProjectId());
			baseDao.create(bfobject);
		} else { // edit
			baseDao.update(bfobject);
		}
		return list();
	}
	
	public String delete() throws Exception {
		String id = getpara("id");
		Tpltb3 bfdata = new Tpltb3();
		bfdata.setId(Long.parseLong(id));
		baseDao.delete(bfdata);
		return list();
	}
	
}
