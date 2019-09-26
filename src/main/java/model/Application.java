package model;

public class Application {
	private Integer id;
	private String title;
	private String status;
	private String appdate;
	private String filepath;
	private Integer tempid;
	private Integer userid;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public Integer getTempid() {
		return tempid;
	}
	public void setTempid(Integer tempid) {
		this.tempid = tempid;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public String getAppdate() {
		return appdate;
	}
	public void setAppdate(String appdate) {
		this.appdate = appdate;
	}
	@Override
	public String toString() {
		return "Application [id=" + id + ", title=" + title + ", status=" + status + ", appdate=" + appdate
				+ ", filepath=" + filepath + ", tempid=" + tempid + ", userid=" + userid +  "]";
	} 
}
