<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/include/admin.jsp"%>
<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>
<title>Welcomeing!</title>
</head>
<body>
		
		<div class="container">
			<h1 class="page-header">Welcome !</h1>
			<div class="well" style="width: 85%;">
				<h2>公告：</h2>
				<p></p>
				<p id="message"></p>
				<p></p>
				<p id="date">时间：</p>
			</div>
			<br/>
			<blockquote>
				<br/>
				<p id="title"></p>
				<p id="words">&nbsp;&nbsp;&nbsp;</p>
				<p></p>
				<p></p>
				<br/>
				<p><small>来自<cite id="author"></cite></small></p>
				
			</blockquote>
		</div>
		
		<div id="calendar"></div>

</body>
<script type="text/javascript">
	$(function(){
		$.post("${txAdmin }/system/ajax/show", {}, function(data){
			var obj =  $.parseJSON(data);
			/* bulletin */
			$("#message").append(obj.bulletin.message);
			$("#date").append(obj.bulletin.date.substring(0, 10));
			/* sentence */
			$("#title").append(obj.sentence.title);
			$("#words").append(obj.sentence.words);
			$("#author").append(obj.sentence.author);
		}, "text");
	});
</script>
</html>