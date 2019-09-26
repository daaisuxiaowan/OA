package service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dao.IActDao;
import dao.IApplicationDao;
import dao.IApproveinfoDao;
import dao.ITemplateDao;
import dao.IUserDao;
import model.Act;
import model.Application;
import model.Approveinfo;
import model.Page;
import model.Template;
import model.User;
import service.IFlowService;

@Service
@Transactional
public class FlowServiceImpl implements IFlowService {
	@Resource
	private IActDao iacd;
	@Resource
	private ITemplateDao itd;
	@Resource
	private IApplicationDao iald;
	@Resource
	private IApproveinfoDao iaid;
	@Resource
	private IUserDao iud;
		
	public void deleteAct(Integer id) {
		Act act = new Act();
		act.setId(id);
		iacd.deleteAct(act);
	}

	public void updateAct(Act act) {
		iacd.updateAct(act);
	}

	public Page<Act> queryActByPage(Page<Act> page) {
		page.setResult(iacd.queryActByPage(page));
		page.setTotalCount(iacd.queryAct(null).size());
		return page;
	}

	public List<Act> queryAct(Act act) {
		return iacd.queryAct(act);
	}

	public Page<Template> queryTemplateByPage(Page<Template> page) {
		page.setResult(itd.queryTemplateByPage(page));
		page.setTotalCount(itd.queryTemplate(null).size());
		return page;
	}

	public List<Template> queryTemplate(Template template) {
		return itd.queryTemplate(template);
	}

	public void updateTemplate(Template template) {
		itd.updateTemplate(template);
	}

	public void deleteTemplate(Integer id) {
		itd.deleteTemplate(id);
	}

	public void addTemplate(Template template) {
		itd.addTemplate(template);
	}

	public void addApplication(Application application) {
		iald.addApplication(application);
	}

	public Page<Application> queryApplicationByPage(Application app, Integer page, Integer pageSize) {
		Page<Application> pg = new Page<Application>();
		pg.setPage(page);
		pg.setPageSize(pageSize);
		pg.setResult(iald.queryApplicationByPage(app.getUserid(), pg.getBegin(), pageSize));
		pg.setTotalCount(iald.queryApplication(app).size());
		return pg;
	}

	public Map<String, Object> approveinfoshow(Integer appid) {
		Map<String,Object> map = new HashMap<String, Object>();
		List<User> list = new ArrayList<User>();
		List<Application> list1 = new ArrayList<Application>();
		List<Approveinfo> list2 = new ArrayList<Approveinfo>();
		Approveinfo approveinfo = new Approveinfo();
		approveinfo.setAppid(appid);
		list2 = iaid.queryApproveinfo(approveinfo);
		for (Approveinfo app : list2) {
			User user1 = new User();
			user1.setId(app.getUserid());
			Application appli = new Application();
			appli.setId(appid);
			for(User user : iud.queryUser(user1)){
				list.add(user);
			}
			for(Application appli2 : iald.queryApplication(appli)){
				list1.add(appli2);
			}
		}
		map.put("app", list2);
		map.put("appmeg", list1);
		map.put("usermeg", list);
		return map;
	}

	public List<Application> queryApplication(Application app) {
		return iald.queryApplication(app);
	}

	public List<Approveinfo> queryApproveinfo(Integer appid) {
		List<Approveinfo> list2 = new ArrayList<Approveinfo>();
		Approveinfo approveinfo = new Approveinfo();
		approveinfo.setAppid(appid);
		list2 = iaid.queryApproveinfo(approveinfo);
		return list2;
	}

	public void addApproveinfo(Integer appid, Integer userid, String comment, String approval) {
		Approveinfo app = new Approveinfo();
		app.setAppid(appid);
		app.setApproval(approval);
		app.setApprovedate(utils.TimeUtil.dateformat(new Date()));
		app.setComment(comment);
		app.setUserid(userid);
		iaid.addApproveinfo(app);
	}

	public void updateApplication(String status,Integer appid) {
		Application app = new Application();
		app.setId(appid);
		for(Application app1 : iald.queryApplication(app)){
			app = app1;
		}
		app.setStatus(status);
		iald.updateApplication(app);
	}

	public void addAct(Act act) {
		iacd.addAct(act);
	}
	

}
