package edu.taru.project.admin.user.service;

import org.nutz.dao.Cnd;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.common.base.BasicService;
import edu.taru.project.admin.user.dao.UserAuthDao;
import edu.taru.project.admin.user.entity.UserAuth;

@IocBean
public class UserAuthService extends BasicService<UserAuth> {

	@Inject
	private UserAuthDao userAuthDao;
	
	public int countByUserId (String userId) {
		return userAuthDao.searchCount(UserAuth.class, Cnd.where("user_id", "=", userId));
	}
	
	public UserAuth findByUserId (String userId) {
		return userAuthDao.findByCondition(UserAuth.class, Cnd.where("user_id", "=", userId));
	}
}
