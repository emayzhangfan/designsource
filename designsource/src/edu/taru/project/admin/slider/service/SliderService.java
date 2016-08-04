package edu.taru.project.admin.slider.service;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.common.base.BasicService;
import edu.taru.project.admin.slider.dao.SliderDao;
import edu.taru.project.admin.slider.entity.Slider;

@IocBean
public class SliderService extends BasicService<Slider> {

	@Inject
	private SliderDao sliderDao;
}
