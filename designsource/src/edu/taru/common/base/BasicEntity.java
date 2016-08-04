package edu.taru.common.base;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;

/**
 * @author iFan
 * @date
 *
 */
public class BasicEntity {

	@Column("remarks")
	public String remarks;	// 备注
	
	@Column("create_by")
	public String createBy;	// 创建者
	
	@Column("create_date")
	public Date createDate;	// 创建日期

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	
	
}
