package edu.taru.project.admin.shiro.service;

import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.common.base.BasicService;
import edu.taru.project.admin.shiro.dao.RoleMenuDao;
import edu.taru.project.admin.shiro.entity.MenuTreeView;
import edu.taru.project.admin.shiro.entity.RoleMenu;

@IocBean
public class RoleMenuService extends BasicService<RoleMenu> {

	@Inject
	private RoleMenuDao roleMenuDao;

	
	/**
	 * 根据角色查询菜单
	 * @param roleId
	 * @return
	 */
	public List<RoleMenu> menuTree(String roleId){
		Cnd cnd = Cnd.where("role_id", "=", roleId);
		cnd.and("is_show", "=", "1");
		List<RoleMenu> list = roleMenuDao.search(RoleMenu.class, cnd);//查询中间表
		roleMenuDao.findLink(list, "menu");//查询关联数据
		return list;
	}
	
	/**
	 * 根据管理员ID查询该管理员的菜单权限
	 * @param adminId
	 * @return
	 */
	public List<MenuTreeView> searchMenuByAdminId(String adminId) {
		return roleMenuDao.searchMenuByAdminId(adminId);
	}
	
	/**
	 * 查询数据条数 根据角色和菜单
	 * @param roleId
	 * @param menuId
	 * @return
	 */
	public int searchCount(String roleId, String menuId){
		return roleMenuDao.searchCount(RoleMenu.class, Cnd.where("role_id", "=", roleId).and("menu_id", "=", menuId));
	}
	
	/**
	 * 根据角色ID删除
	 * @param roleId
	 */
	public int delByRole(String roleId){
		return roleMenuDao.delByCnd(RoleMenu.class, Cnd.where("role_id", "=", roleId));
	}
}
