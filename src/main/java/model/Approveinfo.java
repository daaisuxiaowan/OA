package model;

public class Approveinfo {
	private Integer id;
	private Integer userid;
	private String approvedate;
	private String approval;
	private String comment;
	private Integer appid;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public String getApprovedate() {
		return approvedate;
	}
	public void setApprovedate(String approvedate) {
		this.approvedate = approvedate;
	}
	public String getApproval() {
		return approval;
	}
	public void setApproval(String approval) {
		this.approval = approval;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Integer getAppid() {
		return appid;
	}
	public void setAppid(Integer appid) {
		this.appid = appid;
	}
	@Override
	public String toString() {
		return "approveinfo [id=" + id + ", userid=" + userid + ", approvedate=" + approvedate + ", approval="
				+ approval + ", comment=" + comment + ", appid=" + appid + "]";
	}
	
}
