<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%@ include file="/WEB-INF/views/include/admin.jsp"%>
<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>
<%@ include file="/WEB-INF/views/include/jBox.jsp"%>
</head>
<style>
.table th, .table td { 
	text-align: center; 
}
</style>
<body>
		<div class="container">
			<h2 class="page-header"><font face="微软雅黑">数据字典信息</font>  <small><code>&lt; DictionariesInfo  &gt;</code></small></h2>
			<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#add">
				数据字典录入
			</button>
			
			<br/><br/>
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th ></th>
						<th >数据值</th>
						<th >标签名</th>
						<th >类型</th>
						<th >描述</th>
						<th >父级数据值</th>
						<th >父级类型</th>
						<th >操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${obj.qr.list }" var="data" varStatus="status">
					<tr>
						<td>${status.index +1 }</td>
						<td>${data.value }</td>
						<td>${data.lable }</td>
						<td>${data.type }</td>
						<td>${data.description }</td>
						<td>${data.parent.value }</td>
						<td>${data.parent.type }</td>
						<td>
							<a class="btn btn-warning btn-xs" 
						       title="${data.value }" 
						       href="#">
						    修改</a>
						    
						    <a class="btn btn-danger btn-xs" 
						       title="${data.value }" 
						       href="#">
						    删除</a>
						</td>
					</tr>
					
					</c:forEach>
				</tbody>
			</table>
			
			<c:if test="${obj.qr.list == '[]' }">
				<div class="well well-sm"><center><font class="text-warning" face="微软雅黑">未查出数据！</font></center></div>
			</c:if>
		</div>

		<!-- 页脚 页码 -->
		<center>
			<div>
				<ul id="page" class="pagination"></ul>
			</div>
		</center>
		
		
			
</body>
<script type="text/javascript">
	$(function(){
		
		/**
	     * 动态设置分页页码
	     */
	     /* var url = window.location.href; */
	     var url = "${txAdmin }/system/dict/record?pageNumber="
		 var pageCount = "${obj.qr.pager.pageCount }";//总页数
		 $("#page").append("<li><a href='"+ url + 1 +"'>首页</a></li>");
		 for (var i = 1; i <= pageCount; i++) {
		 	$("#page").append("<li><a href='"+ url + i +"'>"+ i +"</a></li>");
		 }
		 $("#page").append("<li><a href='"+ url + pageCount +"'>末页</a></li>");
		 
		 
		new jBox('Confirm', {
			confirmButton: '确认',
			cancelButton: '取消'
		});
	});	
</script>
</html>