package edu.taru.project.admin.shiro.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * 角色-用户
 * @author iFan
 *
 */
@Deprecated
@Table("admin_role_admin")
public class RoleAdmin {

	@Name
	@Column("id")
	private String id;
	
	@Column("role_id")
	private String roleId;
	
	@Column("admin_id")
	private String adminId;
	
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

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	
}
