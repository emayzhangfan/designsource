<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>TaoX BackGround</title>
	<%@ include file="/WEB-INF/views/include/admin.jsp"%>
	<%@ include file="/WEB-INF/views/include/zTree.jsp"%>
	<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>
	<%@ include file="/WEB-INF/views/include/jBox.jsp"%>
	<script type="text/javascript">
		var curMenu = null, zTree_Menu = null;
		var setting = {
			view: {
				showLine: false,
				showIcon: false,
				selectedMulti: false,
				dblClickExpand: false,
				addDiyDom: addDiyDom
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClick
			}
		};

		var zNodes = null;

		function addDiyDom(treeId, treeNode) {
			var spaceWidth = 5;
			var switchObj = $("#" + treeNode.tId + "_switch"),
			icoObj = $("#" + treeNode.tId + "_ico");
			switchObj.remove();
			icoObj.before(switchObj);
			$("#" + treeNode.tId + "_span").attr("treenode_switch","true");
			if (treeNode.level > 1) {
				var spaceStr = "<span style='display: inline-block;width:" + (spaceWidth * treeNode.level)+ "px'></span>";
				switchObj.before(spaceStr);
			}
			
		}

		function beforeClick(treeId, treeNode) {
			if (treeNode.level == 0 ) {
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				zTree.expandNode(treeNode);
				return false;
			}
			return true;
		}

		$(document).ready(function(){
			
			//Ajax同步
			$.ajax({
				type: "POST",
				url: "${txAdmin }/shiro/ajax/menuTree",
				data: "",
				dataType: "text",
				async: false,
				success: function(msg){
					zNodes = $.parseJSON(msg);
				}
			});
			
			var treeObj = $("#treeDemo");
			$.fn.zTree.init(treeObj, setting, zNodes);
			zTree_Menu = $.fn.zTree.getZTreeObj("treeDemo");
			curMenu = zTree_Menu.getNodes()[0].children[0].children[0];
			zTree_Menu.selectNode(curMenu);

			treeObj.hover(function () {
				if (!treeObj.hasClass("showIcon")) {
					treeObj.addClass("showIcon");
				}
			}, function() {
				treeObj.removeClass("showIcon");
			});
			
			/**
			 * 判断用户密码是否为默认密码，如果是，提醒其修改密码
			 */
			 $.post("${txAdmin }/help/checkDefaultPassword", {}, function(msg){
				 if (msg)
					 $('#changeDefaultPassword').click();
			 });
			
			
			 /* jBox */
			 new jBox('Confirm', {
				 confirmButton: '确认',
				 cancelButton: '取消',
			 });
			 
		});
		
	</script>
	<style type="text/css">
		.ztree * {font-size: 10pt;font-family:"Microsoft Yahei",Verdana,Simsun,"Segoe UI Web Light","Segoe UI Light","Segoe UI Web Regular","Segoe UI","Segoe UI Symbol","Helvetica Neue",Arial}
		.ztree li ul{ margin:0; padding:0}
		.ztree li {line-height:30px;}
		.ztree li a {width:200px;height:30px;padding-top: 0px;}
		.ztree li a:hover {text-decoration:none; background-color: #E7E7E7;}
		.ztree li a span.button.switch {visibility:hidden}
		.ztree.showIcon li a span.button.switch {visibility:visible}
		.ztree li a.curSelectedNode {background-color:#D4D4D4;border:0;height:30px;}
		.ztree li span {line-height:30px;}
		.ztree li span.button {margin-top: -7px;}
		.ztree li span.button.switch {width: 16px;height: 16px;}
		
		.ztree li a.level0 span {font-size: 150%;font-weight: bold;}
		.ztree li span.button {background-image:url("${txStatic }/zTree/left_menuForOutLook.png"); *background-image:url("${txStatic }/zTree/left_menuForOutLook.gif")}
		.ztree li span.button.switch.level0 {width: 20px; height:20px}
		.ztree li span.button.switch.level1 {width: 20px; height:20px}
		.ztree li span.button.noline_open {background-position: 0 0;}
		.ztree li span.button.noline_close {background-position: -18px 0;}
		.ztree li span.button.noline_open.level0 {background-position: 0 -18px;}
		.ztree li span.button.noline_close.level0 {background-position: -18px -18px;}
		
		body {
			background-color: white;
			margin:0; padding:0;
			text-align: center;
		}
		
/* 		div, p, table, th, td { */
/* 			list-style:none; */
/* 			margin:0; padding:0; */
/* 			color:#333; font-size:12px; */
/* 			font-family:dotum, Verdana, Arial, Helvetica, AppleGothic, sans-serif; */
/* 		} */
/* 		#Iframe {margin-left: 10px;} */
		
		#footer {
			/* border-top: 1px dashed #CCC; */
			border-top: 1px dashed #999999;
			margin: 0;
			text-align: center;
			font-weight: normal;
			color: #AAA;
			font-size: 12px;
			position:absolute;
			bottom:0;  
			padding:8px;  
			width:100%;  
		}
	</style>
</head>
<body>
	
	<%@ include file="/WEB-INF/views/include/nav.jsp"%>
	
	<table border=0 height=550px align=left style="background-image: url()">
		<tr>
			<!-- OutLook 样式的左侧菜单 -->
			<td width=260px align=left valign=top style="BORDER-RIGHT: #999999 1px dashed">
				<ul id="treeDemo" class="ztree" style="height:550px;width:260px; overflow:auto;"></ul>
			</td>
			<!-- iframe -->
			<td width=1050px align=left valign=top style="BORDER-RIGHT: #999999 1px dashed">
				<iframe id="Iframe" width=1050px height=550px name="mainFrame" frameborder="no" src="${tx }/welcome.jsp"></iframe>
			</td>
		</tr>
	</table>

	<div id="footer">
    	TaoX &copy; 2016
	</div>
	
	<div style="display:none;">
		<a data-confirm="默认密码安全性极低，您是否现在修改默认密码？"  href="${txAdmin }/help/changepwd" target="mainFrame"><span id="changeDefaultPassword">修改默认密码</span></a>
	</div>
</body>
</html>