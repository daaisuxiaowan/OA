package model;

public class Menu {
	private Integer id;
	private String menuname;
	private String menulink;
	private String securyname;
	private Integer pid;
	private String memo;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getMenuname() {
		return menuname;
	}
	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}
	public String getMenulink() {
		return menulink;
	}
	public void setMenulink(String menulink) {
		this.menulink = menulink;
	}
	public String getSecuryname() {
		return securyname;
	}
	public void setSecuryname(String securyname) {
		this.securyname = securyname;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	@Override
	public String toString() {
		return "Menu [id=" + id + ", menuname=" + menuname + ", menulink=" + menulink + ", securyname=" + securyname
				+ ", pid=" + pid + ", memo=" + memo + "]";
	}
	
}
