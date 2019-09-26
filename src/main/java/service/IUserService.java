package service;

import java.util.List;

import model.Dept;
import model.Menu;
import model.Page;
import model.Role;
import model.User;

public interface IUserService {
	User loginUser(User user);       //验证登录
	Page<User> queryUserByPage(Page<User> page,String ssname,Integer ssdept);  //分页查询用户
	List<User> queryUser(User user);  //查找用户,可根据id(单条),null（所有）
	void addUser(User user);   //增加用户
	void deleteUser(int id);   //删除用户
	void updateUser(User user); //修改用户
	List<Menu> queryMenu(Menu menu);  //查找菜单
	Page<Menu> queryMenuByPage(Page<Menu> page);  //分页查询菜单
	void updateMenu(Menu menu);  //修改菜单，根据菜单id
	void addMenu(Menu menu);    //添加菜单
	void deleteMenu(Integer id); //删除菜单，删除父类，子类一并删除
	Page<Role> queryRoleByPage(Page<Role> page);  //分页查询角色
	List<Role> queryRole(Integer id);   //查找角色，可根据id(单条),null（所有）
	void updateRole(Role role);  //修改角色，根据角色id
	void addRole(Role role);  //添加角色
	void deleteRole(Integer id); //删除角色，根据角色id
	Page<Dept> queryDeptByPage(Page<Dept> page);  //分页查询角色
	List<Dept> queryDept(Integer id);   //查找角色，可根据id(单条),null（所有）
	void updateDept(Dept role);  //修改部门，根据部门id
	void addDept(Dept role);  //添加部门
	void deleteDept(Integer id); //删除部门，根据部门id
}
