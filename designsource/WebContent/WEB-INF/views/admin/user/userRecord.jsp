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
			<h2 class="page-header"><font face="微软雅黑">会员信息</font>  <small><code>&lt; UserInfo  &gt;</code></small></h2>
			
			
			<div class="panel panel-default">
			<div class="panel-body">
				<form class="form-inline" action="${txAdmin }/user/record" method="post">
				  <div class="form-group">
				    <input type="text" name="loginName" class="form-control input-sm" placeholder="登录名" value="${obj.user.loginName }"/>
				  </div>
				  <div class="form-group">
				    <input type="text" name="name" class="form-control input-sm" placeholder="姓名" value="${obj.user.name }"/>
				  </div>
				  <div class="form-group">
				    <input type="text" name="cardId" class="form-control input-sm" placeholder="学号" value="${obj.user.cardId }"/>
				  </div>
				  <select class="form-control input-sm" name="status">
				    	<option value="">认证状态</option>
				    	<option value="1">未认证</option>
				    	<option value="2">待认证</option>
				    	<option value="3">认证通过</option>
				    	<option value="4">认证驳回</option>
				    	<option value="5">黑名单</option>
				    </select>
				  <button type="submit" class="btn btn-default btn-sm">搜索</button>
				</form>
			</div>
			</div>			
			
			
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th width=""></th>
						<th width="">头像</th>
						<th width="">登录名</th>
						<th width="">用户昵称</th>
						<th width="">姓名</th>
						<th width="">性别</th>
						<th width="">电话</th>
						<th width="">学号</th>
						<th width="">用户状态</th>
						<th width="">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${obj.qr.list }" var="data" varStatus="status">
					<tr>
						<td>${status.index +1 }</td>
						<td>
							<c:if test="${data.avatar != null }">
							<a href="${txAvatar }${data.avatar }" title="userID: ${data.id }<br/>loginName: ${data.loginName }" data-jbox-image="gallery1">
								<img alt="" src="${txAvatar }${data.avatar }" width="25px" height="25px">
							</a>
							</c:if>
						</td>
						<td>${data.loginName }</td>
						<td>${data.username }</td>
						<td>${data.name }</td>
						<td>
							<c:if test="${data.sex == 1 }">男</c:if>
							<c:if test="${data.sex == 2 }">女</c:if>
						</td>
						<td>${data.phone }</td>
						<td>${data.cardId }</td>
						<td>
							<c:if test="${data.status == 1 }"><code class="text-warning">未认证</code></c:if>
							<c:if test="${data.status == 2 }"><code class="text-primary">待认证</code></c:if>
							<c:if test="${data.status == 3 }"><code class="text-success">认证通过</code></c:if>
							<c:if test="${data.status == 4 }"><code class="text-muted">认证驳回</code></c:if>
							<c:if test="${data.status == 5 }"><code class="text-danger">黑名单</code></c:if>
						</td>
						<td>
							<c:if test="${data.status != 5 }">
							<a data-confirm="确认将会员 ${data.loginName } 加入黑名单吗？" 
						       class="btn btn-warning btn-xs" 
						       href="${txAdmin }/user/setBlack?id=${data.id }&pageNumber=${obj.qr.pager.pageNumber }&loginName=${obj.user.loginName }&name=${obj.user.name }&cardId=${obj.user.cardId }&status=${obj.user.status }">
						    加入黑名单</a>
							</c:if>
							
							<a data-confirm="确认对会员 ${data.loginName } 重置密码吗？" 
						       class="btn btn-primary btn-xs" 
						       name="updatePassword" 
						       href="${txAdmin }/user/changePasswd?id=${data.id }&pageNumber=${obj.qr.pager.pageNumber }&loginName=${obj.user.loginName }&name=${obj.user.name }&cardId=${obj.user.cardId }&status=${obj.user.status }">
						    重置密码</a>
						    
						    <a data-confirm="确认删除会员 ${data.loginName } 吗？" 
						       class="btn btn-danger btn-xs" 
						       title="${data.name }" name="delete" 
						       href="${txAdmin }/user/delete?id=${data.id }&pageNumber=${obj.qr.pager.pageNumber }&loginName=${obj.user.loginName }&name=${obj.user.name }&cardId=${obj.user.cardId }&status=${obj.user.status }">
						    删除</a>
						</td>
					</tr>
					
					</c:forEach>
				</tbody>
			</table>
			
			<c:if test="${obj.qr.list == '[]' }">
				<div class="well well-sm"><center><font class="text-warning" face="微软雅黑">未查出数据！</font></center></div>
			</c:if>
			
			<!-- 新写的 页脚 页码 -->
			<div class="row">
		      <div class="col-md-5">
		      	<ul class="pagination">
		      		<li><a href="#">共 ${obj.qr.pager.recordCount } 条</a></li>
		      		<li><a href="#">第 ${obj.qr.pager.pageNumber } 页</a></li>
		      		<li><a><input id="pageNumber-custom" type="text" value="${obj.qr.pager.pageNumber }" style="width:40px; height:20px"/></a></li>
		      		<li><a href="#" id="pageNumber-custom-do">跳转</a></li>
		      	</ul>
		      </div>
		      <div class="col-md-7 text-right">
		      	<ul class="pagination" id="pager-list"></ul>
		      </div>  
		    </div>
		</div>

		
		
		
		
		
			
</body>
<script type="text/javascript">
	$(function(){
		
		/**
	     * 动态设置分页页码
	     */
	     var url = "${txAdmin }/user/record?loginName=${obj.user.loginName }&name=${obj.user.name }&cardId=${obj.user.cardId }&status=${obj.user.status }&pageNumber="
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
		 
		new jBox('Confirm', {
			confirmButton: '确认',
			cancelButton: '取消'
		});
		
		new jBox('Image', {
			width: 400,
			height: 300,
		});
	});
</script>
</html>