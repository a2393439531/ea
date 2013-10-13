package com.app.manager.report.action;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.manager.ea.action.BaseEaAction;
import com.app.manager.template.model.Lingli;

@Component("hotelreportAction")
@Scope("prototype")
public class EarptAction extends BaseEaAction {
	
	private static Logger log = LoggerFactory.getLogger(EarptAction.class);
	public Lingli bfobject = new Lingli();

	public String fee() {
		return "success";
	}

	
	
}
