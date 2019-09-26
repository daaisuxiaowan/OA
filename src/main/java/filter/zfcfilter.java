package filter;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Menu;
import model.User;

public class zfcfilter implements Filter {


    public zfcfilter() {
        
    }

	public void destroy() {
		
	}

	@SuppressWarnings("unchecked")
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		/*
		 * 统一所有页面的字符集编码为UTF-8
		 */
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;character=utf-8");
		String[] urls = req.getRequestURI().substring(1).split("/");
		String url = urls[urls.length-1];
		String[] fgs = url.split("\\.");
		if("png".equals(fgs[fgs.length-1]) || "js".equals(fgs[fgs.length-1]) || "html".equals(fgs[fgs.length-1]) || "gif".equals(fgs[fgs.length-1]) || "css".equals(fgs[fgs.length-1]) || "login".equals(url)
				|| "exit".equals(url) ||"checkUser".equals(url) || "download".equals(url)){
			chain.doFilter(req, resp);
			return;
		}
		HttpSession se = req.getSession();
		User user = (User) se.getAttribute("user");
		if(user==null){
			resp.sendRedirect("/oa/login.html");
			return;
		}
		String msg = req.getParameter("ajaxmsg");  //接受ajax的信息，有值则为ajax，没有则为其他跳转
		Map<String,Menu> map = new HashMap<String, Menu>();
		List<String> list = new ArrayList<String>();
		if("jsp".equals(fgs[fgs.length-1])){
			chain.doFilter(req, resp);
			return;
		}
		map = (Map<String, Menu>) se.getAttribute("menuset");
		for (Entry<String, Menu> en : map.entrySet()) {
			if("addRole".equals(en.getValue().getMenulink()) || "updateRole".equals(en.getValue().getMenulink())){
				list.add("queryoneRole");
			}
			if("addUser".equals(en.getValue().getMenulink()) || "updateUser".equals(en.getValue().getMenulink())){
				list.add("queryoneUser");
			}
			if("addMenu".equals(en.getValue().getMenulink()) || "updateMenu".equals(en.getValue().getMenulink())){
				list.add("queryoneMenu");
				list.add("changemenu");
			}
			if("addAct".equals(en.getValue().getMenulink()) || "updateAct".equals(en.getValue().getMenulink())){
				list.add("queryoneAct");
			}
			if("addTemplate".equals(en.getValue().getMenulink()) || "updateTemplate".equals(en.getValue().getMenulink())){
				list.add("queryoneTemplate");
			}
			if("knowledge".equals(en.getValue().getMenulink())){
				list.add("knowledgeshow");
			}
			if("addKnowledge".equals(en.getValue().getMenulink())){
				list.add("addknowledgealax");
			}
			if("announcement".equals(en.getValue().getMenulink())){
				list.add("announcementshow");
			}
			if("addAnnouncement".equals(en.getValue().getMenulink())){
				list.add("addAnnouncementalax");
			}
			if("checkTask".equals(en.getValue().getMenulink())){
				list.add("getTask");
			}
			list.add(en.getValue().getMenulink());
		}
		for (String str : list) {
			if(url.equals(str)){
				chain.doFilter(req, resp);	
				return;
			}	
		}
		if(msg==null || "".equals(msg)){   //其他跳转就直接跳转到无权限页面
			resp.sendRedirect("/oa/warnning.jsp");
			return;
		}else{
			PrintWriter out = resp.getWriter();	  //有值传值到ajax，ajax判断				
			out.print("ajaxmsg");                                  
			out.flush();
			out.close();
			return;
		}				
	}

	public void init(FilterConfig fConfig) throws ServletException {

	}

}
