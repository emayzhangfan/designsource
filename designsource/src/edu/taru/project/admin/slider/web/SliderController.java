package edu.taru.project.admin.slider.web;

import java.util.Date;
import java.util.Map;

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
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import com.google.common.collect.Maps;

import edu.taru.common.Constants;
import edu.taru.common.utils.IdGen;
import edu.taru.mvc.AdminCheckSession;
import edu.taru.project.admin.slider.entity.Slider;
import edu.taru.project.admin.slider.service.SliderService;
import edu.taru.project.admin.system.entity.Admin;

@IocBean
@At("/admin/slider/")
@Ok("json")
@Filters(@By(type=AdminCheckSession.class))
public class SliderController {

	@Inject
	private SliderService sliderService;
	
	@At("get")
	public Slider get(@Param("id")String id){
		return sliderService.get(Slider.class, id);
	}
	
	@At("record")
    public View sliderRecord(@Param("..")Slider slider, @Param("pageNumber")int pageNumber) {
		/* map */
		Map<String,Object> params = Maps.newHashMap();
		/* 设置初始页数 */
		if(0 == pageNumber)
			pageNumber = 1;
		/* 分页查询 */
		QueryResult qr = sliderService.findByPage(Slider.class, Cnd.NEW().asc("create_date"), pageNumber, 5);
		params.put("qr", qr);
		params.put("slider", slider);
		return new ViewWrapper(new JspView("views/admin/slider/sliderRecord"), params);	
    }
	
	/**
	 * 录入
	 * @param slider
	 * @param pageNumber
	 * @return
	 */
	@At("add")
	public View add(@Param("..")Slider slider, @Param("pageNumber")int pageNumber){
		Admin admin = (Admin) Mvcs.getHttpSession().getAttribute("admin");
		slider.setId(IdGen.uuid());//设置主键
		slider.setCreateBy(admin.getId());//设置创建人
		slider.setCreateDate(new Date());//设置创建时间
		
		Slider newSlider = sliderService.save(slider);//保存
		
		if(null != newSlider)
			return sliderRecord(new Slider(), pageNumber);
		
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
	
	/**
	 * 删除
	 * @param id
	 * @param pageNumber
	 * @return
	 */
	@At("delete")
	public View delete (@Param("id") String id, @Param("pageNumber")int pageNumber){
		boolean flag = sliderService.delete(id, Slider.class);
		if(flag)
			return sliderRecord(new Slider(), pageNumber);
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
	
	/**
	 * 修改
	 * @param slider
	 * @param pageNumber
	 * @return
	 */
	@At("update")
	public View update(@Param("..") Slider slider, @Param("pageNumber")int pageNumber){
		boolean flag = sliderService.update(slider);
		if(flag) 
			return sliderRecord(new Slider(), pageNumber);
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
}
