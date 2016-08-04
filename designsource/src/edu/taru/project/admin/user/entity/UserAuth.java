package edu.taru.project.admin.user.entity;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

/**
 * 认证记录
 * @author zhangfan
 *
 */
@Table("tx_authentication")
public class UserAuth {

	/**
	 * 未认证
	 */
	public static final Integer NO_AUTH = 1;
	
	/**
	 * 认证通过
	 */
	public static final Integer PASS_AUTH = 2;
	
	/**
	 * 认证驳回
	 */
	public static final Integer DOWN_AUTH = 3;
	
	public UserAuth() {
		super();
	}
	
	public UserAuth (String id, String userId, String authImgUrl, int status, Date createDate) {
		super();
		this.id = id;
		this.userId = userId;
		this.authImgUrl = authImgUrl;
		this.status = status;
		this.createDate = createDate;
	}
	
	public UserAuth (int status) {
		super();
		this.status = status;
	}
	
	@Name
	@Column("id")
	private String id;
	
	@Column("user_id")
	private String userId;
	@One(target = User.class, field = "userId")
	private User user;
	
	@Column("auth_img_url")
	private String authImgUrl;
	
	@Column("create_date")
	private Date createDate;
	
	/**
	 * 未认证1，认证通过2，认证驳回3
	 */
	@Column("status")
	private Integer status;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getAuthImgUrl() {
		return authImgUrl;
	}

	public void setAuthImgUrl(String authImgUrl) {
		this.authImgUrl = authImgUrl;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	
}
