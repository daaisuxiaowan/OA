package service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dao.IAnnouncementDao;
import model.Announcement;
import model.Page;
import service.IAnnouncementService;
@Service
@Transactional
public class AnnouncementServiceImpl implements IAnnouncementService {
	@Resource
	IAnnouncementDao iand;
	public Page<Announcement> queryAnnouncementByPage(String starttime, String endtime, String name,
			Page<Announcement> page) {
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
		page.setResult(iand.queryAnnouncementByPage(page.getBegin(), page.getPageSize(), starttime, endtime, name));
		page.setTotalCount(iand.queryAnnouncementCount(starttime, endtime, name).size());
		return page;
	}

	public void addAnnouncement(Announcement an) {
		iand.addAnnouncement(an);
	}

	public void deleteAnnouncement(Integer id) {
		iand.deleteAnnouncement(id);
	}

	public List<Announcement> queryAnnouncement(Announcement an) {
		return iand.queryAnnouncement(an);
	}

}
