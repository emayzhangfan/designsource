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
<h2 class="page-header"><font face="微软雅黑">修改密码</font>  <small><code>&lt; UpdatePassword  &gt;</code></small></h2>
	<br/>
	<center><p class="text-danger"><font id="font-msg" face="微软雅黑" size="5px"> ${obj } </font></p></center>
	<form class="form-horizontal" action="${txAdmin }/help/changepwd" method="post">
	   <div class="form-group">
	      <label class="col-sm-2 control-label">旧密码</label>
	      <div class="col-sm-8">
	         <input type="password" class="form-control"
	         	name="oldPassword"
	         	id="oldPassword"
	            placeholder="请输入旧密码">
	      </div>
	   </div>
	   <div class="form-group">
	      <label class="col-sm-2 control-label">新密码</label>
	      <div class="col-sm-8">
	         <input type="password" class="form-control" 
	         	name="newPassword"
	         	id="newPassword1"
	            placeholder="请输入新密码">
	      </div>
	   </div>
	   <div class="form-group" id="has-error-newpw">
	      <label class="col-sm-2 control-label">重复输入新密码</label>
	      <div class="col-sm-8">
	         <input type="password" class="form-control" 
	         	id="newPassword2"
	            placeholder="请再次输入新密码">
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
		
		$("#newPassword2").change(function(){
			$("#font-msg").empty();
			if($(this).val() != $("#newPassword1").val()) {
				$("#btn-changepsd-save").attr("class", "btn btn-default disabled");
				$("#has-error-newpw").attr("class", "form-group has-error");
				$("#font-msg").append("请输入相同的密码！");
			}else {
				$("#btn-changepsd-save").attr("class", "btn btn-default");
				$("#has-error-newpw").attr("class", "form-group");
			}
				
		});
		
		$("#btn-changepsd-save").click(function(){
			$("#font-msg").empty();
			if($("#oldPassword").val() == "" ||
					$("#newPassword1").val() == "" ||
					$("#newPassword2").val() == "")
			{$("#font-msg").append("请补全信息！");return false;}
			else return true;
		});
	});
</script>

</html>