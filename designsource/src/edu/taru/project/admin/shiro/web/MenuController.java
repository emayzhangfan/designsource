package edu.taru.project.admin.shiro.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import edu.taru.common.utils.IdGen;
import edu.taru.common.utils.StringUtils;
import edu.taru.mvc.AdminCheckSession;
import edu.taru.project.admin.shiro.entity.Menu;
import edu.taru.project.admin.shiro.entity.MenuTreeView;
import edu.taru.project.admin.shiro.entity.RoleMenu;
import edu.taru.project.admin.shiro.service.MenuService;
import edu.taru.project.admin.shiro.service.RoleMenuService;
import edu.taru.project.admin.system.entity.Admin;


@IocBean
@At("/admin/shiro/")
@Filters(@By(type=AdminCheckSession.class))
public class MenuController {

	@Inject
	private MenuService menuService;
	
	@Inject
	private RoleMenuService roleMenuService;
	
	/**
	 * 根据主键 获取该对象
	 * @param id
	 * @return
	 */
	@Ok("json")
	@At("menu/get")
	public Menu get(@Param("id")String id){
		Menu menu = menuService.get(Menu.class, id);
		menuService.basicDao.findLink(menu, "parent");
		return menu;
	}
	
	/**
	 * 菜单信息 
	 * @param menu
	 * @param currentPage
	 * @return
	 */
	@At("menu/record")
    public View menuRecord(@Param("..")Menu menu) {
		Map<String,Object> params = Maps.newHashMap();
		QueryResult qr = menuService.findByPage(Menu.class, Cnd.NEW().asc("sort"), 0, 0);
		params.put("qr", qr);
		params.put("menu", menu);
		return new ViewWrapper(new JspView("views/admin/shiro/menuRecord"), params);	
    }
	
	/**
	 * 菜单删除
	 * @param id
	 * @return
	 */
	@At("menu/delete")
	@Aop(TransAop.READ_COMMITTED)
	public View delete(String id){
		List<Menu> childrens = menuService.getChildrens(id);
		
		/*删除自身*/
		boolean flag1 = menuService.delete(id, Menu.class);
		/*删除孩子*/
		boolean flag2 = menuService.delByCnd(Menu.class, Cnd.where("parent_id", "=", id));
		
		/*删除关联对象 角色菜单中间表*/
		boolean flag3 = true;
		for (Menu menu : childrens) {
			boolean flag = roleMenuService.delByCnd(RoleMenu.class, Cnd.where("menu_id", "=", menu.getId()));
			if(!flag)
				flag3 = false;
		}
		
		if(flag1 && flag2 && flag3)
			return menuRecord(new Menu());	
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
	
	/**
	 * 查询所有菜单 用于zTree
	 * 页面ajax方法，返回json
	 * @return
	 */
	@Ok("json")
	@At("ajax/allMenu")
	public Object allMenu(@Param("roleId")String roleId){
		List<MenuTreeView> tree = new ArrayList<MenuTreeView>();
		List<Menu> list = menuService.findAll();
		for (Menu menu : list) {
			MenuTreeView mt = new MenuTreeView();
			mt.setId(menu.getId());
			mt.setName(menu.getName());
			mt.setpId(menu.getParentId());
			if (StringUtils.isNotBlank(roleId)) {
				int row = roleMenuService.searchCount(roleId, menu.getId());
				if(row == 1) mt.setChecked(Constants.TRUE);
			}
			tree.add(mt);
		}
		/*关闭二级菜单*/
		for (MenuTreeView menuTreeView : tree) {
			if("object".equals(menuTreeView.getpId()))
				menuTreeView.setOpen(Constants.FALSE);
		}
		return tree;
	}
	
	/**
	 * 菜单录入
	 * @param menu
	 * @param session
	 * @return
	 */
	@At("menu/add")
	public View add(@Param("..")Menu menu, HttpSession session){
		Admin nowAdmin = (Admin)session.getAttribute("admin");//当前登陆人
		
		menu.setId(IdGen.uuid());//设置主键
		menu.setCreateBy(nowAdmin.getId());//设置创建人
		menu.setCreateDate(new Date());//设置创建时间
		Menu parent = menuService.get(Menu.class, menu.getParentId());
		menu.setParent(parent);
		menu.setParentIds(menu.getParent().getParentIds() + menu.getParent().getId() + ",");
		
		Menu newMenu = menuService.save(menu);//保存
		
		if(null != newMenu) 
			return menuRecord(new Menu());
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
	
	/**
	 * 菜单修改
	 * @param menu
	 * @return
	 */
	@At("menu/update")
	public View update(@Param("..")Menu menu){
		boolean flag = menuService.update(menu);
		if(flag) 
			return menuRecord(new Menu());
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
	
}
