<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	a{
		text-decoration:none;
	}
	#showspan{
		font-size:30px;
	}
	tr{
	background-color: #ffffff;
	vertical-align: bottom;
	height: 22px;
	}
	td{
	height: 25px;
	border-left: 1px solid #d2d2d2;
	border-right: 1px solid #d2d2d2;
	border-top: 1px solid #d2d2d2;
	filter: progid:DXImageTransform.Microsoft.gradient(startcolorstr=#e6e6e6,endcolorstr=#ffffff,gradientType=0);
	}
	#rd{
		position:absolute;
		top:600px;
	}
</style>
</head>
<body>
	<div>
		<jsp:include page="/top.jsp"></jsp:include>
	</div>
	<div style="background: #d8edfc;position:relative;bottom:1%;
	font-size: 12px;
	scrollbar-base-color: #dbecf8;
	scrollbar-arrow-color: #2a8ed1;
	scrollbar-track-color: #bdddf2;
	scrollbar-3dlight-color: #2886c5;
	scrollbar-darkshadow-color: #2886c5;
	scrollbar-face-color: #dbecf8;
	scrollbar-shadow-color: #dbecf8;
	margin: 1px;
	border: 3px solid #4891c6;">
		<span style="position:relative;left:10%;font-size: 18px;">
			<c:forEach items="${menuset}" var="mm">
				<c:if test="${mm.value.pid eq 0}">
					<a href="${pageContext.request.contextPath}/${mm.value.menulink}">${mm.value.menuname}</a>&nbsp;
					<%-- javascript:leftmenu(${mm.value.id})" --%>
				</c:if>
			</c:forEach>
		</span>
	</div>
	<div style="position:relative;bottom:1%;">
		<div id="left" style="float:left;width:10%;height:700px;background: #d8edfc;
		font-size: 25px;
		scrollbar-base-color: #dbecf8;
		scrollbar-arrow-color: #2a8ed1;
		scrollbar-track-color: #bdddf2;
		scrollbar-3dlight-color: #2886c5;
		scrollbar-darkshadow-color: #2886c5;
		scrollbar-face-color: #dbecf8;
		scrollbar-shadow-color: #dbecf8;
		margin: 1px;
		border: 3px solid #4891c6;">
		</div>
	</div>
	<script>
	    var count = 0;
		function $(id){
			return document.getElementById(id);
		}
		
		function leftmenu(v){
			var left = $("left");
			left.innerHTML = "";
			var xhr = new XMLHttpRequest();		//获取ajax对象
			xhr.open("post","${pageContext.request.contextPath}/main/childmenu?pid="+v,true);  //连接获取指定商品信息的servlet
			xhr.send();							//发送请求
			xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
				if(xhr.readyState==4&&xhr.status==200){
					var date = xhr.responseText;		//获取json传来的数据
					date = eval(date);			//解析数据
					for(var i=0;i<date.length;i++){
						var cdiv = document.createElement("div");
						cdiv.innerHTML = "<div>"
										+"<a href='javascript:openchildmenu("+date[i].id+")'>"+date[i].menuname+"</a>"
										+"<div id='lcdiv"+date[i].id+"'></div></div>";
						left.appendChild(cdiv);				
					}
				}
			}
		}
		function openchildmenu(v){
			var leftchild = $("lcdiv"+v);
			if(count%2==0){
				var xhr = new XMLHttpRequest();		//获取ajax对象
				xhr.open("post","${pageContext.request.contextPath}/main/childmenu?pid="+v,true);  //连接获取指定商品信息的servlet
				xhr.send();							//发送请求
				xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
					if(xhr.readyState==4&&xhr.status==200){
						var date = xhr.responseText;		//获取json传来的数据
						date = eval(date);			//解析数据
						leftchild.innerHTML = '';
						for(var i=0;i<date.length;i++){
							var cdiv = document.createElement("div");
							cdiv.innerHTML = "<div>"
											+"&nbsp;<a href='javascript:"+date[i].menulink+"()'>"+date[i].menuname+"</a>"
											+"</div>";
							leftchild.appendChild(cdiv);				
						}
					}
				}
			}else{
				leftchild.innerHTML = "";
			}
			count++;
		}
	</script>
</body>
</html>