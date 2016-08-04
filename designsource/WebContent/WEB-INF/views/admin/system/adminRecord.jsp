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
			<h2 class="page-header"><font face="微软雅黑">管理员信息</font>  <small><code>&lt; AdminInfo  &gt;</code></small></h2>
			<!-- <button type="button" class="btn btn-default" data-toggle="modal" data-target="#add">
				用户录入
			</button> -->
			<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#add">
				用户录入
			</button>
			
			<br/><br/>
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th width="5%"></th>
						<th width="15%">登录名</th>
						<th width="15%">姓名</th>
						<th width="10%">性别</th>
						<th width="15%">电话</th>
						<th width="15%">角色</th>
						<th width="25%">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${obj.qr.list }" var="data" varStatus="status">
					<tr>
						<td>${status.index +1 }</td>
						<td>${data.username }</td>
						<td>${data.name }</td>
						<td>
							<c:if test="${data.sex == 1 }">男</c:if>
							<c:if test="${data.sex == 2 }">女</c:if>
						</td>
						<td>${data.phone }</td>
						<td>${data.role.name }</td>
						<td>
							<a data-confirm="确认对管理员 ${data.name } 重置密码吗？" 
						       class="btn btn-primary btn-xs" 
						       name="updatePassword" 
						       href="${txAdmin }/system/admin/changePasswd?id=${data.id }&pageNumber=${obj.qr.pager.pageNumber }">
						    重置密码</a>
						    
						    <a dataId="${data.id }" data-toggle="modal" data-target="#update"
						       class="btn btn-warning btn-xs update-password" 
						       title="${data.role.name }" 
						       href="#">
						    修改角色</a>
						    
						    <a data-confirm="确认删除管理员 ${data.name } 吗？" 
						       class="btn btn-danger btn-xs" 
						       title="${data.name }" name="delete" 
						       href="${txAdmin }/system/admin/delete?id=${data.id }&pageNumber=${obj.qr.pager.pageNumber }">
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

		
   
		
		
		<!--隐藏的添加框-->
		<form method="post" action="${txAdmin }/system/admin/add?pageNumber=${obj.qr.pager.pageNumber }">
		<div class="modal fade" id="add" tabindex="-1" role="dialog" 
		   aria-labelledby="myModalLabel" aria-hidden="true">
		   <div class="modal-dialog">
		      <div class="modal-content">
		         <div class="modal-header">
		            <button type="button" class="close" 
		               data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel">
		              	 <span class="glyphicon glyphicon-cloud"></span> 用户录入
		            </h4>
		         </div>
		         <div class="modal-body">
		         <center>
			        <div style="width: 300px; height: 150px" class="form-group">
					 
						 <div id="validate-loginname-div" class="input-group">
						 	<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
						 	<input id="validate-loginname" type="text" class="form-control requird" name="username" placeholder="登录名 [支持英文、数字]">
						 </div>
						 <br>
						 <div class="input-group">
						 	<span class="input-group-addon"><span class="glyphicon glyphicon-pencil"></span></span>
						 	<input type="text" class="form-control requird" name="name" placeholder="姓名 [必填]">
						 </div>
						 <br>
						 <div id="role-select" class="form-group">
						    <select id="role-select-append" class="form-control" name='roleId'>
						       <option value="">角色选择</option>
						       <c:forEach items="${obj.roleList }" var="role" varStatus="status">
						       	<option value="${role.id }">${role.name }</option>
						       </c:forEach>
						    </select>
					     </div>
		         	</div>
		         </center>
		      	 </div>
			     <div class="modal-footer">
			            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			            <button id="add-btn" type="submit" class="btn btn-primary">录入</button>
			     </div>
			</div>
		</div>
	</div>
	</form>	
		
	<!--隐藏的修改框-->
	<div id="update-div">	
	<form method="post" action="${txAdmin }/system/admin/changeRole?pageNumber=${obj.qr.pager.pageNumber }">
		<div class="modal fade" id="update" tabindex="-1" role="dialog" 
		   aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
		      <div class="modal-content">
		         <div class="modal-header">
		            <button type="button" class="close" 
		               data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel">
		              	 <span class="glyphicon glyphicon-cloud"></span> 角色修改
		            </h4>
		         </div>
		         <div class="modal-body">
		         <center>
			        <div style="width: 300px; height: 100px" class="form-group">
					 
					 	<input type="hidden" class="" name="id">
					 
						<div id="role-select" class="form-group">
						    <select id="role-select-append" class="form-control" name='roleId'>
						       <option value="">角色选择</option>
						       <c:forEach items="${obj.roleList }" var="role" varStatus="status">
						       	<option value="${role.id }">${role.name }</option>
						       </c:forEach>
						    </select>
					     </div>
		         	</div>
		         </center>
		      	 </div>
			     <div class="modal-footer">
			            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			            <button type="submit" class="btn btn-primary">保存</button>
			     </div>
			</div>
		</div>
	</div>
	</form>	
	</div>
			
</body>
<script type="text/javascript">
	$(function(){
		
		/**
	     * 动态设置分页页码
	     */
	     var url = "${txAdmin }/system/admin/record?pageNumber="
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
		
		/* 修改框赋值 */
		$(".update-password").bind("click",function(){
			var adminId = $(this).attr("dataId");
// 			$.post("${txAdmin }/shiro/admin/get",{id:adminId},function(data){
// 			}, "text");
			$("#update-div").find("input[name='id']").val(adminId);
		});
		
// 		$("#role-select-append").focus(function(){
// 			$("#role-select-append").empty();
// 			$("#role-select-append").append("<option value=''>角色选择</option>");
// 			$.post("${txAdmin }/shiro/ajax/allRole",{},function(data){
// 				var obj = $.parseJSON(data);
// 				$.each(obj, function(){
// 					$("#role-select-append").append("<option value='"+ this.id +"'>"+ this.name +"</option>");
// 				});
// 			}, "text");
// 		});
		
		
		$("#validate-loginname").change(function(){
			var loginName = $(this).val();
			$.post("${txAdmin }/system/admin/validateLoginname",{loginName : loginName},function(msg){
				if (msg == true) {
					$("#add-btn").attr("class", "btn btn-primary disabled");
					$("#validate-loginname-div").attr("class", "input-group has-error");
				}else{
					$("#add-btn").attr("class", "btn btn-primary");
					$("#validate-loginname-div").attr("class", "input-group");
				}
	 		});
		});
		
	});
</script>
</html>