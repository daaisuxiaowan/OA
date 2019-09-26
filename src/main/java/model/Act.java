package model;

public class Act {
	private Integer id;
	private String name;
	private String acttype;
	private String pdkey;
	private String filepath;
	private Integer version;

	@Override
	public String toString() {
		return "Act [id=" + id + ", name=" + name + ", acttype=" + acttype + ", pdkey=" + pdkey + ", filepath="
				+ filepath + ", version=" + version + "]";
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
	public String getActtype() {
		return acttype;
	}
	public void setActtype(String acttype) {
		this.acttype = acttype;
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
	public Integer getVersion() {
		return version;
	}
	public void setVersion(Integer version) {
		this.version = version;
	}
}
