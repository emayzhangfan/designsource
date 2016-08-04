<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>淘学网 - 塔里木大学在线二手服务平台</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/WEB-INF/views/include/front.jsp"%>
<link href="${txStatic }/_front/css/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- start slider -->		
	<link href="${txStatic }/_front/css/slider.css" rel="stylesheet" type="text/css" media="all" />
	<script type="text/javascript" src="${txStatic }/_front/js/modernizr.custom.28468.js"></script>
	<script type="text/javascript" src="${txStatic }/_front/js/jquery.cslider.js"></script>
	<script type="text/javascript">
		$(function() {
			$('#da-slider').cslider();
		});
	</script>
		<!-- Owl Carousel Assets -->
		<link href="${txStatic }/_front/css/owl.carousel.css" rel="stylesheet">
		     <!-- Owl Carousel Assets -->
		    <!-- Prettify -->
		    <script src="${txStatic }/_front/js/owl.carousel.js"></script>
		    <script>
		    $(document).ready(function() {
		
		      $("#owl-demo").owlCarousel({
		        items : 4,
		        lazyLoad : true,
		        autoPlay : true,
		        navigation : true,
			    navigationText : ["",""],
			    rewindNav : false,
			    scrollPerPage : false,
			    pagination : false,
    			paginationNumbers: false,
		      });
		
		    });
		    </script>
		   <!-- //Owl Carousel Assets -->
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
<!-- start slider -->
<%@ include file="/WEB-INF/views/front/inc/slider.jsp"%>			
<!----start-cursual---->
<%@ include file="/WEB-INF/views/front/inc/cursual.jsp"%>
<!-- start main -->
<%@ include file="/WEB-INF/views/front/inc/main.jsp"%>
<!-- start footer -->
<%@ include file="/WEB-INF/views/front/inc/footer.jsp"%>
</body>
</html>
