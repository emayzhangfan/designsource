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
<style>
  #progressbar .ui-progressbar-value {
    background-color: #ccc;
  }
</style>
<body>
<div class="container">
	
	<h2 class="page-header">
		<img src="${txStatic }/images/logo.png" alt="">
		<font face="微软雅黑">忘记密码</font>
		<small><code>&lt;<font face="微软雅黑"> forget password </font>&gt;</code></small>
	</h2>
	<br/><br/>
	<form class="form-horizontal" action="" method="post">
	   <div class="form-group">
	      <label class="col-sm-2 control-label">用户名</label>
	      <div class="col-sm-8">
	         <input type="text" class="form-control"
	         	name="loginName"
	         	id="loginName"
	            placeholder="用于淘学网的登陆账号">
	      </div>
	   </div>
<!-- 	   <div class="form-group"> -->
<!-- 	      <label class="col-sm-2 control-label">修改方式</label> -->
<!-- 	      <div class="col-sm-8"> -->
<!-- 		      <input type="radio" name="optionsRadios" id="optionsRadios1"  -->
<!-- 		         value="1">发送验证邮箱 -->
<!-- 		      <input type="radio" name="optionsRadios" id="optionsRadios2"  -->
<!-- 		         value="2">申请重置密码 -->
<!-- 	      </div> -->
<!-- 	   </div> -->
	   <br/>
	   <div class="form-group" id="email-submit">
	      <div class="col-sm-offset-2 col-sm-10">
	         <button type="submit" class="btn btn-default" onclick="send_email_pwd();return false;">发送验证邮件</button>
	      </div>
	   </div>
	</form>
</div>



<div id="dialog-message" title="发送验证邮件" style="display:none;">
<div style="width: 400px; height: 130px" class="form-group">
	<br />
	<div id="progressbar"></div>
	<br />
	<center><font color="#218868" face="微软雅黑">验证邮件发送中，请稍等。。。</font></center>
	<br />
</div>
</div>

</body>
<script type="text/javascript">

function send_email_pwd() {
	$( "#dialog-message" ).dialog({
	      modal: true,
	      width: 430,
	      open: function (event, ui) {
	      	$(".ui-dialog-titlebar-close", $(this).parent()).hide();
	      }
	});
	var loginName = $("#loginName").val();
    $.ajax({
        url : "${tx }/safe/emailPwd",
        data : {loginName : loginName},
        type : "POST",
        dataType : "json",
        success : function (data) {
            if (data.ok) {
            	$("#dialog-message").dialog("close");
            	new jBox('Notice', {
			   		content: '发送验证邮件成功，请在十分钟内完成验证！',
			   		autoClose: 3000,
			        attributes: {
			    		x: 'left',
			    		y: 'bottom'
			    	},
			    	position: {  // The position attribute defines the distance to the window edges
			    		x: 550,
			    		y: 400
			    	}
				});
            } else {
            	$("#dialog-message").dialog("close");
                new jBox('Notice', {
			   		content: data.msg,
			   		autoClose: 1500,
			        attributes: {
			    		x: 'left',
			    		y: 'bottom'
			    	},
			    	position: {  // The position attribute defines the distance to the window edges
			    		x: 550,
			    		y: 400
			    	}
				});
            }
        }
    });
}


	$(function(){
		
// 		$("#email-submit").hide();
// 		$("#other-submit").hide();
		
// 		$("#optionsRadios1").click(function(){
// 			$("#email-submit").show();
// 			$("#other-submit").hide();
// 		});
		
		$( "#progressbar" ).progressbar({
		      value: false
		});
	});
</script>
</html>