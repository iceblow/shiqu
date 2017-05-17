<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Banner管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="./bootstrap/jquery-2.0.0.min.js"></script>
<script type="text/javascript" src="./bootstrap/jquery-ui"></script>
<link href="./bootstrap/bootstrap-combined.min.css" rel="stylesheet" media="screen">
<script type="text/javascript" src="./bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/common.js"></script>
<script type="text/javascript">
	$(function() {
		$("#menu11").addClass('active');
		words_deal(50,'messagetitle','titlemun');
		words_deal(200,'messagecontent','contentmun');
		var pushtype = $("#pushtype").val();
		if(pushtype == 1){
			$("input[name=pushtype]:eq(0)").attr("checked",'checked'); 
			$("#selectbutton").hide();
			$("#usernum").hide();
		}else{
			$("input[name=pushtype]:eq(1)").attr("checked",'checked'); 
			$("#selectbutton").show();
			$("#usernum").show();
		}
		
	})
	
	$(document).ready(function() {
		$(".radioItem").change(
		function() {
		var $selectedvalue = $("input[name='pushtype']:checked").val();
		if ($selectedvalue == 1) {
			$("#selectbutton").hide();
			$("#usernum").hide();
		}
		else {
			$("#selectbutton").show();
			$("#usernum").show();
		}
		});
	});
	
	function searchuser(){
		$("#messageForm").attr("action", "./searchuser").submit();
	}
	
	function chenckForm(){
		var val=$('input:radio[name="pushtype"]:checked').val();
		if(val == 2){
			if($("#user_ids").val() == ""){
				alert("请选择用户");
				return false;
			}
		}
		var title = $("#messagetitle").val();
		if(title == ""){
			alert("标题不能为空");
			return false;
		}
		var content = $("#messagecontent").val();
		if(content == ""){
			alert("内容不能为空");
			return false;
		}
		$.ajax({
			type:"post",
			url: "./addmessage",
			data: $("#messageForm").serialize(),
			async: false, 
			success: function(msg){
				var msgdata = eval("("+msg+")");
				var code = msgdata.code;
				if(code == 1){
					alert(msgdata.message);
					window.location.href = "./message";
				}
			}
		});
	}
</script>
</head>
<body>
	<div style="margin: 10px; border-width: 1px; border-style: solid; border-color: #DDD; border-collapse: separate; border-radius: 5px;">

		<div class="container-fluid" style="margin-top: 10px;">


			<div class="row-fluid">
				<div class="span12">
					<div class="navbar">
						<div class="navbar-inner">
							<div class="container-fluid">
								<!-- <a data-target=".navbar-responsive-collapse" data-toggle="collapse" class="btn btn-navbar">
									<span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
								</a> -->
								<a href="#" class="brand">食趣后台管理</a>
							</div>
						</div>
					</div>
				</div>
			</div>


			<div class="row-fluid">
				<div class="span2">
					<jsp:include page="left.jsp" />
				</div>
				<div class="span10">

					<div class="row-fluid">
						<div class="span12">
							<form action="" method="post" id="messageForm">
								<fieldset>
									<legend>发布消息</legend>
									<label>推送对象</label>
									<input type="hidden" value="${pushtype }" id="pushtype" />
									<input type="radio" value="1" name="pushtype" class="radioItem"/> 今天生日的所有用户
									<div style="width: 100%; height: 15px;"></div>
									<input type="radio" value="2" name="pushtype" class="radioItem"/>选择发送对象<button id="selectbutton" class="btn btn-primary" type="button" style="float: none;margin-left:5px;" data-toggle="modal" data-target="#addModal" onclick="searchuser()">用户选择</button>
									<span id="usernum">已选择<font>${length }</font>个用户</span>
									<input type="hidden" value="${user_ids }" name="user_ids" id="user_ids"/>
									<div style="width: 100%; height: 15px;"></div>
									<label>标题</label>
									<input type="text" value="${title }" name="title" id="messagetitle" maxlength="50" onkeyup="words_deal(50,'messagetitle','titlemun')"/>
									<span style="color:#CCCCCC;">还可输入<font style="color: #FF0033;" id="titlemun">50</font>个字</span>
									<label>内容</label>
									<textarea rows="4" cols="50" id="messagecontent" name="content" style="resize: none;" onkeyup="words_deal(200,'messagecontent','contentmun')">${content }</textarea>
									<span style="color:#CCCCCC;">还可输入<font style="color: #FF0033;" id="contentmun">200</font>个字</span>
									<br />
									<button type="button" class="btn" onclick="chenckForm()">提交</button>
								</fieldset>
							</form>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>



</body>
</html>