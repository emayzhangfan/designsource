/**
 * 
 */
package edu.taru.project.front.service;

import org.nutz.dao.Cnd;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.common.base.BasicService;
import edu.taru.project.front.dao.UserCollectionDao;
import edu.taru.project.front.pojo.UserCollection;

/**
 * @author 张帆
 * 2016年3月24日
 */
@IocBean
public class UserCollectionService extends BasicService<UserCollection> {

	@Inject 
	private UserCollectionDao userCollectionDao;
	
	public int searchCount (String userId, String goodsId) {
		return userCollectionDao.searchCount(UserCollection.class, Cnd.where("user_id", "=", userId).and("goods_id", "=", goodsId));
	}

	public int collectionTotalBygoodsId (String goodsId) {
		return userCollectionDao.searchCount(UserCollection.class, Cnd.where("goods_id", "=", goodsId));
	}
}
