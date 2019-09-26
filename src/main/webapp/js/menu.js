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
			window.location.href="queryoneMenu";
		}
		function addRole(){
			window.location.href="queryoneRole";
		}
		function addDept(){
			var showspan = $("showspan");
			showspan.innerHTML = "<form action='addDept'>"
								+"部门名称：<input type='text' name='deptname' ><br/>"
								+"<input type='submit'> &nbsp;<input type='reset'>"
		}
		function addUser(){
			window.location.href="queryoneUser";
		}
		function myuser(){
			var showspan = $("showspanchild");
			var xhr = new XMLHttpRequest();		//获取ajax对象
			xhr.open("post","myuser?id="+'${user.id}',true);  //连接获取指定商品信息的servlet
			xhr.send();							//发送请求
			xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
				if(xhr.readyState==4&&xhr.status==200){
					var date = xhr.responseText;		//获取json传来的数据
					date = eval("("+date+")");			//解析数据
					var myuser = date["myuser"];
					var dept = date["dept"];
					showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">部门信息</h2>"
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
									+"<td><a href='queryoneUser?msg=updatemyuser'>修改</a>&nbsp;"
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
		function usershow(page){
			var showspan = $("showspanchild");
			var xhr = new XMLHttpRequest();		//获取ajax对象
			xhr.open("post","usershow?page="+page,true);  //连接获取指定商品信息的servlet
			xhr.send();							//发送请求
			xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
				if(xhr.readyState==4&&xhr.status==200){
					var date = xhr.responseText;		//获取json传来的数据
					date = eval("("+date+")");			//解析数据
					var pg = date["pg"];
					var user = pg.result;
					var dept = date["dept"];
					showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">部门信息</h2>"
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
									+"</table></div><br><span id=\"rd\"></span>";
					var tab = $("tab1");
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
										+"<td>"+user[i].loginname+"</td>"
										+"<td>"+user[i].pwd+"</td>"
										+"<td>"+user[i].name+"</td>"
										+"<td>"+user[i].sex+"</td>"
										+"<td>"+deptname+"</td>"
										+"<td><select id='userselect"+user[i].id+"'></select></td>"
										+"<td><a href='queryoneUser?id="+user[i].id+"'>修改</a>&nbsp;"
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
		function updateDept(id,deptname){
			var showspan = $("showspanchild");
			showspan.innerHTML = "<form action='updateDept'>"
								+"<input type='hidden' name='id' value='"+id+"'>"
								+"部门编号："+id+"<br/>"
								+"部门名称：<input type='text' name='deptname' value='"+deptname+"'><br/>"
								+"<input type='submit'> &nbsp;<input type='reset'>";
		}
		function deptshow(page){
			var showspan = $("showspanchild");
			var xhr = new XMLHttpRequest();		//获取ajax对象
			xhr.open("post","deptshow?page="+page,true);  //连接获取指定商品信息的servlet
			xhr.send();							//发送请求
			xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
				if(xhr.readyState==4&&xhr.status==200){
					var date = xhr.responseText;		//获取json传来的数据
					date = eval("("+date+")");			//解析数据
					var dept = date.result;
					showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">部门信息</h2>"
										+"<div  ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
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
		function roleshow(page){
			var showspan = $("showspanchild");
			var xhr = new XMLHttpRequest();		//获取ajax对象
			xhr.open("post","roleshow?page="+page,true);  //连接获取指定商品信息的servlet
			xhr.send();							//发送请求
			xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
				if(xhr.readyState==4&&xhr.status==200){
					var date = xhr.responseText;		//获取json传来的数据
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
										+"<td><select id='roleselect"+role[i].rolename+"'></select></td>"
										+"<td>"+role[i].memo+"</td>"
										+"<td><a href='queryoneRole?roleid="+role[i].id+"'>修改</a>&nbsp;"
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
					+"共有"+date.totalCount+"个权限，当前为："+date.page+"/"+date.totalPage+"页"
					+"</span>"
					+"<span style=\"position:relative;left:5%;\">"
					+"<a onclick=\"first('role')\" href=\"#\">首页</a> <a href=\"#\" onclick=\"back("+date.page+",'role')\">上一页</a> <a href=\"#\" onclick=\"next("+date.page+",'role',"+date.totalPage+")\">下一页</a> <a href=\"#\" onclick=\"last("+date.totalPage+",'role')\">尾页</a>"					
					+"</span>";
				}
			}
		
		}
		function menushow(page){
			var showspan = $("showspanchild");
			var xhr = new XMLHttpRequest();		//获取ajax对象
			xhr.open("post","menushow?page="+page,true);  //连接获取指定商品信息的servlet
			xhr.send();							//发送请求
			xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
				if(xhr.readyState==4&&xhr.status==200){
					var date = xhr.responseText;		//获取json传来的数据
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
										+"<td><a href='queryoneMenu?menuid="+menu[i].id+"'>修改</a>&nbsp;"
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
												+"<td><a href='queryoneMenu?menuid="+menu[i].id+"'>修改</a>&nbsp;"
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
		function deleteMenu(v,turnname){
			var su = confirm("您确认要删除吗？");
			if(su==true){
				if(turnname=="menu"){
					window.location.href="deleteMenu?id="+v;
				}else if(turnname =="role"){
					window.location.href="deleteRole?id="+v;
				}else if(turnname =="dept"){
					window.location.href="deleteDept?id="+v;
				}else if(turnname =="user"){
					window.location.href="deleteUser?id="+v;
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
				usershow(1);
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
				usershow(v);
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
				usershow(v);
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
				usershow(v);
			}
		}