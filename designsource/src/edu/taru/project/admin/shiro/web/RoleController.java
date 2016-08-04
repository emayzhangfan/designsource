package edu.taru.project.admin.shiro.web;

import java.util.Date;
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
import edu.taru.mvc.AdminCheckSession;
import edu.taru.project.admin.shiro.entity.Role;
import edu.taru.project.admin.shiro.entity.RoleMenu;
import edu.taru.project.admin.shiro.service.RoleMenuService;
import edu.taru.project.admin.shiro.service.RoleService;
import edu.taru.project.admin.system.entity.Admin;

@IocBean
@At("/admin/shiro/")
@Filters(@By(type=AdminCheckSession.class))
public class RoleController {

	@Inject
	private RoleService roleService;
	
	@Inject
	private RoleMenuService roleMenuService;
	
	/**
	 * 查询所有角色 用于下拉列表
	 * 页面ajax方法，返回json
	 * @return
	 */
	@Ok("json")
	@At("ajax/allRole")
	public Object allRole(){
		return roleService.findAll();
	}
	
	/**
	 * 角色信息
	 * @param role
	 * @return
	 */
	@At("role/record")
    public View roleRecord(@Param("..")Role role, @Param("pageNumber")int pageNumber) {
		Map<String,Object> params = Maps.newHashMap();
		if(0 == pageNumber)
			pageNumber = 1;
		QueryResult qr = roleService.findByPage(Role.class, Cnd.NEW().asc("create_date"), pageNumber, 5);
		params.put("qr", qr);
		params.put("role", role);
		return new ViewWrapper(new JspView("views/admin/shiro/roleRecord"), params);	
    }
	
	/**
	 * 角色录入
	 * @param role
	 * @param pageNumber
	 * @param session
	 * @return
	 */
	@At("role/add")
	public View add(@Param("..")Role role, @Param("pageNumber")int pageNumber, HttpSession session){
		Admin nowAdmin = (Admin)session.getAttribute("admin");//当前登陆人
		role.setId(IdGen.uuid());//设置主键
		role.setCreateBy(nowAdmin.getId());//设置创建人
		role.setCreateDate(new Date());//设置创建时间
		
		Role newRole = roleService.save(role);//保存
		
		if(null != newRole)
			return roleRecord(new Role(), pageNumber);
		
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
	
	/**
	 * 根据主键 获取该对象
	 * @param id
	 * @return
	 */
	@Ok("json")
	@At("role/get")
	public Role get(@Param("id")String id){
		return roleService.get(Role.class, id);
	}
	
	/**
	 * 角色修改
	 * @param role
	 * @param pageNumber
	 * @return
	 */
	@At("role/update")
	public View update(@Param("..")Role role, @Param("pageNumber")int pageNumber){
		boolean flag = roleService.update(role);
		if(flag) 
			return roleRecord(new Role(), pageNumber);
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
	
	/**
	 * 角色删除
	 * @param id
	 * @return
	 */
	@At("role/delete")
	@Aop(TransAop.READ_COMMITTED)
	public View delete (final String id, @Param("pageNumber")int pageNumber){
		/*删除自身*/
		boolean flag1 = roleService.delete(id, Role.class);
		/*删除关联对象 角色菜单中间表*/
		boolean flag2 = roleMenuService.delByCnd(RoleMenu.class, Cnd.where("role_id", "=", id));
		if(flag1 && flag2)
			return roleRecord(new Role(), pageNumber);	
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
		
//		Trans.exec(new Atom(){
//		    public void run() {
//		    	boolean flag = roleService.delete(id);
//		    }
//		});
		
	}

}
