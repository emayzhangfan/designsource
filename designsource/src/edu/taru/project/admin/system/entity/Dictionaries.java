package edu.taru.project.admin.system.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

import edu.taru.common.base.BasicEntity;

/**
 * 数据字典
 * @author 张帆
 *
 */
@Table("admin_dictionaries")
public class Dictionaries extends BasicEntity {

	@Name
	@Column("id")
	private String id;
	
	/**
	 * 数据值
	 */
	@Column("value")
	private String value;
	
	/**
	 * 标签名
	 */
	@Column("lable")
	private String lable;
	
	/**
	 * 类型
	 */
	@Column("type")
	private String type;
	
	/**
	 * 描述
	 */
	@Column("description")
	private String description;
	
	/**
	 * 排序
	 */
	@Column("sort")
	private String sort;
	
	/**
	 * 父级编号
	 */
	@Column("parent_id")
	private String parentId;
	@One(target = Dictionaries.class, field = "parentId")
	private Dictionaries parent;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getLable() {
		return lable;
	}

	public void setLable(String lable) {
		this.lable = lable;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public Dictionaries getParent() {
		return parent;
	}

	public void setParent(Dictionaries parent) {
		this.parent = parent;
	}
	
	
}
