package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import model.Menu;
import model.Page;

public interface IMenuDao {
	void addMenu(Menu menu);    //添加菜单
	void deleteMenu(Menu menu);  //删除菜单，根据菜单id
	void updateMenu(Menu menu);  //修改菜单，根据菜单id
	List<Menu> queryMenuToRole(@Param("menuid")Integer id);  //查询角色持有的菜单
	List<Menu> queryMenu(Menu menu);  //查询菜单，根据id(单条),根据所属菜单pid(多条)
	List<Menu> queryMenuByPage(Page<Menu> page);  //分页查询菜单
}
