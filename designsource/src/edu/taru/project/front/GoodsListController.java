package edu.taru.project.front;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.nutz.dao.Cnd;
import org.nutz.dao.QueryResult;
import org.nutz.dao.util.cri.SqlExpressionGroup;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.google.common.collect.Maps;

import edu.taru.common.Constants;
import edu.taru.common.utils.StringUtils;
import edu.taru.project.admin.classification.entity.Classification;
import edu.taru.project.admin.classification.service.ClassificationService;
import edu.taru.project.admin.goods.entity.Goods;
import edu.taru.project.admin.goods.service.GoodsService;
import edu.taru.project.front.service.UserCollectionService;


@IocBean
@Ok("json")
public class GoodsListController extends IndexController {

	@Inject
	private GoodsService goodsService;
	
	@Inject
	private ClassificationService classificationService;
	
	@Inject
	private UserCollectionService userCollectionService;
	
	@SuppressWarnings("unchecked")
	@At("front/goodsList")
	public View goodsList (@Param("classificationId") String classificationId, @Param("searchStr") String searchStr, 
			@Param("sort") String sort, int pageNumber) {
		Map<String, Object> map = Maps.newHashMap();
		/* 设置初始页数 */
		if(0 == pageNumber)
			pageNumber = 1;
		
		/* 设置检索条件 */
		Cnd cnd = Cnd.where("status", "=", Goods.DEFAULT);
		if (StringUtils.isNotBlank(classificationId)) {
			cnd.desc("create_date"); //时间降序
			List<Classification> childrens = classificationService.getChildrens(classificationId); //查询分类所有孩子包括自己
			String [] classificationIds = new String[childrens.size()]; //将结果存入字符串数组
			int num = -1;
			for (Classification c : childrens) {
				num = num + 1;
				classificationIds[num] = c.getId();
			}
			cnd.and("classification_id", "in", classificationIds); //查询条件，根据所选分类及其孩子
			List<Classification> resultClassification = new ArrayList<Classification>(); //取出所有二级菜单，当前的下一级，不包括自己
			for (Classification c : childrens) {
				if (!c.getId().equals(classificationId) && c.getParentId().equals(classificationId)) 
					resultClassification.add(c);
			}
			
			StringBuffer attr = new StringBuffer(); //使用 StringBuffer 拼出所有的分类
			for (String str : classificationIds) {
				attr.append(" " + str);
			}
			
			map.put("classificationId", classificationId); 
			map.put("classification", resultClassification); 
			map.put("attr", attr.toString()); 
		}
		
		if (StringUtils.isNotBlank(searchStr)) {
			SqlExpressionGroup e = Cnd.exps("name", "like", "%" + searchStr + "%")
					.or("title", "like", "%" + searchStr + "%")
					.or("classification_name", "like", "%" + searchStr + "%")
					.or("descriptions", "like", "%" + searchStr + "%")
					.or("remarks", "like", "%" + searchStr + "%");
			cnd.and(e);
			map.put("goodsSort", Constants.GOODS_SORT); 
			map.put("searchStr", searchStr); 
		}
		
		if (StringUtils.isNotBlank(sort)) {
			map.put("goodsSort", Constants.GOODS_SORT); 
			/*
			 * 默认排序，综合排序
			 */
			if ("default".equals(sort)) {
				cnd.desc("create_date"); //时间降序
			} 
			
			/*
			 * 按照收藏量排序
			 */
			if (Constants.GOODS_SORT[0][0].equals(sort)) {
				cnd.desc("collection_total");
//				QueryResult qr = goodsService.findByPage(Goods.class, cnd, pageNumber, 20);
//				List<SortCollectionObj> sortCollectionObjList = new ArrayList<SortCollectionObj>();
//				for (Goods goods : (List<Goods>) qr.getList()) {
//					int collectionTotal = userCollectionService.collectionTotalBygoodsId(goods.getId());
//					sortCollectionObjList.add(new SortCollectionObj(collectionTotal, goods));
//				}
//				/*
//				 * list排序
//				 */
//				Collections.sort(sortCollectionObjList, new Comparator<SortCollectionObj>() {
//		            public int compare(SortCollectionObj arg0, SortCollectionObj arg1) {
//		                return arg1.getTotal().compareTo(arg0.getTotal());
//		            }
//		        });
//				/*
//				 * 测试排序
//				 */
//				for (SortCollectionObj sco : sortCollectionObjList) {
//		            System.out.println("收藏量：" + sco.getTotal());
//		            System.out.println("名  称：" + sco.getGoods().getName());
//		            System.out.println("--------------------");
//		        }
//				/*
//				 * 将排序后的的list赋给QueryResult
//				 */
//				List<Goods> goodsSortByCollection = new ArrayList<Goods>();
//				for (SortCollectionObj sco : sortCollectionObjList) {
//					goodsSortByCollection.add(sco.getGoods());
//				}
//				qr.setList(goodsSortByCollection);
//				map.put("qr", qr);
//				return super.goodsList(map);
			} 
			
			/*
			 * 按照时间排序，取最新
			 */
			if (Constants.GOODS_SORT[1][0].equals(sort)) {
				cnd.desc("create_date"); //时间降序
			} 
			
		}
			
		QueryResult qr = goodsService.findByPage(Goods.class, cnd, pageNumber, 20);
		for (Goods goods : (List<Goods>) qr.getList()) {
			String [] calssificationParentIds = goods.getClassification().getParentIds().split(",");
			StringBuffer attr = new StringBuffer(); 
			for (String str : calssificationParentIds) {
				attr.append(" " + str);
			}
			attr.append(" " + goods.getClassificationId());
			goods.setClassificationId(attr.toString());
		}
		map.put("qr", qr);
		return super.goodsList(map);
	}
	
	
	@At("front/details")
	public View details (@Param("goodsId") String goodsId) {
		Goods bean = goodsService.get(goodsId);
		if (null != bean) 
			return super.details(bean);
		return error(Constants.NOEXIST_OR_DELETED);
	}
	
	/**
	 * 根据商品id查询收藏量
	 * @param goodsId
	 * @return
	 */
	@At("ajax/details/collectionTotal")
	public int collectionTotal (@Param("goodsId") String goodsId) {
		return userCollectionService.collectionTotalBygoodsId(goodsId);
	}
	
}


