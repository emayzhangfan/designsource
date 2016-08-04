package edu.taru.project.admin.system.web;

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

import edu.taru.mvc.AdminCheckSession;
import edu.taru.project.admin.system.entity.Dictionaries;
import edu.taru.project.admin.system.service.DictionariesService;

/**
 * 后台 数据字典维护<br>
 * 暂时不做
 * @author iFan
 *
 */
@IocBean
@At("/admin/system/")
@Ok("json")
@Filters(@By(type=AdminCheckSession.class))
public class DictionariesController {

	@Inject
	private DictionariesService dictionariesService;
	
	@At("dict/record")
    public View dictRecord(@Param("..")Dictionaries dictionaries, @Param("pageNumber")int pageNumber) {
		Map<String,Object> params = Maps.newHashMap();
		if(0 == pageNumber)
			pageNumber = 1;
		QueryResult qr = dictionariesService.findByPage(Dictionaries.class, Cnd.NEW().asc("create_date"), pageNumber, 5);
		params.put("qr", qr);
		params.put("dict", dictionaries);
		return new ViewWrapper(new JspView("views/admin/system/dictRecord"), params);	
    }
}
