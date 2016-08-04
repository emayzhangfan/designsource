package edu.taru.project.front;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Strings;
import org.nutz.lang.util.NutMap;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.GET;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.POST;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.filter.CheckSession;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import edu.taru.common.Constants;
import edu.taru.common.base.BasicController;
import edu.taru.common.utils.IdGen;
import edu.taru.common.utils.Toolkit;
import edu.taru.project.admin.user.entity.User;
import edu.taru.project.admin.user.service.UserService;

/**
 * 安全中心
 * @author 张帆
 * @date 2016年3月28日
 */
@IocBean
@Ok("json")
@Filters(@By(type=CheckSession.class, args={"user", "/index"}))
public class SafeCenterController extends BasicController{

	public static final Log log = Logs.get();
	
	@Inject
	private UserService userService;
	
	/**
	 * 安全中心页
	 * @param goods
	 * @return
	 */
	public View safeCenter(User user) {
		return new ViewWrapper(new JspView("views/front/safeCenter"), user);
	}
	
	@At("front/safeCenter")
	public View safeCenter() {
		return safeCenter((User) Mvcs.getHttpSession().getAttribute("user"));
	}
	
	@Filters
	@At("front/forgetPwd")
	public View forgetPwd() {
		return new ViewWrapper(new JspView("views/front/forgetPwd"), null);
	}
	
	/**
	 * 发送验证邮件
	 * @param userId
	 * @param req
	 * @return
	 */
	@At("/active/mail")
    @POST
    public Object activeMail(@Param("email") String email,
            HttpServletRequest req) {
        NutMap re = new NutMap();
        if (Strings.isBlank(email)) {
            return re.setv("ok", false).setv("msg", "你还没有填邮箱啊!");
        }
        User user = (User) Mvcs.getHttpSession().getAttribute("user");
        user.setEmail(email);
        boolean flag = userService.update(user);
        if (flag) {
        	String token = String.format("%s,%s,%s", user.getId(), email, System.currentTimeMillis());
            token = Toolkit._3DES_encode(emailKEY, token.getBytes());
            String url = req.getRequestURL() + "?token=" + token;
            String html = "<div>如果无法点击，请拷贝一下链接到浏览器中打开<p/>验证链接 %s</div>";
            html = String.format(html, url, url); 
            try {
                boolean ok = emailService.send(email, "淘学网 - 验证邮件 ( from taoxue.online )", html);
            	//boolean ok = true;
                if (!ok) {
                    return re.setv("ok", false).setv("msg", "发送失败");
                }
            } catch (Throwable e) {
                log.debug("发送邮件失败", e);
                return re.setv("ok", false).setv("msg", "发送失败");
            }
            return re.setv("ok", true);
        } else return re.setv("ok", false).setv("msg", Constants.SERVICE_ERROR);
    }
	
	/**
	 * 验证邮件的返回方法
	 * @param token
	 * @param session
	 * @return
	 */
	@Filters 
    @At("/active/mail")
    @GET
    @Ok("jsp:views.front.msg") 
    public String activeMailCallback(@Param("token")String token, HttpSession session) {
        if (Strings.isBlank(token)) {
            return "请不要直接访问这个链接!!!";
        }
        if (token.length() < 10) {
            return "非法token";
        }
        try {
            token = Toolkit._3DES_decode(emailKEY, Toolkit.hexstr2bytearray(token));
            if (token == null)
                return "非法token";
            String[] tmp = token.split(",", 3);
            if (tmp.length != 3 || tmp[0].length() == 0 || tmp[1].length() == 0 || tmp[2].length() == 0)
                return "非法token";
            long time = Long.parseLong(tmp[2]);
            if (System.currentTimeMillis() - time > 10*60*1000) {
                return "该验证链接已经超时";
            }
            Cnd cnd = Cnd.where("id", "=", tmp[0]).and("email", "=", tmp[1]);
            boolean flag = userService.basicDao.update(User.class, Chain.make("emailChecked", true), cnd);
            if (flag) {
            	User entryptEmailUser = Toolkit.entryptEmail(userService.get(User.class, tmp[0]));
				session.setAttribute("user", entryptEmailUser);
                return "验证成功";
            }
            return "验证失败!!请重新验证!!";
        } catch (Throwable e) {
            log.debug("检查token时出错", e);
            return "非法token";
        }
    }
	
