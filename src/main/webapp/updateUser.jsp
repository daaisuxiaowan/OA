<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/menu.js" type="text/javascript"></script>
</head>
<body>
	<script>
		window.onload = function(){
			leftmenu(1);	
		};
		/*
		 * 用户名验证方法
		 */
		function checkuser(){
			var v = $("loginname").value;
			var reg = /^[a-zA-z]\w{7,9}$/;
			var u = $("suserspid");
			if(reg.test(v)){
				u.innerHTML = "用户名格式正确";
				u.style.color = "green";
				var xhr = new XMLHttpRequest();		//获取ajax对象
				xhr.open("post","${pageContext.request.contextPath}/main/checkUser",true);  //连接获取指定商品信息的servlet
				xhr.send();							//发送请求
				xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
					if(xhr.readyState==4&&xhr.status==200){
						var date = xhr.responseText;		//获取json传来的数据
						date = eval("("+date+")");			//解析数据
						for(var i=0;i<date.length;i++){
							if(date[i].loginname == v){
								u.innerHTML = "用户名已被注册，请更换用户名 ";
								u.style.color = "red";
								return false;
							}	
						}
					u.innerHTML = "用户名格式正确,用户名可正常使用 ";
					u.style.color = "green";
					return true;
					}
				}
			}else{
				u.innerHTML = "用户名格式错误";
				u.style.color = "red";
				return false;
			}
		}
		function checkMeg(){
			if(checkuser()){
				return true;
			}else{
				return false;
			}
		}
	</script>
	<div style="width:100%;height:900px;">
		<jsp:include page="/mainmodel.jsp"></jsp:include>
	</div>
	<div style="position:absolute;lfet:50%;top:15%;width:100%;">
		<span id="showspan" style="position:absolute;left:35%;top:50%;">
			<span id="showspanchild">
				<c:choose>
					<c:when test="${flag eq 'update'}">
						<form action="${pageContext.request.contextPath}/main/updateUser">
							<input type="hidden" name="id" value="${updateuser.id}">
							用户编号:${updateuser.id}<br/>		
							&nbsp;登录名:${updateuser.loginname}<br/>
							&nbsp;&nbsp;密码:<input type="text" name="pwd" value="${updateuser.pwd}"><br/>
							真实姓名:<input type="text" name="name" value="${updateuser.name}"><br/>
							&nbsp;&nbsp;性别:<input type="radio" name="sex" 
												<c:if test="${updateuser.sex eq '男'}">
													checked
												</c:if>
											 value="男">男&nbsp;<input type="radio" name="sex"
												 <c:if test="${updateuser.sex eq '女'}">
													checked
												</c:if>
											  value="女">女<br/>
							&nbsp;&nbsp;部门:<select name="deptid" style="width:199px;height:27px;">
												<c:forEach items="${Deptlist}" var="dept">
													<option ${updateuser.deptid eq dept.id ? 'selected' : ''} value="${dept.id}">${dept.deptname}</option>
												</c:forEach>
											</select><br/>
							&nbsp;&nbsp;角色:<br><c:forEach items="${Rolelist}" var="role">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="roleids" 
													<c:forEach items="${updateuser.roles}" var="urs">
														<c:if test="${urs.id eq role.id}">
															checked
														</c:if>
													</c:forEach>
												value="${role.id}">${role.rolename}<br/>
											</c:forEach>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit"> &nbsp;<input type="reset">
						</form>
					</c:when>
					<c:when test="${flag eq 'add'}">
						<form action="${pageContext.request.contextPath}/main/addUser" onsubmit="return checkMeg()">		
							&nbsp;登录名:<input id="loginname" type="text" name="loginname"><span id="suserspid" style="color: #e60020;">字母开头，长度为8~10位</span><br/>
							&nbsp;&nbsp;密码:<input type="text" name="pwd"><br/>
							真实姓名:<input type="text" name="name"><br/>
							&nbsp;&nbsp;性别:<input type="radio" checked name="sex" value="男">男&nbsp;
											<input type="radio" name="sex" value="女">女<br/>
							&nbsp;&nbsp;部门:<select name="deptid" style="width:199px;height:27px;">
												<c:forEach items="${Deptlist}" var="dept">
													<option value="${dept.id}">${dept.deptname}</option>
												</c:forEach>
											</select><br/>
							&nbsp;&nbsp;角色:<br><c:forEach items="${Rolelist}" var="role">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="position:reletive;left:15px;" type="checkbox" name="roleids" value="${role.id}">${role.rolename}<br/>
											</c:forEach>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit"> &nbsp;<input type="reset">
						</form>
					</c:when>
					<c:when test="${flag eq 'updatemyuser'}">
						<form action="${pageContext.request.contextPath}/main/updateMyUser">
							<input type="hidden" name="id" value="${user.id}">
							用户编号:${user.id}<br/>		
							&nbsp;登录名:${user.loginname}<br/>
							&nbsp;&nbsp;密码:${user.pwd}<br/>
							真实姓名:<input type="text" name="name" value="${user.name}" style="width:199px;height:27px;font-size:25px;"><br/>
							&nbsp;&nbsp;性别:<input type="radio" name="sex" 
												<c:if test="${user.sex eq '男'}">
													checked
												</c:if>
											 value="男">男&nbsp;<input type="radio" name="sex"
												 <c:if test="${user.sex eq '女'}">
													checked
												</c:if>
											  value="女">女<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit"> &nbsp;<input type="reset">
						</form>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
			</span><br/>
			<span id="rd">
			</span>
		</span>
	</div>
</body>
</html>