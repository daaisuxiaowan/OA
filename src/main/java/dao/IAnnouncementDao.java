package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import model.Announcement;

public interface IAnnouncementDao {
	void addAnnouncement(Announcement announcement); 
	void updateAnnouncement(Announcement announcement);
	void deleteAnnouncement(Integer id);
	List<Announcement> queryAnnouncement(Announcement announcement);
	List<Announcement> queryAnnouncementCount(@Param("starttime")String starttime,
			@Param("endtime")String endtime,@Param("name")String name);
	List<Announcement> queryAnnouncementByPage(@Param("begin")Integer begin,@Param("pageSize")Integer pageSize,
			@Param("starttime")String starttime,@Param("endtime")String endtime,@Param("name")String name);
}
