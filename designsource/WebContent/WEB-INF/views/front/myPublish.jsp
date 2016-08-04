<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>淘学网 - 个人中心</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<%@ include file="/WEB-INF/views/include/front.jsp"%>
<link href="${txStatic }/_front/css/style.css" rel="stylesheet" type="text/css" media="all" />
<link href="${txStatic }/css/pager.css" rel="stylesheet" type="text/css" media="all" />
<!-- start top_js_button -->
<script type="text/javascript" src="${txStatic }/_front/js/move-top.js"></script>
<script type="text/javascript" src="${txStatic }/_front/js/easing.js"></script>
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
						<h2 class="style top"><font face="微软雅黑">
						<c:if test="${obj.status == 1 }">我的发布</c:if>
						<c:if test="${obj.status == 2 }">垃圾信息</c:if>
						</font></h2>
						<!-- start grids_of_3 -->
						<c:if test="${obj.row1 == '[]' }">
							<br />
							<br />
							<center>
							<font color="" face="微软雅黑">这里没有任何信息！</font><br />
							<font color="" face="微软雅黑">去 <a href="${txFront }/publishForm">发布</a> 一条信息吧！</font>
							</center>
						</c:if>
						<div class="grids_of_3">
						<c:forEach items="${obj.row1 }" var="data">
							<div class="grid1_of_3">
								<a href="${txFront }/details?goodsId=${data.id }">
									<img src="${txGoods }${data.showImgUrl }" alt="" title="${data.title }" width="300px" height="200px"/>
									<h3><font face="微软雅黑">${data.name }</font></h3>
									<div class="price">
										<h4>￥${data.price }<span>go</span></h4>
									</div>
									<span class="b_btm"></span>
								</a>
							</div>
							</c:forEach>
							<div class="clear"></div>
						</div>
						
						<div class="grids_of_3">
						<c:forEach items="${obj.row2 }" var="data">
							<div class="grid1_of_3">
								<a href="${txFront }/details?goodsId=${data.id }">
									<img src="${txGoods }${data.showImgUrl }" alt="" title="${data.title }" width="335px" height="220px"/>
									<h3><font face="微软雅黑">${data.name }</font></h3>
									<div class="price">
										<h4>￥${data.price }<span>go</span></h4>
									</div>
									<span class="b_btm"></span>
								</a>
							</div>
							</c:forEach>
							<div class="clear"></div>
						</div>
						
						<!-- 分页 -->
						<div class="row">
					      <div class="col-md-5">
					      	<ul class="pagination">
					      		<li><a>共 ${obj.pager.recordCount } 条</a></li>
					      		<li><a>第 ${obj.pager.pageNumber } 页</a></li>
					      		<li><a><input id="pageNumber-custom" type="text" value="${obj.pager.pageNumber }" style="width:40px; height:15px"/></a></li>
					      		<li><a href="#" id="pageNumber-custom-do">跳转</a></li>
					      	</ul>
					      	<ul class="pagination" id="pager-list"></ul>
					      </div>
					    </div>
						
						<!-- end grids_of_3 -->
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
</body>
<script type="text/javascript">

		jQuery(document).ready(function($) {
			
			/**
		     * 动态设置分页页码
		     */
		     var url = "${txFront }/myPublish?pageNumber="
		     var pageCount = "${obj.pager.pageCount }";//总页数
			 var beforepageNumber = '${obj.pager.pageNumber }' - 1; //上一页
			 var afterpageNumber = '${obj.pager.pageNumber }' - (-1); //下一页
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
			
			

		});
</script>
</html>