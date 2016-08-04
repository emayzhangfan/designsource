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
<%@ include file="/WEB-INF/views/include/mTree.jsp"%>
</head>
<style>
.table th, .table td { 
	text-align: center; 
}
</style>
<body>
		<div class="container">
			<h2 class="page-header"><font face="微软雅黑">垃圾信息</font>  <small><code>&lt; RubbishGoodsInfo  &gt;</code></small></h2>
			
			
			<div class="panel panel-default">
			<div class="panel-body">
				<form class="form-inline" action="${txAdmin }/rubbishGoods/record" method="post">
				  <div class="form-group">
				    <input type="text" name="name" class="form-control input-sm" placeholder="商品名称" value="${obj.goods.name }"/>
				  </div>
				  <div class="form-group">
				    <input type="text" name="title" class="form-control input-sm" placeholder="发布标题" value="${obj.goods.title }"/>
				  </div>
				  <div class="form-group">
				    <input type="text" name="classificationName" class="form-control input-sm" placeholder="分类"
				     id="menuBtn" href="#" onclick="showMenu(); return false;" data-toggle="modal" data-target="#menuTree"
				     value="${obj.goods.classificationName }" readonly="true"/>
				     <input id="menuSel-id" type="hidden" class="" name="classificationId" value="${obj.goods.classificationId }">
				  </div>
				  <button type="submit" class="btn btn-default btn-sm">搜索</button>
				</form>
			</div>
			</div>			
			
			
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th width=""></th>
						<th width="">展示图片</th>
						<th width="">商品名称</th>
						<th width="">发布标题</th>
						<th width="">所属分类</th>
						<th width="">参考价格</th>
						<th width="">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${obj.qr.list }" var="data" varStatus="status">
					<tr>
						<td>${status.index +1 }</td>
						<td>
							<c:if test="${data.showImgUrl != null }">
							<a href="${txShow }${data.showImgUrl }" title="goodsID: ${data.id }" data-jbox-image="gallery1">
								<img alt="" src="${txShow }${data.showImgUrl }" width="25px" height="25px">
							</a>
							</c:if>
						</td>
						<td>${data.name }</td>
						<td>${data.title }</td>
						<td>${data.classificationName }</td>
						<td>${data.price }</td>
						<td>
							<a data-toggle="modal" data-target="#details"
						       class="btn btn-primary btn-xs" title="${data.id }"
						       href="javascript:void(0);" onclick="selectOne(this);">
						    详情</a>
						
							<a data-confirm="确认将商品 ${data.name } 恢复正常吗？" 
						       class="btn btn-warning btn-xs" 
						       href="${txAdmin }/rubbishGoods/undoRubbish?id=${data.id }&pageNumber=${obj.qr.pager.pageNumber }&name=${obj.goods.name }&title=${obj.goods.title }&classificationId=${obj.goods.classificationId }&classificationName=${obj.goods.classificationName }">
						    恢复</a>
							
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
		              	 <span class="glyphicon glyphicon-cloud"></span> 分类选择
		            </h4>
		         </div>
		         <div class="modal-body">
		         <center>
			        <div style="width: 200px; height: 150px" class="form-group">
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
		
	<!--隐藏的详情-->
	<div class="modal fade" id="details" tabindex="-1" role="dialog" 
		   aria-labelledby="myModalLabel" aria-hidden="true">
		   <div class="modal-dialog">
		      <div class="modal-content">
		         <div class="modal-header">
		            <button type="button" class="close" 
		               data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel">
		              	 <span class="glyphicon glyphicon-cloud"></span> 商品详情
		            </h4>
		         </div>
		         <div class="modal-body">
		         	<div class="panel panel-success">
					   <div class="panel-heading">
					      <h3 class="panel-title">商品描述</h3>
					   </div>
					   <div class="panel-body" id="details-descriptions"></div>
					</div>
		         	<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th width="">用户头像</th>
								<th width="">用户昵称</th>
								<th width="">用户状态</th>
								<th width="">操作</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><img alt="" src="${txAvatar }" width="25px" height="25px" id="details-user-avatar"></td>
								<td id="details-user-username"></td>
								<td id="details-user-status"></td>
								<td>
									<a id="details-user-id"
									   data-confirm="" 
								       class="btn btn-warning btn-xs" 
								       href="">
								    加入黑名单</a>
								</td>
							</tr>
						</tbody>
					</table>
		      	 </div>
			     <div class="modal-footer">
			            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			     </div>
			</div>
		</div>
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
		var menuNameObj = $("#menuBtn");
		menuNameObj.attr("value", v);
		
		if (vId.length > 0 ) vId = vId.substring(0, vId.length-1);
		var menuIdObj = $("#menuSel-id");
		menuIdObj.attr("value", vId);
		
		zTree.expandNode(treeNode, null, null, null, true);
	}

	function showMenu() {
		var menuNameObj = $("#menuBtn");
		var menuNameOffset = $("#menuBtn").offset();
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
	
	function selectOne (_this) {
		$("#details-descriptions").empty();
		$("#details-user-username").empty();
		$("#details-user-status").empty();
		var goodsId = $(_this).attr("title");
		//Ajax同步
		$.ajax({
			type: "POST",
			url: "${txAdmin }/goods/ajax/getOne",
			data: { goodsId : goodsId },
			dataType: "json",
			async: false,
			success: function(data){
				if("undefined" != typeof data.descriptions) 
					$("#details-descriptions").append(data.descriptions);
				
				if("undefined" != typeof data.user.avatar) 
					$("#details-user-avatar").attr("src", "${txAvatar }" + data.user.avatar);
				
				if("undefined" != typeof data.user.username) {
					$("#details-user-username").append(data.user.username);
					$("#details-user-id").attr("data-confirm", "确认将会员 " + data.user.username + " 加入黑名单吗？");
				}
				
				if("undefined" != typeof data.user.status) 
					$("#details-user-status").append(data.user.status);
				
				if("undefined" != typeof data.user.id) {
					$("#details-user-id").attr("href", "${txAdmin }/user/setBlack?pageNumber=${obj.qr.pager.pageNumber }&id=" + data.user.id);
				}
					
			}
		});
	}


	$(function(){
		
		/**
	     * 动态设置分页页码
	     */
	     var url = "${txAdmin }/goods/record?pageNumber="
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
		
	});
</script>
</html>