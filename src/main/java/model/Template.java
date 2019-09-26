package model;

public class Template {
	private Integer id;
	private String name;
	private String pdkey;
	private String filepath;
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
	public String getPdkey() {
		return pdkey;
	}
	public void setPdkey(String pdkey) {
		this.pdkey = pdkey;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	@Override
	public String toString() {
		return "template [id=" + id + ", name=" + name + ", pdkey=" + pdkey + ", filepath=" + filepath + "]";
	}
	
}
