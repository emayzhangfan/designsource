package edu.taru.project.admin.shiro.service;

import java.util.List;

import org.nutz.aop.interceptor.ioc.TransAop;
import org.nutz.dao.Cnd;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.common.base.BasicService;
import edu.taru.project.admin.shiro.dao.RoleDao;
import edu.taru.project.admin.shiro.entity.Role;
import edu.taru.project.admin.shiro.entity.RoleMenu;

@IocBean
public class RoleService extends BasicService<Role> {

	@Inject
	private RoleDao roleDao;
	
	/**
	 * 查询所有角色
	 * @return
	 */
	public List<Role> findAll(){
		return roleDao.search(Role.class, Cnd.NEW().asc("create_date"));
	}
	
	/**
	 * 临时删除方法 还没有测试
	 * @param id
	 * @return
	 */
	@Aop(TransAop.READ_COMMITTED)
	public boolean delete(String id){
		/*删除自身*/
		boolean flag1 = delete(id, Role.class);
		/*删除关联对象 角色菜单中间表*/
		boolean flag2 = delByCnd(RoleMenu.class, Cnd.where("role_id", "=", id));
		if(flag1 && flag2)
			return true;
		return false;
	}

}
