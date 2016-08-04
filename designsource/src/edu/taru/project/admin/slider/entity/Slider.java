package edu.taru.project.admin.slider.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import edu.taru.common.base.BasicEntity;

@Table("tx_slider_view")
public class Slider extends BasicEntity {

	@Name
	@Column("id")
	private String id;
	
	@Column("title")
	private String title;
	
	@Column("descriptions")
	private String descriptions;
	
	@Column("button_value")
	private String buttonValue;
	
	@Column("button_href")
	private String buttonHref;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescriptions() {
		return descriptions;
	}

	public void setDescriptions(String descriptions) {
		this.descriptions = descriptions;
	}

	public String getButtonValue() {
		return buttonValue;
	}

	public void setButtonValue(String buttonValue) {
		this.buttonValue = buttonValue;
	}

	public String getButtonHref() {
		return buttonHref;
	}

	public void setButtonHref(String buttonHref) {
		this.buttonHref = buttonHref;
	}
	
	
}
