package model;

import java.util.List;

public class Role {
	private Integer id;
	private String rolename;
	private String memo;
	private List<Menu> menus;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getRolename() {
		return rolename;
	}
	public void setRolename(String rolename) {
		this.rolename = rolename;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public List<Menu> getMenus() {
		return menus;
	}
	public void setMenus(List<Menu> menus) {
		this.menus = menus;
	}
	@Override
	public String toString() {
		return "Role [id=" + id + ", rolename=" + rolename + ", memo=" + memo + ", menus=" + menus + "]";
	}
	
}
