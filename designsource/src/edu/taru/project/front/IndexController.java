package edu.taru.project.front;



import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.nutz.dao.Cnd;
import org.nutz.dao.QueryResult;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import com.google.common.collect.Maps;

import edu.taru.project.admin.goods.entity.Goods;
import edu.taru.project.admin.goods.service.GoodsService;
import edu.taru.project.admin.slider.entity.Slider;
import edu.taru.project.admin.slider.service.SliderService;
import edu.taru.project.admin.user.entity.User;

/**
 * 
 * @author zhangfan
 *
 */
@IocBean
public class IndexController {
	
	@Inject
	private GoodsService goodsService;
	
	@Inject
	private SliderService sliderService;
	
	/**
	 * 首页
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public View index() {
		Map<String, Object> map = Maps.newHashMap();
		Cnd cnd = Cnd.where("status", "=", Goods.DEFAULT);
		cnd.desc("create_date");
		QueryResult qr = goodsService.findByPage(Goods.class, cnd, 1, 10);
		map.put("cursual", qr.getList());
		
		Cnd cnd2 = Cnd.where("status", "=", Goods.DEFAULT);
		cnd2.desc("collection_total");
		QueryResult qr2 = goodsService.findByPage(Goods.class, cnd2, 1, 6);
		if (qr2.getList().size() > 3) {
			List<Goods> row1 = new ArrayList<Goods>();
			List<Goods> row2 = new ArrayList<Goods>();
			int i = 0;
			for (Goods goods : (List<Goods>) qr2.getList()) {
				 if(++i <= 3) 
					 row1.add(goods);
				 else row2.add(goods);
			}
			map.put("row1", row1);
			map.put("row2", row2);
		} else {
			map.put("row1", (List<Goods>) qr2.getList());
		}
		
		QueryResult qr3 = sliderService.findByPage(Slider.class, Cnd.NEW().desc("create_date"), 1, 5);
		map.put("slider", qr3.getList());
		return new ViewWrapper(new JspView("views/front/index"), map);
	}
	
	/**
	 * 注册页
	 */
	public View register() {
		return new ViewWrapper(new JspView("views/front/register"), null);
	}
	
	/**
	 * 个人中心页
	 * @param myself
	 * @return
	 */
	public View myCenter(User myself) {
		return new ViewWrapper(new JspView("views/front/myCenter"), myself);
	}
	
	/**
	 * 错误页
	 * @param msg
	 * @return
	 */
	public View error(String msg) {
		return new ViewWrapper(new JspView("views/front/error"), msg);
	}
	
	/**
	 * 认证页
	 * @param myself
	 * @return
	 */
	public View authentication(User myself) {
		return new ViewWrapper(new JspView("views/front/authentication"), myself);
	}
	
	/**
	 * 发布页
	 * @param myself
	 * @return
	 */
	public View publish(User myself) {
		return new ViewWrapper(new JspView("views/front/publish"), myself);
	}
	
	/**
	 * 我的发布页
	 * @param map
	 * @return
	 */
	public View myPublish(Map<String, Object> map) {
		return new ViewWrapper(new JspView("views/front/myPublish"), map);
	}
	
	/**
	 * 商品集合页（按分类）
	 * @param map
	 * @return
	 */
	public View goodsList(Map<String, Object> map) {
		return new ViewWrapper(new JspView("views/front/goodsList"), map);
	}
	
	/**
	 * 商品详情页
	 * @param goods
	 * @return
	 */
	public View details(Goods goods) {
		return new ViewWrapper(new JspView("views/front/details"), goods);
	}
	
	/**
	 * 我的收藏页
	 * @param map
	 * @return
	 */
	public View myCollection(Map<String, Object> map) {
		return new ViewWrapper(new JspView("views/front/myCollection"), map);
	}
	
	/**
	 * 商品修改页
	 * @param map
	 * @return
	 */
	public View editPublish(Goods goods) {
		return new ViewWrapper(new JspView("views/front/editPublish"), goods);
	}
	
	/**
	 * 首页
	 * @return
	 */
	@At(value = {"/", "/index", "/home"})
	public View main() {
		return index();	
	}
	
	/**
	 * 销毁某个session
	 * @param op
	 * @param session
	 */
	@At("/removeSession")
	public void removeSession (@Param("op") String op, HttpSession session) {
		session.removeAttribute(op);
	}
	
	
	
/**
 * 多张图片上传 html5
 *
 *	<form action="/example/html5/demo_form.asp" method="get">
 *	 	选择图片：<input type="file" name="img" multiple="multiple" />
 *	 	<input type="submit" />
 *	</form>
 *	<p>请尝试在浏览文件时选取一个以上的文件。</p>
 *
 */

}
