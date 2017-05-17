<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<link rel="stylesheet" href="css/bottom.css" type="text/css" media="screen">
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
	function presentorderlist(){
		window.location.href = "./presentorderlist";
	}
	
	function storelist(){
		window.location.href = "./storeindex";
	}
	
	function mycontent(){
		window.location.href = "./mycontent";
	}
</script>
<title></title>
</head>
<body>
<div class="bottom">
	<div style="float:left; width: 10%; height: 100%;"></div>
	<div style="float:left; width: 20%; height: 100%;text-align: center; color: #a19999;" id="bottom_1" onclick="storelist()">
		<div style="height: 5px;"></div>
		<img src="imgs/bottom_none_icon_1.png" style="width: 17.5px; height: 18px;" id="bottom_img_1">
		<div style="clear: both;"></div>
		<span style="">点餐</span>
	</div>
	<div style="float:left; width: 10%; height: 100%;"></div>
	<div style="float:left; width: 20%; height: 100%;text-align: center; color: #a19999;" id="bottom_2" onclick="presentorderlist()">
		<div style="height: 5px;"></div>
		<img src="imgs/bottom_none_icon_2.png" style="width: 17.5px; height: 18px;" id="bottom_img_2">
		<div style="clear: both;"></div>
		<span style="">订单</span>
	</div>
	<div style="float:left; width: 10%; height: 100%;"></div>
	<div style="float:left; width: 20%; height: 100%;text-align: center; color: #a19999;" id="bottom_3" onclick="mycontent()">
		<div style="height: 5px;"></div>
		<img src="imgs/bottom_none_icon_3.png" style="width: 17.5px; height: 18px;" id="bottom_img_3">
		<div style="clear: both;"></div>
		<span style="">我的</span>
	</div>
</div>
</body>
</html>