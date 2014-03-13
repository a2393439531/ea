package com.app.common.svn.action;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;

@Component("svnAction")
@Scope("prototype")
public class SvnAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(SvnAction.class);
	
	public String svn_list(){
		return "success";
	}
}
