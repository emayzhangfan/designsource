package edu.taru.project.admin.shiro.web;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.nutz.aop.interceptor.ioc.TransAop;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import edu.taru.common.Constants;
import edu.taru.common.utils.IdGen;
import edu.taru.mvc.AdminCheckSession;
import edu.taru.project.admin.shiro.entity.MenuTreeView;
import edu.taru.project.admin.shiro.entity.RoleMenu;
import edu.taru.project.admin.shiro.service.RoleMenuService;
import edu.taru.project.admin.system.entity.Admin;

@IocBean
@At("/admin/shiro/")
@Filters(@By(type=AdminCheckSession.class))
public class RoleMenuController {

	@Inject
	private RoleMenuService roleMenuService;
	
	/**
	 * 查询该登陆人的菜单权限
	 * 页面ajax方法，返回json
	 * @param session
	 * @return
	 */
	@Ok("json")
	@At("ajax/menuTree")
	public Object menuTree(HttpSession session){
		Admin admin = (Admin) session.getAttribute("admin");
		List<MenuTreeView> list = roleMenuService.searchMenuByAdminId(admin.getId());
		/*关闭二级菜单*/
		for (MenuTreeView menuTreeView : list) {
			if("object".equals(menuTreeView.getpId()))
				menuTreeView.setOpen(Constants.FALSE);
		}
		return list;
	}
	
	@Ok("json")
	@At("ajax/saveRoleMenu")
	@Aop(TransAop.READ_COMMITTED)
	public boolean saveRoleMenu(@Param("roleId")String roleId, @Param("menuIds")String [] menuIds){
		int row = roleMenuService.delByRole(roleId);
		if(null != menuIds){
			for (int i = 0; i < menuIds.length; i++) {
				RoleMenu roleMenu = new RoleMenu();
				roleMenu.setId(IdGen.uuid());//设置主键
				roleMenu.setRoleId(roleId);//设置角色
				roleMenu.setMenuId(menuIds[i]);//设置菜单
				roleMenuService.save(roleMenu);
			}
			return true;
		}
		return row >= 0;
	}
	
}
