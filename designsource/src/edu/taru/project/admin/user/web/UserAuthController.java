package edu.taru.project.admin.user.web;

import java.util.Map;

import org.nutz.aop.interceptor.ioc.TransAop;
import org.nutz.dao.Cnd;
import org.nutz.dao.QueryResult;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import com.google.common.collect.Maps;

import edu.taru.common.Constants;
import edu.taru.mvc.AdminCheckSession;
import edu.taru.project.admin.user.entity.User;
import edu.taru.project.admin.user.entity.UserAuth;
import edu.taru.project.admin.user.service.UserAuthService;
import edu.taru.project.admin.user.service.UserService;

/**
 * 后台 会员审核管理
 * @author iFan
 *
 */
@IocBean
@At("/admin/auth/")
@Ok("json")
@Filters(@By(type=AdminCheckSession.class))
public class UserAuthController {

	@Inject
	private UserAuthService userAuthService;
	
	@Inject
	private UserService userService;
	
	/**
	 * 列表
	 * @param userAuth
	 * @param pageNumber
	 * @return
	 */
	@At("record")
    public View userAuthRecord(@Param("..")UserAuth userAuth, @Param("pageNumber")int pageNumber) {
		/* map */
		Map<String,Object> params = Maps.newHashMap();
		/* 设置初始页数 */
		if(0 == pageNumber)
			pageNumber = 1;
		/* 检索条件 */
		Cnd cnd = Cnd.NEW();
		if(null != userAuth.getStatus()){
			cnd.and("status", "=", userAuth.getStatus());
		}
		cnd.asc("status"); //未认证的靠前显示
		cnd.asc("create_date"); //时间早的靠前显示
		
		/* 分页查询 */
		QueryResult qr = userAuthService.findByPage(UserAuth.class, cnd, pageNumber, 5);
		params.put("qr", qr);
		params.put("userAuth", userAuth);
		return new ViewWrapper(new JspView("views/admin/user/authRecord"), params);	
    }
	
	/**
	 * 认证通过
	 * @param id
	 * @param userId
	 * @param status
	 * @param pageNumber
	 * @return
	 */
	@At("pass")
	@Aop(TransAop.READ_COMMITTED)
	public View pass (@Param("id")String id, @Param("userId")String userId, @Param("pageNumber")int pageNumber) {
		UserAuth auth = userAuthService.get(UserAuth.class, id);
		User user = userService.get(User.class, userId);
		
		auth.setStatus(UserAuth.PASS_AUTH); //认证表设置认证通过
		user.setStatus(User.PASS_AUTH); //会员表设置认证通过
		
		boolean flag1 = userAuthService.update(auth);
		boolean flag2 = userService.update(user);
		
		if (flag1 && flag2)
			return userAuthRecord(new UserAuth(), pageNumber);
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);	
		
	}
	
	/**
	 * 认证驳回
	 * @param id
	 * @param userId
	 * @param status
	 * @param pageNumber
	 * @return
	 */
	@At("nopass")
	@Aop(TransAop.READ_COMMITTED)
	public View nopass (@Param("id")String id, @Param("userId")String userId, @Param("pageNumber")int pageNumber) {
		UserAuth auth = userAuthService.get(UserAuth.class, id);
		User user = userService.get(User.class, userId);
		
		auth.setStatus(UserAuth.DOWN_AUTH); //认证表设置认证驳回
		user.setStatus(User.DOWN_AUTH); //会员表设置认证驳回
		
		boolean flag1 = userAuthService.update(auth);
		boolean flag2 = userService.update(user);
		
		if (flag1 && flag2)
			return userAuthRecord(new UserAuth(), pageNumber);
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);	
		
	}
	
}
