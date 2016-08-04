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
<h2 class="page-header"><font face="微软雅黑">字段设置</font>  <small><code>&lt; Sentence  &gt;</code></small></h2>
	<br/>
	<form class="form-horizontal" action="${txAdmin }/system/sentenceRecord" method="post">
	   <input type="hidden" name="id" value="${obj.id }"/>
	   
	   <div class="form-group">
	      <label class="col-sm-2 control-label">标题</label>
	      <div class="col-sm-8">
	         <input type="text" class="form-control"
	         	name="title" value="${obj.title }"/>
	      </div>
	   </div>
	   <div class="form-group">
	      <label class="col-sm-2 control-label">内容</label>
	      <div class="col-sm-8">
	      	 <textarea class="form-control" rows="3" name="words">${obj.words }</textarea>
	      </div>
	   </div>
	   <div class="form-group">
	      <label class="col-sm-2 control-label">作者</label>
	      <div class="col-sm-8">
	         <input type="text" class="form-control"
	         	name="author" value="${obj.author }"/>
	      </div>
	   </div>
	   <br/>
	   <div class="form-group">
	      <div class="col-sm-offset-2 col-sm-10">
	         <button id="btn-changepsd-save" type="submit" class="btn btn-default">保存</button>
	      </div>
	   </div>
	</form>
</div>
</body>
<script type="text/javascript">
	$(function(){
		
	});
</script>

</html>