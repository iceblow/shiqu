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
<script type="text/javascript">
</script>
<title>食趣商家管理平台</title>
</head>
<body>
<div id="content">
	<div style="width: 100%; height: 83px;">
<!-- 		<div style="width: 100%; height: 21px;"></div> -->
<!-- 		<div class="addbutton" onclick="editorCoupon(0)">+&nbsp;&nbsp;添加</div> -->
	</div>
	<form action="" id="delForm" method="post">
	</form>
</div>
</body>
<div class="mask" style="display:none;"></div>
<div class="alert" id="alertdiv" style="width: 450px; height: 215px; display:none">
<form action="./saveupdateCategory" id="saveupdateForm" method="post">
	<input type="hidden" value="0" id="categoryid" name="id"/>
	<div style="width: 100%; height: 65px; background: #f5f6fa;">
		<div style="height: 19px;"></div>
		<div style="width: 400px; height: 27px;margin: 0 auto;text-align: left;">
			添加分类
			<img src="imgs/alertclose.png" style="float:right;cursor: pointer;" onclick="hide()">
		</div>
	</div>
	<input type="text" value="" id="name" name="name" style="border: 1px solid #bdc6d7; width: 305px; height: 43px; padding-left: 5px; float:left; margin-top: 45px; margin-left: 12px;"/>
	<div style="width: 75px; height: 45px; background: #6097fb; text-align: center; line-height: 45px; float:left; color: #fff; margin-top: 45px; margin-left: 15px; cursor: pointer;" onclick="saveorupdate()">确定</div>
</form>
</div>
</html>