	/**
	 * 发送修改密码验证邮件
	 * @param loginName
	 * @param req
	 * @return
	 */
	@Filters
	@At("/safe/emailPwd")
    @POST
    public Object emailPwd (@Param("loginName") String loginName,
            HttpServletRequest req) {
        NutMap re = new NutMap();
        if (Strings.isBlank(loginName)) 
            return re.setv("ok", false).setv("msg", "请填写用户名!");
        User user = userService.findUserByLoginName(loginName);
        if (null == user) 
        	return re.setv("ok", false).setv("msg", "用户不存在!");
        if (Strings.isBlank(user.getEmail()) || (false == user.isEmailChecked())) 
        	return re.setv("ok", false).setv("msg", "该用户没有进行邮箱验证!");
        	
        String tempSession = IdGen.uuid();
        String token = String.format("%s,%s,%s", user.getId(), tempSession, System.currentTimeMillis());
        token = Toolkit._3DES_encode(emailKEY, token.getBytes());
        String url = req.getRequestURL() + "?token=" + token;
        String html = "<div>如果无法点击，请拷贝一下链接到浏览器中打开<p/>验证链接 %s</div>";
        html = String.format(html, url, url); 
        try {
            boolean ok = emailService.send(user.getEmail(), "淘学网 - 密码修改验证邮件 ( from taoxue.online )", html);
            //boolean ok = true;
            if (!ok) {
                return re.setv("ok", false).setv("msg", "发送失败");
            }
        } catch (Throwable e) {
            log.debug("发送邮件失败", e);
            return re.setv("ok", false).setv("msg", "发送失败");
        }
        req.getSession().setAttribute("userIdTempSession", user.getId());
        req.getSession().setAttribute("tempSession", tempSession);
        return re.setv("ok", true);
    }
	
	/**
	 * 修改密码验证邮件的返回方法
	 * @param token
	 * @param session
	 * @return
	 */
	@Filters(@By(type=CheckSession.class, args={"tempSession", "/index"}))
    @At("/safe/emailPwd")
    @GET
    @Ok("jsp:views.front.msg") 
    public Object emailPwdCallback(@Param("token")String token, HttpSession session) {
        if (Strings.isBlank(token)) {
            return "请不要直接访问这个链接!!!";
        }
        if (token.length() < 10) {
            return "非法token";
        }
        try {
            token = Toolkit._3DES_decode(emailKEY, Toolkit.hexstr2bytearray(token));
            if (token == null)
                return "非法token";
            String[] tmp = token.split(",", 3);
            if (tmp.length != 3 || tmp[0].length() == 0 || tmp[1].length() == 0 || tmp[2].length() == 0)
                return "非法token";
            long time = Long.parseLong(tmp[2]);
            if (System.currentTimeMillis() - time > 10*60*1000) {
                return "该验证链接已经超时";
            }
            
            /*
             * 验证成功，直接跳转修改页面
             */
            return new ViewWrapper(new JspView("views/front/updPwd"), (String) session.getAttribute("tempSession"));
        } catch (Throwable e) {
            log.debug("检查token时出错", e);
            return "非法token";
        }
    }
	
	/**
	 * 修改密码 <br>
	 * 只有验证过邮箱的才可以进入这个方法，验证成功后，该链接失效，不能够再进入，除非再次验证邮箱
	 * @param newPassword
	 * @param session
	 * @return
	 */
	@Filters(@By(type=CheckSession.class, args={"tempSession", "/index"}))
    @At("/safe/changepwd")
	public boolean changepwd (@Param ("newPassword") String newPassword, HttpSession session) {
		boolean flag = userService.changePasswd((String) session.getAttribute("userIdTempSession"), Toolkit.entryptPassword(newPassword));
		if (flag) 
			return true; //密码修改成功
		else return false;
	}
}
