package controller;


import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import model.Announcement;
import model.Page;
import service.IAnnouncementService;

@Controller
@RequestMapping("/announcement")
public class AnnouncementController {
	@Resource
	private IAnnouncementService ians;
	@Resource
	private HttpServletRequest request;
	@RequestMapping()
	public String annou(){
		return "redirect:/announcement.jsp";
	}
	@RequestMapping("/announcementshow")   //默认放过
	@ResponseBody
	public Page<Announcement> announcementshow(String starttime,String endtime,String name,String page){
		Page<Announcement> pg = new Page<Announcement>();
		pg.setPage(utils.NumberFormatUtil.format(page, 1));
		pg.setPageSize(5);
		pg = ians.queryAnnouncementByPage(starttime, endtime, name, pg);	
		return pg;
	}
	@RequestMapping("/addAnnouncementalax")   //默认放过
	@ResponseBody
	public String addAnnouncementalax(){	
		return "addkn";
	}
	@RequestMapping("addAnnouncement")
	public String addAnnouncement(String publisher,String name,String content){
		Announcement kn = new Announcement();
		kn.setName(name);
		kn.setPublisher(publisher);
		kn.setReleasedate(utils.TimeUtil.dateformat(new Date()));
		kn.setContent(content);
        ians.addAnnouncement(kn);
        HttpSession se = request.getSession();
        for(Announcement an : ians.queryAnnouncement(null)){
			se.setAttribute("an", an);
			break;
		}
		return "redirect:/announcement.jsp";
	}
	
	@RequestMapping("deleteAnnouncement")
	public String deleteAnnouncement(Integer id){
		ians.deleteAnnouncement(id);
		return "redirect:/announcement.jsp";
	}
	
	@RequestMapping("/announcementDetail")
	@ResponseBody
	public Announcement announcementDetail(Integer id){ 
		Announcement an = new Announcement();
		an.setId(id);
		for(Announcement an1 : ians.queryAnnouncement(an)){
			an = an1;
		}
		return an;  
	}
}
