package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import model.User;

public interface IUserDao {
	void addUser(User user);  //添加用户
	void addUser_role(@Param("userid")Integer userid, @Param("roleid")Integer roleid); //添加中间表
	void deleteUser(Integer id);  //删除用户 
	void deleteUser_role(@Param("userid")Integer userid);  //删除对应中间表，通过用户id
	void updateUser(User user);  //修改用户信息
	List<User> queryUser(User user);  //查找用户
	List<User> queryUserByPage(@Param("begin")Integer begin,@Param("pageSize")Integer pageSize,
			@Param("name")String name,@Param("deptid")Integer deptid);  //分页查询
	User loginUser(User user);   //验证登录
}
