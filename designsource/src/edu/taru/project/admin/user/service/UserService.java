package edu.taru.project.admin.user.service;

import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.common.base.BasicService;
import edu.taru.project.admin.user.dao.UserDao;
import edu.taru.project.admin.user.entity.User;

@IocBean
public class UserService extends BasicService<User> {

	@Inject
	private UserDao userDao;

	/**
	 * 根据id修改会员密码
	 * @param id
	 * @param password
	 * @return
	 */
	public boolean changePasswd(String id, String password){
		return userDao.update(User.class, Chain.make("password", password), Cnd.where("id", "=", id));
	}
	
	/**
	 * 根据登录名查询该会员
	 * @param loginName
	 * @return
	 */
	public User findUserByLoginName(String loginName){
		return userDao.findByCondition(User.class, Cnd.where("loginname", "=", loginName));
	}
}
