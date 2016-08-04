package edu.taru.project.admin.classification.service;

import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.util.cri.SqlExpressionGroup;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.common.base.BasicService;
import edu.taru.project.admin.classification.dao.ClassificationDao;
import edu.taru.project.admin.classification.entity.Classification;

@IocBean
public class ClassificationService extends BasicService<Classification> {

	@Inject
	private ClassificationDao classificationDao;
	
	public List<Classification> findAll(){
		return classificationDao.search(Classification.class, Cnd.NEW().asc("sort"));
	}
	
	public List<Classification> findTop(){
		return classificationDao.search(Classification.class, Cnd.where("parent_id", "=", "0").asc("sort"));
	}

	/**
	 * 查询所有孩子节点
	 * @param id
	 * @return
	 */
	public List<Classification> getChildrens(String id){
		Cnd cnd = Cnd.where("id", "=", id);
		SqlExpressionGroup e = Cnd.exps("parent_id", "=", id).or("parent_ids", "like", "%"+ id +"%");
		cnd.or(e);
		return classificationDao.search(Classification.class, cnd);
	}
}
