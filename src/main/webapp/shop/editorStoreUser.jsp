<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/dishes.css" rel="stylesheet">
<link href="./css/common.css" rel="stylesheet">
<link href="./css/page.css" rel="stylesheet">
<script src="./js/jquery-1.11.2.min.js"></script>
<script src="./js/page.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./js/common.js"></script>
<script type="text/javascript" src="./js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(function(){
		if($("#id").val() == ""){
			$("#id").val(0);
// 			setTimeout(function(){
// 			$("#phone").val("");
// 			$("#password").val("");
// 			},100);
		}
		if($("#discount").val() == ""){
			$("#discount").val("100");
		}
	});
	
	function checkForm(){
		var id = $("#id").val();
		var user_name = $("#name").val();
		if(user_name == ""){
			alert("用户不能为空");
			return false;
		}
		var phone = $("#phone").val();
		if(phone == ""){
			alert("手机号码不能为空");
			$("#phone").focus();
			return false;
		}
		if(id == 0){
			var password = $("#password").val();
			if(password == ""){
				alert("密码不能为空");
				$("#password").focus();
				return false;
			}
		}
		var discount = $("#discount").val();
		if(discount == ""){
			alert("折扣率不能为空");
			$("#discount").focus();
			return false;
		}
		if(discount > 100){
			alert("折扣率不能大于100");
			$("#discount").focus();
			return false;
		}
		
		var limitreset = $("#limitreset").val();
		if(limitreset == ""){
			alert("抹零上限不能为空");
			return false;
		}
		
		$.ajax({
			type: "post",
			url: "./checkstoreuserphone",
			data: {id :id , phone :phone},
			success: function(data){
				if(data == "error"){
					alert("该号码已被注册");
					return false;
				}else{
					$("#storeUserForm").submit();
				}
			}
		});
	}
	
	function clearinput(){
		$("#name").val("");
		$("#phone").val("");
		$("#password").val("");
		$("#discount").val("100");
		$("#limitreset").val("");
		if($("#privilege").val() != 1){
			$("#privilege").val(10);
		}
	}
	
</script>
<title>食趣商家管理平台</title>
</head>
<body>
<div id="content">
	<div style="width: 100%; height: 83px; border-bottom: 1px solid #e5e6ea;">
		<div style="width: 100%; height: 38px;"></div>
		<div style="float: left; background-image: url(imgs/hicon.png); background-repeat: no-repeat;height: 17px; background-position-y: 5px;width: 11px;"></div>
		<span style="float:left; font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;员工管理&nbsp;&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;员工&nbsp;&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;<font style="color: #5f97fa;">修改员工</font></span>
	</div>
	<form action="./saveorupdateStoreUser" id="storeUserForm" method="post" enctype="multipart/form-data">
	<input type="hidden" value="${storeuser.id }" id="id" name="id"/>
	<div class="detailItem">
		<div class="detailItemLeft"><span style="margin-right: 15%;">姓名</span></div>
		<div class="detailItemRight"><input value="${storeuser.name }" id="name" name="name" /></div>
	</div>
	<div class="detailItem" id="usernamediv">
		<div class="detailItemLeft"><span style="margin-right: 15%;">手机号码</span></div>
		<div class="detailItemRight">
		<input value="${storeuser.phone }"  id="phone" name="phone" maxlength="11" onkeyup="return checkNum(event, 'phone');" autocomplete="off"/>
		</div>
	</div>
	<div class="detailItem">
		<div class="detailItemLeft"><span style="margin-right: 15%;">密码</span></div>
		 <input type="password" style="display:none">
		<div class="detailItemRight"><input type="password" value="" id="password" name="password" autocomplete="off"/></div>
	</div>
	<div class="detailItem">
		<div class="detailItemLeft"><span style="margin-right: 15%;">权限</span></div>
		<div class="detailItemRight">
			<select name="privilege" id="privilege">
			<c:if test="${empty storeuser}">
<!-- 				<option value="1">店长</option> -->
				<option value="10">收银</option>
				<option value="20">跑堂</option>
			</c:if>
			<c:if test="${storeuser.privilege == 1 }">
				<option value="1" selected="selected">店长</option>
<!-- 				<option value="10">收银</option> -->
<!-- 				<option value="20">跑堂</option> -->
			</c:if>
			<c:if test="${storeuser.privilege == 10 }">
<!-- 				<option value="1" >店长</option> -->
				<option value="10" selected="selected">收银</option>
				<option value="20">跑堂</option>
			</c:if>
			<c:if test="${storeuser.privilege == 20 }">
<!-- 				<option value="1">店长</option> -->
				<option value="10">收银</option>
				<option value="20" selected="selected">跑堂</option>
			</c:if>
			</select>
		</div>
	</div>
	<div class="detailItem">
		<div class="detailItemLeft"><span style="margin-right: 15%;">折扣率</span></div>
		<div class="detailItemRight"><input value="<fmt:formatNumber type="number" value="${storeuser.discount }" maxFractionDigits="2"/>" id="discount" name="discount" onkeyup="return checkKeyForFloat(event, 'discount')">%</div>
	</div>
	<div class="detailItem">
		<div class="detailItemLeft"><span style="margin-right: 15%;">抹零上限</span></div>
		<div class="detailItemRight"><input value="${storeuser.limitreset }" id="limitreset" name="limitreset" onkeyup="checkKeyForFloat(event, 'limitreset')"/></div>
	</div>
	<div style="width: 100%;height: 40px;"></div>
	<div class="saveorupdate" style="float:left;" onclick="checkForm();">确定并上传</div>
	<div class="clearinput" style="float:left;" onclick="clearinput()">清空填写内容</div>
	<div style="width: 100%;height: 40px;"></div>
	</form>
</div>
</body>
</html>