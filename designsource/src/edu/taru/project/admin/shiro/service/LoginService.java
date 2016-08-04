package edu.taru.project.admin.shiro.service;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.common.base.BasicService;
import edu.taru.project.admin.shiro.dao.LoginDao;

@IocBean
public class LoginService extends BasicService<Object>{

	@Inject
	private LoginDao loginDao;
	
	
}
