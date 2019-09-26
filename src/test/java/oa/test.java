package oa;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.apache.ibatis.session.SqlSession;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import dao.IUserDao;
import model.Menu;
import model.Page;
import model.Role;
import model.User;
import service.IUserService;

public class test {
	
	private SqlSession session = null;
	private ApplicationContext ac = null;

	@Before
	public void init() throws IOException{
//		InputStream in = Resources.getResourceAsStream("mybatis-config.xml");
//		SqlSessionFactory fac = new SqlSessionFactoryBuilder().build(in);
//		session = fac.openSession();
		ac = new ClassPathXmlApplicationContext("ApplicationContext.xml");
	}
	@Test
	public void test1(){
		IUserService ius = (IUserService) ac.getBean("userServiceImpl");
		Menu mu = new Menu();
		Page<Role> page = new Page<Role>();
		page.setPage(1);
		page.setPageSize(5);
//		mu.setId(1);
		System.out.println(ius.queryRoleByPage(page).getResult());
     }
	
	@Test
	public void test2(){
		ProcessEngine pe = ProcessEngines.getDefaultProcessEngine();
		pe.getRuntimeService().deleteProcessInstance("2501", null);;
	}
	
}
