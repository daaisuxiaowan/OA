<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/style/blue/top.css" />
<title>Insert title here</title>
</head>
<body class="PageBody" style="margin: 0">
	<div id="Head1" style="
	width: 100%;
	height: 64px;border: 0px solid #FFFFF;
	margin: 0px auto;
	background: url(${pageContext.request.contextPath}/style/blue/images/top_bg.gif);">
		<div id="Logo">
			<a id="msgLink" href="javascript:void(0)"></a>
            <font color="#0000CC" style="color:#F1F9FE; font-size:28px; font-family:Arial Black, Arial">OA系统</font> 
			<!--<img border="0" src="style/blue/images/logo.png" />-->
        </div>
		
		<div id="Head1Right">
			<div id="Head1Right_UserName">
                <img border="0" width="13" height="14" src="${pageContext.request.contextPath}/style/images/top/user.gif" /> 您好，<b>${user.name}</b>
			</div>
			<div id="Head1Right_UserDept"></div>
			<!-- <div id="Head1Right_UserSetup">
            	<a href="javascript:void(0)">
					<img border="0" width="13" height="14" src="style/images/top/user_setup.gif" /> 个人设置
				</a>
			</div> -->
			<div id="Head1Right_Time"></div>
		</div>
		
        <div id="Head1Right_SystemButton">
            <a target="_parent" href="${pageContext.request.contextPath}/main/exit">
				<img width="78" height="20" alt="退出系统" src="${pageContext.request.contextPath}/style/blue/images/top/logout.gif" />
			</a>
        </div>
		
<!--         <div id="Head1Right_Button">
            <a target="desktop" href="${pageContext.request.contextPath}//desktop?method=show">
				<img width="65" height="20" alt="显示桌面" src="${pageContext.request.contextPath}/style/blue/images/top/desktop.gif" />
			</a>
        </div> -->
	</div>
    
    <div id="Head2" style="width: 100%;
	height: 36px;
	margin-left: auto;
	margin: 0;
	background: url(${pageContext.request.contextPath}/style/blue/images/head2_bg.gif) repeat-x;
	border-top: 1px solid #a0c6e1;
	border-bottom: 1px solid #ffffff;">
        <div id="Head2_Awoke">
            <ul id="AwokeNum">
                <li><a target="desktop" href="javascript:void(0)">
						<img border="0" width="11" height="13" src="${pageContext.request.contextPath}/style/images/top/msg.gif" /> 消息
						<span id="msg"></span>
					</a>
				</li>
                <li class="Line"></li>
                <li><a target="desktop" href="javascript:void(0)">
						<img border="0" width="16" height="11" src="${pageContext.request.contextPath}/style/images/top/mail.gif" /> 邮件
						<span id="mail"></span>
					</a>
				</li>
                <li class="Line"></li>
				  <!-- 是否有待审批文档的提示1，数量 -->
                <li><a href="${pageContext.request.contextPath}/Flow_Formflow/myTaskList.html" target="desktop">
                		<img border="0" width="12" height="14" src="${pageContext.request.contextPath}/style/images/top/wait.gif" /> 
                		待办事项（<span id="wait" class="taskListSize">1</span>）
                	</a>
                </li>
				  
                <!-- 是否有待审批文档的提示2，提示审批 -->
                <li id="messageArea">您有 1 个待审批文档，请及时审批！★★★★★</li>
            </ul>
        </div>
        
		<div id="Head2_FunctionList">
			<marquee style="WIDTH: 100%;" onMouseOver="this.stop()" onMouseOut="this.start()" 
				scrollamount=1 scrolldelay=30 direction=left>
				<b>这是滚动的消息</b>
			</marquee>
		</div>
	</div>

</body>
</html>