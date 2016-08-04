package edu.taru.project.admin.user.web;

import java.util.Map;

import org.nutz.dao.Cnd;
import org.nutz.dao.QueryResult;
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
import edu.taru.mvc.AdminCheckSession;
import edu.taru.project.admin.user.entity.User;
import edu.taru.project.admin.user.service.UserService;

/**
 * 后台 黑名单管理
 * @author iFan
 *
 */
@IocBean
@At("/admin/black/")
@Ok("json")
@Filters(@By(type=AdminCheckSession.class))
public class BlackListController {

	@Inject
	private UserService userService;
	
	@At("record")
    public View blackRecord(@Param("..")User user, @Param("pageNumber")int pageNumber) {
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
		cnd.and("status", "=", User.BLACK);
		cnd.asc("create_date");
		/* 分页查询 */
		QueryResult qr = userService.findByPage(User.class, cnd, pageNumber, 5);
		params.put("qr", qr);
		params.put("user", user);
		return new ViewWrapper(new JspView("views/admin/user/blackRecord"), params);	
    }
	
	/**
	 * 撤销黑名单
	 * @return
	 */
	@At("undoBlack")
	public View undoBlack (@Param("id") String id, @Param("..")User user, @Param("pageNumber")int pageNumber) {
		User userNew = userService.get(User.class, id);
		userNew.setStatus(User.NO_AUTH); //撤消后 直接恢复为未认证用户
		boolean flag = userService.update(userNew);
		if (flag) 
			return blackRecord(user, pageNumber);
		else return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
}
