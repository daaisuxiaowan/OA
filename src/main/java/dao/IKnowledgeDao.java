package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import model.Knowledge;

public interface IKnowledgeDao {
	void addKnowledge(Knowledge knowledge); 
	void updateKnowledge(Knowledge knowledge);
	void deleteKnowledge(Integer id);
	List<Knowledge> queryKnowledge(Knowledge knowledge);
	List<Knowledge> queryKnowledgeCount(@Param("starttime")String starttime,@Param("endtime")String endtime,@Param("name")String name);
	List<Knowledge> queryKnowledgeByPage(@Param("begin")Integer begin,@Param("pageSize")Integer pageSize,
			@Param("starttime")String starttime,@Param("endtime")String endtime,@Param("name")String name);
}
