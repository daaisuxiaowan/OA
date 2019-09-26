package model;

import java.util.List;

public class Page<T> {
	private Integer pageSize;
	private Integer page;
	@SuppressWarnings("unused")
	private Integer begin;
	private Integer totalCount;
	@SuppressWarnings("unused")
	private Integer totalPage;
	private List<T> result;
	
	public Page() {
		super();
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
	public Integer getTotalPage() {
		return ((totalCount-1)/pageSize)+1;
	}
	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
	public List<T> getResult() {
		return result;
	}
	public void setResult(List<T> result) {
		this.result = result;
	}
	public void setBegin(Integer begin){
		this.begin = begin;
	} 
	public Integer getBegin() {
		return (page-1)*pageSize;
	}

}
