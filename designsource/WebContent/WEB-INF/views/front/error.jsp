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
		<font face="微软雅黑">出错啦</font>
		<small><code>&lt;<font face="微软雅黑"> error </font>&gt;</code></small>
	</h2>
	<center>
	<br/><br/><br/><br/><br/>
	<p class="text-danger"><font face="微软雅黑" size="5px"> ${obj } </font></p>
	<br/>
	<a id="return-before-jsp" class="btn btn-default" type="button">返回</a>
	</center>
</div>
</body>
<script type="text/javascript">
	$(function(){
		$("#return-before-jsp").click(function(){
			$(this).attr("href", document.referrer);
		});
	});
</script>
</html>