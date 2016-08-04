package edu.taru.project.admin.system.entity;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * 公告牌
 * @author iFan
 *
 */
@Table("admin_bulletin")
public class Bulletin {

	@Name
	@Column("id")
	private String id;
	
	@Column("message")
	private String message;
	
	@Column("date")
	private Date date;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	
	
}
