package edu.taru.common.base;

import java.util.List;

import org.nutz.dao.Condition;
import org.nutz.dao.QueryResult;
import org.nutz.dao.pager.Pager;
import org.nutz.ioc.loader.annotation.Inject;

import edu.taru.common.utils.Reflections;

public class BasicService<T> {

	@Inject
	public BasicDao  basicDao;
	
	/**
	 * 实体类类型(由构造方法自动赋值)
	 */
	public Class<?> entityClass;
	
	/**
	 * 构造方法，根据实例类自动获取实体类类型
	 */
	public BasicService() {
		entityClass = Reflections.getClassGenricType(getClass());
	}
	
	/**
	 * 根据主键获取实体
	 * @param c
	 * @param id
	 * @return
	 */
	public <K> K get(Class<K> c,String id){
		return basicDao.find(c, id);
	}
	
	/**
	 * 实体对象分页（返回结果集，无分页信息）
	 * @param c 
	 * @param condition 查询条件,用Cnd的静态方法构造
	 * @param currentPage 当前页码
	 * @param pageSize 每页显示的数据量
	 * @return List<K>
	 */
	public <E> List<E> searchByPage(Class<E> c,Condition condition,int currentPage,int pageSize){
		return basicDao.searchByPage(c, condition, currentPage, pageSize);
	}
	
	/**
	 * 实体对象分页（将分页信息和查询结果一起返回） 
	 * @param c
	 * @param condition 查询条件,用Cnd的静态方法构造
	 * @param pageNumber 当前页码
	 * @param pageSize 每页显示的数据量
	 * @return QueryResult
	 */
	public QueryResult findByPage(Class<T> c,Condition condition,int pageNumber,int pageSize){
		Pager pager = basicDao.dao.createPager(pageNumber, pageSize);
		pager.setRecordCount(basicDao.searchCount(c, condition));//设置总条数，因为Nutz封装的Pager并不查询数据总条数
		List<T> list = basicDao.dao.query(c, condition, pager);//分页结果集
		basicDao.findLink(list, null);//查询所有关联对象
		return new QueryResult(list, pager);
	}
	
	/**
	 * 根据Id删除数据
	 * @param <E>
	 * @param id 主键Id
	 * @return true 成功删除一条数据,false删除失败
	 */
	public <E> boolean delete(String id, Class<E> c){
		return basicDao.dao.delete(c, id) == 1;
	}
	
	/**
	 * 增加一条数据
	 * @param <T>
	 * @param t
	 * @return 返回增加到数据库的这条数据
	 */
	public <E> E save(E e){
		return basicDao.dao.insert(e);
	}
	
	/**
	 * 修改一条数据
	 * @param <T>
	 * @param t     修改数据库中的数据
	 * @return true 修改成功,false 修改失败
	 */
	public <E> boolean update(E e){
		return basicDao.dao.updateIgnoreNull(e) == 1;
	}
	
	/**
	 * 根据条件删除
	 * @param c
	 * @param condition
	 * @return
	 */
	public <E> boolean delByCnd(Class<E> c, Condition condition){
		return basicDao.dao.clear(c, condition) >= 0;
		
	}
}
