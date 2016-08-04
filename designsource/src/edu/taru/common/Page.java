/**
 * 
 */
package edu.taru.common;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.taru.common.utils.StringUtils;



/**
 * 分页工具类
 * @author 
 *
 * @param <T>
 */
@Deprecated
public class Page<T> {
	private List<T> list = new ArrayList<T>();

	/**
	 * pageSize
	 */
	private Integer pageSize=5;
	
	/**
	 * currentPage 第几页
	 */
	private Integer currentPage=1;
	
	
	/**
	 * 分页字段
	 */
	private String orderField;
	
	/**
	 * 正序、还是倒序
	 */
	private String orderDirection="asc";
	
	/**
	 * 总条数
	 */
	private Integer totalCount;

	
	/**
	 * 每页条数
	 * @return
	 */
	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * 第几页
	 * @return
	 */
	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

	public String getOrderField() {
		return orderField;
	}
	

	public void setOrderField(String orderField) {
		this.orderField = orderField;
	}

	public String getOrderDirection() {
		return orderDirection;
	}

	public void setOrderDirection(String orderDirection) {
		this.orderDirection = orderDirection;
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
	
	/**
	 * 构造函数
	 * @param pageSize 
	 * @param pageCurrent
	 */
	public Page(int currentPage,int pageSize){
		this.pageSize=pageSize;
		this.currentPage=currentPage;
	}
	/**
	 * 构造方法
	 * @param request 传递 repage 参数，来记住页码
	 * @param response 用于设置 Cookie，记住页码
	 */
	public Page(HttpServletRequest request, HttpServletResponse response){
		this(request, response, -2);
	}
	
	
	/**
	 * 构造方法
	 * @param request 传递 repage 参数，来记住页码
	 * @param response 用于设置 Cookie，记住页码
	 * @param defaultPageSize 默认分页大小，如果传递 -1 则为不分页，返回所有数据
	 */
	public Page(HttpServletRequest request, HttpServletResponse response, int defaultPageSize){
		// 设置页码参数（传递repage参数，来记住页码）
		String numPerPage = request.getParameter("numPerPage");
		if(StringUtils.isNotEmpty(numPerPage)){
			this.pageSize=Integer.parseInt(numPerPage);
		}
		
		String pageNum = request.getParameter("pageNum");
		if(StringUtils.isNotEmpty(pageNum)){
			this.currentPage=Integer.parseInt(pageNum);
		}
		
		
		String orderField = request.getParameter("orderField");
		if(StringUtils.isNotBlank(orderField)){
			this.orderField=orderField;
		}
		
		String orderDirection = request.getParameter("orderDirection");
		if(StringUtils.isNotBlank(orderDirection)){
			this.orderDirection=orderDirection;
		}
		if (defaultPageSize != -2){
			this.pageSize = defaultPageSize;
		}
	}
	
	
}
