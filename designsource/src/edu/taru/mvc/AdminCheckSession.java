package edu.taru.mvc;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.ActionContext;
import org.nutz.mvc.ActionFilter;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.View;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import edu.taru.common.base.RedisService;

/**
 * 后台session超时过滤器
 * 
 * @author zhangfan
 * @date 2016/3/14
 */
@IocBean
public class AdminCheckSession implements ActionFilter {

	@Inject
	private RedisService redisService;
	
	@Override
	public View match(ActionContext actionContext) {
		if (null == Mvcs.getHttpSession().getAttribute("admin")) 
			return new ViewWrapper(new JspView("/404.jsp"),null); //返回404
		return null;
	}

}
