package edu.taru.project.front.service;

import java.util.List;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.common.base.BasicService;
import edu.taru.project.admin.goods.dao.GoodsDao;
import edu.taru.project.admin.goods.entity.Goods;
import edu.taru.project.front.dao.SearchTextDao;
import edu.taru.project.front.pojo.SearchSelectVO;

/**
 * 
 * @author zhangfan
 *
 */
@IocBean
public class SearchTextService extends BasicService<SearchSelectVO> {

	@Inject 
	private SearchTextDao searchTextDao;
	
	@Inject
	private GoodsDao goodsDao;
	
	public String [] availableTagsJson () {
		List<SearchSelectVO> list = searchTextDao.searchTotal();
		StringBuffer availableTags = new StringBuffer(); 
		for (SearchSelectVO searchSelectVO : list) {
			Goods bean = goodsDao.find(Goods.class, searchSelectVO.getGoodsId());
			availableTags.append(bean.getName() + ",");
		}
		return availableTags.toString().split(",");
	}
}
