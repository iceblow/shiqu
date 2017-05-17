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
<script type="text/javascript" src="./js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(function(){
		if($("#id").val() == ""){
			$("#id").val(0);
		}
	});
	
	function checkForm(){
		var id = $("#id").val();
		var name = $("#name").val();
		if(name == ""){
			alert("用户不能为空");
			return false;
		}
// 		var company = $("#company").val();
// 		if(company == ""){
// 			alert("公司不能为空");
// 			$("#phone").focus();
// 			return false;
// 		}
		$.ajax({
			type: "post",
			url: "./checkstoresigner",
			data: {id :id , name :name},
			success: function(data){
				if(data == "error"){
					alert("该姓名已被注册");
					return false;
				}else{
					$("#storeUserForm").submit();
				}
			}
		});
	}
	
	function clearinput(){
		$("#name").val("");
		$("#company").val("");
	}
	
</script>
<title>食趣商家管理平台</title>
</head>
<body>
<div id="content">
	<div style="width: 100%; height: 83px; border-bottom: 1px solid #e5e6ea;">
		<div style="width: 100%; height: 38px;"></div>
		<div style="float: left; background-image: url(imgs/hicon.png); background-repeat: no-repeat;height: 17px; background-position-y: 5px;width: 11px;"></div>
		<span style="float:left; font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;签单人员管理&nbsp;&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;签单人员&nbsp;&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;<font style="color: #5f97fa;">修改签单人员</font></span>
	</div>
	<form action="./saveorupdateStoreSinger" id="storeUserForm" method="post" enctype="multipart/form-data">
	<input type="hidden" value="${storesigner.id }" id="id" name="id"/>
	<div class="detailItem">
		<div class="detailItemLeft"><span style="margin-right: 15%;">姓名</span></div>
		<div class="detailItemRight"><input value="${storesigner.name }" id="name" name="name" /></div>
	</div>
	<div class="detailItem" id="usernamediv">
		<div class="detailItemLeft"><span style="margin-right: 15%;">公司</span></div>
		<div class="detailItemRight">
		<input value="${storesigner.company }" id="company" name="company"/>
		</div>
	</div>
	<div style="width: 100%;height: 40px;"></div>
	<div type="submit" class="saveorupdate" style="float:left;" onclick="checkForm();">确定并上传</div>
	<div class="clearinput" style="float:left;" onclick="clearinput()">清空填写内容</div>
	<div style="width: 100%;height: 40px;"></div>
	</form>
</div>
</body>
</html>