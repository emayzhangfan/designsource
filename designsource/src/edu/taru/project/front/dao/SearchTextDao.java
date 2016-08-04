package edu.taru.project.front.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.common.base.BasicDao;
import edu.taru.project.front.pojo.SearchSelectVO;

@IocBean
public class SearchTextDao extends BasicDao {

	/**
	 * 查询每个商品的收藏量 降序
	 * @return
	 */
	public List<SearchSelectVO> searchTotal() {
		Sql sql = Sqls.create("select count(goods.goods_id) as total, goods.goods_id as goodsId "+
								"from tx_user_collection as goods "+
								"group by goods.goods_id "+
								"order by total desc "+
								"limit 0, 20");
		sql.setCallback(new SqlCallback() {
			public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
				List<SearchSelectVO> list = new ArrayList<SearchSelectVO>();
				while(rs.next()){
					SearchSelectVO vo = new SearchSelectVO();
					vo.setTotal(rs.getString("total"));
					vo.setGoodsId(rs.getString("goodsId"));
					list.add(vo);
				};
				return list;
			}
		});
		dao.execute(sql);
		return sql.getList(SearchSelectVO.class);
	}
}
