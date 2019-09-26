package dao;

import java.util.List;

import model.Dept;
import model.Page;

public interface IDeptDao {
	void addDept(Dept dept);  //添加部门
	void updateDept(Dept dept);   //修改部门
	void deleteDept(Integer id);  //删除部门
	List<Dept> queryDept(Integer id);  //查询部门 根据id（单条）， null（多条）
	List<Dept> queryDeptByPage(Page<Dept> page);   //分页查询部门
}
