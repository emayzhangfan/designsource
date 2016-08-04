<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="da-slider" class="da-slider">
			<c:forEach items="${obj.slider }" var="data" varStatus="status">
				<div class="da-slide">
					<h2><font face="微软雅黑">${data.title }</font></h2>
					<p><font face="微软雅黑">${data.descriptions }</font></p>
					<a href="${txFront }${data.buttonHref }" class="da-link" style="width:150px">${data.buttonValue }</a>
					<div class="da-img"><img src="${txStatic }/_front/images/slider1.png" alt="image01" /></div>
				</div>
			</c:forEach>
				
				<nav class="da-arrows">
					<span class="da-arrows-prev"></span>
					<span class="da-arrows-next"></span>
				</nav>
</div>
