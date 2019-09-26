package service.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dao.IKnowledgeDao;
import model.Knowledge;
import model.Page;
import service.IKnowledgeService;
@Service
@Transactional
public class KnowledgeServiceImpl implements IKnowledgeService {

	@Resource
	private IKnowledgeDao ikd;
	public Page<Knowledge> queryKnowledgeByPage(String starttime, String endtime, String name, Page<Knowledge> page) {
		if(endtime==null || "".equals(endtime)){
			endtime = utils.TimeUtil.dateformat(new Date());
		}else{
			endtime += " 23:59:59";
		}
		if(starttime==null || "".equals(starttime)){
			starttime = "1970-01-01 00:00:00";
		}else{
			starttime += " 00:00:00";
		}
		page.setResult(ikd.queryKnowledgeByPage(page.getBegin(), page.getPageSize(), starttime, endtime, name));
		page.setTotalCount(ikd.queryKnowledgeCount(starttime, endtime, name).size());
		return page;
	}
	public void addKnowledge(Knowledge kn) {
		ikd.addKnowledge(kn);
		
	}
	public void deleteKnowledge(Integer id) {
		ikd.deleteKnowledge(id);
		
	}

}
