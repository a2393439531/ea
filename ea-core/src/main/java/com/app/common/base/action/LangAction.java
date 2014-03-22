package com.app.common.base.action;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.i18n.I18n;
import com.app.ea.api.InfEa;
import com.app.ea.model.Organize;
import com.app.ea.model.Resource;
import com.app.ea.model.User;

import com.opensymphony.xwork2.ActionContext;

import com.utils.path.PathUtils;

@Component("langAction")
@Scope("prototype")
public class LangAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(LangAction.class);

	public String execute() throws Exception {
		// 如果是第一次，langString=first,则根据，问题是，不一定有我们已经有的语言，所以需要一个MAP
		String langString = getpara("lang");
		if (langString.equals("first")) { // 如果不是第一次，认证错误了的话
			HttpServletRequest requestServelt = ServletActionContext.getRequest();
			// zh-cn,zh;q=0.5 FIREFOX又有所不同了,IE是zh-cn
			langString = requestServelt.getHeader("Accept-Language").split(",")[0].toLowerCase();
			// 去后台判断是否需要显示
			HashMap languageMap = I18n.getLanguage();
			if (!languageMap.containsKey(langString)) {
				langString = "en";
			}
		}
		// 如果不是第一次，还有用户名密码
		Map sessionMap = ActionContext.getContext().getSession();
		sessionMap.put("lang", langString);
		return "login"; // login.ftl
	}
}
