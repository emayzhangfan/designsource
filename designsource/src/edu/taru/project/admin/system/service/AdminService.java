package edu.taru.project.admin.system.service;

import java.util.List;

import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.common.Page;
import edu.taru.common.base.BasicService;
import edu.taru.common.utils.StringUtils;
import edu.taru.project.admin.system.dao.AdminDao;
import edu.taru.project.admin.system.entity.Admin;

@SuppressWarnings("deprecation")
@IocBean
public class AdminService extends BasicService<Admin>{

	@Inject
	private AdminDao adminDao;
	
	/**
	 * 根据主键获取对象 并关联
	 * @param id
	 * @return
	 */
	public Admin getLink(String id) {
		Admin admin = adminDao.find(Admin.class, id);
		adminDao.findLink(admin, "role");
		return admin;
	}

	/**
	 * 根据登录名查询该对象
	 * @param loginName
	 * @return
	 */
	public Admin findUserByLoginName(String loginName){
		return adminDao.findByCondition(Admin.class, Cnd.where("username", "=", loginName));
	}
	
	/**
	 * 分页查询用户信息
	 * @param admin
	 * @param page
	 * @return
	 */
	@Deprecated
	public Page<Admin> find(Admin admin, Page<Admin> page){
		Cnd cnd=Cnd.NEW();
		if(StringUtils.isNotEmpty(admin.getName())){
			cnd.and("name", "like", "%"+admin.getName()+"%");
		}
		//cnd.asc("create_date");
		List<Admin> list = adminDao.searchByPage(Admin.class, cnd, page.getCurrentPage(), page.getPageSize());
		adminDao.findLink(list, "role");
		page.setList(list);
		page.setTotalCount(adminDao.searchCount(Admin.class, cnd));
		return page;
	}
	
	/**
	 * 根据id修改用户密码
	 * @param id
	 * @param password
	 * @return
	 */
	public boolean changePasswd(String id, String password){
		return adminDao.update(Admin.class, Chain.make("password", password), Cnd.where("id", "=", id));
	}
	
	/**
	 * 修改角色
	 * @param id
	 * @param roleId
	 * @return
	 */
	public boolean changeRole(String id, String roleId){
		return adminDao.update(Admin.class, Chain.make("role_id", roleId), Cnd.where("id", "=", id));
	}
	
}
