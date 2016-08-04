<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>淘学网 - 个人中心</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<%@ include file="/WEB-INF/views/include/front.jsp"%>
<%@ include file="/WEB-INF/views/include/mTree.jsp"%>
<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>
<%@ include file="/WEB-INF/views/include/summernote.jsp"%>
<%@ include file="/WEB-INF/views/include/jBox.jsp"%>
<link href="${txStatic }/_front/css/style.css" rel="stylesheet" type="text/css" media="all" />
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
				<div class="contact-form">
					<h2><font face="微软雅黑">发布信息</font></h2>
					<br />
					<form id="validForm" method="post" action="${txFront }/publish"
			 	 	    	target="_self" enctype="multipart/form-data">
			 	 	
			 	 			<input name="userId" type="hidden" class="textbox" value="${obj.id }">
					    	<div class="contact-form-div">
						    	<span><label>物品名称<font color="#FA8072">*   </font></label></span>
						    	<span><input name="name" type="text" class="textbox required" value=""></span>
						    </div>
						    <div class="contact-form-div">
						    	<span><label>分类<font color="#FA8072">*   </font></label></span>
						    	<span><input id="classification-name" name="classificationName" readonly="true" type="text" class="textbox required" placeholder="分类选择"></span>
						    	<input id="classification-id" type="hidden" class="" name="classificationId">
						    </div>
						    <div class="contact-form-div">
						    	<span><label>发布标题<font color="#FA8072">*   </font></label></span>
						    	<span><input name="title" type="text" class="textbox required" value=""></span>
						    </div>
						    <div class="contact-form-div">
						    	<span><label>参考价格（单位：元）<font color="#FA8072">*   </font></label></span>
						    	<span><input name="price" type="text" class="textbox required {digits:true}" value=""></span>
						    </div>
			 	 			<br />
						    <div class="contact-form-div">
						    	<span><label>上传封面图片<font color="#FA8072">*   图片大小不超过100K，推荐像素 380px * 366px</font></label></span>
						    	<span>
						    		<a class="btn_addPic" href="#" style="text-decoration: none; color:#999999;">
										<span><em></em>添加图片</span> 
										<input id="upload-goodsimg-show" class="filePrew required" title="" tabIndex="3" type="file" size="3" name="showImg">
									</a>
						    	</span>
						    	<span><label id="upload-goodsimg-message"></label></span>
						    </div>
						    <br />
						    <div class="contact-form-div">
						    	<span><label>物品详情描述</label></span>
						    	<div id="summernote"></div>
						    	<input type="hidden" name="descriptions" value="" />
						    </div>
						   <div class="contact-form-div">
						   		<span><input id="btn-publish-save" type="submit" class="" value="发布"></span>
						  </div>
			 	 	</form>
				</div>
  				<div class="clear"></div>		
			    </div>
				</div>
				</div>
				
				<!-- start sidebar -->
				<%@ include file="/WEB-INF/views/front/inc/sidebar.jsp"%>
				<div class="clear"></div>
	</div>
</div>
</div>
	
<div id="dialog-message" title="分类选择" style="display:none;">
<div style="width: 200px; height: 220px" class="form-group">
<div id="menuContent" class="menuContent">
	<ul id="treeDemo" class="ztree" style=""></ul>
</div>
</div>
</div>					

<!-- start footer -->
<%@ include file="/WEB-INF/views/front/inc/footer.jsp"%>
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
		var menuNameObj = $("#classification-name");
		menuNameObj.attr("value", v);
		
		if (vId.length > 0 ) vId = vId.substring(0, vId.length-1);
		var menuIdObj = $("#classification-id");
		menuIdObj.attr("value", vId);
		
		zTree.expandNode(treeNode, null, null, null, true);
	}

	function showMenu() {
		var menuNameObj = $("#classification-name");
		var menuNameOffset = $("#classification-name").offset();
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


		jQuery(document).ready(function($) {
			
			if ('' != '${sessionScope.uploadPublishMsg }') {
				new jBox('Notice', {
			   		content: '${sessionScope.uploadPublishMsg }',
			   		autoClose: 1500,
			        attributes: {
			    		x: 'left',
			    		y: 'bottom'
			    	},
			    	position: {  // The position attribute defines the distance to the window edges
			    		x: 550,
			    		y: 400
			    	}
				});
				$.post("${tx }/removeSession?op=uploadPublishMsg", {}, function(){});
			}
			
			
			
			$("#classification-name").click(function(){
				$( "#dialog-message" ).dialog({
				      modal: true,
				      width: 300,
				      buttons: {
				        确认: function() {
				          $( this ).dialog( "close" );
				        }
				      }
				});
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
			
			
			$('#summernote').summernote({
				  height: 200,                 
				  minHeight: 200,             
				  maxHeight: 400,             
				  focus: true,                 
			});
			
			$("#upload-goodsimg-show").change(function(){
				$("#upload-goodsimg-message").empty();
				var file = this.files[0]; 
				var filename = file.name;
				var filesize = file.size/1024;
				html = '<br />';
				html += '&nbsp;文件名称：<br />&nbsp;&nbsp;' + filename + '<br />';
				if (filesize > 100) 
					html += '&nbsp;文件大小：<br />&nbsp;&nbsp;<font color="red">' + filesize + 'KB ×<font color="red">';
				else html += '&nbsp;文件大小：<br />&nbsp;&nbsp;' + filesize + 'KB';
				$("#upload-goodsimg-message").append(html);
			});
			
			$("#btn-publish-save").click(function(){
				var sHTML = $('#summernote').summernote('code');
				$("input[name='descriptions']").val(sHTML);
			});
			
			$("#validForm").validate();

		});
</script>
</html>