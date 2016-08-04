package edu.taru.project.admin.classification.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

import edu.taru.common.base.BasicEntity;

@Table("tx_classification")
public class Classification extends BasicEntity {

	@Name
	@Column("id")
	private String id;
	
	@Column("name")
	private String name;
	
	@Column("parent_id")
	private String parentId;
	@One(target = Classification.class, field = "parentId")
	private Classification parent;
	
	@Column("parent_ids")
	private String parentIds;
	
	@Column("sort")
	private Integer sort;
	
	@Column("url")
	private String url;

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

	public Classification getParent() {
		return parent;
	}

	public void setParent(Classification parent) {
		this.parent = parent;
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
	
	
}
