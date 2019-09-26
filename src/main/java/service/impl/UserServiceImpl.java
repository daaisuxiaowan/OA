package service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dao.IDeptDao;
import dao.IMenuDao;
import dao.IRoleDao;
import dao.IUserDao;
import model.Dept;
import model.Menu;
import model.Page;
import model.Role;
import model.User;
import service.IUserService;

@Service
@Transactional
public class UserServiceImpl implements IUserService{
	@Resource
	private IUserDao iud;
	@Resource
	private IRoleDao ird;
	@Resource 
	private IMenuDao imd;
	@Resource
	private IDeptDao idd;
	public User loginUser(User user) {
		return iud.loginUser(user);
	}
	public void addUser(User user) {
		iud.addUser(user);
		for(Role r : user.getRoles()){
			iud.addUser_role(user.getId(), r.getId());
		}
	}
	public void deleteUser(int id) {
		iud.deleteUser(id);
		iud.deleteUser_role(id);
	}
	public void updateUser(User user) {
		iud.updateUser(user);
		iud.deleteUser_role(user.getId());
		for(Role r : user.getRoles()){
			iud.addUser_role(user.getId(), r.getId());
		}		
	}
	public List<User> queryUser(User user) {		
		return iud.queryUser(user);
	}
	public List<Menu> queryMenu(Menu menu) {		
		return imd.queryMenu(menu);
	}
	public Page<Menu> queryMenuByPage(Page<Menu> page) {
		page.setResult(imd.queryMenuByPage(page));
		page.setTotalCount(imd.queryMenu(null).size());
		return page;
	}
	public void updateMenu(Menu menu) {
		imd.updateMenu(menu);		
	}
	public void addMenu(Menu menu) {
		imd.addMenu(menu);
	}
	public void deleteMenu(Integer id) {
		Menu menu = new Menu();
		menu.setPid(id);
		List<Menu> list = new ArrayList<Menu>();
		list=imd.queryMenu(menu);
		System.out.println(list.size());
		if(list.size()!=0){
			for (Menu menu2 : list) {
				deleteMenu(menu2.getId());
			}
		}
		menu.setPid(null);
		menu.setId(id);
		imd.deleteMenu(menu);
	}
	public Page<Role> queryRoleByPage(Page<Role> page) {
		page.setResult(ird.queryRoleByPage(page));
		page.setTotalCount(ird.queryRole(null).size());
		return page;
	}
	public List<Role> queryRole(Integer id) {
		return ird.queryRole(id);
	}
	public void updateRole(Role role) {
		ird.updateRole(role);
		ird.deleteRole_menu(role.getId());
		for(Menu m : role.getMenus()){
			ird.addRole_menu(role.getId(), m.getId());
		}	
	}
	public void addRole(Role role) {
		ird.addRole(role);
		for(Menu m : role.getMenus()){
			ird.addRole_menu(role.getId(), m.getId());
		}
	}
	public void deleteRole(Integer id) {
		ird.deleteRole(id);
		ird.deleteRole_menu(id);
	}
	public Page<Dept> queryDeptByPage(Page<Dept> page) {
		page.setResult(idd.queryDeptByPage(page));
		page.setTotalCount(idd.queryDept(null).size());
		return page;
	}
	public List<Dept> queryDept(Integer id) {	
		return idd.queryDept(id);
	}
	public void updateDept(Dept dept) {
		idd.updateDept(dept);
	}
	public void addDept(Dept dept) {
		idd.addDept(dept);
	}
	public void deleteDept(Integer id) {
		idd.deleteDept(id);
	}
	public Page<User> queryUserByPage(Page<User> page,String ssname,Integer ssdept) {
		User user = new User();
		user.setDeptid(ssdept);
		user.setName(ssname);
		page.setResult(iud.queryUserByPage(page.getBegin(),page.getPageSize(),user.getName(),user.getDeptid()));
		page.setTotalCount(iud.queryUser(user).size());
		return page;
	}

}
