package edu.taru.project.admin.shiro.service;

import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.util.cri.SqlExpressionGroup;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.common.base.BasicService;
import edu.taru.project.admin.shiro.dao.MenuDao;
import edu.taru.project.admin.shiro.entity.Menu;

@IocBean
public class MenuService extends BasicService<Menu> {

	@Inject
	private MenuDao menuDao;
	
	/**
	 * 查询所有菜单
	 * @return
	 */
	public List<Menu> findAll(){
		return menuDao.search(Menu.class, Cnd.NEW().asc("sort"));
	}
	
	/**
	 * 查询所有孩子节点
	 * SELECT * FROM admin_menu  WHERE id=? OR (parent_id=? OR parent_ids LIKE ?)
	 * @param id
	 * @return
	 */
	public List<Menu> getChildrens(String id){
		Cnd cnd = Cnd.where("id", "=", id);
		SqlExpressionGroup e = Cnd.exps("parent_id", "=", id).or("parent_ids", "like", "%"+ id +"%");
		cnd.or(e);
		return menuDao.search(Menu.class, cnd);
	}
	
}
