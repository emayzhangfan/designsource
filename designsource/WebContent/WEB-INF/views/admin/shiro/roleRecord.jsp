<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/include/admin.jsp"%>
<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>
<%@ include file="/WEB-INF/views/include/jBox.jsp"%>
<%@ include file="/WEB-INF/views/include/mTree.jsp"%>
</head>
<style>
.table th, .table td { 
	text-align: center; 
}
</style>
<body>
		<div class="container">
			<h2 class="page-header"><font face="微软雅黑">角色信息</font>  <small><code>&lt; RoleInfo  &gt;</code></small></h2>
			<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#add">
				角色录入
			</button>
			<br/><br/>
			<table id="treeTable" class="table table-bordered table-hover">
				<thead>
					<tr>
						<th width="10%"></th>
						<th width="20%">角色</th>
						<th width="40%">备注</th>
						<th width="30%">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${obj.qr.list }" var="data" varStatus="status">
					<tr>
						<td>${status.index +1 }</td>
						<td>${data.name }</td>
						<td>${data.remarks }</td>
						<td>
							<a dataId="${data.id }" data-toggle="modal" data-target="#update"
						       class="btn btn-warning btn-xs update-role" 
						       title="${data.name }" 
						       href="#">
						    修改</a>
						
						    <a data-confirm="确认删除菜单 ${data.name } 吗？" 
						       class="btn btn-danger btn-xs" 
						       title="${data.name }" 
						       href="${txAdmin }/shiro/role/delete?id=${data.id }&pageNumber=${obj.qr.pager.pageNumber }">
						    删除</a>
						    
						    <a dataId="${data.id }" data-toggle="modal" data-target="#menuTree"
						       class="btn btn-default btn-xs get-shiro" 
						       title="${data.name }"
						       href="#">
						    设置权限</a>
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
		
		
		<!--隐藏的添加框-->
		<form method="post" action="${txAdmin }/shiro/role/add?pageNumber=${obj.qr.pager.pageNumber }">
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
		              	 <span class="glyphicon glyphicon-cloud"></span> 角色录入
		            </h4>
		         </div>
		         <div class="modal-body">
		         <center>
			        <div style="width: 300px; height: 100px" class="form-group">
					 
						 <div class="input-group">
						 	<span class="input-group-addon"><span class="glyphicon glyphicon-pencil"></span></span>
						 	<input type="text" class="form-control requird" name="name" placeholder="角色名称">
						 </div>
						 <br>
						 <div class="input-group">
						 	<span class="input-group-addon"><span class="glyphicon glyphicon-paperclip"></span></span>
						 	<input type="text" class="form-control requird" name="remarks" placeholder="备注">
						 </div>
						 <br>
		         	</div>
		         </center>
		      	 </div>
			     <div class="modal-footer">
			            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			            <button type="submit" class="btn btn-primary">录入</button>
			     </div>
			</div>
		</div>
	</div>
	</form>	
	
	
	
	<!--隐藏的修改框-->
	<div id="update-div">	
	<form method="post" action="${txAdmin }/shiro/role/update?pageNumber=${obj.qr.pager.pageNumber }">
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
					 
						 <div class="input-group">
						 	<span class="input-group-addon"><span class="glyphicon glyphicon-pencil"></span></span>
						 	<input type="text" class="form-control requird" name="name" placeholder="角色名称">
						 </div>
						 <br>
						 <div class="input-group">
						 	<span class="input-group-addon"><span class="glyphicon glyphicon-paperclip"></span></span>
						 	<input type="text" class="form-control requird" name="remarks" placeholder="备注">
						 </div>
						 <br>
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
	
	
	<!--隐藏的菜单树-->
	<div class="modal fade" id="menuTree" tabindex="-1" role="dialog" 
		   aria-labelledby="myModalLabel" aria-hidden="true">
		   <div class="modal-dialog">
		      <div class="modal-content">
		         <div class="modal-header">
		            <button type="button" class="close" 
		               data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel">
		              	 <span class="glyphicon glyphicon-cloud"></span> 权限配置
		            </h4>
		         </div>
		         <div class="modal-body">
		         <center>
			        <div style="width: 300px; height: 230px" class="form-group">
						<ul id="tree" class="ztree" style="width:560px; overflow:auto;"></ul>
		         	</div>
		         </center>
		      	 </div>
			     <div class="modal-footer">
			            <button id="set-shiro" type="button" class="btn btn-default" data-dismiss="modal">确认</button>
			     </div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

	var zTree;
	
	var setting = {
	    check: {
	        enable: true
	    },
	    view: {
	        dblClickExpand: false,
	        showLine: true,
	        selectedMulti: false
	    },
	    data: {
	        simpleData: {
	            enable:true,
	            idKey: "id",
	            pIdKey: "pId",
	            rootPId: ""
	        }
	    },
	    callback: {
	        beforeClick: function(treeId, treeNode) {
	            var zTree = $.fn.zTree.getZTreeObj("tree");
	            if (treeNode.isParent) {
	                zTree.expandNode(treeNode);
	                return false;
	            } else {
	                return true;
	            }
	        }
	    }
	};
	
	var zNodes = null;

	$(function(){
		
		/**
	     * 动态设置分页页码
	     */
	     /* var url = window.location.href; */
	     var url = "${txAdmin }/shiro/role/record?pageNumber="
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
		
		
		/* 修改框赋值 */
		$(".update-role").bind("click",function(){
			var roleId = $(this).attr("dataId");
			$.post("${txAdmin }/shiro/role/get",{id:roleId},function(data){
				var obj = $.parseJSON(data);
				$("#update-div").find("input[name='id']").val(obj.id);
				$("#update-div").find("input[name='name']").val(obj.name);
				$("#update-div").find("input[name='remarks']").val(obj.remarks);
			}, "text");
		});
		
		
		
	   
		var zTree = null;
		
		/* 获取权限树 */
	    $(".get-shiro").click(function(){
	    	var roleId = $(this).attr("dataId");
	    	$("#set-shiro").attr("dataId", roleId);
	    	//Ajax同步
			$.ajax({
				type: "POST",
				url: "${txAdmin }/shiro/ajax/allMenu",
				data: {roleId:roleId},
				dataType: "text",
				async: false,
				success: function(msg){
					zNodes = $.parseJSON(msg);
				}
			});
		    $.fn.zTree.init($("#tree"), setting, zNodes);
		    zTree = $.fn.zTree.getZTreeObj("tree");
	    });
	    
	    /* 保存权限树 */
	    $("#set-shiro").click(function(){
	    	var checkedNode = null;
	    	checkedNode = zTree.getCheckedNodes(true);
	    	var roleId = $(this).attr("dataId");
	    	var menuIds = getChildrens(checkedNode);
	    	//alert(ids);
	    	$.post("${txAdmin }/shiro/ajax/saveRoleMenu", {roleId:roleId, menuIds:menuIds}, function(flag){
	    		if(flag)
	    			notice1SecTrue();
	    		else notice1SecFalse();
	    	});
	    });
	    
	    /* 获取节点 */
	    function getChildrens(jsonObj){
	    	var res;
	    	$.each(jsonObj, function(){
	    		if("undefined" == typeof res) res = this.id;
	    		else res += ","+this.id;
			});	
	    	return res;
	    }
	    
	    /* jBox通知 */
	    function notice1SecTrue() {
	        new jBox('Notice', {
	            content: '权限配置成功！',
	            autoClose: 1500,
	            attributes: {
	    			x: 'left',
	    			y: 'bottom'
	    		},
	    		position: {  // The position attribute defines the distance to the window edges
	    			x: 450,
	    			y: 300
	    		}
	        });
	    }
	    function notice1SecFalse() {
	        new jBox('Notice', {
	            content: '操作失败，请重试！',
	            autoClose: 1500,
	            attributes: {
	    			x: 'left',
	    			y: 'bottom'
	    		},
	    		position: {  
	    			x: 450,
	    			y: 300
	    		}
	        });
	    }
	});

</script>
</html>