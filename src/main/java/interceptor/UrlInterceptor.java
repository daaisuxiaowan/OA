package interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;


public class UrlInterceptor implements HandlerInterceptor{

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		/*if (request.getRequestURI().indexOf("login") >= 0) {
			return true;
		}
		HttpSession se = request.getSession();
		User user = (User) se.getAttribute("user");
		if(user==null){
			response.sendRedirect("/oa/login.html");
			return false;
		}
		String msg = request.getParameter("ajaxmsg");  //接受ajax的信息，有值则为ajax，没有则为其他跳转
		Map<String,Menu> map = new HashMap<String, Menu>();
		List<String> list = new ArrayList<String>();
		String[] urls = request.getRequestURI().substring(1).split("/");
		String url = urls[urls.length-1];
		String yz = url.substring(url.length()-3, url.length());
		if("jsp".equals(yz)){
			return true;
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
				return true;		
			}	
		}
		if(msg==null || "".equals(msg)){   //其他跳转就直接跳转到无权限页面
			response.sendRedirect("/oa/warnning.jsp");
		}else{
			PrintWriter out = response.getWriter();	  //有值传值到ajax，ajax判断				
			out.print("ajaxmsg");                                  
			out.flush();
			out.close();
		}
		return false;*/
		return true;
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
