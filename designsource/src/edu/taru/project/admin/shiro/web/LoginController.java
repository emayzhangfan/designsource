package edu.taru.project.admin.shiro.web;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.GET;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.POST;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import com.google.common.collect.Maps;

import edu.taru.common.Constants;
import edu.taru.common.base.RedisService;
import edu.taru.common.utils.StringUtils;
import edu.taru.common.utils.Toolkit;
import edu.taru.mvc.AdminCheckSession;
import edu.taru.project.admin.system.entity.Admin;
import edu.taru.project.admin.system.service.AdminService;


/**
 * 后台 登录
 * @author iFan
 *
 */
@IocBean
@Filters(@By(type=AdminCheckSession.class)) // 检查当前Session是否带admin这个属性
public class LoginController {

	@Inject
	private AdminService adminService;
	
	@Inject
	private RedisService redisService;
	
	/**
	 * 登陆
	 * @return
	 */
	@At("/admin/login")
	@GET
	@Ok("redirect:/admin")
	@Filters()
	public Object login(HttpSession session){
		if(null == session.getAttribute("admin")){
			return new ViewWrapper(new JspView("views/admin/login"),null);	
		}
		return null;
	}
	
	@At("/admin/login")
	@POST
	@Ok("redirect:/admin")
	@Filters()
	public Object login(String loginName, String password, HttpSession session, HttpServletRequest request){
		Map<String,Object> params = Maps.newHashMap();
		if(StringUtils.isNotEmpty(loginName) && StringUtils.isNotEmpty(password)){
			String ip = redisService.get(loginName);
			if (StringUtils.isNotEmpty(ip)) {
				params.put("Logining", Constants.LOGINING_EXIST);
				params.put("loginName", loginName);
				params.put("password", password);
				return new ViewWrapper(new JspView("views/admin/login"),params);
			}
			
			validateLoginAndSetRedis(params, loginName, password, session, request);
		}else{
			params.put("error", Constants.LOGINNAME_PASSWORD_NOT_EMPTY);
			return new ViewWrapper(new JspView("views/admin/login"),params);
		}
		return null;
	}
	
	/**
	 * 强制登录
	 * @param loginName
	 * @param password
	 * @param session
	 * @param request
	 * @return
	 */
	@At("/admin/loginAgain")   
	@GET
	@Ok("redirect:/admin")
	@Filters()
	public Object loginAgain(String loginName, String password, HttpSession session, HttpServletRequest request){
		Map<String,Object> params = Maps.newHashMap();
		if(StringUtils.isNotEmpty(loginName) && StringUtils.isNotEmpty(password)){
			validateLoginAndSetRedis(params, loginName, password, session, request);
		}else{
			params.put("error", Constants.LOGINNAME_PASSWORD_NOT_EMPTY);
			return new ViewWrapper(new JspView("views/admin/login"),params);
		}
		return null;
	}
	
	/**
	 * 
	 * @param params
	 * @param loginName
	 * @param password
	 * @param session
	 * @param request
	 * @return
	 */
	public Object validateLoginAndSetRedis (Map<String,Object> params, String loginName, String password, HttpSession session, HttpServletRequest request){
		Admin admin=adminService.findUserByLoginName(loginName);
		if(null != admin){
			if(Toolkit.validatePassword(password, admin.getPassword())){
//				session.setAttribute("admin", admin);
				String token = String.format("%s;%s", Json.toJson(admin), System.currentTimeMillis());
				redisService.setex(Toolkit.getIpAddress(request), 1800, token); //一个IP对应一个session
				redisService.setex(loginName, 1800, Toolkit.getIpAddress(request)); //一个用户对应一个IP
			}else{
				params.put("error", Constants.LOGINPASSWORD_WRONG);
				return new ViewWrapper(new JspView("views/admin/login"),params);
			}
		}else{
			params.put("error", Constants.LOGINNAME_NOT_EXIST);
			return new ViewWrapper(new JspView("views/admin/login"),params);
		}
		return null;
	}
	
	@At(value = {"/admin", "/a" , "/bg"})
	@Filters()
	public Object index(HttpSession session){
		Map<String,Object> params = Maps.newHashMap();
		String redisSession = getRedisSession();
		if (StringUtils.isNotEmpty(redisSession)) {
			String[] tmp = redisSession.split(";", 2);
			Admin admin = Json.fromJson(Admin.class, tmp[0]);
			if (!Toolkit.getIpAddress(Mvcs.getReq()).equals(redisService.get(admin.getUsername()))) {
				params.put("ReLogin", Constants.LOGINING_EXIST_AGAIN);
				session.removeAttribute("admin");
				return new ViewWrapper(new JspView("views/admin/login"),params);
			}
			
			session.setAttribute("admin", admin);
			int mii = (int) ((System.currentTimeMillis() - Long.valueOf(tmp[1])) * 1000);
			session.setMaxInactiveInterval(mii);
		} else {
			return new ViewWrapper(new JspView("views/admin/login"), null);	
		}
		
		if(null == session.getAttribute("admin")){
			return new ViewWrapper(new JspView("views/admin/login"), null);	
		}
		
		return new ViewWrapper(new JspView("views/admin/index"), params);
	}
	
	/**
	 * 登出
	 */
	@Filters
	@At("/admin/loginOut")
	@Ok("redirect:/admin")
	public void loginOut(HttpSession session){
		redisService.del(Toolkit.getIpAddress(Mvcs.getReq()));
		Admin admin = (Admin) Mvcs.getHttpSession().getAttribute("admin");
		redisService.del(admin.getUsername());
		session.removeAttribute("admin");
	}
	
	/**
	 * 从Redis中获取session
	 * @return
	 */
	public String getRedisSession () {
		return redisService.get(Toolkit.getIpAddress(Mvcs.getReq()));
	}

}
