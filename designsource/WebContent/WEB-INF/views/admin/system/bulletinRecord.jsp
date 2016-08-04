<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%@ include file="/WEB-INF/views/include/admin.jsp"%>
<%@ include file="/WEB-INF/views/include/bootstrap.jsp"%>
<%@ include file="/WEB-INF/views/include/datetimepicker.jsp"%>
<%@ include file="/WEB-INF/views/include/summernote.jsp"%>
</head>
<body>
<div class="container">
<h2 class="page-header"><font face="微软雅黑">公告牌</font>  <small><code>&lt; Bulletin  &gt;</code></small></h2>
	<br/>
	<form class="form-horizontal" action="${txAdmin }/system/bulletinRecord" method="post">
	   <input type="hidden" name="id" value="${obj.id }"/>
	   
	   <div class="form-group">
	      <label class="col-sm-2 control-label">公告内容</label>
	      <div class="col-sm-8">
	      	 <div id="summernote">${obj.message }</div>
	      	 <input type="hidden" name="message" value="" />
	      </div>
	   </div>
	   <div class="form-group">
	      <label class="col-sm-2 control-label">时间</label>
	      <div class="col-sm-8">
	         <input type="text" class="form-control" 
	         	name="date" value="<fmt:formatDate value='${obj.date }'/>" id="datetimepicker" readonly/>
	      </div>
	   </div>
	   
	   <br/>
	   <div class="form-group">
	      <div class="col-sm-offset-2 col-sm-10">
	         <button id="btn-changebulletin-save" type="submit" class="btn btn-default">保存</button>
	      </div>
	   </div>
	</form>
	
</div>
</body>
<script type="text/javascript">
	$(function(){
		$('#datetimepicker').datetimepicker({ 
			minView: "month", //选择日期后，不会再跳转去选择时分秒 
			format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式 
			language: 'zh-CN', //汉化 
			autoclose:true //选择日期后自动关闭 
		});
		$('#summernote').summernote({
			  height: 100,                 // set editor height
			  minHeight: 100,             // set minimum height of editor
			  maxHeight: 150,             // set maximum height of editor
			  focus: true,                 // set focus to editable area after initializing summernote
		});
		$("#btn-changebulletin-save").click(function(){
			//新版本取值 $('#summernote').summernote('code');
			//赋值$('#summernote').summernote('code', ‘所要赋的值’);
			var sHTML = $('#summernote').summernote('code');
			$("input[name='message']").val(sHTML);
		});
	});
</script>

</html>