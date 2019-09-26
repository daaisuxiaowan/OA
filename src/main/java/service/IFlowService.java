package service;

import java.util.List;
import java.util.Map;

import model.Act;
import model.Application;
import model.Approveinfo;
import model.Page;
import model.Template;

public interface IFlowService {
	void addAct(Act act);     //增加流程定义
	void deleteAct(Integer id);   //删除流程定义
	void updateAct(Act act);		//修改流程定义
	Page<Act> queryActByPage(Page<Act> page);  //分页查询流程定义
	List<Act> queryAct(Act act); 	//查询流程定义，根据id 或 pdkey
	Page<Template> queryTemplateByPage(Page<Template> page);  //分页查询模板
	List<Template> queryTemplate(Template template);  //查询模板，根据id
	void updateTemplate(Template template);  //修改模板
	void deleteTemplate(Integer id);  //删除模板
	void addTemplate(Template template); //添加模板
	void addApplication(Application application);   //添加申请信息
	Page<Application> queryApplicationByPage(Application app,Integer page,Integer pageSize); //分页查询用户自身的申请
	Map<String,Object> approveinfoshow(Integer appid);  //根据appid获取对应的审核表和审核人和申请表
	List<Application> queryApplication(Application app); //根据id或用户userid 查询
	List<Approveinfo> queryApproveinfo(Integer appid); //根据申请表appid查询
	void addApproveinfo(Integer appid,Integer userid,String comment,String approval); //添加审核表信息
	void updateApplication(String status,Integer appid); //修改申请表状态
}
