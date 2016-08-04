<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%@ include file="/WEB-INF/views/include/admin.jsp"%>
<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>
<%@ include file="/WEB-INF/views/include/jBox.jsp"%>
<%@ include file="/WEB-INF/views/include/jquery-ui.jsp"%>
</head>
<body>
<div class="container">
	
	<h2 class="page-header">
		<img src="${txStatic }/images/logo.png" alt="">
		<font face="微软雅黑">修改密码</font>
		<small><code>&lt;<font face="微软雅黑"> update password </font>&gt;</code></small>
	</h2>
	<form class="form-horizontal" action="${tx }/safe/changepwd" method="post">
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
	         <button id="btn-changepsd-save" type="submit" class="btn btn-default">修改</button>
	      </div>
	   </div>
	</form>
</div>



<div id="dialog-message" title="页面跳转中" style="display:none;">
<div style="width: 400px; height: 130px" class="form-group">
	<center>
		<span class="text-success">修改成功！</span><br/>页面将在3秒后跳转...
		<br/><br/>还剩<span id="num">3</span>秒  
	</center>
	<br />
</div>
</div>
</body>
<script type="text/javascript">

	function jump(count) {    
	    window.setTimeout(function(){    
	        count--;    
	        if(count > 0) {   
	        	$('#num').empty();
	            $('#num').append(count);    
	            jump(count);    
	        } else {    
	            location.href="${tx }/index";    
	        }    
	    }, 1000);    
	}    

	$(function(){
		$("#btn-changepsd-save").click(function(){
			$.post("${tx }/safe/changepwd", {newPassword : $("#newPassword1").val()}, function(flag){
				if (flag) {
					$.post("${tx }/removeSession?op=tempSession", {}, function(){});
					$( "#dialog-message" ).dialog({
					      modal: true,
					      width: 430,
					      open: function (event, ui) {
					      	$(".ui-dialog-titlebar-close", $(this).parent()).hide();
					      }
					});
				}
				jump(3);
			});
			return false;
		});
	});
</script>
</html>