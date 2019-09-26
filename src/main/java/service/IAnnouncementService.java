package service;

import java.util.List;

import model.Announcement;
import model.Page;

public interface IAnnouncementService {
	Page<Announcement> queryAnnouncementByPage(String starttime,String endtime,String name,Page<Announcement> page);
	void addAnnouncement(Announcement an);
	void deleteAnnouncement(Integer id);
	List<Announcement> queryAnnouncement(Announcement an);
}
