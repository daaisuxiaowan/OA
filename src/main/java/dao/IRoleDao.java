package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import model.Page;
import model.Role;

public interface IRoleDao {
	void addRole(Role role);    //添加角色
	void addRole_menu(@Param("roleid")Integer roleid,@Param("menuid")Integer menuid);   //添加角色菜单中间表
	void deleteRole(Integer id);   //删除角色
	void deleteRole_menu(@Param("roleid")Integer roleid);   //删除角色菜单中间表
	void updateRole(Role role);    //修改角色
	List<Role> queryRole(@Param("id")Integer id);  //查询角色
	List<Role> queryRoleByPage(Page<Role> page);  //分页查询角色
	List<Role> queryRoleToUser(@Param("id")Integer id);  //查询用户对应角色
	Role queryRoleByName(Role role);  //查询角色通过角色名字
}
