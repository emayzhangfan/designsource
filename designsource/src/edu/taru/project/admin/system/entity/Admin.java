package edu.taru.project.admin.system.entity;


import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

import edu.taru.common.base.BasicEntity;
import edu.taru.project.admin.shiro.entity.Role;

/**
 * 系统管理员
 * @author iFan
 *
 */
@Table("admin_admin")
public class Admin extends BasicEntity {

	/**
	 * 男
	 */
	public static final String SEX_MAN = "1";
	
	/**
	 * 女
	 */
	public static final String SEX_WOMAN = "2";
	
	@Name
	@Column("id")
	private String id;
	
	/**
	 * 登录名
	 */
	@Column("username")
	private String username;
	
	@Column("password")
	private String password;
	
	/**
	 * 姓名
	 */
	@Column("name")
	private String name;
	
	/**
	 * 性别 男1，女2
	 */
	@Column("sex")
	private String sex;
	
	@Column("phone")
	private String phone;
	
	/**
	 * 角色
	 */
	@Column("role_id")
	private String roleId;
	@One(target = Role.class, field = "roleId")
	private Role role;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}
	
	
}
