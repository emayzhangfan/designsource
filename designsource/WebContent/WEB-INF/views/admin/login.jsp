<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>TaoX SignIn</title>
    <%@ include file="/WEB-INF/views/include/admin.jsp"%>
	<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>
	<%@ include file="/WEB-INF/views/include/jBox.jsp"%>
    <link href="${txStatic }/css/signin.css" rel="stylesheet" type="text/css">
	<!-- /designsource/WEB-INF/static -->
</head>
<body>
	<div class="container">
      <form class="form-signin" action="${txAdmin }/login" method="post">
        <h2 class="form-signin-heading"><font face="微软雅黑" color="#3276B1">“淘学网”后台管理</font></h2>
        <center><p class="text-danger"><font face="微软雅黑"> ${obj.error } </font></p></center>
        <label for="inputEmail" class="sr-only">用户名</label>
        <input type="text" id="inputEmail" class="form-control" name="loginName" placeholder="用户名" required autofocus>
        <label for="inputPassword" class="sr-only">密码</label>
        <input type="password" id="inputPassword" class="form-control" name="password" placeholder="密码" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住密码
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
      </form>

    </div> <!-- /container -->
    
	<div style="display:none;">
		<form action="${txAdmin }/login" method="post">
			<a data-confirm="该账户在其他终端已登录，是否强制登录，并下线其他终端？" href="${txAdmin }/loginAgain?loginName=${obj.loginName }&password=${obj.password }" target="mainFrame"><span id="login_again">温馨提示</span></a>
		</form>
		
	</div>
	
	<div style="display:none;">
		<form action="${txAdmin }/login" method="post">
			<a data-confirm="该账户在其他设备已登录，请重新登录！" target="mainFrame"><span id="ReLogin">温馨提示</span></a>
		</form>
		
	</div>
</body>
<script type="text/javascript">
	
$(document).ready(function(){
	/* jBox */
	 new jBox('Confirm', {
		 confirmButton: '确认',
		 cancelButton: '取消',
	 });
	
	if ('' != '${obj.Logining }') {
// 		$('#login_again').attr('data-confirm','${obj.Logining }');
		$('#login_again').click();
	}
	
	if ('' != '${obj.ReLogin }') {
		$('#ReLogin').click();
	}
	
		
});

</script>
</html>
