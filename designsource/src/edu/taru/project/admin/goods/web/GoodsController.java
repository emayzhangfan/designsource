package edu.taru.project.admin.goods.web;

import java.util.Map;

import org.nutz.dao.Cnd;
import org.nutz.dao.QueryResult;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import com.google.common.collect.Maps;

import edu.taru.common.Constants;
import edu.taru.common.utils.StringUtils;
import edu.taru.mvc.AdminCheckSession;
import edu.taru.project.admin.goods.entity.Goods;
import edu.taru.project.admin.goods.service.GoodsService;

@IocBean
@At("/admin/goods/")
@Filters(@By(type=AdminCheckSession.class))
public class GoodsController {

	@Inject
	private GoodsService goodsService;
	
	@At("record")
    public View goodsRecord(@Param("..") Goods goods, @Param("pageNumber")int pageNumber) {
		Map<String,Object> params = Maps.newHashMap();
		if (0 == pageNumber)
			pageNumber = 1;
		Cnd cnd = Cnd.where("status", "=", Goods.DEFAULT);
		if(StringUtils.isNotBlank(goods.getName()))
			cnd.and("name", "like", "%" + goods.getName() + "%");
		if(StringUtils.isNotBlank(goods.getTitle()))
			cnd.and("title", "like", "%" + goods.getTitle() + "%");
		if(StringUtils.isNotBlank(goods.getClassificationId()))
			cnd.and("classification_id", "=", goods.getClassificationId());
		QueryResult qr = goodsService.findByPage(Goods.class, cnd.asc("create_date"), pageNumber, 5);
		params.put("qr", qr);
		params.put("goods", goods);
		return new ViewWrapper(new JspView("views/admin/goods/goodsRecord"), params);	
    }
	
	@At("ajax/getOne")
	@Ok("json")
	public Object get (@Param("goodsId") String goodsId) {
		return goodsService.get(goodsId);
	}
	
	/**
	 * 标记为垃圾商品
	 * @param id
	 * @param goods
	 * @param pageNumber
	 * @return
	 */
	@At("setRubbish")
	public View setRubbish (@Param("id") String id, @Param("..") Goods goods, @Param("pageNumber") int pageNumber) {
		Goods bean = goodsService.get(Goods.class, id);
		bean.setStatus(Goods.RUBBISH);
		boolean flag = goodsService.update(bean);
		if (flag) 
			return goodsRecord(goods, pageNumber);
		else return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
	
}
