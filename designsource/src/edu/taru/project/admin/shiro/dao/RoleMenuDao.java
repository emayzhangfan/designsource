package edu.taru.project.admin.shiro.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.common.base.BasicDao;
import edu.taru.project.admin.shiro.entity.MenuTreeView;

@IocBean
public class RoleMenuDao extends BasicDao {
	
	/**
	 * 根据管理员ID查询该管理员的菜单权限
	 * @param adminId
	 * @return
	 */
	public List<MenuTreeView> searchMenuByAdminId(String adminId) {
		Sql sql = Sqls.create("select am.* from admin_admin aa, admin_role_menu arm, admin_menu am "+
								"where aa.role_id = arm.role_id "+
								"and am.id = arm.menu_id "+
								"and aa.id = @adminId "+
								"and am.is_show = '1' "+
								"order by am.sort asc");
		sql.params().set("adminId", adminId);
		sql.setCallback(new SqlCallback() {
			public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
				List<MenuTreeView> list = new ArrayList<MenuTreeView>();
				while(rs.next()){
					MenuTreeView menuTreeView = new MenuTreeView();
					menuTreeView.setId(rs.getString("id"));
					menuTreeView.setpId(rs.getString("parent_id"));
					menuTreeView.setName(rs.getString("name"));
					menuTreeView.setUrl(rs.getString("url"));
					list.add(menuTreeView);
				};
				return list;
			}
		});
		dao.execute(sql);
		return sql.getList(MenuTreeView.class);
	}
}
