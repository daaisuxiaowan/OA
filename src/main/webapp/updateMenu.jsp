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
			openchildmenu(4);	
		};
		function $(v){
			return document.getElementById(v);
		}
		function changemenu(v){
			var xhr = new XMLHttpRequest();		//获取ajax对象
			xhr.open("post","${pageContext.request.contextPath}/main/changemenu?ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
			xhr.send();							//发送请求
			xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
				if(xhr.readyState==4&&xhr.status==200){
					var date = xhr.responseText;		//获取json传来的数据
					if(date == "ajaxmsg"){
						showspan.innerHTML="无访问权限";
					}else{
						m = eval(date);			//解析数据
					
						var pid = $("pidselect");
						pid.length = 0;
						if(v=="1级权限"){
							var op = document.createElement("option");
							op.innerHTML="";
							op.value = "0";
							pid.appendChild(op);
						}else if(v=="2级权限"){
							for(var i=0;i<m.length;i++){
								if(m[i].securyname=="1级权限"){
									var op = document.createElement("option");
									op.innerHTML=m[i].menuname;
									op.value = m[i].id;
									pid.appendChild(op);
								}
							}
						}else if(v=="3级权限"){
							for(var i=0;i<m.length;i++){
								if(m[i].securyname=="2级权限"){
									var op = document.createElement("option");
									op.innerHTML=m[i].menuname;
									op.value = m[i].id;
									pid.appendChild(op);
								}
							}
						}else if(v=="4级权限"){
							for(var i=0;i<m.length;i++){
								if(m[i].securyname=="3级权限"){
									var op = document.createElement("option");
									op.innerHTML=m[i].menuname;
									op.value = m[i].id;
									pid.appendChild(op);
								}
							}
						}
					}
				}
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
						<form action="${pageContext.request.contextPath}/main/updateMenu" style="position:relative;left:35%;">
							<input type="hidden" name="menuid" value="${menu.id}">
							权限编号:${menu.id}<br/>		
							权限名字:<input type="text" name="menuname" value="${menu.menuname}"><br/>
							权限连接:<input type="text" name="menulink" value="${menu.menulink}"><br/>
							权限级别:<select name="securyname" onchange="changemenu(this.value)" style="width:199px;height:27px;font-size:25px;">
										<option ${menu.securyname eq '1级权限' ? 'selected' : ''} value="1级权限">1级权限</option>
										<option ${menu.securyname eq '2级权限' ? 'selected' : ''} value="2级权限">2级权限</option>
										<option ${menu.securyname eq '3级权限' ? 'selected' : ''} value="3级权限">3级权限</option>
										<option ${menu.securyname eq '4级权限' ? 'selected' : ''} value="4级权限">4级权限</option>
									</select><br/>	
							所属权限:<select name="pid" style="width:199px;height:27px;font-size:25px;" id="pidselect">
									<option value="0"></option>
									<c:forEach items="${menulist}" var="ml">
										<option ${menu.pid eq ml.id ? 'selected' : ''} value="${ml.id}">${ml.menuname}</option>
									</c:forEach>
									</select><span>空白默认为一级权限</span><br/>
							权限说明:<input type="text" name="memo" value="${menu.memo}"><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit"> &nbsp;<input type="reset">
						</form>
					</c:when>
					<c:when test="${flag eq 'add'}">
						<form action="${pageContext.request.contextPath}/main/addMenu" style="position:relative;left:35%;">	
							权限名字:<input type="text" name="menuname" ><br/>
							权限连接:<input type="text" name="menulink" ><br/>
							权限级别:<select name="securyname" onchange="changemenu(this.value)" style="width:199px;height:27px;font-size:25px;">
										<option value="1级权限">1级权限</option>
										<option value="2级权限">2级权限</option>
										<option value="3级权限">3级权限</option>
										<option value="4级权限">4级权限</option>
									</select><br/>	
							所属权限:<select name="pid" style="width:199px;height:27px;font-size:25px;" id="pidselect">
									<option value="0"></option>
									</select><span>空白默认为一级权限</span><br/>
							权限说明:<input type="text" name="memo" ><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit"> &nbsp;<input type="reset">
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