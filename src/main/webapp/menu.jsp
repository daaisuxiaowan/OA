<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="width:100%;height:900px;">
		<jsp:include page="/mainmodel.jsp"></jsp:include>
	</div>
	<div style="position:absolute;lfet:50%;top:15%;width:100%;">
		<span id="showspan" style="position:absolute;left:35%;top:50%;">
			<span id="showspanchild">
				<span style="position:relative;left:330%;">
					<h2 style="position:relative;left:30%;font-size:35px;">公告栏</h2>
						<span  >
							<table border="5" style="border-collapse:collapse;border-color:#ddd;position:relative;">
								<tr style='width:250px;height:70px;'>
									<td style='text-align: center;width:250px;vertical-align:top'>${an.name}</td>
								</tr>
								<tr style='width:250px;height:300px;'>
									<td style='width:250px;vertical-align:top;'>内容:${an.content}</td>
								</tr>
							</table>
						</span>
				</span>
			</span><br/>
		</span>
	</div>
	<script>
		window.onload = function(){
			leftmenu(1);
			var flag = '${flag}';
			if(flag == 1){     //修改和增加后一进来就是展示菜单 
				menushow(1);
			}else if(flag == 2){     //修改和增加后一进来就是展示角色 
				roleshow(1);
			}else if(flag == 3){     //修改和增加后一进来就是展示部门  
				deptshow(1);
			}else if(flag == 4){     //修改和增加后一进来就是展示用户   
				var msg = '${openmsg}';
				if(msg == "update"){
					alert("修改成功");
				}else if(msg == "add"){
					alert("添加成功");
				}
				usershow(1);
			}else if(flag == 5){     //修改和增加后一进来就是展示用户 
				alert("修改成功")
				myuser();
			}
		};
		function $(id){
			return document.getElementById(id);
		}
		function addMenu(){
			window.location.href="${pageContext.request.contextPath}/main/queryoneMenu";
		}
		function addRole(){
			window.location.href="${pageContext.request.contextPath}/main/queryoneRole";
		}
		function addDept(){
			var showspan = $("showspanchild");
			showspan.innerHTML = "<form action='${pageContext.request.contextPath}/main/addDept'style=\"position:relative;left:30%;\">"
								+"部门名称：<input type='text' name='deptname' ><br/><br/>"
								+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='submit'> &nbsp;<input type='reset'>"
		}
		function addUser(){
			window.location.href="${pageContext.request.contextPath}/main/queryoneUser";
		}
		function myuser(){
			var showspan = $("showspanchild");
			var xhr = new XMLHttpRequest();		//获取ajax对象
			xhr.open("post","${pageContext.request.contextPath}/main/myuser?id="+'${user.id}'+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
			xhr.send();							//发送请求
			xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
				if(xhr.readyState==4&&xhr.status==200){
					var date = xhr.responseText;		//获取json传来的数据
					if(date == "ajaxmsg"){
						showspan.innerHTML="无访问权限";
					}else{
					date = eval("("+date+")");			//解析数据
					var myuser = date["myuser"];
					var dept = date["dept"];
					showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">我的信息</h2>"
										+"<div  ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
										+"<tr>"
											+"<th>编号</th>"
											+"<th>登录名</th>"
											+"<th>密码</th>"
											+"<th>真实姓名</th>"
											+"<th>性别</th>"
											+"<th>所属部门</th>"
											+"<th>角色</th>"
											+"<th>操作</th>"
										+"</tr>"
									+"</table></div><br>";
					var tab = $("tab1");
						var deptname = "无";
						for(var j=0;j<dept.length;j++){
							if(myuser.deptid == dept[j].id){
								deptname = dept[j].deptname;
							}
						}
						var tr = document.createElement("tr");
						tr.innerHTML = "<tr>"
									+"<td>"+myuser.id+"</td>"
									+"<td>"+myuser.loginname+"</td>"
									+"<td>"+myuser.pwd+"</td>"
									+"<td>"+myuser.name+"</td>"
									+"<td>"+myuser.sex+"</td>"
									+"<td>"+deptname+"</td>"
									+"<td><select id='userselect"+myuser.id+"'></select></td>"
									+"<td><a href='${pageContext.request.contextPath}/main/queryoneUser?msg=updatemyuser'>修改</a>&nbsp;"
									+"</tr>";
						tab.appendChild(tr);
						var roles = myuser.roles;
						var roleselect = $("userselect"+myuser.id);
						for(var j=0;j<roles.length;j++){
							var option = document.createElement("option");
							option.innerHTML = roles[j].rolename;
							roleselect.appendChild(option);
						}
					}
				}
			}
		}
		function getusershow(page){
			var ssname = $("ssname").value;
			var ssdept = $("ssdept").value;
			usershow(page,ssname,ssdept);
		}
		function usershow(page,ssname,ssdept){
			if(ssname==null){
				ssname="";
			}
			if(ssdept==null){
				ssdept="";
			}
			var showspan = $("showspanchild");
			var xhr = new XMLHttpRequest();		//获取ajax对象
			xhr.open("post","${pageContext.request.contextPath}/main/usershow?page="+page+"&ssname="+ssname+"&ssdept="+ssdept+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
			xhr.send();							//发送请求
			xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
				if(xhr.readyState==4&&xhr.status==200){
					var date = xhr.responseText;		//获取json传来的数据
					if(date == "ajaxmsg"){
						showspan.innerHTML="无访问权限";
					}else{
					date = eval("("+date+")");			//解析数据
					var pg = date["pg"];
					var user = pg.result;
					var dept = date["dept"];
					showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">用户信息</h2>"
										+"姓名：<input type='text' id='ssname' value='"+ssname+"' style=\"width:120px;height:26px;font-size:25px;position:relative;bottom:1px;\">&nbsp;&nbsp;"
										+"部门：<select id='ssdept' style=\"width:100px;height:27px;font-size:25px;\"><option value=''></option></select>"
										+"&nbsp;&nbsp;<button onclick='getusershow("+pg.page+")' style=\"position:relative;bottom:1px;font-size:25px;\">搜索</button>"
										+"<div  ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
										+"<tr>"
											+"<th>编号</th>"
											+"<th>真实姓名</th>"
											+"<th>性别</th>"
											+"<th>所属部门</th>"
											+"<th>角色</th>"
											+"<th>操作</th>"
										+"</tr>"
									+"</table></div><br><span id=\"rd\"></span>";
					var tab = $("tab1");
					var deptselect = $("ssdept");
					for(var i=0;i<user.length;i++){
							var deptname = "无";
							for(var j=0;j<dept.length;j++){
								if(user[i].deptid==dept[j].id){
									deptname = dept[j].deptname;
								}
							}
							var tr = document.createElement("tr");
							tr.innerHTML = "<tr>"
										+"<td>"+user[i].id+"</td>"
										+"<td style=\"width:150px;\">"+user[i].name+"</td>"
										+"<td>"+user[i].sex+"</td>"
										+"<td style=\"width:140px;\">"+deptname+"</td>"
										+"<td style=\"width:160px;\"><select id='userselect"+user[i].id+"' style=\"width:130px;height:27px;font-size:22px;\"></select></td>"
										+"<td><a href='${pageContext.request.contextPath}/main/queryoneUser?id="+user[i].id+"'>修改</a>&nbsp;"
										+"<a href=\"javascript:deleteMenu("+user[i].id+",'user')\">删除</a></td>"
										+"</tr>";
							tab.appendChild(tr);
							var roles = user[i].roles;
							var roleselect = $("userselect"+user[i].id);
							for(var j=0;j<roles.length;j++){
								var option = document.createElement("option");
								option.innerHTML = roles[j].rolename;
								roleselect.appendChild(option);
							}
					}
					for(var j=0;j<dept.length;j++){
						var op = document.createElement("option");
						op.innerHTML = dept[j].deptname;
						op.value = dept[j].id;
						if(ssdept==dept[j].id){
							op.selected = true;
						}
						deptselect.appendChild(op);
					}
					var rd = $("rd");
					rd.innerHTML = "<span><br>"
					+"共有"+pg.totalCount+"个用户，当前为："+pg.page+"/"+pg.totalPage+"页"
					+"</span>"
					+"<span style=\"position:relative;left:5%;\">"
					+"<a onclick=\"first('user')\" href=\"#\">首页</a> <a href=\"#\" onclick=\"back("+pg.page+",'user')\">上一页</a> <a href=\"#\" onclick=\"next("+pg.page+",'user',"+pg.totalPage+")\">下一页</a> <a href=\"#\" onclick=\"last("+pg.totalPage+",'user')\">尾页</a>"					
					+"</span>";
					}
				}
			}
		}
		function updateDept(id,deptname){
			var showspan = $("showspanchild");
			showspan.innerHTML = "<form action='${pageContext.request.contextPath}/main/updateDept'>"
								+"<input type='hidden' name='id' value='"+id+"'>"
								+"部门编号："+id+"<br/>"
								+"部门名称：<input type='text' name='deptname' value='"+deptname+"'><br/>"
								+"<input type='submit'> &nbsp;<input type='reset'>";
		}
		function deptshow(page){
			var showspan = $("showspanchild");
			var xhr = new XMLHttpRequest();		//获取ajax对象
			xhr.open("post","${pageContext.request.contextPath}/main/deptshow?page="+page+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
			xhr.send();							//发送请求
			xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
				if(xhr.readyState==4&&xhr.status==200){
					var date = xhr.responseText;		//获取json传来的数据
					if(date == "ajaxmsg"){
						showspan.innerHTML="无访问权限";
					}else{
					date = eval("("+date+")");			//解析数据
					var dept = date.result;
					showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">部门信息</h2>"
										+"<div style=\"position:relative;left:30%;\" ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
										+"<tr>"
											+"<th>部门编号</th>"
											+"<th>部门名称</th>"
											+"<th>操作</th>"
										+"</tr>"
									+"</table></div><br><span id=\"rd\"></span>";
					var tab = $("tab1");
					for(var i=0;i<dept.length;i++){
							var tr = document.createElement("tr");
							tr.innerHTML = "<tr>"
										+"<td>"+dept[i].id+"</td>"
										+"<td>"+dept[i].deptname+"</td>"
										+"<td><a href='javascript:updateDept("+dept[i].id+","+dept[i].deptname+")'>修改</a>&nbsp;"
										+"<a href=\"javascript:deleteMenu("+dept[i].id+",'dept')\">删除</a></td>"
										+"</tr>";
							tab.appendChild(tr);
					}
					var rd = $("rd");
					rd.innerHTML = "<span><br>"
					+"共有"+date.totalCount+"个部门，当前为："+date.page+"/"+date.totalPage+"页"
					+"</span>"
					+"<span style=\"position:relative;left:5%;\">"
					+"<a onclick=\"first('dept')\" href=\"#\">首页</a> <a href=\"#\" onclick=\"back("+date.page+",'dept')\">上一页</a> <a href=\"#\" onclick=\"next("+date.page+",'dept',"+date.totalPage+")\">下一页</a> <a href=\"#\" onclick=\"last("+date.totalPage+",'dept')\">尾页</a>"					
					+"</span>";
					}
				}
			}
		}
		function roleshow(page){
			var showspan = $("showspanchild");
			var xhr = new XMLHttpRequest();		//获取ajax对象
			xhr.open("post","${pageContext.request.contextPath}/main/roleshow?page="+page+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
			xhr.send();							//发送请求
			xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
				if(xhr.readyState==4&&xhr.status==200){
					var date = xhr.responseText;		//获取json传来的数据
					if(date == "ajaxmsg"){
						showspan.innerHTML="无访问权限";
					}else{
					date = eval("("+date+")");			//解析数据
					var role = date.result;
					showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">角色信息</h2>"
										+"<div  ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
										+"<tr>"
											+"<th>角色编号</th>"
											+"<th>角色名字</th>"
											+"<th>角色权限</th>"
											+"<th>角色说明</th>"
											+"<th>操作</th>"
										+"</tr>"
									+"</table></div><br><span id=\"rd\"></span>";
					var tab = $("tab1");
					for(var i=0;i<role.length;i++){
							var tr = document.createElement("tr");
							tr.innerHTML = "<tr>"
										+"<td>"+role[i].id+"</td>"
										+"<td>"+role[i].rolename+"</td>"
										+"<td><select id='roleselect"+role[i].rolename+"' style=\"width:130px;height:27px;font-size:22px;\"></select></td>"
										+"<td>"+role[i].memo+"</td>"
										+"<td><a href='${pageContext.request.contextPath}/main/queryoneRole?roleid="+role[i].id+"'>修改</a>&nbsp;"
										+"<a href=\"javascript:deleteMenu("+role[i].id+",'role')\">删除</a></td>"
										+"</tr>";
							tab.appendChild(tr);
							var menus = role[i].menus;
							var roleselect = $("roleselect"+role[i].rolename);
							for(var j=0;j<menus.length;j++){
								var option = document.createElement("option");
								option.innerHTML = menus[j].menuname;
								roleselect.appendChild(option);
							}
					}
					var rd = $("rd");
					rd.innerHTML = "<span><br>"
					+"共有"+date.totalCount+"个角色，当前为："+date.page+"/"+date.totalPage+"页"
					+"</span>"
					+"<span style=\"position:relative;left:5%;\">"
					+"<a onclick=\"first('role')\" href=\"#\">首页</a> <a href=\"#\" onclick=\"back("+date.page+",'role')\">上一页</a> <a href=\"#\" onclick=\"next("+date.page+",'role',"+date.totalPage+")\">下一页</a> <a href=\"#\" onclick=\"last("+date.totalPage+",'role')\">尾页</a>"					
					+"</span>";
					}
				}
			}
		
		}
		function menushow(page){
			var showspan = $("showspanchild");
			var xhr = new XMLHttpRequest();		//获取ajax对象
			xhr.open("post","${pageContext.request.contextPath}/main/menushow?page="+page+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
			xhr.send();							//发送请求
			xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
				if(xhr.readyState==4&&xhr.status==200){
					var date = xhr.responseText;		//获取json传来的数据
					if(date == "ajaxmsg"){
						showspan.innerHTML="无访问权限";
					}else{
					date = eval("("+date+")");			//解析数据
					var pg = date["pg"];
					var menu = pg.result;
					var menulist = date["menulist"];
					showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">菜单信息</h2>"
										+"<div  ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
										+"<tr>"
											+"<th>权限编号</th>"
											+"<th>权限名字</th>"
											+"<th>权限连接</th>"
											+"<th>权限级别</th>"
											+"<th>所属权限</th>"
											+"<th>权限说明</th>"
											+"<th>操作</th>"
										+"</tr>"
									+"</table></div><br><span id=\"rd\"></span>";
					var tab = $("tab1");
					for(var i=0;i<menu.length;i++){
						if(menu[i].pid==0){
							var tr = document.createElement("tr");
							tr.innerHTML = "<tr>"
										+"<td>"+menu[i].id+"</td>"
										+"<td>"+menu[i].menuname+"</td>"
										+"<td>"+menu[i].menulink+"</td>"
										+"<td>"+menu[i].securyname+"</td>"
										+"<td>"+menu[i].menuname+"</td>"
										+"<td>"+menu[i].memo+"</td>"
										+"<td><a href='${pageContext.request.contextPath}/main/queryoneMenu?menuid="+menu[i].id+"'>修改</a>&nbsp;"
										+"<a href=\"javascript:deleteMenu("+menu[i].id+",'menu')\">删除</a></td>"
										+"</tr>";
							tab.appendChild(tr);
						}else{
							for(var j=0;j<menulist.length;j++){
								if(menu[i].pid==menulist[j].id){
									var tr = document.createElement("tr");
									tr.innerHTML = "<tr>"
												+"<td>"+menu[i].id+"</td>"
												+"<td>"+menu[i].menuname+"</td>"
												+"<td>"+menu[i].menulink+"</td>"
												+"<td>"+menu[i].securyname+"</td>"
												+"<td>"+menulist[j].menuname+"</td>"
												+"<td>"+menu[i].memo+"</td>"
												+"<td><a href='${pageContext.request.contextPath}/main/queryoneMenu?menuid="+menu[i].id+"'>修改</a>&nbsp;"
												+"<a href=\"javascript:deleteMenu("+menu[i].id+",'menu')\">删除</a></td>"
												+"</tr>";
									tab.appendChild(tr);
								}
							}
						}
						
					}
					var rd = $("rd");
					rd.innerHTML = "<span><br>"
					+"共有"+pg.totalCount+"个权限，当前为："+pg.page+"/"+pg.totalPage+"页"
					+"</span>"
					+"<span style=\"position:relative;left:5%;\">"
					+"<a onclick=\"first('menu')\" href=\"#\">首页</a> <a href=\"#\" onclick=\"back("+pg.page+",'menu')\">上一页</a> <a href=\"#\" onclick=\"next("+pg.page+",'menu',"+pg.totalPage+")\">下一页</a> <a href=\"#\" onclick=\"last("+pg.totalPage+",'menu')\">尾页</a>"					
					+"</span>";
					}
				}
			}
		}
		function deleteMenu(v,turnname){
			var su = confirm("您确认要删除吗？");
			if(su==true){
				if(turnname=="menu"){
					window.location.href="${pageContext.request.contextPath}/main/deleteMenu?id="+v;
				}else if(turnname =="role"){
					window.location.href="${pageContext.request.contextPath}/main/deleteRole?id="+v;
				}else if(turnname =="dept"){
					window.location.href="${pageContext.request.contextPath}/main/deleteDept?id="+v;
				}else if(turnname =="user"){
					window.location.href="${pageContext.request.contextPath}/main/deleteUser?id="+v;
				}
			}
		}
		function first(func){
			if(func=="menu"){
				menushow(1);
			}else if(func=="role"){
				roleshow(1);
			}else if(func=="dept"){
				deptshow(1);
			}else if(func=="user"){
				getusershow(1);
			}
		}
		function back(v,func){
			var v = (v==1?1:v-1);
			if(func=="menu"){
				menushow(v);
			}else if(func=="role"){
				roleshow(v);
			}else if(func=="dept"){
				deptshow(v);
			}else if(func=="user"){
				getusershow(v);
			}
		}
		function next(v,func,m){
			var v = (v==m?m:v+1);
			if(func=="menu"){
				menushow(v);
			}else if(func=="role"){
				roleshow(v);
			}else if(func=="dept"){
				deptshow(v);
			}else if(func=="user"){
				getusershow(v);
			}
		}
		function last(v,func){
			if(func=="menu"){
				menushow(v);
			}else if(func=="role"){
				roleshow(v);
			}else if(func=="dept"){
				deptshow(v);
			}else if(func=="user"){
				getusershow(v);
			}
		}
	</script>
</body>
</html>