<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>淘学网 - 商品列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<%@ include file="/WEB-INF/views/include/front.jsp"%>
<link href="${txStatic }/_front/css/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="${txStatic }/css/pager.css" rel="stylesheet" type="text/css" media="all" />
	<!-- start gallery_sale -->
	<script type="text/javascript" src="${txStatic }/_front/js/jquery.easing.min.js"></script>	
	<script type="text/javascript" src="${txStatic }/_front/js/jquery.mixitup.min.js"></script>
	<script type="text/javascript">
	$(function () {
		
		var filterList = {
		
			init: function () {
			
				// MixItUp plugin
				// http://mixitup.io
				$('#portfoliolist').mixitup({
					targetSelector: '.portfolio',
					filterSelector: '.filter',
					effects: ['fade'],
					easing: 'snap',
					// call the hover effect
					onMixEnd: filterList.hoverEffect()
				});				
			
			},
			
			hoverEffect: function () {
			
				// Simple parallax effect
				$('#portfoliolist .portfolio').hover(
					function () {
						$(this).find('.label').stop().animate({bottom: 0}, 200, 'easeOutQuad');
						$(this).find('img').stop().animate({top: -30}, 500, 'easeOutQuad');				
					},
					function () {
						$(this).find('.label').stop().animate({bottom: -40}, 200, 'easeInQuad');
						$(this).find('img').stop().animate({top: 0}, 300, 'easeOutQuad');								
					}		
				);				
			
			}

		};
		
		// Run the show!
		filterList.init();
		
		
	});	
	</script>
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
	<!-- start gallery_sale  -->
			<div class="gallery1">
					<div class="container">
					<ul id="filters" class="clearfix">
						<li><span class="filter active" data-filter="${obj.attr }">All</span></li>
						<c:forEach items="${obj.classification }" var="data">
							<li><span class="filter" data-filter="${data.id }"><font face="微软雅黑">${data.name }</font></span></li>
						</c:forEach>
						<c:forEach items="${obj.goodsSort }" var="data">
							<li><span class="filter" data-filter="${data[0] }"><font face="微软雅黑"><a href="${txFront }/goodsList?searchStr=${obj.searchStr }&sort=${data[0] }">${data[1] }</a></font></span></li>
						</c:forEach>
					</ul>
			<div id="portfoliolist">
			<c:forEach items="${obj.qr.list }" var="data">
				<div class="portfolio ${data.classificationId }" data-cat="">
				<div class="portfolio-wrapper">				
					<a href="${txFront }/details?goodsId=${data.id }">
						<img src="${txGoods }${data.showImgUrl }"  alt="" width="282px" height="307px"/>
					</a>
					<div class="label">
						<div class="label-text">
							<a class="text-title">￥${data.price }</a>
							<span class="text-category">${data.title }</span>
						</div>
						<div class="label-bg"></div>
					</div>
				</div>
			    </div>			
			</c:forEach>
			<div class="clear"></div>
						<!-- 分页 -->
					    <div class="row">
					      <div class="col-md-5">
					      	<ul class="pagination">
					      		<li><a>共 ${obj.qr.pager.recordCount } 条</a></li>
					      		<li><a>第 ${obj.qr.pager.pageNumber } 页</a></li>
					      		<li><a><input id="pageNumber-custom" type="text" value="${obj.qr.pager.pageNumber }" style="width:40px; height:15px"/></a></li>
					      		<li><a href="#" id="pageNumber-custom-do">跳转</a></li>
					      	</ul>
					      	<ul class="pagination" id="pager-list"></ul>
					      </div>
					    </div>
																																	
					</div>
	</div><!-- container -->
	<script type="text/javascript" src="js/fliplightbox.min.js"></script>
	<script type="text/javascript">$('body').flipLightBox()</script>
	<div class="clear"> </div>
	</div>
<!---End-gallery----->
	</div>
</div>
</div>		
<!-- start footer -->
<%@ include file="/WEB-INF/views/front/inc/footer.jsp"%>
</body>
<script type="text/javascript">

		jQuery(document).ready(function($) {
			/**
		     * 动态设置分页页码
		     */
		     var url = "${txFront }/goodsList?classificationId=${obj.classificationId }&sort=default&pageNumber="
		     var pageCount = "${obj.qr.pager.pageCount }";//总页数
			 var beforepageNumber = '${obj.qr.pager.pageNumber }' - 1; //上一页
			 var afterpageNumber = '${obj.qr.pager.pageNumber }' - (-1); //下一页
			 if (afterpageNumber > pageCount) 
				 afterpageNumber = pageCount;
			 var html = '<li><a href="'+ url + beforepageNumber +'">&laquo;</a></li>';
			 if (pageCount > 7) {
				 for (var i = 1; i <= 3; i++) {
					 html += '<li><a href="'+ url + i +'">'+ i +'</a></li>';
				 }
				 html += '<li><a href="#">...</a></li>';
				 for (var i = pageCount -2; i <= pageCount; i++) {
					 html += '<li><a href="'+ url + i +'">'+ i +'</a></li>';
				 }
				 html += '<li><a href="'+ url + afterpageNumber +'">&raquo;</a></li>';
			 } else {
				 for (var i = 1; i <= pageCount; i++) {
					 html += '<li><a href="'+ url + i +'">'+ i +'</a></li>';
				 }
				 html += '<li><a href="'+ url + afterpageNumber +'">&raquo;</a></li>';
			 }
			 $("#pager-list").append(html);
			 $("#pageNumber-custom-do").click(function(){
				 var pn = $("#pageNumber-custom").val();
				 if (parseInt(pn) > parseInt(pageCount))
					 pn = pageCount;
				 if (pn <= 0)
					 pn = 1;
				 $(this).attr("href", url + pn);
				 return true;
			 });
			
// 			var classificationList = '${obj.classification }';
// // 			var obj = $.parseJSON(classificationList);
// 			alert(classificationList);
// 			$.each(classificationList, function(){
// 				alert(this);
// 			});
// 			$("#all-classification-datafilter").attr("data-filter", html);
		});
</script>
</html>