<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="main_bg1">
<div class="wrap">	
	<div class="main1">
		<h2><font face="微软雅黑">热门收藏</font> hot</h2>
	</div>
</div>
</div>
<!-- start main -->
<div class="main_bg">
<div class="wrap">	
	<div class="main">
		<!-- start grids_of_3 -->
		<div class="grids_of_3">
			<c:forEach items="${obj.row1 }" var="data">
			<div class="grid1_of_3">
				<a href="${txFront }/details?goodsId=${data.id }">
					<img src="${txGoods }${data.showImgUrl }" alt="" width="168px" height="126px"/>
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
					<img src="${txGoods }${data.showImgUrl }" alt="" width="168px" height="126px"/>
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
		<!-- end grids_of_3 -->
	</div>
</div>
</div>	