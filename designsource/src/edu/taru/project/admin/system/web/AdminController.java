package edu.taru.project.admin.system.web;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import edu.taru.common.utils.IdGen;
import edu.taru.common.utils.Toolkit;
import edu.taru.mvc.AdminCheckSession;
import edu.taru.project.admin.shiro.entity.Role;
import edu.taru.project.admin.shiro.service.RoleService;
import edu.taru.project.admin.system.entity.Admin;
import edu.taru.project.admin.system.service.AdminService;

/**
 * 后台 用户管理 
 * @author iFan
 *
 */
@IocBean
@At("/admin/system/")
@Ok("json")
@Filters(@By(type=AdminCheckSession.class))
public class AdminController {

	@Inject
	private AdminService adminService;
	
	@Inject
	private RoleService roleService;
	
	@At("admin/get")
	public Admin get(@Param("id")String id){
		Admin admin = adminService.get(Admin.class, id);
		adminService.basicDao.findLink(admin, null);
		return admin;
	}
	
	/**
	 * 管理员信息
	 * @param admin 检索条件
	 * @param pageNumber 当前页
	 * @return
	 */
	@At("admin/record")
    public View adminRecord(@Param("..")Admin admin, @Param("pageNumber")int pageNumber) {
		Map<String,Object> params = Maps.newHashMap();
		if(0 == pageNumber)
			pageNumber = 1;
		QueryResult qr = adminService.findByPage(Admin.class, Cnd.NEW().asc("create_date"), pageNumber, 5);
		List<Role> roleList = roleService.findAll();
		params.put("qr", qr);
		params.put("admin", admin);
		params.put("roleList", roleList);
		return new ViewWrapper(new JspView("views/admin/system/adminRecord"), params);	
    }
	
	/**
	 * 管理员删除
	 * @param id 主键ID
	 * @param pageNumber 当前页 
	 * @return
	 */
	@At("admin/delete")
	public View delete(@Param("id")String id, @Param("pageNumber")int pageNumber, HttpSession session){
		Admin nowAdmin = (Admin)session.getAttribute("admin");//当前登陆人
		if(!id.equals(nowAdmin.getId())){//不能删除当前登陆用户
			boolean flag = adminService.delete(id, Admin.class);
			if(flag)
				return adminRecord(new Admin(), pageNumber);	
			else
				return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
		}
		return new ViewWrapper(new JspView("views/admin/error"), Constants.NOT_DELETE_OWN);
	}
	
	/**
	 * 管理员录入
	 * @param admin
	 * @param pageNumber
	 * @param session
	 * @return
	 */
	@At("admin/add")
	public View add(@Param("..")Admin admin, @Param("pageNumber")int pageNumber, HttpSession session){
		Admin nowAdmin = (Admin)session.getAttribute("admin");//当前登陆人
		
		admin.setId(IdGen.uuid());//设置主键
		admin.setPassword(Toolkit.entryptPassword(Constants.DEFAULT_PASSWORD));//设置默认密码123456
		admin.setCreateBy(nowAdmin.getId());//设置创建人
		admin.setCreateDate(new Date());//设置创建时间
		
		Admin newAdmin = adminService.save(admin);//保存
		
		if(null != newAdmin)
			return adminRecord(new Admin(), pageNumber);
		
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
	
	/**
	 * 重置为默认密码
	 * @param id
	 * @param pageNumber
	 * @return
	 */
	@At("admin/changePasswd")
	public View changePasswd(@Param("id")String id, @Param("pageNumber")int pageNumber){
		boolean flag = adminService.changePasswd(id, Toolkit.entryptPassword(Constants.DEFAULT_PASSWORD));
		if(flag)
			return adminRecord(new Admin(), pageNumber);	
		
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}

	/**
	 * 修改角色
	 * @param id
	 * @param roleId
	 * @param pageNumber
	 * @return
	 */
	@At("admin/changeRole")
	public View changeRole(@Param("id")String id, @Param("roleId")String roleId, @Param("pageNumber")int pageNumber){
		boolean flag = adminService.changeRole(id, roleId);
		if(flag)
			return adminRecord(new Admin(), pageNumber);	
		
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
	
	/**
	 * 验证用户名是否存在
	 * @param loginName
	 * @return
	 */
	@At("admin/validateLoginname")
	public boolean validateLoginname (String loginName) {
		if (null != adminService.findUserByLoginName(loginName)) 
			return true;//存在
		return false;
	}
}
