package edu.taru.project.front.pojo;

import edu.taru.project.admin.goods.entity.Goods;

public class SortCollectionObj {

	public SortCollectionObj (Integer total, Goods goods) {
		this.total = total;
		this.goods = goods;
	}
	
	private Integer total;

	private Goods goods;
	
	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	
}
