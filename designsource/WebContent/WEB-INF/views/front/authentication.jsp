<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>淘学网 - 个人中心</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<%@ include file="/WEB-INF/views/include/front.jsp"%>
<%@ include file="/WEB-INF/views/include/jBox.jsp"%>
<link href="${txStatic }/_front/css/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- start top_js_button -->
<script type="text/javascript" src="${txStatic }/_front/js/move-top.js"></script>
<script type="text/javascript" src="${txStatic }/_front/js/easing.js"></script>
   <script type="text/javascript">
		jQuery(document).ready(function($) {
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
				<!-- start service -->
	  			<div class="service">
				<div class="ser-main">
				<div class="contact">				
				<div class="contact-form">
						<h2><font face="微软雅黑">学生认证</font></h2>
						<br />
			 	 	    <form id="validForm" method="post" action="${txFront }/authentication"
			 	 	    	target="_self" enctype="multipart/form-data">
			 	 	    	<input name="id" type="hidden" class="textbox" value="${obj.id }">
					    	<div class="contact-form-div">
						    	<span><label>学号<font color="#FA8072">*   </font></label></span>
						    	<span><input name="cardId" type="text" class="textbox required" value=""></span>
						    </div>
						    <div class="contact-form-div">
						    	<span><label>姓名<font color="#FA8072">*   </font></label></span>
						    	<span><input name="name" type="text" class="textbox required" value=""></span>
						    </div>
						    <div class="contact-form-div">
						     	<span><label>性别<font color="#FA8072">*   </font></label></span>
						    	<span><label>
							    	<input name="sex" type="radio" class="textbox" value="1">男
							    	<input name="sex" type="radio" class="textbox" value="2">女	
						    	</label></span>
						    </div>
						    <br />
						    <div class="contact-form-div">
						    	<span><label>上传学生证照片<font color="#FA8072">*   图片大小不超过100K</font></label></span>
						    	<span>
						    		<a class="btn_addPic" href="#">
										<span><em></em>添加图片</span> 
										<input id="upload-authimg-avatar" class="filePrew required" title="" tabIndex="3" type="file" size="3" name="auth">
									</a>
						    	</span>
						    	<span><label id="upload-authimg-message"></label></span>
						    </div>
						   <div class="contact-form-div">
						   		<span><input type="submit" class="" value="认证"></span>
						  </div>
					    </form>
				</div>
  				<div class="clear"></div>		
			    </div>
				</div>
				</div>
				<!-- start sidebar -->
				<%@ include file="/WEB-INF/views/front/inc/sidebar.jsp"%>
				<div class="clear"></div>
			</div>
	</div>
</div>
	


<!-- start footer -->
<%@ include file="/WEB-INF/views/front/inc/footer.jsp"%>
</body>
<script type="text/javascript">
		jQuery(document).ready(function($) {
			
			if ('' != '${sessionScope.uploadUserAuthMsg }') {
				new jBox('Notice', {
			   		content: '${sessionScope.uploadUserAuthMsg }',
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
				$.post("${tx }/removeSession?op=uploadUserAuthMsg", {}, function(){});
			}
			
			$("#validForm").validate();
			
			$("#upload-authimg-avatar").change(function(){
				$("#upload-authimg-message").empty();
				var file = this.files[0]; 
				var size = file.size/1024;
				html = '<br />';
				html += '&nbsp;文件名称：<br />&nbsp;&nbsp;' + file.name + '<br />';
				if (size > 100) 
					html += '&nbsp;文件大小：<br />&nbsp;&nbsp;<font color="red">' + size + 'KB ×</font>';
				else html += '&nbsp;文件大小：<br />&nbsp;&nbsp;' + size + 'KB';
				$("#upload-authimg-message").append(html);
			});
			
		});
</script>
</html>