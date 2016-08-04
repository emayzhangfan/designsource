package edu.taru.project.admin.help;

import javax.servlet.http.HttpSession;

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

import edu.taru.common.Constants;
import edu.taru.common.utils.StringUtils;
import edu.taru.common.utils.Toolkit;
import edu.taru.mvc.AdminCheckSession;
import edu.taru.project.admin.system.entity.Admin;
import edu.taru.project.admin.system.service.AdminService;

@IocBean
@At("/admin/help/")
@Ok("json")
@Filters(@By(type=AdminCheckSession.class))
public class HelpController {
	
	@Inject
	private AdminService adminService;
	
	/**
	 * View 修改个人密码
	 * @param msg
	 * @return
	 */
	public View changepwd (String msg) {
		return new ViewWrapper(new JspView("views/admin/changepwd"), msg); 
	}
	
	/**
	 * View 查看/修改个人信息
	 * @param msg
	 * @return
	 */
	public View adminInfo (Admin admin) {
		return new ViewWrapper(new JspView("views/admin/adminInfo"), admin); 
	}
	
	/**
	 * View 联系方式，暂时写死，时间充裕的情况下可修改成灵活的
	 * @return
	 */
	@At("contactInfo")
	public View contactInfo () {
		return new ViewWrapper(new JspView("views/admin/contactInfo"), null); 
	}
	
	/**
	 * View 个人消息，这个功能暂时不做
	 * @return
	 */
	@Deprecated
	@At("message")
	public View message () {
		return new ViewWrapper(new JspView("views/admin/message"), null); 
	}
	
	/**
	 * 修改密码 保存
	 * @param session
	 * @param oldPassword
	 * @param newPassword
	 * @return
	 */
	@At("changepwd")
	public View updatePassword(HttpSession session, @Param("oldPassword")String oldPassword, @Param("newPassword")String newPassword){
		Admin admin = (Admin) session.getAttribute("admin");
		Admin newAdmin = adminService.get(Admin.class, admin.getId());//session数据没有实时性，从新get一次
		String msg = null;
		/**
		 * 1旧密码解密处理，看是否与输入旧密码一致，2一致后，新密码加密保存
		 */
		if(StringUtils.isNotBlank(newPassword)&&StringUtils.isNotBlank(oldPassword)){
			if(Toolkit.validatePassword(oldPassword,newAdmin.getPassword())){
				String newMiMa = Toolkit.entryptPassword(newPassword);
				adminService.changePasswd(newAdmin.getId(),newMiMa);
				msg = Constants.UPDATE_PASSWORD_SUCCESS;
			}else{
				msg = Constants.UPDATE_PASSWORD_FAILE;
			}
		}
		return changepwd(msg);
	}
	
	/**
	 * 个人信息查看修改
	 * @param session
	 * @param admin
	 * @return
	 */
	@At("adminInfo")
	public View adminInfo(HttpSession session, @Param("..") Admin admin){
		Admin sessionGet = (Admin) session.getAttribute("admin");
		Admin newAdmin = adminService.getLink(sessionGet.getId());//session数据没有实时性，从新get一次
		if(StringUtils.isNotBlank(admin.getId())){
			if(adminService.update(admin))
				return adminInfo(adminService.getLink(admin.getId()));
			else return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
		}
		return adminInfo(newAdmin);
	}
	
	/**
	 * 判断用户密码是否为默认密码
	 * @param session
	 * @return boolean
	 */
	@At("checkDefaultPassword")
	public boolean checkDefaultPassword(HttpSession session){
		Admin sessionAdmin = (Admin) session.getAttribute("admin");
		if (Toolkit.validatePassword(Constants.DEFAULT_PASSWORD, sessionAdmin.getPassword())) 
			return true;//是默认密码
		return false;
	}
	
}
 