package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import model.Announcement;
import model.Dept;
import model.Menu;
import model.Page;
import model.Role;
import model.User;
import service.IAnnouncementService;
import service.IUserService;
import utils.NumberFormatUtil;

@Controller
@RequestMapping("/main")
public class Main {
	@Resource
	private IUserService ius;
	@Resource
	private IAnnouncementService ias;
	@Resource
	private HttpServletRequest request; 
	
	@RequestMapping("/login")    //需要放过
	public String login(String loginname,String pwd){
		HttpSession se = request.getSession();
		User user = new User();
		user.setLoginname(loginname);
		user.setPwd(pwd);
		user = ius.loginUser(user);
		if(user!=null){
			se.setAttribute("user", user);
			Map<String,Menu> set = new HashMap<String,Menu>();
			for (Role role : user.getRoles()) {
				for(Menu menu : role.getMenus()){
					set.put(menu.getMenuname(),menu);
				}
			}
			se.setAttribute("menuset", set);
			Announcement an = new Announcement();
			for(Announcement an1 : ias.queryAnnouncement(null)){
				an = an1;
				break;
			}
			se.setAttribute("an", an);
			return "redirect:/menu.jsp";	
		}
		return "redirect:/login.html?flag=-1";
	}
	@RequestMapping("/exit")    //需要放过
	public String exit(){
		HttpSession se = request.getSession();
		se.removeAttribute("user");
		se.removeAttribute("menuset");
		se.removeAttribute("an");
		return "redirect:/login.html";
	}
	@RequestMapping("/checkUser")    //需要放过
	@ResponseBody
	public List<User> checkUser(){
		return ius.queryUser(null);
	}
	
	@RequestMapping()    
	public String main1(){
			return "redirect:/menu.jsp";
	}
	
