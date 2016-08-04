package edu.taru.project.admin.shiro.entity;

public class MenuTreeView{
	
	private String id;
	private String pId;
	private String name;
	private String url;
	private String open = "true";
	private String target = "mainFrame";
	private String isHidden;
	private String checked;
	
	public String getOpen() {
		return open;
	}
	public void setOpen(String open) {
		this.open = open;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIsHidden() {
		return isHidden;
	}
	public void setIsHidden(String isHidden) {
		this.isHidden = isHidden;
	}
	public String getChecked() {
		return checked;
	}
	public void setChecked(String checked) {
		this.checked = checked;
	}
	
	
	
}
