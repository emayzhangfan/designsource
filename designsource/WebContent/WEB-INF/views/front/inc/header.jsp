<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jquery-ui.jsp"%>
<link href="${txStatic }/css/upload_btn.css" rel="stylesheet" type="text/css" media="all" />
<style>
/* bootstrap a标签 冲突解决 */
#header-nav-classification a{text-decoration: none;} 
</style>
<div class="header_bg">
<div class="wrap">
	<div class="header">
	
		<div class="logo">
			<a href="${tx }/index"><img src="${txStatic }/images/logo.png" alt="" height="43px" width="43px"/> </a>
		</div>
		<div class="logo">
			<p style="line-height:43px;">&nbsp;&nbsp;&nbsp;<font face="微软雅黑" color="#2F4F4F" size="4px">淘学网</font></p>
		</div>
		<div class="logo">
			<p style="line-height:43px;">&nbsp;&nbsp;&nbsp;<font face="微软雅黑" color="#2F4F4F" size="2px">塔里木大学二手服务平台</font></p>
		</div>
		<div class="h_icon">
		<ul class="icon1 sub-icon1">
<!-- 			style="background:url(../images/cart.png) no-repeat 0px 0px;" -->
			<c:if test="${sessionScope.user.username == null }">
				<li><a class="active-icon c1" href="#"><i>login</i></a>
					<ul class="sub-icon1 list">
						<li><h3>sign in</h3><a href=""></a></li>
						<li>
							<div class="contact-form">
							    	<div class="contact-form-div">
								    	<span><label>用户名</label></span>
								    	<span><input id="header-username" name="" type="text" class="textbox" placeholder="请输入用户名"></span>
								    </div>
								    <div class="contact-form-div">
								    	<span><label>密码</label></span>
								    	<span><input id="header-password" name="" type="password" class="textbox" placeholder="请输入密码"></span>
								    </div>
								    <div class="contact-form-div" id="captcha-div" style="display:none;">
									    <script type="text/javascript">
								            function next_captcha() {
								                $("#captcha_img").attr("src", "${base}/captcha/next?_=" + new Date().getTime()); 
								            }
								        </script>
								        <span><label>验证码</label></span>
								        <span><input id="header-captcha" name="captcha" type="text" value=""></span>
								        <span><img id="captcha_img" onclick="next_captcha();return false;" src="${base}/captcha/next" /></span>
							        </div>
							        <center>
								    <div class="contact-form-div">
								    	<font id="header-error-msg" face="微软雅黑" color="red">${sessionScope.user.username }</font>
								    </div>
								    <div class="contact-form-div">
								    	<a style="float:right; font-size:4px; color:#68838B;" href="${txFront }/forgetPwd">忘记密码?</a>
								    </div>
								   <div class="contact-form-div">
								   		<span><input id="header-register-btn" type="submit" class="" value="注册"></span>
								   		<span><input id="header-login-btn" type="submit" class="" value="登录"></span>
								   </div>
								   </center>
						    </div>
	  						<div class="clear"></div>		
						</li>
					</ul>
				</li>
			</c:if>
			
			<c:if test="${sessionScope.user.username != null }">
				<li>
					<div class="logo">
					<a href="${txFront }/myCenterForm"><img class="img-circle" src="${txAvatar }${sessionScope.user.avatar }" alt="" height="43px" width="43px"/> </a>
					</div>
					<div class="logo">
						<font style="line-height:43px;" face="微软雅黑" size="2px" color="#838B8B">&nbsp;&nbsp;&nbsp;${sessionScope.user.username}</font>
					</div>
					<ul class="sub-icon1 list">
						<li><h3>welcome</h3><a href=""></a></li>
						<li>
							<div class="contact-form">
								   <center>
								   <div>
								   		<span><input id="header-myCenter-btn" type="submit" class="" value="个人中心"></span>
								   		<span><input id="header-loginOut-btn" type="submit" class="" value="安全退出"></span>
								   </div>
								   </center>
						    </div>
	  						<div class="clear"></div>		
						</li>
					</ul>
				</li>
			</c:if>
		</ul>
		</div>
		
		<div class="h_search">
    		<form action="${txFront }/goodsList?sort=default" method="post">
    			<input id="tags" type="text" value="" name="searchStr" placeholder="搜索" />
    			<input id="header-search-btn" type="submit" value="" />
    		</form>
		</div>
		<div class="clear"></div>
	</div>
</div>
</div>

<!-- 导航 -->
<div class="header_btm">
<div class="wrap">
	<div class="header_sub">
		<div class="h_menu">
			<ul id="header-nav-classification"></ul>
		</div>
	<div class="clear"></div>
</div>
</div>
</div>
<script type="text/javascript">

	jQuery(document).ready(function($) {
		
		/* 导航ajax获取 */
		$.post("${tx }/nav/ajax/redis/classificationTop", {}, function(data){
			var html = '<li class="active"><a href="${tx }/index" style=""><font size="4px" face="微软雅黑">主页</font></a></li>';
			var obj = $.parseJSON(data);
			$.each(obj, function(){
				html += '<li><a href="${txFront }/'+ this.url +'?classificationId='+ this.id +'&op=default"><font size="4px" face="微软雅黑">'+ this.name +'</font></a></li>';
			});
			$("#header-nav-classification").append(html);
		}, "json");
		
		/* 登录 */
		var loginUrl = "${txFront }/login";
		$("#header-login-btn").click(function(){
			$("#header-error-msg").empty();
			var loginName = $("#header-username").val();
			var password = $("#header-password").val();
			var captcha = $("#header-captcha").val();
 			$.post(loginUrl, {loginName:loginName, password:password, captcha:captcha}, function(msg){
				if(msg == "pageRefresh")
					location.reload();
				else {
					$("#header-error-msg").append(msg);
					$("#captcha-div").show();
					//带验证码的登录
					loginUrl = "${txFront }/loginWithCaptcha";
				}
	 		});
		});
		/* 安全退出 */
		$("#header-loginOut-btn").click(function(){
			window.location.href="${txFront }/loginOut";
		});
		/* 注册跳转 */
		$("#header-register-btn").click(function(){
			window.location.href="${txFront }/registerForm";
		});
		/* 搜索 */
		$("#header-search-btn").click(function(){
			window.location.href="${txFront }/loginOut";
		});
		/* 个人中心 */
		$("#header-myCenter-btn").click(function(){
			window.location.href="${txFront }/myCenterForm";
		});
		
		var availableTags = null;
		
		$.ajax({
			type: "POST",
			url: "${tx }/nav/ajax/redis/availableTags",
			dataType: "json",
			async: false,
			success: function(data){
				availableTags = $.parseJSON(data);
			}
		});

		$( "#tags" ).autocomplete({
			minLength:0,
			autoFocus: false,
			source: availableTags
		}).focus(function(){
			$( "#tags" ).autocomplete("search");
			return false;
		});
	});
	
</script>

