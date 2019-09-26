package model;

public class Knowledge {
	private Integer id;
	private String name;
	private String filepath;
	private String releasedate;
	private String publisher;
	@Override
	public String toString() {
		return "knowledge [id=" + id + ", name=" + name + ", filepath=" + filepath + ", releasedate=" + releasedate
				+ ", publisher=" + publisher + "]";
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public String getReleasedate() {
		return releasedate;
	}
	public void setReleasedate(String releasedate) {
		this.releasedate = releasedate;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
}
