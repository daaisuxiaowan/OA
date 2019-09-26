package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import model.Application;


public interface IApplicationDao {
	List<Application> queryApplication(Application application);  //通过id或userid查找
	void addApplication(Application application);  //增加申请表
	List<Application> queryApplicationByPage(@Param("userid")Integer userid,@Param("begin")Integer begin,
			@Param("pageSize")Integer pageSize);  //查找用户自己的申请表，通过userid查找
	void updateApplication(Application application); //修改申请表状态
}
