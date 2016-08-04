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
import edu.taru.common.utils.StringUtils;
import edu.taru.common.utils.Toolkit;
import edu.taru.mvc.AdminCheckSession;
import edu.taru.project.admin.user.entity.User;
import edu.taru.project.admin.user.entity.UserAuth;
import edu.taru.project.admin.user.service.UserAuthService;
import edu.taru.project.admin.user.service.UserService;

/**
 * 后台 会员管理
 * @author iFan
 *
 */
@IocBean
@At("/admin/user/")
@Ok("json")
@Filters(@By(type=AdminCheckSession.class))
public class UserController {

	@Inject
	private UserService userService;
	
	@Inject
	private UserAuthService userAuthService;
	
	/**
	 * 会员信息
	 * @param user 检索条件
	 * @param pageNumber 当前页
	 * @return
	 */
	@At("record")
    public View userRecord(@Param("..")User user, @Param("pageNumber")int pageNumber) {
		/* map */
		Map<String,Object> params = Maps.newHashMap();
		/* 设置初始页数 */
		if(0 == pageNumber)
			pageNumber = 1;
		/* 检索条件 */
		Cnd cnd = Cnd.NEW();
		if(StringUtils.isNotBlank(user.getLoginName())){
			cnd.and("loginname", "=", user.getLoginName());
		}
		if(StringUtils.isNotBlank(user.getName())){
			cnd.and("name", "like", "%" + user.getName() + "%");
		}
		if(StringUtils.isNotBlank(user.getCardId())){
			cnd.and("card_id", "=", user.getCardId());
		}
		if(null != user.getStatus()){
			cnd.and("status", "=", user.getStatus());
		}
		cnd.asc("create_date");
		/* 分页查询 */
		QueryResult qr = userService.findByPage(User.class, cnd, pageNumber, 5);
		params.put("qr", qr);
		params.put("user", user);
		return new ViewWrapper(new JspView("views/admin/user/userRecord"), params);	
    }
	
	/**
	 * 删除会员
	 * @param user
	 * @param id
	 * @param pageNumber
	 * @return
	 */
	@At("delete")
	@Aop(TransAop.READ_COMMITTED)
	public View delete(@Param("..")User user, @Param("id")String id, @Param("pageNumber")int pageNumber){
		boolean flag1 = userService.delete(id, User.class);
		boolean flag2 = true;
		if (userAuthService.countByUserId(id) > 0)
			flag2 = userAuthService.delByCnd(UserAuth.class, Cnd.where("user_id", "=", id)); //删除关联的认证表
		if(flag1 && flag2)
			return userRecord(user, pageNumber);	
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
	
	/**
	 * 重置密码
	 * @param user
	 * @param id
	 * @param pageNumber
	 * @return
	 */
	@At("changePasswd")
	public View changePasswd(@Param("..")User user, @Param("id")String id, @Param("pageNumber")int pageNumber){
		boolean flag = userService.changePasswd(id, Toolkit.entryptPassword(Constants.DEFAULT_PASSWORD));
		if(flag)
			return userRecord(user, pageNumber);	
		
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}

	/**
	 * 加入黑名单，顺便删除认证记录
	 * @return
	 */
	@At("setBlack")
	public View setBlack (@Param("id") String id, @Param("..")User user, @Param("pageNumber")int pageNumber) {
		User userNew = userService.get(User.class, id);
		userNew.setStatus(User.BLACK); 
		boolean flag1 = userService.update(userNew);
		boolean flag2 = true;
		if (null != userAuthService.findByUserId(id)) {
			flag2 = userAuthService.delByCnd(UserAuth.class, Cnd.where("user_id", "=", id));
		}
		if (flag1 && flag2) 
			return userRecord(user, pageNumber);
		else return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
}
