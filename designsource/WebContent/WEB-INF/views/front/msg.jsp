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
<style>
.icon_fail {
    display: inline-block;
    width: 179px;
    height: 110px;
    background: url(${txStatic }/images/email.png) 0 -140px;
}
</style>
<body>
<div class="container">
	
	<h2 class="page-header">
		<img src="${txStatic }/images/logo.png" alt="">
		<font face="微软雅黑">验证信息</font>
		<small><code>&lt;<font face="微软雅黑"> email return message </font>&gt;</code></small>
	</h2>
	<center>
	<span class="icon_fail" id=""></span>
	<br/><br/>
	<p class="text-danger"><font face="微软雅黑" size="5px"> ${obj } </font></p>
	<br/>
	<a id="" class="btn btn-default" type="button" href="${txFront }/myCenterForm">返回个人中心</a>
	</center>
</div>
</body>
<script type="text/javascript">
	$(function(){
		
	});
</script>
</html>