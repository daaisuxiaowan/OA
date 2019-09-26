package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import model.Knowledge;
import model.Page;
import service.IKnowledgeService;

@Controller
@RequestMapping("/knowledge")
public class KnowledgeController {
	@Resource
	private IKnowledgeService iks;
	@RequestMapping()
	public String know(){
		return "redirect:/knowledge.jsp";
	}
	@RequestMapping("/knowledgeshow")   //默认放过
	@ResponseBody
	public Page<Knowledge> knowledgeshow(String starttime,String endtime,String name,String page){
		Page<Knowledge> pg = new Page<Knowledge>();
		pg.setPage(utils.NumberFormatUtil.format(page, 1));
		pg.setPageSize(5);
		pg = iks.queryKnowledgeByPage(starttime, endtime, name, pg);	
		return pg;
	}
	@RequestMapping("/addknowledgealax")   //默认放过
	@ResponseBody
	public String addknowledgealax(){	
		return "addkn";
	}
	@RequestMapping("addKnowledge")
	public String addKnowledge(String publisher,String name,MultipartFile file) throws IOException{
		Knowledge kn = new Knowledge();
		kn.setName(name);
		kn.setPublisher(publisher);
		kn.setReleasedate(utils.TimeUtil.dateformat(new Date()));
		String path = "d:\\test\\knowledge";   //在目标路径下创建一个叫file的文件夹
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
           kn.setFilepath(filename);
        iks.addKnowledge(kn);
		return "redirect:/knowledge.jsp";
	}
	
	@RequestMapping("deleteKnowledge")
	public String deleteKnowledge(Integer id){
		iks.deleteKnowledge(id);
		return "redirect:/knowledge.jsp";
	}
	
	@RequestMapping("/knowledgeDownload")  
	public ResponseEntity<byte[]> knowledgeDownload(String path) throws IOException{ //下载的方法需要返回ResponseEntity<byte[]>类型，一般参数传入文件的名字
		String parentPath = "d:\\test\\knowledge";  //获取目标文件所在文件夹
		File file = new File(parentPath,path);  //创建file对象，地址为指定好的
		HttpHeaders headers = new HttpHeaders();  //创建HttpHeaders对象，下载方法需要的参数之一
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);  //设置传输的方式，流的形式
		String filename = new String(path.getBytes("utf-8"), "iso-8859-1");  //如果传输文件的名字为中文，需要转码，让浏览器识别
		headers.setContentDispositionFormData("attchment", filename );  //将文件的地址传入参数
		ResponseEntity<byte[]> re = new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
          //前两个参数需要配置，第三个参数固定设置为HttpStatus.CREATED
		return re;  //返回ResponseEntity<byte[]>对象给前端
	}
}
