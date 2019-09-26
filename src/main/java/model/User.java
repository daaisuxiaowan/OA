package model;

import java.util.List;

public class User {
	private Integer id;
	private String loginname;
	private String pwd;
	private String name;
	private String sex;
	private Integer deptid;
	private List<Role> roles;
	public User() {
		super();
	}
	public User(Integer id) {
		super();
		this.id = id;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public Integer getDeptid() {
		return deptid;
	}
	public void setDeptid(Integer deptid) {
		this.deptid = deptid;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", loginname=" + loginname + ", pwd=" + pwd + ", name=" + name + ", sex=" + sex
				+ ", deptid=" + deptid + ", roles=" + roles + "]";
	}
	public List<Role> getRoles() {
		return roles;
	}
	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}
	
}
