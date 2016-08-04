package edu.taru.project.admin.classification.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.nutz.aop.interceptor.ioc.TransAop;
import org.nutz.dao.Cnd;
import org.nutz.dao.QueryResult;
import org.nutz.ioc.aop.Aop;
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
import edu.taru.common.utils.IdGen;
import edu.taru.common.utils.StringUtils;
import edu.taru.mvc.AdminCheckSession;
import edu.taru.project.admin.classification.entity.Classification;
import edu.taru.project.admin.classification.entity.ClassificationTreeView;
import edu.taru.project.admin.classification.service.ClassificationService;
import edu.taru.project.admin.system.entity.Admin;

@IocBean
@At("/admin/classification/")
@Filters(@By(type=AdminCheckSession.class))
public class ClassificationController {

	@Inject
	private ClassificationService classificationService;
	
	/**
	 * 根据id获取该对象
	 * @param id
	 * @return
	 */
	@Ok("json")
	@At("get")
	public Classification get(@Param("id") String id){
		Classification classification = classificationService.get(Classification.class, id);
		classificationService.basicDao.findLink(classification, "parent");
		return classification;
	}
	
	/**
	 * 查询所有结果集合
	 * @param classification
	 * @return
	 */
	@At("record")
    public View classificationRecord(@Param("..")Classification classification) {
		Map<String,Object> params = Maps.newHashMap();
		QueryResult qr = classificationService.findByPage(Classification.class, Cnd.NEW().asc("sort"), 0, 0);
		params.put("qr", qr);
		params.put("classification", classification);
		return new ViewWrapper(new JspView("views/admin/classification/classificationRecord"), params);	
    }
	
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@At("delete")
	@Aop(TransAop.READ_COMMITTED)
	public View delete(String id){
		/*删除自身*/
		boolean flag1 = classificationService.delete(id, Classification.class);
		/*删除孩子*/
		boolean flag2 = classificationService.delByCnd(Classification.class, Cnd.where("parent_id", "=", id));
		
		if(flag1 && flag2)
			return classificationRecord(new Classification());	
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
	
	/**
	 * 查询所有 用于ztree
	 * @return
	 */
	@Ok("json")
	@At("ajax/allClassification")
	@Filters()
	public Object allClassification(){
		List<ClassificationTreeView> tree = new ArrayList<ClassificationTreeView>();
		List<Classification> list = classificationService.findAll();
		for (Classification classification : list) {
			ClassificationTreeView ct = new ClassificationTreeView();
			ct.setId(classification.getId());
			ct.setName(classification.getName());
			ct.setpId(classification.getParentId());
			tree.add(ct);
		}
		/*关闭菜单*/
		for (ClassificationTreeView classificationTreeView : tree) {
//			if("0".equals(classificationTreeView.getpId()))
				classificationTreeView.setOpen(Constants.FALSE);
		}
		return tree;
	}
	
	/**
	 * 添加
	 * @param classification
	 * @param session
	 * @return
	 */
	@At("add")
	public View add(@Param("..")Classification classification, HttpSession session){
		Admin nowAdmin = (Admin)session.getAttribute("admin");//当前登陆人
		
		classification.setId(IdGen.uuid());//设置主键
		classification.setCreateBy(nowAdmin.getId());//设置创建人
		classification.setCreateDate(new Date());//设置创建时间
		if (StringUtils.isBlank(classification.getParentId())) {
			classification.setParentId("0");
			classification.setParentIds("0,");
		} else {
			Classification parent = classificationService.get(Classification.class, classification.getParentId());
			classification.setParent(parent);
			classification.setParentIds(classification.getParent().getParentIds() + classification.getParent().getId()+",");
		}
		
		Classification newClassification = classificationService.save(classification);//保存
		
		if(null != newClassification) 
			return classificationRecord(null);
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
	
	/**
	 * 修改
	 * @param classification
	 * @return
	 */
	@At("update")
	public View update(@Param("..")Classification classification){
		boolean flag = classificationService.update(classification);
		if(flag) 
			return classificationRecord(null);
		return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
	}
	
}
