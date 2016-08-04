<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%@ include file="/WEB-INF/views/include/admin.jsp"%>
<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>
<%@ include file="/WEB-INF/views/include/treeTable.jsp"%>
<%@ include file="/WEB-INF/views/include/jBox.jsp"%>
<%@ include file="/WEB-INF/views/include/mTree.jsp"%>
</head>
<style>
/* 	ul.ztree {margin-top: 10px;border: 1px solid #617775;background: #f0f6e4;width:220px;height:360px;overflow-y:scroll;overflow-x:auto;} */
</style>
<body>
		<div class="container">
			<h2 class="page-header"><font face="微软雅黑">分类信息</font>  <small><code>&lt; ClassificationInfo  &gt;</code></small></h2>
			<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#add">
				分类录入
			</button>
			<br/><br/>
			<table id="treeTable" class="table table-hover">
				<thead>
					<tr>
						<th width="25%">类型名称</th>
						<th width="10%">排序</th>
						<th width="50%">地址</th>
						<th width="25%">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${obj.qr.list }" var="data">
					<tr id="${data.id }" pId="${data.parentId }">
						<td>${data.name }</td>
						<td>${data.sort }</td>
						<td>${data.url }</td>
						<td>
						<c:if test="${data.parentId != '' }">
							<a dataId="${data.id }" data-toggle="modal" data-target="#update"
						       class="btn btn-warning btn-xs update-menu" 
						       title="${data.name }" name="delete" 
						       href="#">
						    修改</a>
						
						    <a data-confirm="确认删除菜单 ${data.name } 吗？" 
						       class="btn btn-danger btn-xs" 
						       title="${data.name }" name="delete" 
						       href="${txAdmin }/classification/delete?id=${data.id }">
						    删除</a>
						</c:if>    
						</td>
					</tr>
					
					</c:forEach>
				</tbody>
			</table>
			
			<c:if test="${obj.qr.list == '[]' }">
				<div class="well well-sm"><center><font class="text-warning" face="微软雅黑">未查出数据！</font></center></div>
			</c:if>
		</div>


		<!--隐藏的添加框-->
		<form method="post" action="${txAdmin }/classification/add">
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
		              	 <span class="glyphicon glyphicon-cloud"></span> 分类录入
		            </h4>
		         </div>
		         <div class="modal-body">
		         <center>
			        <div style="width: 300px; height: 200px" class="form-group">
					 
						 <div class="input-group">
						 	<span class="input-group-addon"><span class="glyphicon glyphicon-search"></span></span>
						 	<input id="menuSel-name" readonly="true" type="text" class="form-control requird" placeholder="父级分类">
						 	<input id="menuSel-id" type="hidden" class="" name="parentId">
						 	<span class="input-group-addon"><a id="menuBtn" href="#" onclick="showMenu(); return false;" data-toggle="modal" data-target="#menuTree">选择</a></span>
						 </div>
						 <br>
						 <div class="input-group">
						 	<span class="input-group-addon"><span class="glyphicon glyphicon-pencil"></span></span>
						 	<input type="text" class="form-control requird" name="name" placeholder="分类名称">
						 </div>
						 <br>
						 <div class="input-group">
						 	<span class="input-group-addon"><span class="glyphicon glyphicon-tags"></span></span>
						 	<input type="text" class="form-control requird" name="sort" placeholder="排序">
						 </div>
						 <br>
						 <div class="input-group">
						 	<span class="input-group-addon"><span class="glyphicon glyphicon-send"></span></span>
						 	<input type="text" class="form-control requird" name="url" placeholder="地址">
						 </div>
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
		              	 <span class="glyphicon glyphicon-cloud"></span> 父级分类选择
		            </h4>
		         </div>
		         <div class="modal-body">
		         <center>
			        <div style="width: 300px; height: 200px" class="form-group">
					 		<div id="menuContent" class="menuContent" style="display:none; /* position: absolute; */">
								<ul id="treeDemo" class="ztree" style=""></ul>
							</div>
		         	</div>
		         </center>
		      	 </div>
			     <div class="modal-footer">
			            <button type="button" class="btn btn-default" data-dismiss="modal">确认</button>
			     </div>
			</div>
		</div>
	</div>


	<!--隐藏的修改框-->
	<div id="update-div">	
	<form method="post" action="${txAdmin }/classification/update">
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
		              	 <span class="glyphicon glyphicon-cloud"></span> 分类修改
		            </h4>
		         </div>
		         <div class="modal-body">
		         <center>
			        <div style="width: 300px; height: 200px" class="form-group">
					 
					 	<input type="hidden" class="" name="id">
					 
						 <div class="input-group">
						 	<span class="input-group-addon"><span class="glyphicon glyphicon-search"></span></span>
						 	<input readonly="true" type="text" name="parentName" class="form-control requird" placeholder="父级分类">
						 	<input type="hidden" name="parentId">
						 	<span class="input-group-addon">禁止修改</span>
						 </div>
						 <br>
						 <div class="input-group">
						 	<span class="input-group-addon"><span class="glyphicon glyphicon-pencil"></span></span>
						 	<input type="text" class="form-control requird" name="name" placeholder="分类名称">
						 </div>
						 <br>
						 <div class="input-group">
						 	<span class="input-group-addon"><span class="glyphicon glyphicon-tags"></span></span>
						 	<input type="text" class="form-control requird" name="sort" placeholder="排序">
						 </div>
						 <br>
						 <div class="input-group">
						 	<span class="input-group-addon"><span class="glyphicon glyphicon-send"></span></span>
						 	<input type="text" class="form-control requird" name="url" placeholder="地址">
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



	var setting = {
		view: {
			dblClickExpand: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			//beforeClick: beforeClick,
			beforeExpand: beforeExpand,
				onExpand: onExpand,
			onClick: onClick
		}
	};

 	var zNodes = null;

	function beforeClick(treeId, treeNode) {
		var check = (treeNode && !treeNode.isParent);
		if (!check) alert("只能最末级");
		return check;
	}
	
	function onClick(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
		nodes = zTree.getSelectedNodes(),
		v = "";
 		vId = "";
		nodes.sort(function compare(a,b){return a.id-b.id;});
		for (var i=0, l=nodes.length; i<l; i++) {
			v += nodes[i].name + ",";
			vId += nodes[i].id + ",";
		}
		if (v.length > 0 ) v = v.substring(0, v.length-1);
		var menuNameObj = $("#menuSel-name");
		menuNameObj.attr("value", v);
		
		if (vId.length > 0 ) vId = vId.substring(0, vId.length-1);
		var menuIdObj = $("#menuSel-id");
		menuIdObj.attr("value", vId);
		
		zTree.expandNode(treeNode, null, null, null, true);
	}

	function showMenu() {
		var menuNameObj = $("#menuSel-name");
		var menuNameOffset = $("#menuSel-name").offset();
		$("#menuContent").css({left:menuNameOffset.left + "px", top:menuNameOffset.top + menuNameObj.outerHeight() + "px"}).slideDown("fast");
		
		//$("body").bind("mousedown", onBodyDown);
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
			hideMenu();
		}
	}
	
	
	
	
	
	function createNodes(maxNodesNumInLevel, maxLevel, curLevel, curPId) {
		if (maxNodesNumInLevel<5) {
			maxNodesNumInLevel = 5;
		}
		var nodes = [], num = 0;
		while(num<3) {
			num = parseInt(Math.random()*1024)%maxNodesNumInLevel+1;
		}
		for (var i=0; i<num; i++) {
			var id = curPId ? curPId + "-" + i : "" + i, isParent = (parseInt(Math.random()*9999)%3!=0),
			node = {id: id, pId : curPId, name : "N" + id};
			nodes.push(node);
			if (isParent && curLevel<maxLevel) {
				nodes = nodes.concat(createNodes(maxNodesNumInLevel, maxLevel, curLevel+1, id));
			}
		}
		return nodes;
	}
	var zNodes =createNodes(5, 5, 0);

	var curExpandNode = null;
	function beforeExpand(treeId, treeNode) {
		var pNode = curExpandNode ? curExpandNode.getParentNode():null;
		var treeNodeP = treeNode.parentTId ? treeNode.getParentNode():null;
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		for(var i=0, l=!treeNodeP ? 0:treeNodeP.children.length; i<l; i++ ) {
			if (treeNode !== treeNodeP.children[i]) {
				zTree.expandNode(treeNodeP.children[i], false);
			}
		}
		while (pNode) {
			if (pNode === treeNode) {
				break;
			}
			pNode = pNode.getParentNode();
		}
		if (!pNode) {
			singlePath(treeNode);
		}

	}
	function singlePath(newNode) {
		if (newNode === curExpandNode) return;
		if (curExpandNode && curExpandNode.open==true) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			if (newNode.parentTId === curExpandNode.parentTId) {
				zTree.expandNode(curExpandNode, false);
			} else {
				var newParents = [];
				while (newNode) {
					newNode = newNode.getParentNode();
					if (newNode === curExpandNode) {
						newParents = null;
						break;
					} else if (newNode) {
						newParents.push(newNode);
					}
				}
				if (newParents!=null) {
					var oldNode = curExpandNode;
					var oldParents = [];
					while (oldNode) {
						oldNode = oldNode.getParentNode();
						if (oldNode) {
							oldParents.push(oldNode);
						}
					}
					if (newParents.length>0) {
						zTree.expandNode(oldParents[Math.abs(oldParents.length-newParents.length)-1], false);
					} else {
						zTree.expandNode(oldParents[oldParents.length-1], false);
					}
				}
			}
		}
		curExpandNode = newNode;
	}

	function onExpand(event, treeId, treeNode) {
		curExpandNode = treeNode;
	}
	


	$(function(){
		
		/* treeTable */
		var option = { expandLevel : 1 };
		$("#treeTable").treeTable(option);
		
		/* jBox */
		new jBox('Confirm', {
			confirmButton: '确认',
			cancelButton: '取消'
		});
		
		
		
		//Ajax同步
		$.ajax({
			type: "POST",
			url: "${txAdmin }/classification/ajax/allClassification",
			data: "",
			dataType: "text",
			async: false,
			success: function(msg){
				zNodes = $.parseJSON(msg);
			}
		});
		/* zTree */
		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		
		/* 修改框赋值 */
		$(".update-menu").bind("click",function(){
			
			var classificationId = $(this).attr("dataId");
			$.post("${txAdmin }/classification/get",{id:classificationId},function(data){
				var obj = $.parseJSON(data);
				$("#update-div").find("input[name='id']").val(obj.id);
				if("undefined" != typeof obj.parent) 
					$("#update-div").find("input[name='parentName']").val(obj.parent.name);
				else 
					$("#update-div").find("input[name='parentName']").val("");
				$("#update-div").find("input[name='parentId']").val(obj.parentId);
				$("#update-div").find("input[name='name']").val(obj.name);
				$("#update-div").find("input[name='sort']").val(obj.sort);
				$("#update-div").find("input[name='url']").val(obj.url);
			}, "text");
		});
		
		
		
	});
</script>
</html>