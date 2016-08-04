<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>淘学网 - 商品详情</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<%@ include file="/WEB-INF/views/include/front.jsp"%>
<%@ include file="/WEB-INF/views/include/jBox.jsp"%>
<link href="${txStatic }/_front/css/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- start details -->
<link rel="stylesheet" type="text/css" href="${txStatic }/_front/css/productviewgallery.css" media="all" />
<script type="text/javascript" src="${txStatic }/_front/js/jquery.min.js"></script>
<script type="text/javascript" src="${txStatic }/_front/js/cloud-zoom.1.0.3.min.js"></script>
<script type="text/javascript" src="${txStatic }/_front/js/jquery.fancybox.pack.js"></script>
<script type="text/javascript" src="${txStatic }/_front/js/jquery.fancybox-buttons.js"></script>
<script type="text/javascript" src="${txStatic }/_front/js/jquery.fancybox-thumbs.js"></script>
<script type="text/javascript" src="${txStatic }/_front/js/productviewgallery.js"></script>
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
	<!-- start content -->
	<div class="single">
			<!-- start span1_of_1 -->
			<div class="left_content">
			<div class="span1_of_1">
				<!-- start product_slider -->
				<div class="product-view">
				<div class="product-essential">
				<div class="product-img-box">
				    <div class="product-image" style="border:2px solid #A3A3A3"> 
				        <a class="cs-fancybox-thumbs cloud-zoom" rel="adjustX:30,adjustY:0,position:'right',tint:'#202020',tintOpacity:0.5,smoothMove:2,showTitle:true,titleOpacity:0.5" data-fancybox-group="thumb" title="" >
				           	<img src="${txGoods }${obj.showImgUrl }" alt="" title="" width="380px" height="366px"/>
				        </a>
				    </div>
				</div>
				</div>
				</div>
				<!-- end product_slider -->
			</div>
			<!-- start span1_of_1 -->
			<div class="span1_of_1_des">
				  <div class="desc1">
					<h3><font face="微软雅黑">${obj.name }</font></h3>
					<p><font face="微软雅黑">${obj.title }</font></p>
					<br/>
					<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${obj.user.qq }&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:${obj.user.qq }:51" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
					<p><font face="微软雅黑" id="collection-total">收藏量：</font></p>
					<p><font face="微软雅黑">发布时间：<fmt:formatDate value="${obj.createDate }" pattern="yyyy-MM-dd HH:mm"/></font></p>
					<h5><font face="微软雅黑">RMB: ${obj.price }</font><!-- <a href="#">click for offer</a> --></h5>
					<div class="available">
						<div class="btn_form">
							<c:choose>
								<c:when test="${sessionScope.user.id != obj.user.id }">
									<form>
									<input type="submit" value="收藏" title="" id="collection"/>
									</form>
								</c:when>
								<c:otherwise>
									<form>
										<input type="submit" value="编辑" title="" id="update-myPublish"/>
										<a data-confirm="确认删除 ${obj.name } 吗？" href="${txFront }/deletePublish?goodsId=${obj.id }"><input type="submit" value="删除" title="" id="delete-myPublish-temp"/></a>
									</form>
									
									
									<input type="submit" value="删除" title="" id="delete-myPublish" style="display: none;"/>
								</c:otherwise>
							</c:choose>
						</div>
						<span class="span_right"><!-- <a href="#">login to save in wishlist </a> --></span>
						<div class="clear"></div>
					</div>
					<div class="share-desc">
						<div class="share">
							<h4><font face="微软雅黑">分享 :</font></h4>
								<div class="jiathis_style">
									<a class="jiathis_like_tsina" data="width=120"></a>
									<a class="jiathis_like_qzone"></a>
								</div>
								<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jia.js" charset="utf-8"></script>
							
						</div>
						<div class="clear"></div>
					</div>
			   	 </div>
			   	</div>
			   	<div class="clear"></div>
			   	<!-- start tabs -->
				   	<section class="tabs">
		            <input id="tab-1" type="radio" name="radio-set" class="tab-selector-1" checked="checked">
			        <label for="tab-1" class="tab-label-1"><font face="微软雅黑">商品详情</font></label>
			
		            <input id="tab-3" type="radio" name="radio-set" class="tab-selector-3">
			        <label for="tab-3" class="tab-label-3"><font face="微软雅黑">卖家信息</font></label>
	          
				    <div class="clear-shadow"></div>
					
			        <div class="content">
			        
			        	<!-- 商品详情 -->
				        <div class="content-1">
				        	<p class="para top">${obj.descriptions }</p>
							
							<div class="clear"></div>
						</div>

						<!-- 卖家信息 -->
				        <div class="content-3">
				        <center>
				        	<br />
							<img class="img-circle" src="${txAvatar }${obj.user.avatar }" alt="" height="100px" width="100px"/>
							<br /><br />
							<font face="微软雅黑" color="#8B1A1A" size="4px">${obj.user.username }</font>
							<br />
							<c:if test="${obj.user.status == 1 }"><!-- 未认证 -->
								<font face="微软雅黑" color="#8B1A1A" size="2px">该用户没有进行实名认证</font>
							</c:if>
							<c:if test="${obj.user.status == 2 }"><!-- 待认证 -->
								<font face="微软雅黑" color="#8B1A1A" size="2px">该用户认证申请正在审核中。。。</font>
							</c:if>
							<c:if test="${obj.user.status == 3 }"><!-- 认证通过 -->
								<font face="微软雅黑" color="#8B1A1A" size="2px">淘学网 - 认证用户</font>
							</c:if>
							<c:if test="${obj.user.status == 4 }"><!-- 认证驳回 -->
								<font face="微软雅黑" color="#8B1A1A" size="2px">该用户没有进行实名认证</font>
							</c:if>
							<c:if test="${obj.user.status == 5 }"><!-- 黑名单 -->
								<font face="微软雅黑" color="#8B1A1A" size="2px">小心！该用户是淘学网黑名单用户！</font>
							</c:if>
