<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<script type="text/javascript">
	window.onload = function(){
		leftmenu(24);
		var flag = '${flag}';
		if(flag == 1){     //修改和增加后一进来就是展示流程定义 
			actshow(1);
		}else if(flag == 2){     //修改和增加后一进来就是展示流程模板 
			templateshow(1);
		}else if(flag == 3){     //修改和增加后一进来就是展示流程  
			openchildmenu(40);
		} else if(flag == 4){     //修改和增加后一进来就是展示用户   
			var msg = '${openmsg1}';
			if(msg == "update"){
				alert("申请成功");
			}
			applicationshow(1);
		}else if(flag == 5){     //修改和增加后一进来就是展示用户 
			mytaskshow();
		} 
	};
	function $(id){
		return document.getElementById(id);
	}
	function addTemplate(){
		queryoneTemplate();
	}
	function addAct(){
		var showspan = $("showspanchild");
		showspan.innerHTML = "<form action='${pageContext.request.contextPath}/flow/addAct' onsubmit=\"return checkaddAct()\" method=\"post\" enctype=\"multipart/form-data\">"
			+"<input type='hidden' id='actmeg' name='meg' ><br/>"
			+"流程名称:<input type='text' name='name'><br/>"
			+"所属任务:<select name='acttype'>"
				+"<option  value='单线任务'>单线任务</option>"
				+"<option  value='组任务'>组任务</option>"
				+"<option  value='排它任务'>排它任务</option>"
			+"</select><br/>"
			+"流程文件:<input id='actfiles'type=\"file\" name=\"file\"><span id='actfilespan'>如需修改才上传,文件后缀为zip格式</span><br>"
			+"&nbsp;&nbsp;<input type='submit'> &nbsp;<input type='reset'>"
			+"</form>";
	}
	function checkTask(v,meg){
		var showspan = $("showspanchild");
		var xhr = new XMLHttpRequest();		//获取ajax对象
		xhr.open("post","${pageContext.request.contextPath}/flow/checkTask?appid="+v+"&username=${user.name}&taskmeg="+meg+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "ajaxmsg"){
					showspan.innerHTML="无访问权限";
				}else{
				date = eval("("+date+")");			//解析数据
				var app = date["app"];
				var usermeg = date["usermeg"];
				var taskmsg = date["taskmsg"];
				var api = date["api"];
				showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">审核任务</h2>"
									+"<div id='download'>下载文件</div>"
									+"<div  ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
									+"<tr>"
										+"<th>编号</th>"
										+"<th>申请人</th>"
										+"<th>申请项目</th>"
										+"<th>申请状态</th>"
										+"<th>审核时间</th>"
									+"</tr>"
								+"</table></div><br>"
								+"<div  ><table id='tab2' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
									+"<tr>"
										+"<th>编号</th>"
										+"<th>审核人</th>"
										+"<th>审核时间</th>"
										+"<th>审核结果</th>"
										+"<th>审核说明</th>"
									+"</tr>"
							+"</table></div><br>"
							+"<div id='taskdiv'></div>";
							var taskdiv = $("taskdiv");
							if(taskmsg=="gapp"){
								taskdiv.innerHTML = "<a href='javascript:gettask("+v+")'>拾取任务</a>";
							}else if(taskmsg=="papp"){
								taskdiv.innerHTML = "<form action='${pageContext.request.contextPath}/flow/dealTask'>"
											+"<input type='hidden' name='appid' value='"+v+"'>"
											+"<input type='hidden' name='username' value='${user.name}'>"
											+"<input type='hidden' name='userid' value='${user.id}'>"
											+"说明：<textarea name='comment' rows=\"5\" cols=\"21\"></textarea><br>"
											+"&nbsp;&nbsp;&nbsp;<input type=\"radio\" checked name=\"approval\" value=\"同意\">同意&nbsp;"
											+"<input type=\"radio\" name=\"approval\" value=\"驳回\">驳回&nbsp;"
											+"<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='submit' value='确定'></form>";
							}else if(taskmsg=="zu"){
								taskdiv.innerHTML = "<form action='${pageContext.request.contextPath}/flow/dealTask'>"
									+"<input type='hidden' name='appid' value='"+v+"'>"
									+"<input type='hidden' name='username' value='${user.name}'>"
									+"<input type='hidden' name='userid' value='${user.id}'>"
									+"说明：<textarea name='comment' rows=\"5\" cols=\"21\"></textarea><br>"
									+"&nbsp;&nbsp;&nbsp;<input type=\"radio\" checked name=\"approval\" value=\"同意\">同意&nbsp;"
									+"<input type=\"radio\" name=\"approval\" value=\"驳回\">驳回&nbsp;"
									+"<input type=\"radio\" name=\"approval\" checked value=\"搁置\">搁置"
									+"<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='submit' value='确定'></form>";
					}
				var tab = $("tab1");
				var tab2 = $("tab2");
				for(var i=0;i<app.length;i++){
					var username = "无";
					for(var j=0;j<usermeg.length;j++){
						if(usermeg[j].id==app[i].userid){
							username = usermeg[j].name;
						}
					}
						var tr = document.createElement("tr");
						tr.innerHTML = "<tr>"
									+"<td>"+app[i].id+"</td>"
									+"<td>"+username+"</td>"
									+"<td>"+app[i].title+"</td>"
									+"<td>"+app[i].status+"</td>"
									+"<td>"+app[i].appdate.substring(0,19)+"</td>"
									+"</tr>";
						tab.appendChild(tr);
					$("download").innerHTML = "申请文档:<a href='${pageContext.request.contextPath}/flow/download?path="+app[i].filepath+"&msg=审核下载'>下载文档</a><br/>";
				}
				for(var i=0;i<api.length;i++){
					var username = "无";
					for(var j=0;j<usermeg.length;j++){
						if(usermeg[j].id==api[i].userid){
							username = usermeg[j].name;
						}
					}
						var tr = document.createElement("tr");
						tr.innerHTML = "<tr>"
									+"<td>"+api[i].id+"</td>"
									+"<td>"+username+"</td>"
									+"<td>"+api[i].approvedate.substring(0,19)+"</td>"
									+"<td>"+api[i].approval+"</td>"
									+"<td>"+api[i].comment+"</td>"
									+"</tr>";
						tab2.appendChild(tr);
				}
				if(api.length==0){
					tab2.innerHTML = '';
				}
				}
			}
		}
	}
	
	function gettask(v){
		var taskdiv = $("taskdiv");
		var xhr = new XMLHttpRequest();		//获取ajax对象
		xhr.open("post","${pageContext.request.contextPath}/flow/getTask?appid="+v+"&username=${user.name}&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "notask"){
					taskdiv.innerHTML = "任务已被他人拾取"
										+"<a href='javascript:mytaskshow()'>返回</a>";
				}else if(date == "ok"){
					taskdiv.innerHTML = "<form action='${pageContext.request.contextPath}/flow/dealTask'>"
						+"<input type='hidden' name='appid' value='"+v+"'>"
						+"<input type='hidden' name='username' value='${user.name}'>"
						+"<input type='hidden' name='userid' value='${user.id}'>"
						+"说明：<textarea name='comment' rows=\"5\" cols=\"21\"></textarea><br>"
						+"&nbsp;&nbsp;&nbsp;<input type=\"radio\" name=\"approval\" value=\"同意\">同意&nbsp;"
						+"<input type=\"radio\" name=\"approval\" value=\"驳回\">驳回&nbsp;"
						+"<input type=\"radio\" name=\"approval\" checked value=\"搁置\">搁置"
						+"<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='submit' value='确定'></form>";
				}
			}
		}
	}
	function mytaskshow(){
		var showspan = $("showspanchild");
		var xhr = new XMLHttpRequest();		//获取ajax对象
		xhr.open("post","${pageContext.request.contextPath}/flow/mytaskshow?username=${user.name}"+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "ajaxmsg"){
					showspan.innerHTML="无访问权限";
				}else{
				date = eval("("+date+")");			//解析数据
				var gapps = date["gapps"];
				var papps = date["papps"];
				var usermeg = date["usermeg"];
				showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">我的审批任务</h2>"
									+"<div  ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
									+"<tr>"
										+"<th>编号</th>"
										+"<th>申请人</th>"
										+"<th>申请项目</th>"
										+"<th>申请状态</th>"
										+"<th>审核时间</th>"
										+"<th>操作</th>"
									+"</tr>"
								+"</table></div><br><span id=\"rd\"></span>";
				var tab = $("tab1");
				for(var i=0;i<gapps.length;i++){
					var username = "无";
					for(var j=0;j<usermeg.length;j++){
						if(usermeg[j].id==gapps[i].userid){
							username = usermeg[j].name;
						}
					}
						var tr = document.createElement("tr");
						tr.innerHTML = "<tr>"
									+"<td>"+gapps[i].id+"</td>"
									+"<td>"+username+"</td>"
									+"<td>"+gapps[i].title+"</td>"
									+"<td>"+gapps[i].status+"</td>"
									+"<td>"+gapps[i].appdate.substring(0,19)+"</td>"
									+"<td><a href='javascript:checkTask("+gapps[i].id+",\"gapp\")'>办理任务</a>&nbsp;</td>"
									+"</tr>";
						tab.appendChild(tr);
				}
				for(var i=0;i<papps.length;i++){
					var username = "无";
					for(var j=0;j<usermeg.length;j++){
						if(usermeg[j].id==papps[i].userid){
							username = usermeg[j].name;
						}
					}
						var tr = document.createElement("tr");
						tr.innerHTML = "<tr>"
									+"<td>"+papps[i].id+"</td>"
									+"<td>"+username+"</td>"
									+"<td>"+papps[i].title+"</td>"
									+"<td>"+papps[i].status+"</td>"
									+"<td>"+papps[i].appdate.substring(0,19)+"</td>"
									+"<td><a href='javascript:checkTask("+papps[i].id+",\"papp\")'>办理任务</a>&nbsp;</td>"
									+"</tr>";
						tab.appendChild(tr);
				}
				if(papps.length==0 && gapps.length==0){
					tab.innerHTML = "无待审核的任务";
				}
				}
			}
		}
	}
	function approveinfoshow(v){
		var showspan = $("showspanchild");
		var xhr = new XMLHttpRequest();		//获取ajax对象
		xhr.open("post","${pageContext.request.contextPath}/flow/approveinfoshow?appid="+v+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "ajaxmsg"){
					showspan.innerHTML="无访问权限";
				}else{
				date = eval("("+date+")");			//解析数据
				var app = date["app"];
				if(app.length == 0){
					showspan.innerHTML = "无审核记录";
				}else{
				var usermeg = date["usermeg"];
				var appmeg = date["appmeg"];
				showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">审核流程</h2>"
									+"<div  ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
									+"<tr>"
										+"<th>编号</th>"
										+"<th>审核人</th>"
										+"<th>审核时间</th>"
										+"<th>审核结果</th>"
										+"<th>审核说明</th>"
										+"<th>申请名称</th>"
									+"</tr>"
								+"</table></div><br><span id=\"rd\"></span>";
				var tab = $("tab1");
				for(var i=0;i<app.length;i++){
					var username = "无";
					var appname = "无";
					for(var j=0;j<usermeg.length;j++){
						if(usermeg[j].id==app[i].userid){
							username = usermeg[j].name;
						}
					}
					for(var j=0;j<appmeg.length;j++){
						if(appmeg[j].id==app[i].appid){
							appname = appmeg[j].title;
						}
					}
						var tr = document.createElement("tr");
						tr.innerHTML = "<tr>"
									+"<td>"+app[i].id+"</td>"
									+"<td>"+username+"</td>"
									+"<td>"+app[i].approvedate.substring(0,19)+"</td>"
									+"<td>"+app[i].approval+"</td>"
									+"<td>"+app[i].comment+"</td>"
									+"<td>"+appname+"</td>"
									+"</tr>";
						tab.appendChild(tr);
				}
				var rd = $("rd");
				rd.innerHTML = "<span style=\"position:relative;left:5%;\">"
				+"<a onclick=\"applicationshow(1)\" href=\"#\">返回</a>"					
				+"</span>";	
				}
				}
			}
		}
	}
	function applicationshow(v){
		if(v==null){
			v='';
		}
		var showspan = $("showspanchild");
		var xhr = new XMLHttpRequest();		//获取ajax对象
		xhr.open("post","${pageContext.request.contextPath}/flow/applicationshow?userid=${user.id}&page="+v+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "ajaxmsg"){
					showspan.innerHTML="无访问权限";
				}else{
				date = eval("("+date+")");			//解析数据
				var pg = date;
				var app = pg.result;
				showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">我的申请</h2>"
									+"<div  ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
									+"<tr>"
										+"<th>编号</th>"
										+"<th>申请类型</th>"
										+"<th>审核状态</th>"
										+"<th>申请时间</th>"
										+"<th>操作</th>"
									+"</tr>"
								+"</table></div><br><span id=\"rd\"></span>";
				var tab = $("tab1");
				var num = pg.begin+1;
				for(var i=0;i<app.length;i++){
						var tr = document.createElement("tr");
						tr.innerHTML = "<tr>"
									+"<td>"+num+"</td>"
									+"<td>"+app[i].title+"</td>"
									+"<td>"+app[i].status+"</td>"
									+"<td>"+app[i].appdate.substring(0,19)+"</td>"
									+"<td><a href='javascript:approveinfoshow("+app[i].id+")'>查看进程</a>&nbsp;</td>"
									+"</tr>";
						tab.appendChild(tr);
						num++;
				}
				var rd = $("rd");
				rd.innerHTML = "<span><br>"
				+"共有"+pg.totalCount+"个申请，当前为："+pg.page+"/"+pg.totalPage+"页"
				+"</span>"
				+"<span style=\"position:relative;left:5%;\">"
				+"<a onclick=\"first('app')\" href=\"#\">首页</a> <a href=\"#\" onclick=\"back("+pg.page+",'app')\">上一页</a> <a href=\"#\" onclick=\"next("+pg.page+",'app',"+pg.totalPage+")\">下一页</a> <a href=\"#\" onclick=\"last("+pg.totalPage+",'app')\">尾页</a>"					
				+"</span>";	
				}
			}
		}
	}
	function openApplication(){
		var v = '';
		var showspan = $("showspanchild");
		var xhr = new XMLHttpRequest();		//获取ajax对象
		xhr.open("post","${pageContext.request.contextPath}/flow/queryoneTemplate?id="+v+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "ajaxmsg"){
					showspan.innerHTML="无访问权限";
				}else{
				date = eval("("+date+")");			//解析数据
				var act = date["act"];
				showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:25px;\">请选择申请内容</h2>"
								+"<form action='${pageContext.request.contextPath}/flow/openApplication' >"
								+"<input type='hidden' name='actname' id='actname'><br/>"
								+"<select id='appselect' name='actkey'></select>"
								+"&nbsp;&nbsp;<input type='submit' value='确定'>";
				var appselect = $("appselect");
				var msg = "";
				for(var j=0;j<act.length;j++){
					msg += "<option value='"+act[j].pdkey+"*"+act[j].name+"'>"+act[j].name+" </option>";
				}
				appselect.innerHTML = msg;
				}
			}
		}
	}
	function templateshow(page){
		var showspan = $("showspanchild");
		var xhr = new XMLHttpRequest();		//获取ajax对象
		xhr.open("post","${pageContext.request.contextPath}/flow/templateshow?page="+page+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "ajaxmsg"){
					showspan.innerHTML="无访问权限";
				}else{
				date = eval("("+date+")");			//解析数据
				var pg = date["pg"];
				var template = pg.result;
				var act = date["act"];
				showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">模板信息</h2>"
									+"<div  ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
									+"<tr>"
										+"<th>编号</th>"
										+"<th>模板名</th>"
										+"<th>所属流程</th>"
										+"<th>文件名</th>"
										+"<th>操作</th>"
									+"</tr>"
								+"</table></div><br><span id=\"rd\"></span>";
				var tab = $("tab1");
				for(var i=0;i<template.length;i++){
						var actname = "无";
						var tr = document.createElement("tr");
						for(var j=0;j<act.length;j++){
							if(act[j].pdkey==template[i].pdkey){
								actname = act[j].name;
							}
						}
						tr.innerHTML = "<tr>"
									+"<td>"+template[i].id+"</td>"
									+"<td>"+template[i].name+"</td>"
									+"<td>"+actname+"</td>"
									+"<td>"+template[i].filepath+"</td>"
									+"<td><a href='javascript:queryoneTemplate("+template[i].id+")'>修改</a>&nbsp;"
									+"<a href=\"javascript:deleteMenu("+template[i].id+",'template')\">删除</a></td>"
									+"</tr>";
						tab.appendChild(tr);
				}
				var rd = $("rd");
				rd.innerHTML = "<span><br>"
				+"共有"+pg.totalCount+"个模板，当前为："+pg.page+"/"+pg.totalPage+"页"
				+"</span>"
				+"<span style=\"position:relative;left:5%;\">"
				+"<a onclick=\"first('template')\" href=\"#\">首页</a> <a href=\"#\" onclick=\"back("+pg.page+",'template')\">上一页</a> <a href=\"#\" onclick=\"next("+pg.page+",'template',"+pg.totalPage+")\">下一页</a> <a href=\"#\" onclick=\"last("+pg.totalPage+",'template')\">尾页</a>"					
				+"</span>";		
				}
			}
		}
	}
	function queryoneTemplate(v){
		if(v==null){
			v = '';
		}
		var showspan = $("showspanchild");
		var xhr = new XMLHttpRequest();		//获取ajax对象
		xhr.open("post","${pageContext.request.contextPath}/flow/queryoneTemplate?id="+v+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "ajaxmsg"){
					showspan.innerHTML="无访问权限";
				}else{
				date = eval("("+date+")");			//解析数据
				var tempname = date["tempname"];
				var act = date["act"];
				if(tempname == "update"){
					var template = date["template"];
					showspan.innerHTML = "<form action='${pageContext.request.contextPath}/flow/updateTemplate' onsubmit=\"return checkupdateTemplate()\" method=\"post\" enctype=\"multipart/form-data\">"
										+"<input type='hidden' name='id' value='"+template.id+"'><br/>"
										+"<input type='hidden' id='meg' name='meg' ><br/>"
										+"模板编号:"+template.id+"<br/>"
										+"模板名称:<input type='text' name='name' value='"+template.name+"'><br/>"
										+"所属流程<select name='pdkey' id='actselect"+template.id+"'>"	
										+"</select><br/>"
										+"模板文件:<input id='files'type=\"file\" name=\"file\"><span id='filespan'>如需修改才上传</span><br>"
										+"<input type='submit'> &nbsp;<input type='reset'>"
										+"</form>";	
					var actselect = $("actselect"+template.id);
					var msg = "";
					for(var j=0;j<act.length;j++){
						msg += "<option "+(act[j].pdkey == template.pdkey?"selected":"")+" value='"+act[j].pdkey+"'>"+act[j].name+" </option>";
					}
					actselect.innerHTML = msg;
				}else if(tempname == "add"){
					showspan.innerHTML = "<form action='${pageContext.request.contextPath}/flow/addTemplate' onsubmit=\"return checkaddTemplate()\" method=\"post\" enctype=\"multipart/form-data\">"
						+"<input type='hidden' id='meg' name='meg' ><br/>"
						+"模板名称:<input type='text' name='name' ><br/>"
						+"所属流程<select name='pdkey' id='actselect'>"	
						+"</select><br/>"
						+"模板文件:<input type=\"file\" id='files' name=\"file\"><span id='filespan'></span><br>"
						+"<input type='submit'> &nbsp;<input type='reset'>"
						+"</form>";	
					var actselect = $("actselect");
					var msg = "";
					for(var j=0;j<act.length;j++){
						msg += "<option value='"+act[j].pdkey+"'>"+act[j].name+" </option>";
					}
					actselect.innerHTML = msg;
				}
				}
			}
		}
	}

	function actshow(page){
		var showspan = $("showspanchild");
		var xhr = new XMLHttpRequest();		//获取ajax对象
		xhr.open("post","${pageContext.request.contextPath}/flow/actshow?page="+page+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "ajaxmsg"){
					showspan.innerHTML="无访问权限";
				}else{
				date = eval("("+date+")");			//解析数据
				var pg = date;
				var act = pg.result;
				showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">流程定义信息</h2>"
									+"<div  ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
									+"<tr>"
										+"<th>编号</th>"
										+"<th>流程名</th>"
										+"<th>任务种类</th>"
										+"<th>版本号</th>"
										+"<th>流程键</th>"
										+"<th>文件名</th>"
										+"<th>操作</th>"
									+"</tr>"
								+"</table></div><br><span id=\"rd\"></span>";
				var tab = $("tab1");
				for(var i=0;i<act.length;i++){
						var tr = document.createElement("tr");
						tr.innerHTML = "<tr>"
									+"<td>"+act[i].id+"</td>"
									+"<td>"+act[i].name+"</td>"
									+"<td>"+act[i].acttype+"</td>"
									+"<td>"+act[i].version+"</td>"
									+"<td>"+act[i].pdkey+"</td>"
									+"<td>"+act[i].filepath+"</td>"
									+"<td><a href='javascript:updateAct("+act[i].id+")'>修改</a>&nbsp;"
									+"<a href='${pageContext.request.contextPath }/flow/actpic?pdkey="+act[i].pdkey+"' target='view_window'>查看流程图 </a>&nbsp;"
									+"<a href=\"javascript:deleteMenu("+act[i].id+",'act','"+act[i].pdkey+"')\">删除</a></td>"
									+"</tr>";
						tab.appendChild(tr);
				}
				var rd = $("rd");
				rd.innerHTML = "<span><br>"
				+"共有"+pg.totalCount+"个流程，当前为："+pg.page+"/"+pg.totalPage+"页"
				+"</span>"
				+"<span style=\"position:relative;left:5%;\">"
				+"<a onclick=\"first('act')\" href=\"#\">首页</a> <a href=\"#\" onclick=\"back("+pg.page+",'act')\">上一页</a> <a href=\"#\" onclick=\"next("+pg.page+",'act',"+pg.totalPage+")\">下一页</a> <a href=\"#\" onclick=\"last("+pg.totalPage+",'act')\">尾页</a>"					
				+"</span>";			
				}
			}
		}
	}
	function updateAct(v){
		var showspan = $("showspanchild");
		var xhr = new XMLHttpRequest();		//获取ajax对象
		xhr.open("post","${pageContext.request.contextPath}/flow/queryoneAct?id="+v+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "ajaxmsg"){
					showspan.innerHTML="无访问权限";
				}else{
				date = eval("("+date+")");			//解析数据
				var act = date;
				showspan.innerHTML = "<form action='${pageContext.request.contextPath}/flow/updateAct' onsubmit=\"return checkAct()\" method=\"post\" enctype=\"multipart/form-data\">"
									+"<input type='hidden' name='id' value='"+act.id+"'><br/>"
									+"<input type='hidden' id='actmeg' name='meg' ><br/>"
									+"&nbsp;&nbsp;编号:"+act.id+"<br/>"
									+"流程名称:<input type='text' name='name' value='"+act.name+"'><br/>"
									+"所属任务:<select name='acttype'>"
										+"<option "+(act.acttype == "单线任务" ? "select" : "")+" value='单线任务'>单线任务</option>"
										+"<option "+(act.acttype == "组任务" ? "select" : "")+" value='组任务'>组任务</option>"
										+"<option "+(act.acttype == "排它任务" ? "select" : "")+" value='排它任务'>排它任务</option>"
									+"</select><br/>"
									+"流程文件:<input id='actfiles'type=\"file\" name=\"file\"><span id='actfilespan'>如需修改才上传,文件后缀为zip格式</span><br>"
									+"&nbsp;&nbsp;<input type='submit'> &nbsp;<input type='reset'>"
									+"</form>";
				}
			}
		}
	}
	
	function deleteMenu(v,turnname,key){
		var su = confirm("您确认要删除吗？");
		if(su==true){
			if(turnname=="act"){
				window.location.href="${pageContext.request.contextPath}/flow/deleteAct?id="+v+"&pdkey="+key;
			}else if(turnname =="template"){
				window.location.href="${pageContext.request.contextPath}/flow/deleteTemplate?id="+v;
			}
		}
	}
	function first(func){
		if(func=="act"){
			actshow(1);
		}else if(func=="template"){
			templateshow(1);
		}else if(func=="app"){
			applicationshow(1);
		}else if(func=="user"){
			usershow(1);
		}
	}
	function back(v,func){
		var v = (v==1?1:v-1);
		if(func=="act"){
			actshow(v);
		}else if(func=="template"){
			templateshow(v);
		}else if(func=="app"){
			applicationshow(v);
		}else if(func=="user"){
			usershow(v);
		}
	}
	function next(v,func,m){
		var v = (v==m?m:v+1);
		if(func=="act"){
			actshow(v);
		}else if(func=="template"){
			templateshow(v);
		}else if(func=="app"){
			applicationshow(v);
		}else if(func=="user"){
			usershow(v);
		}
	}
	
	function last(v,func){
		if(func=="act"){
			actshow(v);
		}else if(func=="template"){
			templateshow(v);
		}else if(func=="app"){
			applicationshow(v);
		}else if(func=="user"){
			usershow(v);
		}
	}
	function checkupdateTemplate(){
		var v = $("files").value;
		var mm = $("filespan");
		var meg = $("meg");
		if(v==''){
			meg.value = "";
			return true;
		}else{
			v=v.split(".")[1];
			if(v=="doc" || v=="docx"){
				mm.innerHTML = "格式正确";
				meg.value = "上传文件成功"
				return true;
			}else{
				mm.innerHTML = "格式错误，请上传doc或docx文件";
				mm.style.color = "red";
				return false;
			}
		}
		
	}
	function checkAct(){
		var v = $("actfiles").value;
		var mm = $("actfilespan");
		var meg = $("actmeg");
		if(v==''){
			meg.value = "";
			return true;
		}else{
			v=v.split(".")[1];
			if(v=="zip"){
				mm.innerHTML = "格式正确";
				meg.value = "上传文件成功"
				return true;
			}else{
				mm.innerHTML = "格式错误，请上传zip文件";
				mm.style.color = "red";
				return false;
			}
		}
		
	}
	function checkaddAct(){
		var v = $("actfiles").value;
		var mm = $("actfilespan");
		var meg = $("actmeg");
		if(v==''){
			mm.innerHTML = "请上传文件";
			mm.style.color = "red";
			return false;
		}else{
			v=v.split(".")[1];
			if(v=="zip"){
				mm.innerHTML = "格式正确";
				meg.value = "上传文件成功";
				return true;
			}else{
				mm.innerHTML = "格式错误，请上传zip文件";
				mm.style.color = "red";
				return false;
			}
		}
		
	}
	function checkaddTemplate(){
		var v = $("files").value;
		var mm = $("filespan");
		var meg = $("meg");
		if(v==''){
			mm.innerHTML = "请上传文件";
			mm.style.color = "red";
			return false;
		}else{
			v=v.split(".")[1];
			if(v=="doc" || v=="docx"){
				mm.innerHTML = "格式正确";
				meg.value = "上传文件成功";
				return true;
			}else{
				mm.innerHTML = "格式错误，请上传doc或docx文件";
				mm.style.color = "red";
				return false;
			}
		}
		
	}
	</script>
</body>
</html>