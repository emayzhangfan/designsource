<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    	<!-- 导航 开始 -->
		<nav class="navbar navbar-default" role="navigation">
		   <div class="navbar-header">
		   	  <img src="${txStatic }/images/logo.png" alt="" style="float:left; width:50px; height:50px;">
		      <a class="navbar-brand" href="${txAdmin }" style="font-family:微软雅黑;font-size:20px;">"淘学网"后台管理</a>
		   </div>
		   <div>
		      
		      <!--向右对齐-->
		      <ul class="nav navbar-nav navbar-right">
		         <li class="dropdown">
		            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
		         		 帮助 <b class="caret"></b>
		            </a>
		            <ul class="dropdown-menu">
		               <!-- <li><a href="#" target="mainFrame">消息中心</a></li> -->
		               <li><a href="${txAdmin }/help/adminInfo" target="mainFrame">个人设置</a></li>
		               <li><a href="${txAdmin }/help/changepwd" target="mainFrame">修改密码</a></li>
		               <%-- <li class="divider"></li>
		               <li><a href="${txAdmin }/help/contactInfo" target="mainFrame">反馈建议</a></li>
		               <li><a href="${txAdmin }/help/contactInfo" target="mainFrame">帮助中心</a></li> --%>
		               <li class="divider"></li>
		               <li><a href="${txAdmin }/help/contactInfo" target="mainFrame">联系我们</a></li>
		            </ul>
		         </li>
		      </ul>
		      
		      
			<div class="navbar-right">
			<ul class="nav navbar-nav">
		         <li class="active"><a href="#">${sessionScope.admin.name}</a></li>
		         <li ><a href="#" onclick="closeWin()">安全退出</a></li>
	         </ul>
	         	<%-- 
		         <button type="button" class="btn btn-default navbar-btn">
				  	<span class="glyphicon glyphicon-user" style="color: rgb(89, 130, 99); font-size: 14px;">${sessionScope.loginUser.name}</span>
				 </button>
				  	
				 <button type="button" class="btn btn-default navbar-btn" id="exit" onclick="closeWin()">
				  	<span class="glyphicon glyphicon-off" style="color: rgb(89, 130, 99); font-size: 14px;"> 安全退出</span>
				 </button>
				  --%>
		    </div>
		
		   </div>
		</nav>
		<!-- 导航 结束 -->
		
		
		
		<script type="text/javascript">
			/**
			 * 安全退出
			 */
		    function closeWin(){
		    	//window.parent.window.location.href = "${tx }/exit.jsp";
		    	window.parent.window.location.href = "${txAdmin }/loginOut";
		    }
	    </script>