	@RequestMapping("/childmenu")
	@ResponseBody
	public List<Menu> childmenu(Integer pid){
		HttpSession se = request.getSession();
		@SuppressWarnings("unchecked")
		Map<String,Menu> map = (Map<String, Menu>) se.getAttribute("menuset");
		Menu menu = new Menu();
		menu.setPid(pid);
		List<Menu> list = new ArrayList<Menu>();
		List<Menu> list1 = new ArrayList<Menu>();
		list = ius.queryMenu(menu);
		for (Menu menu2 : list) {
			for(Entry<String,Menu> en : map.entrySet()){
				if(menu2.getMenuname().equals(en.getKey())){
					list1.add(menu2);
				}
			}
		}
		return list1;
	}
	@RequestMapping("/menushow")
	@ResponseBody
	public Map<String,Object> menushow(String page){
		Page<Menu> pg = new Page<Menu>();
		List<Menu> list =new ArrayList<Menu>();
		Map<String,Object> map = new HashMap<String, Object>();
		pg.setPage(NumberFormatUtil.format(page, 1));
		pg.setPageSize(5);
		pg = ius.queryMenuByPage(pg);
		list = ius.queryMenu(null);
		map.put("menulist", list);
		map.put("pg", pg);
		return map;
	}
	@RequestMapping("/queryoneMenu")   // 查询要修改的菜单，默认放过
	public String queryoneMenu(Integer menuid,Model model){
		List<Menu> list = new ArrayList<Menu>();
		model.addAttribute("flag", "add");
		if(menuid!=null){
			Menu menu = new Menu();
			menu.setId(menuid);
			list = ius.queryMenu(menu);
			for (Menu menu2 : list) {
				menu = menu2;
			}
			model.addAttribute("menu", menu);
			model.addAttribute("flag", "update");
		}
		list = ius.queryMenu(null);
		model.addAttribute("menulist", list);
		return "/updateMenu.jsp";
	}
	@RequestMapping("/changemenu")   // 查询要修改的菜单，默认放过
	@ResponseBody
	public List<Menu> changemenu(){
		return ius.queryMenu(null);
	}
	@RequestMapping("/updateMenu")
	public String updateMenu(Integer menuid,String menuname,String menulink,String securyname,
			Integer pid,String memo,Model model){
		Menu menu = new Menu();
		menu.setId(menuid);
		menu.setMenuname(menuname);
		menu.setMenulink(menulink);
		menu.setSecuryname(securyname);
		menu.setPid(pid);
		menu.setMemo(memo);
		ius.updateMenu(menu);
		model.addAttribute("flag", 1);
		return "/menu.jsp";
	}
	@RequestMapping("/addMenu")
	public String addMenu(String menuname,String menulink,String securyname,
			Integer pid,String memo,Model model){
		Menu menu = new Menu();
		menu.setMenuname(menuname);
		menu.setMenulink(menulink);
		menu.setSecuryname(securyname);
		menu.setPid(pid);
		menu.setMemo(memo);
		ius.addMenu(menu);
		model.addAttribute("flag", 1);
		return "/menu.jsp";
	}
	@RequestMapping("/deleteMenu")
	public String doAddMenu(Integer id,Model model){
		ius.deleteMenu(id);;
		model.addAttribute("flag", 1);
		return "/menu.jsp";
	}
	@RequestMapping("/roleshow")
	@ResponseBody
	public Page<Role> roleshow(String page){
		Page<Role> pg = new Page<Role>();
		pg.setPage(NumberFormatUtil.format(page, 1));
		pg.setPageSize(5);
		pg = ius.queryRoleByPage(pg);
		return pg;
	}
	@RequestMapping("/queryoneRole")   // 查询要修改的角色，默认放过
	public String queryoneRole(Integer roleid,Model model){
		List<Menu> list = new ArrayList<Menu>();
		model.addAttribute("flag", "add");
		if(roleid!=null){
			for (Role role : ius.queryRole(roleid)) {
				model.addAttribute("role", role);
			}
			model.addAttribute("flag", "update");
		}
		list = ius.queryMenu(null);
		model.addAttribute("menulist", list);
		return "/updateRole.jsp";
	}
	@RequestMapping("/updateRole")
	public String updateRole(Integer id,String rolename,Integer[] menuname,String memo,Model model){
		Role role = new Role();
		List<Menu> li = new ArrayList<Menu>();
		role.setId(id);
		role.setRolename(rolename);
		role.setMemo(memo);
		for (Integer i : menuname) {
			Menu menu = new Menu();
			menu.setId(i);
			List<Menu> list = new ArrayList<Menu>();
			list = ius.queryMenu(menu);
			for (Menu menu2 : list) {
				li.add(menu2);
			}
		}
		role.setMenus(li);
		ius.updateRole(role);
		model.addAttribute("flag", 2);
		HttpSession se = request.getSession();
		User user = (User) se.getAttribute("user");
		for(User u : ius.queryUser(user)){
			user = u;
		}
		se.setAttribute("user", user);
		Map<String,Menu> set = new HashMap<String,Menu>();
		for (Role roles : user.getRoles()) {
			for(Menu menu : roles.getMenus()){
				set.put(menu.getMenuname(),menu);
			}
		}
		se.setAttribute("menuset", set);
		return "/menu.jsp";
	}
	@RequestMapping("/addRole")
	public String updateRole(String rolename,Integer[] menuname,String memo,Model model){
		Role role = new Role();
		List<Menu> li = new ArrayList<Menu>();
		role.setRolename(rolename);
		role.setMemo(memo);
		for (Integer i : menuname) {
			Menu menu = new Menu();
			menu.setId(i);
			List<Menu> list = new ArrayList<Menu>();
			list = ius.queryMenu(menu);
			for (Menu menu2 : list) {
				li.add(menu2);
			}
		}
		role.setMenus(li);
		ius.addRole(role);
		model.addAttribute("flag", 2);
		return "/menu.jsp";
	}
	@RequestMapping("/deleteRole")
	public String deleteRole(Integer id,Model model){
		ius.deleteRole(id);
		model.addAttribute("flag", 2);
		return "/menu.jsp";
	}
	@RequestMapping("/deptshow")
	@ResponseBody
	public Page<Dept> deptshow(String page,Integer fse){
		System.out.println(fse);
		Page<Dept> pg = new Page<Dept>();
		pg.setPage(NumberFormatUtil.format(page, 1));
		pg.setPageSize(5);
		pg = ius.queryDeptByPage(pg);
		return pg;
	}
	@RequestMapping("/updateDept")
	public String updateDept(Integer id,String deptname,Model model){
		Dept dept = new Dept();
		dept.setId(id);
		dept.setDeptname(deptname);
		ius.updateDept(dept);
		model.addAttribute("flag", 3);
		return "/menu.jsp";
	}
	@RequestMapping("/addDept")
	public String addDept(String deptname,Model model){
		Dept dept = new Dept();
		dept.setDeptname(deptname);
		ius.addDept(dept);
		model.addAttribute("flag", 3);
		return "/menu.jsp";
	}
	@RequestMapping("/deleteDept")
	public String deleteDept(Integer id,Model model){
		ius.deleteDept(id);
		model.addAttribute("flag", 3);
		return "/menu.jsp";
	}
	@RequestMapping("/usershow")
	@ResponseBody
	public Map<String,Object> usershow(String page,String ssname,Integer ssdept){
		Map<String,Object> map = new HashMap<String, Object>();
		List<Dept> list = new ArrayList<Dept>();
		Page<User> pg = new Page<User>();
		pg.setPage(NumberFormatUtil.format(page, 1));
		pg.setPageSize(5);
		pg = ius.queryUserByPage(pg,ssname,ssdept);
		list = ius.queryDept(null);
		map.put("pg", pg);
		map.put("dept", list);
		return map;
	}
	@RequestMapping("/queryoneUser")   // 查询要修改的用户，默认放过
	public String queryoneUser(Integer id,String msg,Model model){
		User user = new User();
		user.setId(id);
		if(msg!=null){
				model.addAttribute("flag", "updatemyuser");
		}else{
			List<Role> list = new ArrayList<Role>();
			List<Dept> list1 = new ArrayList<Dept>();
			model.addAttribute("flag", "add");
			if(id!=null){
				for (User user1 : ius.queryUser(user)) {
					model.addAttribute("updateuser", user1);
				}
				model.addAttribute("flag", "update");
			}
			list = ius.queryRole(null);
			model.addAttribute("Rolelist", list);
			list1 = ius.queryDept(null);
			model.addAttribute("Deptlist", list1);
		}
		return "/updateUser.jsp";
	}
	@RequestMapping("/updateUser")
	public String updateUser(Integer id,String pwd,String name,String sex,
			Integer deptid,Integer[] roleids,Model model){
		User user = new User();
		user.setId(id);
		List<User> li1 = new ArrayList<User>();
		li1 = ius.queryUser(user);
		for (User i : li1) {
			user = i;
		}
		List<Role> li = new ArrayList<Role>();
		user.setPwd(pwd);
		user.setName(name);
		user.setSex(sex);
		user.setDeptid(deptid);
		if(roleids!=null){
			for (Integer i : roleids) {
				List<Role> list = new ArrayList<Role>();
				list = ius.queryRole(i);
				for (Role menu2 : list) {
					li.add(menu2);
				}
			}		
			user.setRoles(li);
		}
		ius.updateUser(user);
		model.addAttribute("flag", 4);
		model.addAttribute("openmsg", "update");
		return "/menu.jsp";
	}
	@RequestMapping("/addUser")
	public String addUser(String loginname,String pwd,String name,String sex,
			Integer deptid,Integer[] roleids,Model model){
		User user = new User();
		List<Role> li = new ArrayList<Role>();
		user.setLoginname(loginname);
		user.setPwd(pwd);
		user.setName(name);
		user.setDeptid(deptid);
		user.setSex(sex);
		if(roleids!=null){
			for (Integer i : roleids) {
				List<Role> list = new ArrayList<Role>();
				list = ius.queryRole(i);
				for (Role menu2 : list) {
					li.add(menu2);
				}
			}		
		}
		user.setRoles(li);
		ius.addUser(user);
		model.addAttribute("flag", 4);
		model.addAttribute("openmsg", "add");
		return "/menu.jsp";
	}
	@RequestMapping("/deleteUser")
	public String deleteUser(Integer id,Model model){
		ius.deleteUser(id);
		model.addAttribute("flag", 4);
		return "/menu.jsp";
	}
	@RequestMapping("/updateMyUser")
	public String updateMyUser(Integer id,String name,String sex,
			Integer deptid,Integer[] roleids,Model model){
		User user = new User();
		user.setId(id);
		List<User> li = new ArrayList<User>();
		li = ius.queryUser(user);
		for (User i : li) {
			user = i;
		}
		user.setName(name);
		user.setSex(sex);
		ius.updateUser(user);
		model.addAttribute("flag", 5);
		return "/menu.jsp";
	}
	@RequestMapping("/myuser")
	@ResponseBody
	public Map<String,Object> myuser(Integer id){
		Map<String,Object> map = new HashMap<String, Object>();
		List<Dept> list = new ArrayList<Dept>();
		List<User> list2 = new ArrayList<User>();
		User user = new User();
		user.setId(id);
		list2 = ius.queryUser(user);
		for (User user1 : list2) {
			map.put("myuser", user1);		
		}
		list = ius.queryDept(null);
		map.put("dept", list);
		return map;
	}
}
