package edu.taru.project.front;

import java.io.File;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.nutz.aop.interceptor.ioc.TransAop;
import org.nutz.dao.Cnd;
import org.nutz.dao.QueryResult;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Files;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.AdaptBy;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.filter.CheckSession;
import org.nutz.mvc.impl.AdaptorErrorContext;
import org.nutz.mvc.upload.TempFile;
import org.nutz.mvc.upload.UploadAdaptor;

import com.google.common.collect.Maps;

import edu.taru.common.Constants;
import edu.taru.common.utils.IdGen;
import edu.taru.project.admin.goods.entity.Goods;
import edu.taru.project.admin.goods.service.GoodsService;
import edu.taru.project.admin.user.entity.User;
import edu.taru.project.admin.user.service.UserService;
import edu.taru.project.front.pojo.UserCollection;
import edu.taru.project.front.service.UserCollectionService;

@IocBean
@Ok("json")
@Filters(@By(type=CheckSession.class, args={"user", "/index"}))
public class PublishController extends IndexController {
	
	@Inject
	private UserService userService;
	
	@Inject
	private GoodsService goodsService;
	
	@Inject
	private UserCollectionService userCollectionService;

	@At("front/publishForm")
	public View publishForm () {
//		User myself = userService.get(User.class, id);
		return publish((User) Mvcs.getHttpSession().getAttribute("user"));
	}
	
	@At("front/editPublish")
	public View editPublish (@Param("goodsId") String id) {
		Goods goods= goodsService.get(Goods.class, id);
		return editPublish(goods);
	}
	
	/**
	 * 我的发布列表 展示正常商品，无垃圾<br>
	 * 由于受页面模版限制，只能将集合元素每三个划分为一组，按行传给页面<br>
	 * 我的发布显示两行，一页最多6条数据<br>
	 * @param id
	 * @param pageNumber
	 * @return
	 */
	@At("front/myPublish")
	public View myPublish (@Param("pageNumber")int pageNumber) {
		return super.myPublish(publishMap(pageNumber, Goods.DEFAULT));
	}
	
