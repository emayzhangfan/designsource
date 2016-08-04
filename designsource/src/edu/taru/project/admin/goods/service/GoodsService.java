package edu.taru.project.admin.goods.service;

import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.common.base.BasicService;
import edu.taru.project.admin.goods.dao.GoodsDao;
import edu.taru.project.admin.goods.entity.Goods;

@IocBean
public class GoodsService extends BasicService<Goods> {

	/**
	 * 枚举类型
	 * 用于修改收藏量 添加或者修改
	 * @author zhangfan
	 *
	 */
	public enum Collection {
		
		ADD_COLLECTION ("+"), 
		
		SUBTRACT_COLLECTION ("-");

		private final String value;
		
		Collection (String value) {
			this.value = value;
		}
		
		public String getValue() {
            return value;
        }
	}

	@Inject 
	private GoodsDao goodsDao;
	
	public Goods get (String id) {
		Goods bean = super.get(Goods.class, id);
		goodsDao.findLink(bean, null);
		return bean;
	}
	
	/**
	 * 修改收藏量 (+/-) 1
	 * @param goodsId
	 * @param collection
	 * @return
	 */
	public boolean updateCollection (String goodsId, Collection collection) {
		return goodsDao.update(Goods.class, 
				Chain.makeSpecial("collection_total", collection.getValue() + 1),
				Cnd.where("id", "=", goodsId));
	}
}
