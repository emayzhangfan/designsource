<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="wrap">
    <!----start-img-cursual---->
	<div id="owl-demo" class="owl-carousel">
		<c:forEach items="${obj.cursual }" var="data" varStatus="status">
			<div class="item" onclick="location.href='${txFront }/details?goodsId=${data.id }';">
				<div class="cau_left">
					<img style="height:75px;width:99px" class="lazyOwl" data-src="${txGoods }${data.showImgUrl }" alt="Lazy Owl Image">
				</div>
				<div class="cau_left">
					<h4><a href="${txFront }/details?goodsId=${data.id }"><font face="微软雅黑">${data.name }</font></a></h4>
					<a href="${txFront }/details?goodsId=${data.id }" class="btn">shop</a>
				</div>
			</div>	
		</c:forEach>
	</div>
	<!----//End-img-cursual---->
</div>