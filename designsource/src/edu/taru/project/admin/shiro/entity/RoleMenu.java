package edu.taru.project.admin.shiro.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

/**
 * 角色-菜单
 * @author iFan
 *
 */
@Table("admin_role_menu")
public class RoleMenu {

	@Name
	@Column("id")
	private String id;
	
	@Column("role_id")
	private String roleId;
	@One(target = Role.class, field = "roleId")
	private Role role;
	
	@Column("menu_id")
	private String menuId;
	@One(target = Menu.class, field = "menuId")
	private Menu menu;
	
	@Column("remarks")
	private String remarks;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}
	
	

}
