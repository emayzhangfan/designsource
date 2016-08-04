<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>淘学网 - 注册页面</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<%@ include file="/WEB-INF/views/include/front.jsp"%>
<link href="${txStatic }/_front/css/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- start top_js_button -->
<script type="text/javascript" src="${txStatic }/_front/js/move-top.js"></script>
<script type="text/javascript" src="${txStatic }/_front/js/easing.js"></script>
<script type="text/javascript" src="${txStatic }/js/validdateLoginname.js"></script>
   <script type="text/javascript">
		jQuery(document).ready(function($) {
			$("#validForm").validate();
			$(".scroll").click(function(event){		
				event.preventDefault();
				$('html,body').animate({scrollTop:$(this.hash).offset().top},1200);
			});
		});
	</script>
</head>
<body>
<!-- start header -->
<%@ include file="/WEB-INF/views/front/inc/header.jsp"%>
<!-- start main -->
<div class="main_bg">
<div class="wrap">	
<div class="main">
		 <div class="service">
		 <div class="ser-main">
	 	 <div class="contact">				
				  <div class="contact-form">
			 	  	 	<h2><font face="微软雅黑">用户注册</font></h2>
			 	  	 	<br />
			 	 	    <form id="validForm" method="post" action="${txFront }/register">
					    	<div class="contact-form-div">
						    	<span><label>登录名<font color="#FA8072">*   </font><font id="check-loginname-msg" color="#FA8072"></font></label></span>
						    	<input id="check-loginname" name="loginName" type="text" class="textbox required" onchange="validdateLoginname(this, '${txFront }')">
						    </div>
						    <div class="contact-form-div">
						    	<span><label>个性昵称<font color="#FA8072">*</font></label></span>
						    	<input name="username" type="text" class="textbox required">
						    </div>
						    <div class="contact-form-div">
						     	<span><label>电话<font color="#FA8072">*</font></label></span>
						    	<input name="phone" type="text" class="textbox required {digits:true}">
						    </div>
						    <div class="contact-form-div">
						     	<span><label>QQ<font color="#FA8072">*</font></label></span>
						    	<input name="qq" type="text" class="textbox required {digits:true}">
						    </div>
						    <div class="contact-form-div">
						    	<span><label>密码<font color="#FA8072">*</font></label></span>
						    	<input id="password" name="password" type="text" class="textbox required">
						    </div>
						    <div class="contact-form-div">
						    	<span><label>确认密码<font color="#FA8072">*</font></label></span>
						    	<input type="text" class="textbox {required:true,equalTo:'#password'}">
						    </div>
						    <div class="contact-form-div">
						    	<span><label>个人介绍</label></span>
						    	<textarea name="remarks"> </textarea>
						    </div>
						   <div class="contact-form-div">
						   		<span><input id="register-btn" type="submit" class="" value="注册"></span>
						  </div>
					    </form>
				</div>
  				<div class="clear"></div>		
		</div>
		</div>
		</div>
		<div class="clear"></div>
</div>
</div>
</div>		


<!-- start footer -->
<%@ include file="/WEB-INF/views/front/inc/footer.jsp"%>
</body>

<script type="text/javascript">

</script>
</html>