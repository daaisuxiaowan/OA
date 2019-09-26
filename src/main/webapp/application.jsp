<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/flow.js" type="text/javascript"></script>
</head>
<body>
<div style="width:100%;height:900px;">
		<jsp:include page="/mainmodel.jsp"></jsp:include>
	</div>
	<div style="position:absolute;lfet:50%;top:15%;width:100%;">
		<span id="showspan" style="position:absolute;left:35%;top:50%;">
			<span id="showspanchild">
				<h2>发起申请</h2>
				请下载申请文档,填写后上传:<a href="${pageContext.request.contextPath}/flow/download?path=${template.filepath}&msg='申请下载'">下载文档</a><br/>
				<form action="${pageContext.request.contextPath}/flow/submitApplication" method="post" onsubmit="return checkaddTemplate()" enctype="multipart/form-data">
					<input type="hidden" name="pdkey" value="${template.pdkey}">
					<input type="hidden" name="username" value="${user.name}">
					<input type="hidden" name="title" value="${actname}">
					<input type="hidden" name="userid" value="${user.id}">
					<input type="hidden" name="tempid" value="${template.id}">
					<input type='hidden' id='meg' name='meg' ><br/>
					&nbsp;申请人:${user.name}<br>
					申请题目:${actname}<br>
					申请模板:<input type="file" id="files" name="file"><span id='filespan'></span><br>
					&nbsp;&nbsp;&nbsp;<input type="submit" value="发起申请">
				</form>
			</span>
		</span>
	</div>
	<script>
	window.onload = function(){
		leftmenu(24);	
	};
	function $(v){
		return document.getElementById(v);
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