	/**
	 * 我的发布列表 展示垃圾信息<br>
	 * @param id
	 * @param pageNumber
	 * @return
	 */
	@At("front/myPublish/rubbish")
	public View myPublishRubbish (@Param("pageNumber")int pageNumber) {
		return super.myPublish(publishMap(pageNumber, Goods.RUBBISH));
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> publishMap (int pageNumber, int status) {
		User user = (User) Mvcs.getHttpSession().getAttribute("user");
		/* 设置初始页数 */
		if(0 == pageNumber)
			pageNumber = 1;
		Cnd cnd = Cnd.where("status", "=", status);
		cnd.and("user_id", "=", user.getId()).asc("create_date");
		QueryResult qr = goodsService.findByPage(Goods.class, cnd, pageNumber, 6);
		Map<String, Object> map = Maps.newHashMap();
		if (qr.getList().size() > 3) {
			List<Goods> row1 = new ArrayList<Goods>();
			List<Goods> row2 = new ArrayList<Goods>();
			int i = 0;
			for (Goods goods : (List<Goods>) qr.getList()) {
				 if(++i <= 3) 
					 row1.add(goods);
				 else row2.add(goods);
			}
			map.put("row1", row1);
			map.put("row2", row2);
		} else {
			map.put("row1", (List<Goods>) qr.getList());
		}
		map.put("pager", qr.getPager());
		map.put("status", status);
		return map;
	}
	
	/**
	 * 发布二手信息
	 * @param goods
	 * @param tf
	 * @param err
	 * @param request
	 * @param session
	 * @return
	 */
	@At("/front/publish")
	@Ok("redirect:/front/myPublish?userId=${obj }&pageNumber=1") //防止表单重复提交，应该重定向
	@AdaptBy(type = UploadAdaptor.class, args = { Constants.UPLOAD_SHOW_URI_TEMP, 
												   Constants.DATA_BUFFER_SIZE, 
												   Constants.UTF_8, 
												   Constants.TEMP_FILE_SIZE_MAX, 
												   Constants.IMAGE_SIZE_MAX} )
	public Object publish (@Param("..") Goods goods, @Param("showImg") TempFile tf, 
			HttpServletRequest request, HttpSession session, AdaptorErrorContext err) {
		User user = (User) Mvcs.getHttpSession().getAttribute("user");
		String msg = null;
        if (err != null && err.getAdaptorErr() != null) {
            msg = Constants.FILE_SIZE_INVALID;
            Mvcs.getHttpSession().setAttribute("uploadPublishMsg", msg);
            return publishForm();
        } else if (tf == null) {
            msg = Constants.EMPTY_FILE;
            Mvcs.getHttpSession().setAttribute("uploadPublishMsg", msg);
            return publishForm();
        } else if (!("image/png".equals(tf.getContentType()) || "image/bmp".equals(tf.getContentType()) || "image/jpeg".equals(tf.getContentType()))) {
            msg = Constants.IMAGE_FORMAT_ERROR;
            Mvcs.getHttpSession().setAttribute("uploadPublishMsg", msg);
            return publishForm();
        } else {
        	String goodsId = IdGen.uuid();
        	ServletContext servletContext = request.getSession().getServletContext();
        	@SuppressWarnings("deprecation")
			boolean flag1 = Files.copy(tf.getFile(), new File(servletContext.getRealPath("/") 
        			+ Constants.UPLOAD_SHOW_URI + goodsId + Constants.IMAGE_UPLOAD_PNG));
        	if(flag1) {
        		goods.setId(goodsId);
        		goods.setShowImgUrl(goodsId + Constants.IMAGE_UPLOAD_PNG);
        		goods.setCreateDate(new Date());
        		goods.setStatus(Goods.DEFAULT); //初始状态默认为正常信息
        		goods.setCollectionTotal(BigInteger.valueOf(0)); //收藏量为0
        		Goods newGoods = goodsService.save(goods);
        		if (flag1 && null != newGoods) 
        			msg = Constants.IMAGE_UPLOAD_SUCCESS;
        	} else {
        		msg = Constants.IMAGE_UPLOAD_FAILE;
        		Mvcs.getHttpSession().setAttribute("uploadPublishMsg", msg);
                return publishForm();
        	} 
        }
        if (msg != null)
            Mvcs.getHttpSession().setAttribute("uploadMsg", msg);
        return user.getId(); 
	}
	
	/**
	 * 删除已发布信息
	 * @param goodsId
	 * @return
	 */
	@At("front/deletePublish")
	@Aop(TransAop.READ_COMMITTED)
	@Ok("redirect:/front/myPublish?pageNumber=1")
	public Object deleteMypublish (@Param("goodsId") String goodsId) {
		boolean flag1 = goodsService.delete(goodsId, Goods.class);
		boolean flag2 = userCollectionService.delByCnd(UserCollection.class, Cnd.where("goods_id", "=", goodsId));
		if (flag1 && flag2) 
			return true;
		return error(Constants.SERVICE_ERROR);
	}
	
	/**
	 * 编辑二手信息
	 * @param goods
	 * @param tf
	 * @param err
	 * @param request
	 * @param session
	 * @return
	 */
	@At("/front/editPublishSave")
	@Ok("redirect:/front/myPublish?userId=${obj }&pageNumber=1") //防止表单重复提交，应该重定向
	@AdaptBy(type = UploadAdaptor.class, args = { Constants.UPLOAD_SHOW_URI_TEMP, 
												   Constants.DATA_BUFFER_SIZE, 
												   Constants.UTF_8, 
												   Constants.TEMP_FILE_SIZE_MAX, 
												   Constants.IMAGE_SIZE_MAX} )
	public Object editPublishSave (@Param("..") Goods goods, @Param("showImg") TempFile tf, 
			HttpServletRequest request, HttpSession session, AdaptorErrorContext err) {
		User user = (User) Mvcs.getHttpSession().getAttribute("user");
		String msg = null;
        if (err != null && err.getAdaptorErr() != null) {
            msg = Constants.FILE_SIZE_INVALID;
            Mvcs.getHttpSession().setAttribute("uploadPublishMsg", msg);
            return editPublish(goods.getId());
        } 
        if (tf == null) {
        	boolean flag = goodsService.update(goods);
        	if (!flag)
        		return error(Constants.SERVICE_ERROR);
        } else {
        	String goodsId = goods.getId();
        	ServletContext servletContext = request.getSession().getServletContext();
        	@SuppressWarnings("deprecation")
			boolean flag1 = Files.copy(tf.getFile(), new File(servletContext.getRealPath("/") 
        			+ Constants.UPLOAD_SHOW_URI + goodsId + Constants.IMAGE_UPLOAD_PNG));
        	if(flag1) {
        		boolean flag2 = goodsService.update(goods);
        		if (flag1 && flag2) 
        			msg = Constants.IMAGE_UPLOAD_SUCCESS;
        	} else {
        		msg = Constants.IMAGE_UPLOAD_FAILE;
        		Mvcs.getHttpSession().setAttribute("uploadPublishMsg", msg);
                return publishForm();
        	} 
        }
        if (msg != null)
            Mvcs.getHttpSession().setAttribute("uploadMsg", msg);
        return user.getId(); 
	}
}
