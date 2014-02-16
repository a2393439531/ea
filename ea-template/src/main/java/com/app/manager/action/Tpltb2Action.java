package com.app.manager.action;

import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.common.spring.ssh.action.BaseBusinessAction;
import com.app.manager.model.Tpltb2;

@Component("tpltb2Action")
@SuppressWarnings("rawtypes")
public class Tpltb2Action extends BaseEaAction {
	private static Logger log = LoggerFactory.getLogger(Tpltb2Action.class);
	public Tpltb2 tpltb2object = new Tpltb2();

	public String menu_tpltb2() throws Exception {
		getPageData();
		rhs.put("info_type", "success");
		rhs.put("info", "");
		return "success";
	}

	public String load() throws Exception {
		if (!getpara("id").equals("")) {
			Tpltb2 tpltb2 = (Tpltb2) baseDao.loadById("Tpltb2",
					Long.parseLong(getpara("id")));
			rhs.put("tpltb2", tpltb2);
		} else {
			rhs.put("tpltb2", null);
		}
		return "success";
	}

	public String save() throws Exception {
		if (getpara("id").equals("")) {
			// tpltb2object.setBirthDate();
			baseDao.create(tpltb2object);
			rhs.put("tpltb2", tpltb2object);
			List countList = baseDao.find("from Tpltb2");
			int maxPage = countList.size() % pagination.getMaxSize() > 0 ? countList
					.size() / pagination.getMaxSize() + 1
					: countList.size() / pagination.getMaxSize();
			pagination.setCurrentPage(maxPage);

			List tpltb2List = baseDao.page("from Tpltb2", pagination);
			rhs.put("dataList", tpltb2List);
			rhs.put("maxSize", pagination.getMaxSize());
			rhs.put("count", countList.size());
			rhs.put("maxPage", maxPage);
			rhs.put("currentPage", maxPage);

			rhs.put("info_type", "success");
			rhs.put("info", "create success!");
		} else {
			tpltb2object.setId(Long.parseLong(getpara("id")));
			Tpltb2 tpltb2 = (Tpltb2) baseDao.loadById("Tpltb2",
					Long.parseLong(getpara("id")));
			BeanUtils.copyProperties(tpltb2, tpltb2object);
			baseDao.update(tpltb2);
			rhs.put("tpltb2", tpltb2);
			getPageData();
		}
		return "success";
	}

	public String create() throws Exception {
		Tpltb2 tpltb2 = new Tpltb2();
		tpltb2.setName("");
		baseDao.create(tpltb2);
		getPageData();
		List countList = baseDao.find("from Tpltb2");
		// List countList =infEa.getAllTpltb2();
		int maxPage = countList.size() % pagination.getMaxSize() > 0 ? countList
				.size() / pagination.getMaxSize() + 1
				: countList.size() / pagination.getMaxSize();
		pagination.setCurrentPage(maxPage);

		List tpltb2List = baseDao.page("from Tpltb2", pagination);
		rhs.put("dataList", tpltb2List);
		rhs.put("maxSize", pagination.getMaxSize());
		rhs.put("count", countList.size());
		rhs.put("maxPage", maxPage);
		rhs.put("currentPage", maxPage);

		rhs.put("info_type", "success");
		rhs.put("info", "create success!");
		return "success";
	}

	public String delete() throws Exception {
		String id = getpara("id");
		Tpltb2 tpltb2data = new Tpltb2();
		tpltb2data.setId(Long.parseLong(id));
		baseDao.delete(tpltb2data);
		getPageData();
		rhs.put("info_type", "success");
		rhs.put("info", "delete success!");
		return "success";
	}

	public String update() throws Exception {
		String id = getpara("id");
		String column = ServletActionContext.getRequest()
				.getParameter("column");
		String columnValue = getpara("columnValue");
		if (column.equals("maxSize")) {
			int pageNum = Integer.parseInt(columnValue);
			if (pageNum != pagination.getMaxSize() && pageNum > 0) {
				pagination.setMaxSize(pageNum);
			}
		} else {
			Tpltb2 tpltb2 = (Tpltb2) baseDao.loadById("Tpltb2",
					Long.parseLong(id));
			BeanUtils.setProperty(tpltb2, column, columnValue);
			baseDao.update(tpltb2);
		}

		if (false) {
			rhs.put("info_type", "error");
			rhs.put("info", "错误异常代码演示!");
		} else {
			rhs.put("info_type", "success");
			rhs.put("info", "update success!");
		}
		getPageData();
		return "success";
	}

	@SuppressWarnings("unchecked")
	public void getPageData() throws Exception {
		String pageId = getpara("pageId");
		int maxSize = 20;
		if (getSessionValue("maxSize") == null
				|| getSessionValue("maxSize").equals("")) {
			maxSize = pagination.getMaxSize();
		} else {
			maxSize = Integer.parseInt(getSessionValue("maxSize").toString());
			pagination.setMaxSize(maxSize);

		}
		if (pageId == null || "".equals(pageId)) {
			pageId = (String) ServletActionContext.getRequest().getSession()
					.getAttribute("pageId");
			if (pageId == null || "".equals(pageId))
				pageId = "1";
		}
		putSessionValue("pageId", pageId);

		pagination.setCurrentPage(Integer.parseInt(pageId));
		List tpltb2List = baseDao.page("from Tpltb2", pagination);
		rhs.put("dataList", tpltb2List);
		List countList = baseDao.find("from Tpltb2");
		rhs.put("maxSize", maxSize);
		rhs.put("count", countList.size());
		rhs.put("maxPage",
				countList.size() % pagination.getMaxSize() > 0 ? countList
						.size() / pagination.getMaxSize() + 1 : countList
						.size() / pagination.getMaxSize());
		rhs.put("currentPage", Integer.parseInt(pageId));
	}

	public String change_page_number() throws Exception {
		putSessionValue("maxSize", getpara("maxSize"));
		getPageData();
		rhs.put("info_type", "success");
		rhs.put("info", "");
		return "success";
	}

	public String ajax_page_data() throws Exception {
		getPageData();
		rhs.put("info_type", "success");
		rhs.put("info", "success!");
		return "success";
	}

	public Tpltb2 getTpltb2object() {
		return tpltb2object;
	}

	public void setTpltb2object(Tpltb2 tpltb2object) {
		this.tpltb2object = tpltb2object;
	}

}
