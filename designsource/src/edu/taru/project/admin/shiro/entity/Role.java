package edu.taru.project.admin.shiro.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import edu.taru.common.base.BasicEntity;

/**
 * 角色
 * @author iFan
 *
 */
@Table("admin_role")
public class Role extends BasicEntity {

	@Name
	@Column("id")
	private String id;
	
	@Column("name")
	private String name;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
