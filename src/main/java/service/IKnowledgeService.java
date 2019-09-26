package service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import model.Knowledge;
import model.Page;

@Service
@Transactional
public interface IKnowledgeService {
	Page<Knowledge> queryKnowledgeByPage(String starttime,String endtime,String name,Page<Knowledge> page);
	void addKnowledge(Knowledge kn);
	void deleteKnowledge(Integer id);
}
