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
<script type="text/javascript" src="${txStatic }/js/validdateLoginname.js"></script>
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
					<div style="margin-bottom: 100px;"  class="contact-form-div">
						<div class="logo">
							<ul class="icon1 sub-icon1"><li>
							<img class="img-circle" src="${txAvatar }${obj.avatar }" alt="" height="80px" width="80px"/>
							<ul class="sub-icon1 list" style="width: 170px">
									<li><h3><font face="微软雅黑">设置头像</font></h3></li>
									<li>
										<div class="contact-form">
											   <center>
											   <div>
											   		<form target="_self" enctype="multipart/form-data" action="${txFront }/uploadUserAvatar" method="post" >
											   		<input name="id" type="hidden" class="textbox" value="${obj.id }">
												    <a class="btn_addPic" href="#">
												    		<span><em></em>添加图片</span> 
												    	<input id="upload-img-avatar" class="filePrew" title="" tabIndex="3" type="file" size="3" name="avatar">
												    </a>
												    <p id="upload-img-message"></p>
												    
												    <span><input id="header-myCenter-btn" type="submit" class="" value="上传"></span>
												    </form>
											   </div>
											   </center>
									    </div>
				  						<div class="clear"></div>		
									</li>
									<li><center><font face="微软雅黑" color="#FA8072" size="2px"><br />图片大小不超过100K<br />推荐像素 80px * 80px</font></center></li>
							</ul>
							</li></ul>
						</div>
						<div class="logo">
							<c:if test="${obj.status == 1 }"><!-- 未认证 -->
								<p style="line-height:80px;">
								&nbsp;&nbsp;&nbsp;<font face="微软雅黑" color="#8B1A1A" size="4px">您还没有进行实名认证，请尽快完成认证！</font>
								&nbsp;&nbsp;&nbsp;<input id="myCenter-authentication-btn" type="submit" class="" value="认证">
								</p>
							</c:if>
							<c:if test="${obj.status == 2 }"><!-- 待认证 -->
								<p style="line-height:80px;">
								&nbsp;&nbsp;&nbsp;<font face="微软雅黑" color="#8B1A1A" size="4px">我们已收到您的认证申请，我们将在三个工作日内完成审核。</font>
								</p>
							</c:if>
							<c:if test="${obj.status == 3 }"><!-- 认证通过 -->
								<p style="line-height:80px;">
								&nbsp;&nbsp;&nbsp;<font face="微软雅黑" color="#8B1A1A" size="4px">淘学网 - 认证用户</font>
								</p>
							</c:if>
							<c:if test="${obj.status == 4 }"><!-- 认证驳回 -->
								<p style="line-height:80px;">
								&nbsp;&nbsp;&nbsp;<font face="微软雅黑" color="#8B1A1A" size="4px">您的实名认证没有通过，请再次认证！</font>
								&nbsp;&nbsp;&nbsp;<input id="myCenter-authentication-btn" type="submit" class="" value="认证">
								</p>
							</c:if>
							<c:if test="${obj.status == 5 }"><!-- 黑名单 -->
								<p style="line-height:80px;">
								&nbsp;&nbsp;&nbsp;<font face="微软雅黑" color="#8B1A1A" size="4px">很不幸，您是淘学网黑名单用户！</font>
								&nbsp;&nbsp;&nbsp;<input id="myCenter-authentication-btn" type="submit" class="" value="反馈">
								</p>
							</c:if>
							
						</div>
					</div>
						
			 	 	    <form id="validForm" method="post" action="${txFront }/myInfoUpdate">
			 	 	    	<input name="id" type="hidden" class="textbox" value="${obj.id }">
					    	<div class="contact-form-div">
						    	<span><label>登录名  <font id="check-loginname-msg" color="#FA8072"></font></label></span>
						    	<span><input name="loginName" type="text" class="textbox" value="${obj.loginName }" onchange="validdateLoginname(this, '${txFront }')" readonly></span>
						    </div>
						    <div class="contact-form-div">
						    	<span><label>个性昵称</label></span>
						    	<span><input name="username" type="text" class="textbox" value="${obj.username }"></span>
						    </div>
						    <div class="contact-form-div">
						     	<span><label>电话</label></span>
						    	<span><input name="phone" type="text" class="textbox {digits:true}" value="${obj.phone }"></span>
						    </div>
						    <div class="contact-form-div">
						     	<span><label>QQ</label></span>
						    	<span><input name="qq" type="text" class="textbox {digits:true}" value="${obj.phone }"></span>
						    </div>
						    <div class="contact-form-div">
						    	<span><label>个人介绍</label></span>
						    	<span><textarea name="remarks">${obj.remarks }</textarea></span>
						    </div>
						   <div class="contact-form-div">
						   		<span><input type="submit" class="" value="保存"></span>
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

			$("#validForm").validate();
			
			if ('' != '${sessionScope.uploadAvatarMsg }') {
				new jBox('Notice', {
			   		content: '${sessionScope.uploadAvatarMsg }',
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
				$.post("${tx }/removeSession?op=uploadAvatarMsg", {}, function(){});
			}
				
			$("#upload-img-avatar").change(function(){
				$("#upload-img-message").empty();
				var file = this.files[0]; 
				$("#upload-img-message").append("文件名称：<br />" + file.name + "<br />");
				var size = file.size/1024;
				if (size > 100) 
					$("#upload-img-message").append("文件大小：<br /><font color='red'>" + size + "KB ×</font>");
				else $("#upload-img-message").append("文件大小：<br />" + size + "KB");
			});
			
			/* 认证 */
			$("#myCenter-authentication-btn").click(function(){
				window.location.href="${txFront }/authenticationForm?userId=${sessionScope.user.id }";
			});
			
		});
</script>
</html>