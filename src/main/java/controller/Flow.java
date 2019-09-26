package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipInputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.DeploymentBuilder;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import model.Act;
import model.Application;
import model.Approveinfo;
import model.Page;
import model.Role;
import model.Template;
import model.User;
import service.IFlowService;
import service.IUserService;
import utils.NumberFormatUtil;

@Controller
@RequestMapping("/flow")
public class Flow {
	@Resource
	private IUserService ius;
	@Resource
	private IFlowService ifs;
	@Resource
	private HttpServletRequest request;
	@Resource
	private RepositoryService rpser;
	@Resource
	private TaskService tser;
	@Resource
	private RuntimeService rtser;
	@RequestMapping()    
	public String main1(){
			return "redirect:/flow.jsp";
	}
	
	@RequestMapping("/actshow") 
	@ResponseBody
	public Page<Act> actshow(String page){
		Page<Act> pg = new Page<Act>();
		pg.setPage(NumberFormatUtil.format(page, 1));
		pg.setPageSize(5);
		pg = ifs.queryActByPage(pg);
			return pg;
	}
	@RequestMapping("/actpic") 
	public ResponseEntity<byte[]> actpic(String pdkey,Model model) throws IOException{
		ProcessDefinitionQuery query = rpser.createProcessDefinitionQuery().processDefinitionKey(pdkey);
		List<ProcessDefinition> pd = query.list();
		String id = null;
		for (ProcessDefinition pr : pd) {
			id = pr.getId();
		}
		InputStream in = rpser.getProcessDiagram(id );
	    File file = new File("D:/test/pic",pdkey+".png");//运用双斜杠是因为在java中\是转义字符，只写一个\会把后面的转义
	    if(!file.getParentFile().exists()){           //判断文件所在文件夹是否存在，不存在创建一个
	    	file.getParentFile().mkdir();
		}
		if(file.exists()){
			file.delete(); 
	    }
	    FileOutputStream out = new FileOutputStream(file);
	    byte[] buf = new byte[1024];
	    int l = -1;
	    while((l = in.read(buf)) != -1){
	      out.write(buf, 0, l);    
	    }
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.IMAGE_PNG);//传的文件的格式
	    ResponseEntity<byte[]> re = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers , HttpStatus.CREATED);
	    out.close();//关闭输入流
	    return re;
	}
	@RequestMapping("/addAct") 
	public String addAct(String name,String meg,MultipartFile file,String acttype, Model model) throws IOException{   
		Act act = new Act();
		act.setName(name);
		act.setActtype(acttype);
		Boolean flag = false;
		if("上传文件成功".equals(meg)){
			//目标文件的路径
			String path = "d:\\test";   //在目标路径下创建一个叫file的文件夹
			//上传文件的名字
			String filename = file.getOriginalFilename();       //获得上传文件的名字
			File target = new File(path, filename);             //创建目标文件的对象
			if(!target.getParentFile().exists()){           //判断文件所在文件夹是否存在，不存在创建一个
				target.getParentFile().mkdir();
			}
			if(target.exists()){
				target.delete(); 
		    }
			target.createNewFile();                         //在目标路径下创建文件
			InputStream in = file.getInputStream();         //创建输入流
			FileUtils.copyInputStreamToFile(in, target);    //调用插件方法，将上传文件内容写入目标文件，流到文件的形式
	           in.close();
	        //存入流程定义表
			String pdkey = filename.split("\\.")[0];
			act.setFilepath(filename);
			act.setPdkey(pdkey);
			DeploymentBuilder bu = rpser.createDeployment();
			InputStream ins = new FileInputStream("D:\\test\\"+filename);
			ZipInputStream zipInputStream = new ZipInputStream(ins );
			bu.addZipInputStream(zipInputStream);
			bu.deploy();
			ProcessDefinitionQuery query = rpser.createProcessDefinitionQuery();
			//查询每个流程定义的最新版本
			query.latestVersion();
			query.processDefinitionKey(pdkey);
			ProcessDefinition pd = query.singleResult();
			act.setVersion(pd.getVersion());
			for(Act act1 : ifs.queryAct(null)){
				if(act1.getPdkey().equals(act.getPdkey())){
					act.setId(act1.getId());
					ifs.updateAct(act);
					flag = true;
				}
			}
			if(!flag){
				ifs.addAct(act);
			}
			model.addAttribute("flag", 1);
			
		}	
		return "/flow.jsp";
	}
	@RequestMapping("/queryoneAct") 
	@ResponseBody
	public Act queryoneAct(Integer id){   //需要放过
		List<Act> list = new ArrayList<Act>();
		Act act1 = new Act();
		act1.setId(id);
		list = ifs.queryAct(act1);
		for (Act act : list) {
			return act;
		}
			return null;
	}
	
	@RequestMapping("/updateTemplate") 
	public String updateTemplate(String name,Integer id,String pdkey,String meg,MultipartFile file, Model model) throws IOException{   
		List<Template> list = new ArrayList<Template>();
		Template template = new Template();
		template.setId(id);
		list = ifs.queryTemplate(template);
		for (Template act1 : list) {
			template = act1;
		}
		template.setName(name);
		template.setPdkey(pdkey);
		if("上传文件成功".equals(meg)){
			//目标文件的路径
			String path = "d:\\test\\model";   //在目标路径下创建一个叫file的文件夹
			//上传文件的名字
			String filename = file.getOriginalFilename();       //获得上传文件的名字
			File target = new File(path, filename);             //创建目标文件的对象
			if(!target.getParentFile().exists()){           //判断文件所在文件夹是否存在，不存在创建一个
				target.getParentFile().mkdir();
			}
			if(target.exists()){
				target.delete(); 
		    }
			target.createNewFile();                         //在目标路径下创建文件
			InputStream in = file.getInputStream();         //创建输入流
			FileUtils.copyInputStreamToFile(in, target);    //调用插件方法，将上传文件内容写入目标文件，流到文件的形式
	           in.close();
	           template.setFilepath(filename);
		}	
		ifs.updateTemplate(template);;
		model.addAttribute("flag", 2);
		return "/flow.jsp";
	}
	
	@RequestMapping("/addTemplate") 
	public String addTemplate(String name,String pdkey,String meg,MultipartFile file, Model model) throws IOException{   
		Template template = new Template(); 
		Boolean flag = false;
		template.setName(name);
		template.setPdkey(pdkey);
		if("上传文件成功".equals(meg)){
			//目标文件的路径
			String path = "d:\\test\\model";   //在目标路径下创建一个叫file的文件夹
			//上传文件的名字
			String filename = file.getOriginalFilename();       //获得上传文件的名字
			template.setFilepath(filename);
			for(Template tp : ifs.queryTemplate(null)){
				if(tp.getPdkey().equals(pdkey)){
					template.setId(tp.getId());
					ifs.updateTemplate(template);
					flag = true;
				}
			}
			if(!flag){
				ifs.addTemplate(template);	
			}
			model.addAttribute("flag", 2);
			File target = new File(path, filename);             //创建目标文件的对象
			if(!target.getParentFile().exists()){           //判断文件所在文件夹是否存在，不存在创建一个
				target.getParentFile().mkdir();
			}
			if(target.exists()){
				target.delete(); 
		    }
			target.createNewFile();                         //在目标路径下创建文件
			InputStream in = file.getInputStream();         //创建输入流
			FileUtils.copyInputStreamToFile(in, target);    //调用插件方法，将上传文件内容写入目标文件，流到文件的形式
	           in.close();
		}	
		return "/flow.jsp";
	}
	
	@RequestMapping("/queryoneTemplate") 
	@ResponseBody
	public Map<String,Object> queryoneTemplate(Integer id){   //需要放过
		Map<String,Object> model = new HashMap<String, Object>();
		List<Act> list = new ArrayList<Act>();
		model.put("tempname", "add");
		if(id!=null){
			Template template = new Template();
			template.setId(id);
			for (Template menu2 : ifs.queryTemplate(template)) {
				template = menu2;
			}
			model.put("template", template);
			model.put("tempname", "update");
		}
		list = ifs.queryAct(null);
		model.put("act", list);
			return model;
	}
	
	@RequestMapping("/deleteTemplate") 
	public String deleteTemplate(Integer id, Model model){   
		ifs.deleteTemplate(id);
		model.addAttribute("flag", 2);
		return "/flow.jsp";
	}
	
	@RequestMapping("/deleteAct") 
	public String deleteAct(Integer id,String pdkey, Model model){   
		ifs.deleteAct(id);
		ProcessDefinitionQuery query = rpser.createProcessDefinitionQuery().processDefinitionKey(pdkey);
		List<ProcessDefinition> pd = query.list();
		for (ProcessDefinition pr : pd) {
			TaskQuery qt = tser.createTaskQuery();
			qt.processDefinitionKey(pdkey);
			List<Task> task = qt.list();
			if(task.size()!=0){
				for (Task task2 : task) {
					Integer i = (Integer) tser.getVariable(task2.getId(), "appid");
						rtser.deleteProcessInstance(task2.getProcessInstanceId(), null);;	
						ifs.updateApplication("已取消", i);
				}
			}
			rpser.deleteDeployment( pr.getDeploymentId(),true);
		}
		if(ifs.queryTemplate(null).size()!=0){
			for(Template tem : ifs.queryTemplate(null)){
				if(tem.getPdkey().equals(pdkey)){
					ifs.deleteTemplate(tem.getId());
					break;
				}
			}		
		}
		model.addAttribute("flag", 1);
		return "/flow.jsp";
	}
	
	@RequestMapping("/templateshow") 
	@ResponseBody
	public Map<String,Object> templateshow(String page){
		Map<String,Object> map = new HashMap<String, Object>();
		Page<Template> pg = new Page<Template>();
		pg.setPage(NumberFormatUtil.format(page, 1));
		pg.setPageSize(5);
		pg = ifs.queryTemplateByPage(pg);
		map.put("pg", pg);
		map.put("act", ifs.queryAct(null));
			return map;
	}
	@RequestMapping("/updateAct") 
	public String updateAct(String name,Integer id,String meg,MultipartFile file,String acttype, Model model) throws IOException{   
		List<Act> list = new ArrayList<Act>();
		Act act = new Act();
		act.setId(id);
		list = ifs.queryAct(act);
		for (Act act1 : list) {
			act = act1;
		}
		act.setName(name);
		act.setActtype(acttype);
		if("上传文件成功".equals(meg)){
			//目标文件的路径
			String path = "d:\\test";   //在目标路径下创建一个叫file的文件夹
			//上传文件的名字
			String filename = file.getOriginalFilename();       //获得上传文件的名字
			act.setFilepath(filename);
			act.setPdkey(filename.split("\\.")[0]);
			DeploymentBuilder bu = rpser.createDeployment();
			InputStream ins = new FileInputStream("D:\\test\\"+filename);
			ZipInputStream zipInputStream = new ZipInputStream(ins );
			bu.addZipInputStream(zipInputStream);
			bu.deploy();
			ProcessDefinitionQuery query = rpser.createProcessDefinitionQuery();
			//查询每个流程定义的最新版本
			query.latestVersion();
			query.processDefinitionKey(filename.split("\\.")[0]);
			ProcessDefinition pd = query.singleResult();
			act.setVersion(pd.getVersion());
			model.addAttribute("flag", 1);
			File target = new File(path, filename);             //创建目标文件的对象
			if(!target.getParentFile().exists()){           //判断文件所在文件夹是否存在，不存在创建一个
				target.getParentFile().mkdir();
			}
			if(target.exists()){
				target.delete(); 
		    }
			target.createNewFile();                         //在目标路径下创建文件
			InputStream in = file.getInputStream();         //创建输入流
			FileUtils.copyInputStreamToFile(in, target);    //调用插件方法，将上传文件内容写入目标文件，流到文件的形式
	           in.close();
		}	
		ifs.updateAct(act);
		model.addAttribute("flag", 1);
		return "/flow.jsp";
	}
	@RequestMapping("/openApplication") 
	public String openApplication(String actkey, Model model){   
		List<Template> list = new ArrayList<Template>();
		Template template = new Template();
		String[] str = actkey.split("\\*");
		template.setPdkey(str[0]);
		list = ifs.queryTemplate(template);
		for (Template act1 : list) {
			template = act1;
		}
		model.addAttribute("flag", 3);
		model.addAttribute("template",template);
		model.addAttribute("actname",str[1]);
		return "/application.jsp";
	}
	@RequestMapping("/download")  //默认放过
	public ResponseEntity<byte[]> download(String path,String msg) throws IOException{ //下载的方法需要返回ResponseEntity<byte[]>类型，一般参数传入文件的名字
		String parentPath = "d:\\test\\model";  //获取目标文件所在文件夹
		if("审核下载".equals(msg)){
			parentPath = "d:\\test\\appmodel";  //获取目标文件所在文件夹
		}
		File file = new File(parentPath,path);  //创建file对象，地址为指定好的
		HttpHeaders headers = new HttpHeaders();  //创建HttpHeaders对象，下载方法需要的参数之一
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);  //设置传输的方式，流的形式
		String filename = new String(path.getBytes("utf-8"), "iso-8859-1");  //如果传输文件的名字为中文，需要转码，让浏览器识别
		headers.setContentDispositionFormData("attchment", filename );  //将文件的地址传入参数
		ResponseEntity<byte[]> re = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
          //前两个参数需要配置，第三个参数固定设置为HttpStatus.CREATED
		return re;  //返回ResponseEntity<byte[]>对象给前端
	}
	
	@RequestMapping("/submitApplication") 
	public String submitApplication(String title,String pdkey,Integer tempid,Integer userid,
			String meg,MultipartFile file,String username, Model model) throws IOException{   
		if("上传文件成功".equals(meg)){
			String filename = file.getOriginalFilename();       //获得上传文件的名字
			//将申请信息存入数据库，并开启流程实例
			Application app = new Application();
			app.setStatus("审核中");
			app.setTempid(tempid);
			app.setUserid(userid);
			app.setFilepath(filename);
			app.setTitle(title);
			app.setAppdate(utils.TimeUtil.dateformat(new Date()));
			ifs.addApplication(app);
			//开启流程实例
			List<User> list = new ArrayList<User>();
			List<Role> list1 = new ArrayList<Role>();
			List<String> list2 = new ArrayList<String>();
			List<String> list3 = new ArrayList<String>();
			list = ius.queryUser(null);
			for (User user : list) {
				list1 = user.getRoles();
				for (Role role : list1) {
					if("部长".equals(role.getRolename())){
						list2.add(user.getName());
					}
					if("经理".equals(role.getRolename())){
						list3.add(user.getName());
					}
				}
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("minister", list2);
			map.put("manager", list3);
			map.put("appName", username);
			map.put("appid",app.getId()); 
			Act ac= new Act();
			ac.setPdkey(pdkey);
			for(Act act : ifs.queryAct(ac)){
				if("组任务".equals(act.getActtype())){
					map.put("acttype","zu");
				}else if("个人任务".equals(act.getActtype())){
					map.put("acttype","person");
				}
			}
			rtser.startProcessInstanceByKey(pdkey, map);
			//申请人发起申请
			TaskQuery query = tser.createTaskQuery();
			query.taskAssignee(username);
			Task task = query.singleResult();
			tser.complete(task.getId());
			model.addAttribute("flag", 4);
			model.addAttribute("openmsg1", "update");
			//目标文件的路径
			String path = "d:\\test\\appmodel";   //在目标路径下创建一个叫file的文件夹
			//上传文件的名字
			File target = new File(path, filename);             //创建目标文件的对象
			if(!target.getParentFile().exists()){           //判断文件所在文件夹是否存在，不存在创建一个
				target.getParentFile().mkdir();
			}
			if(target.exists()){
				target.delete(); 
		    }
			target.createNewFile();                         //在目标路径下创建文件
			InputStream in = file.getInputStream();         //创建输入流
			FileUtils.copyInputStreamToFile(in, target);    //调用插件方法，将上传文件内容写入目标文件，流到文件的形式
	           in.close();
		}	
		return "/flow.jsp";
	}
	
	@RequestMapping("/applicationshow") 
	@ResponseBody
	public Page<Application> applicationshow(Integer userid,String page){
		Page<Application> pg = new Page<Application>();
		Application app = new Application();
		app.setUserid(userid);
		pg = ifs.queryApplicationByPage(app, NumberFormatUtil.format(page, 1), 5);
		return pg;
	}
	@RequestMapping("/approveinfoshow") 
	@ResponseBody
	public Map<String,Object> approveinfoshow(Integer appid){
		Map<String,Object> map = new HashMap<String, Object>();
		map = ifs.approveinfoshow(appid);
		return map;
	}
	
	@RequestMapping("/mytaskshow") 
	@ResponseBody
	public Map<String,Object> mytaskshow(String username){
		Map<String,Object> map = new HashMap<String, Object>();
		List<Application> list = new ArrayList<Application>();
		List<Application> list1 = new ArrayList<Application>();
		List<User> list2 = new ArrayList<User>();
		TaskQuery query = tser.createTaskQuery();
		query.taskCandidateUser(username);
		List<Task> task = query.list();
		for (Task task2 : task) {
			Integer i = (Integer) tser.getVariable(task2.getId(), "appid");
			Application appli = new Application();
			appli.setId(i);
			for(Application app : ifs.queryApplication(appli)){
				for(User user : ius.queryUser(new User(app.getUserid()))){
					list2.add(user);
				}
				list.add(app);
			}
		}
		TaskQuery query1 = tser.createTaskQuery();
		query1.taskAssignee(username);
		List<Task> task1 = query1.list();
		for (Task task2 : task1) {
			Integer i = (Integer) tser.getVariable(task2.getId(), "appid");
			Application appli = new Application();
			appli.setId(i);
			for(Application app : ifs.queryApplication(appli)){
				for(User user : ius.queryUser(new User(app.getUserid()))){
					list2.add(user);
				}
				list1.add(app);
			}
			
		}
		map.put("gapps", list);
		map.put("papps", list1);
		map.put("usermeg", list2);
		return map;
	}
	@RequestMapping("/getTask") 
	@ResponseBody
	public String getTask(String username,Integer appid){
		TaskQuery query = tser.createTaskQuery();
		query.taskCandidateUser(username);
		List<Task> task = query.list();
		for (Task task2 : task) {
			Integer i = (Integer)tser.getVariable(task2.getId(), "appid");
			if(i.equals(appid)){
				tser.claim(task2.getId() , username );
				return "ok";
			}
		}
		return "notask";
	}
	@RequestMapping("/checkTask") 
	@ResponseBody
	public Map<String,Object> checkTask(String username,Integer appid,String taskmeg){
		Map<String,Object> map = new HashMap<String, Object>();
		List<Approveinfo> list3 = new ArrayList<Approveinfo>();
		List<User> list2 = new ArrayList<User>();
		List<Application> list = new ArrayList<Application>();
		if("gapp".equals(taskmeg)){
			TaskQuery query = tser.createTaskQuery();
			query.taskCandidateUser(username);
			List<Task> task = query.list();
			for (Task task2 : task) {
				Integer i = (Integer)tser.getVariable(task2.getId(), "appid");
				if(i.equals(appid)){
					Application appli = new Application();
					appli.setId(i);
					for(Application app : ifs.queryApplication(appli)){
						for(User user : ius.queryUser(new User(app.getUserid()))){
							list2.add(user);
						}
						for(Approveinfo api : ifs.queryApproveinfo(appid)){
							for(User user1 : ius.queryUser(new User(api.getUserid()))){
								list2.add(user1);
							}
							list3.add(api);
						}
						list.add(app);
					}
				}
			}
		}else if("papp".equals(taskmeg)){
			TaskQuery query = tser.createTaskQuery();
			query.taskAssignee(username);
			List<Task> task = query.list();
			for (Task task2 : task) {
				String mg = (String) tser.getVariable(task2.getId(), "acttype");
				if("zu".equals(mg)){
					taskmeg = "zu";
				}
				Integer i = (Integer) tser.getVariable(task2.getId(), "appid");
				if(i.equals(appid)){
					Application appli = new Application();
					appli.setId(i);
					for(Application app : ifs.queryApplication(appli)){
						for(User user : ius.queryUser(new User(app.getUserid()))){
							list2.add(user);
						}
						for(Approveinfo api : ifs.queryApproveinfo(appid)){
							for(User user1 : ius.queryUser(new User(api.getUserid()))){
								list2.add(user1);
							}
							list3.add(api);
						}
						list.add(app);
					}
					break;
				}
			}
		}
		map.put("app", list);
		map.put("api", list3);
		map.put("usermeg", list2);
		map.put("taskmsg", taskmeg);
		return map;
	}
	
	@RequestMapping("/dealTask") 
	public String dealTask(String username,Integer appid,Integer userid,String comment,
			String approval,Model model){
		String prid = null;
		if("同意".equals(approval)){
			TaskQuery query = tser.createTaskQuery();
			query.taskAssignee(username);
			List<Task> task = query.list();
			for (Task task2 : task) {
				Integer i = (Integer) tser.getVariable(task2.getId(), "appid");
				if(i.equals(appid)){
					tser.complete(task2.getId());
					prid = task2.getProcessInstanceId();
				}	
			}
			ifs.addApproveinfo(appid, userid, comment, approval);	
			List<ProcessInstance> pr = rtser.createProcessInstanceQuery().processInstanceId(prid).list();
			if(pr.size()==0){
				ifs.updateApplication("已通过", appid);
			}
		}else if("驳回".equals(approval)){
			TaskQuery query = tser.createTaskQuery();
			query.taskAssignee(username);
			List<Task> task = query.list();
			for (Task task2 : task) {
				Integer i = (Integer) tser.getVariable(task2.getId(), "appid");
				if(i.equals(appid)){
					rtser.deleteProcessInstance(task2.getProcessInstanceId(), null);;
				}	
			}
			ifs.addApproveinfo(appid, userid, comment, approval);
			ifs.updateApplication("已拒绝", appid);
		}else if("搁置".equals(approval)){
			TaskQuery query = tser.createTaskQuery();
			query.taskAssignee(username);
			List<Task> task = query.list();
			for (Task task2 : task) {
				Integer i = (Integer) tser.getVariable(task2.getId(), "appid");
				if(i.equals(appid)){
					tser.setAssignee(task2.getId() , null);;
				}	
			}
		}
		model.addAttribute("flag", 5);
		return "/flow.jsp";
	}
}