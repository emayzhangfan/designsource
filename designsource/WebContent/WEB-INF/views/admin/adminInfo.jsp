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
<h2 class="page-header"><font face="微软雅黑">个人信息</font>  <small><code>&lt; Myself  &gt;</code></small></h2>
	<br/>
<%-- 	<center><p class="text-danger"><font id="font-msg" face="微软雅黑" size="5px"> ${obj } </font></p></center> --%>
	<form class="form-horizontal" action="${txAdmin }/help/adminInfo" method="post">
	   <input type="hidden" name="id" value="${obj.id }"/>
	   
	   <div class="form-group">
	      <label class="col-sm-2 control-label">登录名</label>
	      <div class="col-sm-8">
	         <input type="text" class="form-control"
	         	name="username" readonly="true" value="${obj.username }"/>
	      </div>
	   </div>
	   <div class="form-group">
	      <label class="col-sm-2 control-label">姓名</label>
	      <div class="col-sm-8">
	         <input type="text" class="form-control" 
	         	name="name" value="${obj.name }"/>
	      </div>
	   </div>
	   <div class="form-group" id="has-error-newpw">
	      <label class="col-sm-2 control-label">性别</label>
	      <div class="col-sm-8">
	      	<c:choose>
	      		<c:when test="${obj.sex == 1 }">
	      			<input type="radio" name="sex" value="1" checked/>男 
	         		<input type="radio" name="sex" value="2"/>女
	      		</c:when>
	      		<c:when test="${obj.sex == 2 }">
	      			<input type="radio" name="sex" value="1"/>男
	         		<input type="radio" name="sex" value="2" checked/>女
	      		</c:when>
	      		<c:otherwise>
	      			<input type="radio" name="sex" value="1"/>男 
	         		<input type="radio" name="sex" value="2"/>女
	      		</c:otherwise>
	      	</c:choose>
	         
	      </div>
	   </div>
	   <div class="form-group" id="has-error-newpw">
	      <label class="col-sm-2 control-label">电话</label>
	      <div class="col-sm-8">
	         <input type="text" class="form-control" 
	         	name="phone" value="${obj.phone }"/>
	      </div>
	   </div>
	   <div class="form-group" id="has-error-newpw">
	      <label class="col-sm-2 control-label">角色</label>
	      <div class="col-sm-8">
	         <input type="text" class="form-control" 
	         	name="" readonly="true" value="${obj.role.name }"/>
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