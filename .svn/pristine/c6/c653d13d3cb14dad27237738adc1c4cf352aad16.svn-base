<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
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
	function editorMenu(menu_id){
		window.location.href = "./editorMenu?menu_id="+menu_id;
	}
</script>
<title>食趣商家管理平台</title>
</head>
<body>
<div id="content">
	<div style="width: 100%; height: 83px;">
		<div style="width: 100%; height: 38px;"></div>
		<div style="float: left; background-image: url(imgs/hicon.png); background-repeat: no-repeat;height: 17px; background-position-y: 5px;width: 11px;"></div>
		<span style="float:left; font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;菜品管理&nbsp;&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;菜品管理&nbsp;&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;<font style="color: #5f97fa;">查看菜品</font></span>
	</div>
	<div style="margin-bottom: 29px; width: 105px; height: 40px; background: #6097fb; color: #fff; cursor: pointer; line-height: 40px;" onclick="editorMenu(${menu.menu_id})">
		<img src="imgs/detaileditoricon.png" style="width: 18px; height: 18px; margin-left: 13px;">
		<span>编辑资料</span>
	</div>
	<div class="detailItem" style="border-top:1px solid #e5e6ea; height: auto; border-bottom: 0px;">
		<div class="detailItemLeft" style="height: auto;text-align: center; min-width: 150px; width: 15%;">
			<img src="${menu.pic_url }" style="width: 120px; height: 120px; margin-top: 30px;">
			<div>照片</div>
		</div>
		<div class="detailItemRight" style="height: auto; width: 80%;">
			<div style="width: 100%; height: 30px;"></div>
			<div style="width: 10%; float:left; text-align: right;">名称：</div>
			<div style="width: 88%; float:left; text-align: left; margin-left: 1%;">${menu.menu_name }</div>
			<div style="clear: both; height: 30px;"></div>
			<div style="width: 10%; float:left; text-align: right;">所属分类：</div>
			<div style="width: 88%; float:left; text-align: left; margin-left: 1%;">${menu.category }</div>
			<div style="clear: both; height: 30px;"></div>
			<div style="width: 10%; float:left; text-align: right;">单价：</div>
			<div style="width: 88%; float:left; text-align: left; margin-left: 1%;">${menu.price }元</div>
			<div style="clear: both; height: 30px;"></div>
			<div style="width: 10%; float:left; text-align: right;">点餐单位：</div>
			<div style="width: 88%; float:left; text-align: left; margin-left: 1%;">${menu.unit }</div>
			<div style="clear: both; height: 30px;"></div>
			<div style="width: 10%; float:left; text-align: right;">送厨单位：</div>
			<div style="width: 88%; float:left; text-align: left; margin-left: 1%;">${menu.kitunit }</div>
			<div style="clear: both; height: 30px;"></div>
			<div style="width: 10%; float:left; text-align: right;">口味：</div>
			<div style="width: 88%; float:left; text-align: left; margin-left: 1%;">${menu.taste }</div>
			<div style="clear: both; height: 30px;"></div>
			<div style="width: 10%; float:left; text-align: right;">打印机：</div>
			<div style="width: 88%; float:left; text-align: left; margin-left: 1%;"></div>
			<div style="clear: both; height: 30px;"></div>
			<div style="width: 10%; float:left; text-align: right;">描述：</div>
			<div style="width: 88%; float:left; text-align: left; margin-left: 1%;">${menu.description }</div>
			<div style="clear: both; height: 30px;"></div>
			<div style="width: 10%; float:left; text-align: right;">其他：</div>
			<div style="width: 88%; float:left; text-align: left; margin-left: 1%;">
				<c:if test="${menu.is_hot == 1 }">热销&nbsp;&nbsp; </c:if>
				<c:if test="${menu.is_weigh == 1 }">需称重&nbsp;&nbsp;</c:if>
				<c:if test="${menu.can_discount == 1 }">不可打折&nbsp;&nbsp;</c:if>
				<c:if test="${menu.sell_out == 1 }">沽清</c:if>
			</div>
		</div>
	</div>
	<div style="clear:both; border-top:1px solid #e5e6ea; "></div>
</div>
</body>
</html>