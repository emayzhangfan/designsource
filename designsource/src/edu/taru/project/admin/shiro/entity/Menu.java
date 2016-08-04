package edu.taru.project.admin.shiro.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

import edu.taru.common.base.BasicEntity;

/**
 * 权限菜单实体
 * @author iFan
 *
 */
@Table("admin_menu")
public class Menu extends BasicEntity {

	/**
	 * 显示
	 */
	public static final String SHOW_TRUE = "1";
	
	/**
	 * 隐藏
	 */
	public static final String SHOW_FALSE = "0";
	
	@Name
	@Column("id")
	private String id;
	
	@Column("name")
	private String name;
	
	@Column("parent_id")
	private String parentId;
	@One(target = Menu.class, field = "parentId")
	private Menu parent;
	
	@Column("parent_ids")
	private String parentIds;
	
	@Column("sort")
	private Integer sort;
	
	@Column("url")
	private String url;
	
	/**
	 * 控制显隐，0为隐藏，1为显示
	 */
	@Column("is_show")
	private String isShow;
	
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

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getIsShow() {
		return isShow;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	public Menu getParent() {
		return parent;
	}

	public void setParent(Menu parent) {
		this.parent = parent;
	}
	
	
}
