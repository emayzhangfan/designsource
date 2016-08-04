	
	/**
	 * 注册验证用户名唯一性
	 * 作者：张帆
	 * 日期：2016/03/10
	 */
	function validdateLoginname (_this, path) {
		$("#check-loginname-msg").empty();
		var loginName = $(_this).val();
		var html = "用户名已存在";
		$.post(path + "/ajax/validateLoginname", {loginName : loginName}, function(flag){
			if (flag == true) {
				$("#check-loginname-msg").append(html);
				$("#register-btn").prop("disabled", true);
			} else {
				$("#register-btn").prop("disabled", false);
			}
				
		});
	}