<%-- 							<p><font>姓名：${obj.user.name }</font></p> --%>
<%-- 							<p><font>性别：${obj.user.sex }</font></p> --%>
<%-- 							<p><font>电话：${obj.user.phone }</font></p> --%>
<%-- 							<p><font>个性签名：${obj.user.remarks }</font></p> --%>
							<br />
							<font face="微软雅黑" color="#8B1A1A" size="4px">电话：${obj.user.phone }</font>
							<div class="clear"></div>
						</center>
						</div>
						
						
			        </div>
			        </section>
			        
					<!-- UY BEGIN -->
					<div id="uyan_frame"></div>
					<script type="text/javascript" src="http://v2.uyan.cc/code/uyan.js?uid=2090439"></script>
					<!-- UY END -->
					<div class="clear"></div>
			        
		         	<!-- end tabs -->
			   	</div>
			 	<!-- start sidebar -->
			 	<%@ include file="/WEB-INF/views/front/inc/sidebar.jsp"%>
			 	
				<!-- end sidebar -->
          	    <div class="clear"></div>
	       </div>	
	<!-- end content -->
	</div>
</div>
</div>	
<!-- start footer -->
<%@ include file="/WEB-INF/views/front/inc/footer.jsp"%>
</body>
<script type="text/javascript">
	
	jQuery(document).ready(function($) {
		
		var url = "${txFront }/collection";
		var data = {goodsId : '${obj.id }'};
		
		$.post("${txFront }/existCollection", data, function(msg){
			if (msg) {
				$("#collection").val("取消收藏");
				url = "${txFront }/undoCollection";
			}
		});
		
		$("#collection").click(function(){
			$.post(url, data, function(msg){
				new jBox('Notice', {
			   		content: msg,
			   		autoClose: 1500,
			        attributes: {
			    		x: 'left',
			    		y: 'bottom'
			    	},
			    	position: {  
			    		x: 550,
			    		y: 350
			    	}
				});
				if ("收藏成功" == msg) {
					$("#collection").val("取消收藏");
					url = "${txFront }/undoCollection";
				}
				if ("取消收藏成功" == msg) {
					$("#collection").val("收藏");
					url = "${txFront }/collection";
				}
			});
			return false;
		});
		
		/*
		 * 删除我的发布
		 */
		$("#delete-myPublish").click(function(){
			$.post("${txFront }/deletePublish", data, function(msg){
				if (msg) 
					window.location.href="${txFront }/myPublish?userId=${sessionScope.user.id }";
				else {
					new jBox('Notice', {
				   		content: msg,
				   		autoClose: 1500,
				        attributes: {
				    		x: 'left',
				    		y: 'bottom'
				    	},
				    	position: {  
				    		x: 550,
				    		y: 350
				    	}
					});
				}
			});
			return false;
		});
		
		$("#update-myPublish").click(function(){
			window.location.href="${txFront }/editPublish?goodsId=${obj.id }";
			return false;
		});
		
		new jBox('Confirm', {
			confirmButton: '确认',
			cancelButton: '取消'
		});
		
		/**
		 * 收藏量
		 */
		$.post("${tx }/ajax/details/collectionTotal", data, function(total){
			$("#collection-total").append(total);
		});
		
		
		
	});
</script>
</html>