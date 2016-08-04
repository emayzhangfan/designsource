/**
 * 
 */
package edu.taru.project.front.pojo;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.PK;
import org.nutz.dao.entity.annotation.Table;

import edu.taru.project.admin.goods.entity.Goods;
import edu.taru.project.admin.user.entity.User;

/**
 * 我的收藏
 * @author 张帆
 * 2016年3月24日
 */
@Table("tx_user_collection")
@PK( {"userId", "goodsId"} )
public class UserCollection {

	public UserCollection () {};
	public UserCollection (String userId, String goodsId, Date createDate) {
		this.userId = userId;
		this.goodsId = goodsId;
		this.createDate = createDate;
	}
	
	@Column("user_id")
	private String userId;
	@One(target = User.class, field = "userId")
	private User user;
	
	@Column("goods_id")
	private String goodsId;
	@One(target = Goods.class, field = "goodsId")
	private Goods goods;
	
	@Column("create_date")
	public Date createDate;	
	
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
	public String getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}
	public Goods getGoods() {
		return goods;
	}
	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	
}
