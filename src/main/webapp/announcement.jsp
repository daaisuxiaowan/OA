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
			</span><br/>
		</span>
	</div>
	<script>
	window.onload = function(){
		announcementshow(1);
	};
	function announcementDetail(v){
		var showspan = $("showspanchild");
		var xhr = new XMLHttpRequest();		//获取ajax对象
		xhr.open("post","${pageContext.request.contextPath}/announcement/announcementDetail?id="+v+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "ajaxmsg"){
					showspan.innerHTML="无访问权限";
				}else{
					date = eval("("+date+")");			//解析数据
					showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">"+date.name+"</h2>"
						+"<div  ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
						+"<tr>"
							+"<th>发布时间:</th><td>"+date.releasedate+"</td>"
							+"<th>发布人:</th><td>"+date.publisher+"</td>"
						+"</tr>"
						+"<tr style='width:300px;height:500px;'>"
							+"<td colspan='4' style='text-align: center;vertical-align:top'>"+date.content+"</td>"
					+"</tr>"
					+"</table></div><br>"
					+"<a href='javascript:announcementshow(1)'>返回</a>";
				}
			}
		}
	}
	function addAnnouncement(){
		var showspan = $("showspanchild");
		var xhr = new XMLHttpRequest();		//获取ajax对象
		xhr.open("post","${pageContext.request.contextPath}/announcement/addAnnouncementalax?ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "ajaxmsg"){
					showspan.innerHTML="无访问权限";
				}else if(date == "addkn"){
					showspan.innerHTML = "<form action='${pageContext.request.contextPath}/announcement/addAnnouncement' onsubmit=\"return checkaddAnnouncement()\" >"
						+"<input type='hidden' name='publisher' value='${user.name}'><br/>"
						+"公告名称:<input type='text' name='name'><br/><br/>"
						+"公告内容:<textarea id='actfiles'rows=\"5\" cols=\"21\" name=\"content\"></textarea><span id='actfilespan'>* </span><br>"
						+"&nbsp;&nbsp;<input type='submit'> &nbsp;<input type='reset'>"
						+"</form>";
				}
			}
		}
	}
	
	function getannouncementshow(page){
		var ssname = $("ssname").value;
		var starttime = $("starttime").value;
		var endtime = $("endtime").value;
		announcementshow(page,ssname,starttime,endtime);
	}
	function announcementshow(page,ssname,starttime,endtime){
		if(ssname==null){
			ssname="";
		}
		if(starttime==null){
			starttime="";
		}
		if(endtime==null){
			endtime="";
		}
		var showspan = $("showspanchild");
		var xhr = new XMLHttpRequest();		//获取ajax对象
		xhr.open("post","${pageContext.request.contextPath}/announcement/announcementshow?page="+page+"&name="+ssname+"&starttime="+starttime+"&endtime="+endtime+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "ajaxmsg"){
					showspan.innerHTML="无访问权限";
				}else{
				date = eval("("+date+")");			//解析数据
				var pg = date;
				var an = pg.result;
				showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">公告信息</h2>"
									+"<div><button onclick='addAnnouncement()'>发布公告</button></div>"
									+"公告名称：<input type='text' id='ssname' value='"+ssname+"' style=\"width:120px;height:26px;font-size:25px;position:relative;bottom:1px;\">"
									+"发布时间：<input type='date' id='starttime' style=\"width:195px;height:27px;font-size:25px;\">至<input type='date' id='endtime' style=\"width:195px;height:27px;font-size:25px;\">"
									+"&nbsp;&nbsp;<button onclick='getannouncementshow("+pg.page+")' style=\"position:relative;bottom:1px;font-size:25px;\">搜索</button>"
									+"<div  ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
									+"<tr>"
										+"<th>编号</th>"
										+"<th style=\"width:300px;\">公告名称</th>"
										+"<th>发布时间</th>"
										+"<th>发布人</th>"
										+"<th>操作</th>"
									+"</tr>"
								+"</table></div><br><span id=\"rd\"></span>";
				var tab = $("tab1");
				for(var i=0;i<an.length;i++){
						var tr = document.createElement("tr");
						tr.innerHTML = "<tr>"
									+"<td>"+(i+1)+"</td>"
									+"<td style=\"width:150px;\">"+an[i].name+"</td>"
									+"<td>"+an[i].releasedate+"</td>"
									+"<td style=\"width:140px;\">"+an[i].publisher+"</td>"
									+"<td><a href='javascript:announcementDetail("+an[i].id+")'>详情</a>&nbsp;"
									+"<a href=\"javascript:deleteAnnouncement("+an[i].id+")\">删除</a></td>"
									+"</tr>";
						tab.appendChild(tr);
				}
				var rd = $("rd");
				rd.innerHTML = "<span><br>"
				+"共有"+pg.totalCount+"个公告，当前为："+pg.page+"/"+pg.totalPage+"页"
				+"</span>"
				+"<span style=\"position:relative;left:5%;\">"
				+"<a onclick=\"first('announcement')\" href=\"#\">首页</a> <a href=\"#\" onclick=\"back("+pg.page+",'announcement')\">上一页</a> <a href=\"#\" onclick=\"next("+pg.page+",'announcement',"+pg.totalPage+")\">下一页</a> <a href=\"#\" onclick=\"last("+pg.totalPage+",'announcement')\">尾页</a>"					
				+"</span>";
				}
			}
		}
	}
	function deleteAnnouncement(v){
		var su = confirm("您确认要删除吗？");
		if(su==true){
			window.location.href="${pageContext.request.contextPath}/announcement/deleteAnnouncement?id="+v;
		}
	}
	function first(func){
		if(func=="announcement"){
			announcementshow(1);
		}else if(func=="template"){
			templateshow(1);
		}else if(func=="app"){
			appshow(1);
		}else if(func=="user"){
			usershow(1);
		}
	}
	function back(v,func){
		var v = (v==1?1:v-1);
		if(func=="announcement"){
			announcementshow(v);
		}else if(func=="template"){
			templateshow(v);
		}else if(func=="app"){
			appshow(v);
		}else if(func=="user"){
			usershow(v);
		}
	}
	function next(v,func,m){
		var v = (v==m?m:v+1);
		if(func=="announcement"){
			announcementshow(v);
		}else if(func=="template"){
			templateshow(v);
		}else if(func=="app"){
			appshow(v);
		}else if(func=="user"){
			usershow(v);
		}
	}
	
	function last(v,func){
		if(func=="announcement"){
			announcementshow(v);
		}else if(func=="template"){
			templateshow(v);
		}else if(func=="app"){
			appshow(v);
		}else if(func=="user"){
			usershow(v);
		}
	}
	function checkaddAnnouncement(){
		var v = $("actfiles").value;
		var mm = $("actfilespan");
		if(v==''){
			mm.innerHTML = "请填写公告内容";
			mm.style.color = "red";
			return false;
		}else{	
			return true;
		}	
	}
	</script>
</body>
</html>