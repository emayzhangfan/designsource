package edu.taru.project.admin.goods.entity;

import java.math.BigInteger;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

import edu.taru.common.base.BasicEntity;
import edu.taru.project.admin.classification.entity.Classification;
import edu.taru.project.admin.user.entity.User;

/**
 * 发布的二手信息
 * @author 张帆
 *
 */
@Table("tx_publish_goods_info")
public class Goods extends BasicEntity {
	
	/**
	 * 默认正常状态
	 */
	public static final Integer DEFAULT = 1;
	
	/**
	 * 垃圾信息
	 */
	public static final Integer RUBBISH = 2;
	
	@Name
	@Column("id")
	private String id;
	
	@Column("name")
	private String name;
	
	@Column("title")
	private String title;
	
	@Column("show_img_url")
	private String showImgUrl;
	
	@Column("classification_id")
	private String classificationId;
	@One(target = Classification.class, field = "classificationId")
	private Classification classification;
	
	/**
	 * 冗余检索字段
	 */
	@Column("classification_name")
	private String classificationName;
	
	@Column("price")
	private Double price;
	
	@Column("user_id")
	private String userId;
	@One(target = User.class, field = "userId")
	private User user;
	
	@Column("descriptions")
	private String descriptions;
	
	/**
	 * 信息状态 1正常，2不正常
	 */
	@Column("status")
	private Integer status;
	
	/**
	 * 收藏量
	 */
	@Column("collection_total")
	private BigInteger collectionTotal;
	
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
	public String getShowImgUrl() {
		return showImgUrl;
	}
	public void setShowImgUrl(String showImgUrl) {
		this.showImgUrl = showImgUrl;
	}
	public String getClassificationId() {
		return classificationId;
	}
	public void setClassificationId(String classificationId) {
		this.classificationId = classificationId;
	}
	public Classification getClassification() {
		return classification;
	}
	public void setClassification(Classification classification) {
		this.classification = classification;
	}
	public String getClassificationName() {
		return classificationName;
	}
	public void setClassificationName(String classificationName) {
		this.classificationName = classificationName;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescriptions() {
		return descriptions;
	}
	public void setDescriptions(String descriptions) {
		this.descriptions = descriptions;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public BigInteger getCollectionTotal() {
		return collectionTotal;
	}
	public void setCollectionTotal(BigInteger collectionTotal) {
		this.collectionTotal = collectionTotal;
	}
	
}
