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
<%@ include file="/WEB-INF/views/include/jquery-ui.jsp"%>
<link href="${txStatic }/_front/css/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="${txStatic }/css/pager.css" rel="stylesheet" type="text/css" media="all" />
<style>
  #progressbar .ui-progressbar-value {
    background-color: #ccc;
  }
</style>
<script type="text/javascript">
	
	$(function() {
		$( "#progressbar" ).progressbar({
		      value: false
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
						<h2><font face="微软雅黑">安全中心</font></h2>
						<c:if test="${obj.emailChecked == true }">
							<br />
							<div class="contact-form-div">
								<script type="text/javascript">
									function update_password () {
										window.location.href="${txFront }/forgetPwd";
									}
								</script>
						    	<span><label><font color="#FA8072" size="3px" >邮箱验证完成 ${obj.email }</font></label></span>
<!-- 						    	<span><input id="" type="submit" class="" value="修改邮箱" onclick=""></span> -->
						    	<span><input id="" type="submit" class="" value="修改密码" onclick="update_password();"></span>
						    </div>
						</c:if>
						
						<c:if test="${obj.emailChecked == false }">
			 	  	 	    <br />
					    	<div class="contact-form-div">
						    	<span><label>邮箱<font color="#FA8072">*   </font></label></span>
						    	<span><input id="email" name="email" type="text" class="textbox required" value=""></span>
						    	<br />
						    	<span><label><font color="#FA8072" size="2px">温馨提示：验证邮件发送成功后，请在十分钟内完成验证</font></label></span>
						    	
						    </div>
						    <div class="contact-form-div">
						   		<script type="text/javascript">
			                        function send_email_check() {
			                        	$( "#dialog-message" ).dialog({
			          				      modal: true,
			          				      width: 430,
			          				      open: function (event, ui) {
			          				      	$(".ui-dialog-titlebar-close", $(this).parent()).hide();
			          				      }
			          					});
			                        	var email = $("#email").val();
			                            $.ajax({
			                                url : "${tx }/active/mail",
			                                data : {email : email},
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
		                    	</script>
						   		<span><input id="register-btn" type="submit" class="" value="发送验证邮件" onclick="send_email_check();return false;"></span>
						    </div>
						</c:if>
			 	  	 	
					</div>
				</div>
  				<div class="clear"></div>		
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
</html>