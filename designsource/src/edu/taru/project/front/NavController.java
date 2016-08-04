package edu.taru.project.front;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.Scope;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Attr;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.filter.CheckSession;

import edu.taru.common.Constants;
import edu.taru.common.base.RedisService;
import edu.taru.common.utils.IdGen;
import edu.taru.common.utils.StringUtils;
import edu.taru.common.utils.Toolkit;
import edu.taru.project.admin.classification.entity.Classification;
import edu.taru.project.admin.classification.service.ClassificationService;
import edu.taru.project.admin.user.entity.User;
import edu.taru.project.admin.user.service.UserService;
import edu.taru.project.front.service.SearchTextService;

/**
 * 导航
 * @author zhangfan
 *
 */
@IocBean
public class NavController extends IndexController {

	@Inject
	private UserService userService;
	
	@Inject
	private ClassificationService classificationService;
	
	@Inject
	private SearchTextService searchTextService;
	
	@Inject 
	private RedisService redisService;
	
	public static final Log log = Logs.get();
	
	/**
	 * 登录
	 * @param loginName
	 * @param password
	 * @param session
	 * @return
	 */
	@At("/front/login")
	@Ok("json")
	public Object login (@Param("loginName") String loginName, @Param("password") String password, HttpSession session) {
		if(StringUtils.isNotEmpty(loginName) && StringUtils.isNotEmpty(password)){
			User user = userService.findUserByLoginName(loginName);
			if(null != user){
				if(Toolkit.validatePassword(password, user.getPassword())){
					User entryptEmailUser = Toolkit.entryptEmail(user); //隐藏邮箱信息
					session.setAttribute("user", entryptEmailUser);
					User u = (User) session.getAttribute("user");
					log.debug(u.getUsername()+"_登陆淘学网，时间：" + new Date());
					return Constants.PAGE_REFRESH;
				}else return Constants.LOGINPASSWORD_WRONG;
			}else return Constants.LOGINNAME_NOT_EXIST;
		}else return Constants.LOGINNAME_PASSWORD_NOT_EMPTY;
	}
	
	/**
	 * 验证码登录
	 * @param loginName
	 * @param password
	 * @param captcha
	 * @param _captcha
	 * @param session
	 * @return
	 */
	@At("/front/loginWithCaptcha")
	@Ok("json")
	public Object loginWithCaptcha (@Param("loginName") String loginName, @Param("password") String password, 
			@Param("captcha")String captcha, 
			@Attr(scope=Scope.SESSION, value="nutz_captcha")String _captcha,
			HttpSession session) {
		if (StringUtils.isBlank(captcha)) {
            return Constants.CAPTCHA_NULL;
        }
		if (!Toolkit.checkCaptcha(_captcha, captcha)) {
            return Constants.CAPTCHA_ERROR;
        }
		if (StringUtils.isNotEmpty(loginName) && StringUtils.isNotEmpty(password)){
			User user = userService.findUserByLoginName(loginName);
			if(null != user){
				if(Toolkit.validatePassword(password, user.getPassword())){
					User entryptEmailUser = Toolkit.entryptEmail(user);
					session.setAttribute("user", entryptEmailUser);
					return Constants.PAGE_REFRESH;
				}else return Constants.LOGINPASSWORD_WRONG;
			}else return Constants.LOGINNAME_NOT_EXIST;
		}else return Constants.LOGINNAME_PASSWORD_NOT_EMPTY;
	}
	
	/**
	 * 登出
	 */
	@At("/front/loginOut")
	@Ok("redirect:/index")
	public void loginOut(HttpSession session){
		session.removeAttribute("user");
	}
	
	/**
	 * 注册页面跳转
	 * @return
	 */
	@At("/front/registerForm")
	public View registerForm () {
		return register();
	}
	
	/**
	 * 个人中心跳转
	 * @return
	 */
	@At("front/myCenterForm")
	@Filters(@By(type=CheckSession.class, args={"user", "/index"}))
	public View myCenterFrom () {
		return myCenter((User) Mvcs.getHttpSession().getAttribute("user"));
	}
	
	/**
	 * 注册
	 * @param user
	 * @return
	 */
	@At(value={"/front/register"})
	@Ok("redirect:/front/myCenterForm") //防止表单重复提交，应该重定向
	public Object register (@Param("..") User user, HttpSession session) {
		if (StringUtils.isBlank(user.getId())) { 
			user.setId(IdGen.uuid()); //主键
			user.setPassword(Toolkit.entryptPassword(user.getPassword())); //密码加密
			user.setStatus(User.NO_AUTH); //未认证1
			user.setCreateDate(new Date()); //创建时间
			user.setAvatar(Constants.DEFAULT_AVATAT); //设置默认头像
			user.setEmailChecked(false);//未验证邮箱
			User registerNewUser = userService.save(user); //保存
			User entryptEmailUser = Toolkit.entryptEmail(registerNewUser);
			session.setAttribute("user", entryptEmailUser); //存入session，并跳转到个人中心，引导用户进行实名认证
			if (null != registerNewUser) 
				return null;
		}
		return error(Constants.SERVICE_ERROR); //不论什么错误，把锅甩给服务器，返回一个服务器忙的页面
	}
	
	/**
	 * 验证用户名是否存在
	 * @param loginName
	 * @return
	 */
	@Ok("json")
	@At(value={"/front/ajax/validateLoginname"})
	public Object validateLoginname (@Param("loginName") String loginName) {
		if (null != userService.findUserByLoginName(loginName)) 
			return true; //存在
		return false;
	}
	
	/**
	 * 查询顶级分类，用于导航
	 * @return
	 */
	@Deprecated
	@At(value={"/nav/ajax/classificationTop"})
	@Ok("json")
	public Object classificationTop () {
		return classificationService.findTop();
	}
	
	/**
	 * 返回availableTags的json
	 * @return
	 */
	@Deprecated
	@At(value={"/nav/ajax/availableTags"})
	@Ok("json")
	public Object availableTags () {
		return searchTextService.availableTagsJson();
	}
	
	
	
	
	/**
	 * 查询顶级分类，用于导航 
	 * 缓存中取
	 * @return
	 */
	@At(value={"/nav/ajax/redis/classificationTop"})
	@Ok("json")
	public Object classificationTopRedis () {
		if (null != redisService.get("nav")) 
			return redisService.get("nav");
		List<Classification> list = classificationService.findTop();
		String nav = Json.toJson(list);
		redisService.set("nav", nav);
		return redisService.get("nav");
	}
	
	/**
	 * 返回availableTags的json
	 * 缓存中取
	 * @return
	 */
	@At(value={"/nav/ajax/redis/availableTags"})
	@Ok("json")
	public Object availableTagsRedis () {
		if (null != redisService.get("availableTags")) 
			return redisService.get("availableTags");
		String availableTags = Json.toJson(searchTextService.availableTagsJson());
		redisService.set("availableTags", availableTags);
		return redisService.get("availableTags");
	}
}
