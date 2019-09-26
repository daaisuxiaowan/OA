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
			openchildmenu(2);	
		};
	</script>
	<div style="width:99%;height:900px;">
		<jsp:include page="/mainmodel.jsp"></jsp:include>
	</div>
	<div style="position:absolute;lfet:50%;top:15%;width:100%;">
		<span id="showspan" style="position:absolute;left:35%;top:50%;">
			<span id="showspanchild">
				<c:choose>
					<c:when test="${flag eq 'update'}">
						<form action="${pageContext.request.contextPath}/main/updateRole" style="font-size:20px;position:relative;left:35%;">
							<input type="hidden" name="id" value="${role.id}">
							角色编号:${role.id}<br/>		
							角色名字:<input type="text" name="rolename" value="${role.rolename}"><br/>
							角色说明:<input type="text" name="memo" value="${role.memo}"><br/>
							角色权限:<br/>
								<c:forEach items="${menulist}" var="onelv">
									<c:if test="${onelv.securyname eq '1级权限'}">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	<input type="checkbox" name="menuname"
											<c:forEach items="${role.menus}" var="rm">
												<c:if test="${rm.menuname eq onelv.menuname}">
													checked
												</c:if>
											</c:forEach>
										 value="${onelv.id}">${onelv.menuname}<br/>
											<c:forEach items="${menulist}" var="twolv">
												<c:if test="${twolv.securyname eq '2级权限'}">
													<c:if test="${onelv.id eq twolv.pid}">
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="menuname"
															<c:forEach items="${role.menus}" var="rm">
																<c:if test="${rm.menuname eq twolv.menuname}">
																	checked
																</c:if>
															</c:forEach>
														 value="${twolv.id}">${twolv.menuname}<br/>
														<c:forEach items="${menulist}" var="threelv">
															<c:if test="${threelv.securyname eq '3级权限'}">
																<c:if test="${twolv.id eq threelv.pid}">
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" 
																		<c:forEach items="${role.menus}" var="rm">
																			<c:if test="${rm.menuname eq threelv.menuname}">
																				checked
																			</c:if>
																		</c:forEach>
																	name="menuname" value="${threelv.id}">${threelv.menuname}<br/>
																	<c:forEach items="${menulist}" var="fourlv">
																		<c:if test="${fourlv.securyname eq '4级权限'}">
																			<c:if test="${threelv.id eq fourlv.pid}">
																				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox"
																					<c:forEach items="${role.menus}" var="rm">
																						<c:if test="${rm.menuname eq fourlv.menuname}">
																							checked
																						</c:if>
																					</c:forEach>
																				 name="menuname" value="${fourlv.id}">${fourlv.menuname}<br/>
																			</c:if>
																		</c:if>
																	</c:forEach>
																</c:if>
															</c:if>
														</c:forEach>
													</c:if>
												</c:if>
											</c:forEach>
									</c:if>
								</c:forEach>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit"> &nbsp;<input type="reset">
						</form>
					</c:when>
					<c:when test="${flag eq 'add'}">
						<form action="${pageContext.request.contextPath}/main/addRole" style="font-size:20px;position:relative;left:35%;">		
							角色名字:<input type="text" name="rolename"><br/>
							角色说明:<input type="text" name="memo"><br/>
							角色权限:<br/>
								<c:forEach items="${menulist}" var="onelv">
									<c:if test="${onelv.securyname eq '1级权限'}">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="menuname" value="${onelv.id}">${onelv.menuname}<br/>
											<c:forEach items="${menulist}" var="twolv">
												<c:if test="${twolv.securyname eq '2级权限'}">
													<c:if test="${onelv.id eq twolv.pid}">
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="menuname" value="${twolv.id}">${twolv.menuname}<br/>
														<c:forEach items="${menulist}" var="threelv">
															<c:if test="${threelv.securyname eq '3级权限'}">
																<c:if test="${twolv.id eq threelv.pid}">
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="menuname" value="${threelv.id}">${threelv.menuname}<br/>
																	<c:forEach items="${menulist}" var="fourlv">
																		<c:if test="${fourlv.securyname eq '4级权限'}">
																			<c:if test="${threelv.id eq fourlv.pid}">
																				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="menuname" value="${fourlv.id}">${fourlv.menuname}<br/>
																			</c:if>
																		</c:if>
																	</c:forEach>
																</c:if>
															</c:if>
														</c:forEach>
													</c:if>
												</c:if>
											</c:forEach>
									</c:if>
								</c:forEach>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit"> &nbsp;<input type="reset">
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