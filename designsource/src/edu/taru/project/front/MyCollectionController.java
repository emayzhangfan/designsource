package edu.taru.project.front;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.nutz.dao.Cnd;
import org.nutz.dao.QueryResult;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.filter.CheckSession;

import com.google.common.collect.Maps;

import edu.taru.common.Constants;
import edu.taru.project.admin.goods.entity.Goods;
import edu.taru.project.admin.goods.service.GoodsService;
import edu.taru.project.admin.goods.service.GoodsService.Collection;
import edu.taru.project.admin.user.entity.User;
import edu.taru.project.front.pojo.UserCollection;
import edu.taru.project.front.service.UserCollectionService;

@IocBean
@Ok("json")
@Filters(@By(type=CheckSession.class, args={"user", "/index"}))
public class MyCollectionController extends IndexController {

	@Inject
	private UserCollectionService userCollectionService;
	
	@Inject 
	private GoodsService goodsService;
	
	/**
	 * 收藏
	 * @param session
	 * @param goodsId
	 * @return
	 */
	@Filters()
	@At("front/collection")
	public String collection (HttpSession session, @Param("goodsId") String goodsId) {
		User user = (User) session.getAttribute("user");
		if (null == user) 
			return Constants.LOGIN_FALSE;
		String userId = user.getId();
		int row = userCollectionService.searchCount(userId, goodsId);
		if (row == 0) {
			/* 收藏操作，存入数据库 */
			UserCollection userCollection = userCollectionService.save(new UserCollection(userId, goodsId, new Date()));
			boolean flag = goodsService.updateCollection(goodsId, Collection.ADD_COLLECTION);
			if (null != userCollection && flag) 
				return Constants.COLLECTION_SUCCESS;
		} 
		if (row >= 1) {
			/* 警告，重复收藏 */
			return Constants.COLLECTION_REPEAT;
		} 
		return Constants.ERROR_UNDEFINED;
	}
	
	/**
	 * 检查是否收藏
	 * @param session
	 * @param goodsId
	 * @return
	 */
	@Filters()
	@At("front/existCollection")
	public boolean existCollection (HttpSession session, @Param("goodsId") String goodsId) {
		User user = (User) session.getAttribute("user");
		if (null == user) 
			return false;
		String userId = user.getId();
		int row = userCollectionService.searchCount(userId, goodsId);
		if (row >= 1) 
			return true; //已收藏
		return false;
	}
	
	/**
	 * 取消收藏
	 * @param session
	 * @param goodsId
	 * @return
	 */
	@Filters()
	@At("front/undoCollection")
	public Object undoCollection (HttpSession session, @Param("goodsId") String goodsId) {
		User user = (User) session.getAttribute("user");
		if (null == user) 
			return Constants.LOGIN_FALSE;
		String userId = user.getId();
		boolean flag1 = userCollectionService.delByCnd(UserCollection.class, Cnd.where("user_id", "=", userId).and("goods_id", "=", goodsId));
		boolean flag2 = goodsService.updateCollection(goodsId, Collection.SUBTRACT_COLLECTION);
		if (flag1 && flag2) 
			return Constants.UNDOCOLLECTION_SUCCESS; //取消收藏成功
		return Constants.SERVICE_ERROR;
	}
	
	/**
	 * 我的收藏
	 * @param id
	 * @param pageNumber
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@At("front/myCollection")
	public View myCollection (@Param("pageNumber")int pageNumber) {
		User user = (User) Mvcs.getHttpSession().getAttribute("user");
		/* 设置初始页数 */
		if(0 == pageNumber)
			pageNumber = 1;
		QueryResult qr = userCollectionService.findByPage(UserCollection.class, Cnd.where("user_id", "=", user.getId()).asc("create_date"), pageNumber, 6);
		Map<String, Object> map = Maps.newHashMap();
		if (qr.getList().size() > 3) {
			List<Goods> row1 = new ArrayList<Goods>();
			List<Goods> row2 = new ArrayList<Goods>();
			int i = 0;
			for (UserCollection uc : (List<UserCollection>) qr.getList()) {
				 if(++i <= 3) 
					 row1.add(uc.getGoods());
				 else	
					 row2.add(uc.getGoods());
			}
			map.put("row1", row1);
			map.put("row2", row2);
		} else {
			List<Goods> row = new ArrayList<Goods>();
			for (UserCollection uc : (List<UserCollection>) qr.getList())
				row.add(uc.getGoods());
			map.put("row1", row);
		}
		map.put("pager", qr.getPager());
		return super.myCollection(map);
	}
	
	
}
