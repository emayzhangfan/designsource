<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%@ include file="/WEB-INF/views/include/admin.jsp"%>
<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>
</head>
<body>
<div class="container">
	<h2 class="page-header">
		<img src="${txStatic }/images/logo.png" alt="">
		<font face="微软雅黑">页面找不到</font>
		<small><code>&lt;<font face="微软雅黑"> Not Page </font>&gt;</code></small>
	</h2>
	<p class="text-primary"><font face="微软雅黑"><strong>可能是以下原因造成：</strong></font></p>
	<p class="text-muted"><font face="微软雅黑">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. 没有该页面，请<code>检查地址</code>！</font></p>
	<p class="text-muted"><font face="微软雅黑">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. 您没有该页面的权限，请<code>联系管理员</code>！</font></p>
	<p class="text-muted"><font face="微软雅黑">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. 您还没有登录，请<code>登录</code>！</font></p>
	<p class="text-muted"><font face="微软雅黑">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4. Session（会话）超时，请您<code>重新登录</code>！</font></p>
	
</div>
</body>
</html>
