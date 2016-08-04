package edu.taru.project.admin.user.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import edu.taru.common.base.BasicEntity;

/**
 * 会员
 * @author iFan
 *
 */
@Table("tx_user")
public class User extends BasicEntity {

	/**
	 * 男
	 */
	public static final String SEX_MAN = "1";
	
	/**
	 * 女
	 */
	public static final String SEX_WOMAN = "2";
	
	/**
	 * 未认证
	 */
	public static final Integer NO_AUTH = 1;
	
	/**
	 * 待认证
	 */
	public static final Integer WAIT_AUTH = 2;
	
	/**
	 * 认证通过
	 */
	public static final Integer PASS_AUTH = 3;
	
	/**
	 * 认证驳回
	 */
	public static final Integer DOWN_AUTH = 4;
	
	/**
	 * 黑名单
	 */
	public static final Integer BLACK = 5;
	
	@Name
	@Column("id")
	private String id;
	
	/**
	 * 登录名
	 */
	@Column("loginname")
	private String loginName;
	
	@Column("password")
	private String password;
	
	/**
	 * 头像的url
	 */
	@Column("avatar")
	private String avatar;
	
	@Column("card_id")
	private String cardId;
	
	/**
	 * 用户昵称
	 */
	@Column("username")
	private String username;
	
	@Column("name")
	private String name;
	
	/**
	 * 性别 男1，女2
	 */
	@Column("sex")
	private String sex;
	
	@Column("phone")
	private String phone;
	
	@Column("qq")
	private String qq;

	/**
	 * 用户状态（未认证1，待认证2，认证通过3，认证驳回4，黑名单5）
	 */
	@Column("status")
	private Integer status;
	
	/**用户邮箱*/
    @Column("email")
    private String email;
	
	/**邮箱是否已经验证过*/
    @Column("email_checked")
    private boolean emailChecked;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getCardId() {
		return cardId;
	}

	public void setCardId(String cardId) {
		this.cardId = cardId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
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

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public boolean isEmailChecked() {
		return emailChecked;
	}

	public void setEmailChecked(boolean emailChecked) {
		this.emailChecked = emailChecked;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}
	
	
}
