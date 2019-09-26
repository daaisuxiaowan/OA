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
		knowledgeshow(1);
	};
	
	function addknowledge(){
		var showspan = $("showspanchild");
		var xhr = new XMLHttpRequest();		//获取ajax对象
		xhr.open("post","${pageContext.request.contextPath}/knowledge/addknowledgealax?ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "ajaxmsg"){
					showspan.innerHTML="无访问权限";
				}else if(date == "addkn"){
					showspan.innerHTML = "<form action='${pageContext.request.contextPath}/knowledge/addKnowledge' onsubmit=\"return checkaddKnowledge()\" method=\"post\" enctype=\"multipart/form-data\">"
						+"<input type='hidden' name='publisher' value='${user.name}'><br/>"
						+"文件名称:<input type='text' name='name'><br/>"
						+"知识文件:<input id='actfiles'type=\"file\" name=\"file\"><span id='actfilespan'>必须上传文件</span><br>"
						+"&nbsp;&nbsp;<input type='submit'> &nbsp;<input type='reset'>"
						+"</form>";
				}
			}
		}
	}
	
	function getknowledgeshow(page){
		var ssname = $("ssname").value;
		var starttime = $("starttime").value;
		var endtime = $("endtime").value;
		knowledgeshow(page,ssname,starttime,endtime);
	}
	function knowledgeshow(page,ssname,starttime,endtime){
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
		xhr.open("post","${pageContext.request.contextPath}/knowledge/knowledgeshow?page="+page+"&name="+ssname+"&starttime="+starttime+"&endtime="+endtime+"&ajaxmsg='ajaxmsg'",true);  //连接获取指定商品信息的servlet
		xhr.send();							//发送请求
		xhr.onreadystatechange = function () {  	//监听状态，等一切就绪后进入数据处理阶段
			if(xhr.readyState==4&&xhr.status==200){
				var date = xhr.responseText;		//获取json传来的数据
				if(date == "ajaxmsg"){
					showspan.innerHTML="无访问权限";
				}else{
				date = eval("("+date+")");			//解析数据
				var pg = date;
				var kn = pg.result;
				showspan.innerHTML = "<h2 style=\"position:relative;left:44%;font-size:35px;\">知识信息</h2>"
									+"<div><button onclick='addknowledge()'>添加文件</button></div>"
									+"文件名称：<input type='text' id='ssname' value='"+ssname+"' style=\"width:120px;height:26px;font-size:25px;position:relative;bottom:1px;\">"
									+"时间：<input type='date' id='starttime' style=\"width:195px;height:27px;font-size:25px;\">至<input type='date' id='endtime' style=\"width:195px;height:27px;font-size:25px;\">"
									+"&nbsp;&nbsp;<button onclick='getknowledgeshow("+pg.page+")' style=\"position:relative;bottom:1px;font-size:25px;\">搜索</button>"
									+"<div  ><table id='tab1' border=\"5\" style=\"border-collapse:collapse;border-color:#ddd;position:relative;\">"
									+"<tr>"
										+"<th>编号</th>"
										+"<th>文件名</th>"
										+"<th>上传时间</th>"
										+"<th>上传人</th>"
										+"<th>操作</th>"
									+"</tr>"
								+"</table></div><br><span id=\"rd\"></span>";
				var tab = $("tab1");
				for(var i=0;i<kn.length;i++){
						var tr = document.createElement("tr");
						tr.innerHTML = "<tr>"
									+"<td>"+kn[i].id+"</td>"
									+"<td style=\"width:150px;\">"+kn[i].name+"</td>"
									+"<td>"+kn[i].releasedate+"</td>"
									+"<td style=\"width:140px;\">"+kn[i].publisher+"</td>"
									+"<td><a href='${pageContext.request.contextPath}/knowledge/knowledgeDownload?path="+kn[i].filepath+"'>下载</a>&nbsp;"
									+"<a href=\"javascript:deleteKnowledge("+kn[i].id+",'knowledge')\">删除</a></td>"
									+"</tr>";
						tab.appendChild(tr);
				}
				var rd = $("rd");
				rd.innerHTML = "<span><br>"
				+"共有"+pg.totalCount+"个知识，当前为："+pg.page+"/"+pg.totalPage+"页"
				+"</span>"
				+"<span style=\"position:relative;left:5%;\">"
				+"<a onclick=\"first('knowledge')\" href=\"#\">首页</a> <a href=\"#\" onclick=\"back("+pg.page+",'knowledge')\">上一页</a> <a href=\"#\" onclick=\"next("+pg.page+",'knowledge',"+pg.totalPage+")\">下一页</a> <a href=\"#\" onclick=\"last("+pg.totalPage+",'knowledge')\">尾页</a>"					
				+"</span>";
				}
			}
		}
	}
	function deleteKnowledge(v,turnname){
		var su = confirm("您确认要删除吗？");
		if(su==true){
			if(turnname=="knowledge"){
				window.location.href="${pageContext.request.contextPath}/knowledge/deleteKnowledge?id="+v;
			}
		}
	}
	function first(func){
		if(func=="knowledge"){
			knowledgeshow(1);
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
		if(func=="knowledge"){
			knowledgeshow(v);
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
		if(func=="knowledge"){
			knowledgeshow(v);
		}else if(func=="template"){
			templateshow(v);
		}else if(func=="app"){
			appshow(v);
		}else if(func=="user"){
			usershow(v);
		}
	}
	
	function last(v,func){
		if(func=="knowledge"){
			knowledgeshow(v);
		}else if(func=="template"){
			templateshow(v);
		}else if(func=="app"){
			appshow(v);
		}else if(func=="user"){
			usershow(v);
		}
	}
	function checkaddKnowledge(){
		var v = $("actfiles").value;
		var mm = $("actfilespan");
		if(v==''){
			mm.innerHTML = "请上传文件";
			mm.style.color = "red";
			return false;
		}else{	
			return true;
		}	
	}
	</script>
</body>
</html>