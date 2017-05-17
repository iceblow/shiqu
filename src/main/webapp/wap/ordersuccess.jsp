<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>下单成功</title>
</head>
<body>
<img style="width:50%;margin-left:25%;margin-top:50px;" src="./imgs/ordersuccess.png">
<div style="width:100%;text-align:center;font-size:24px;color:#3e3e3e;margin-top:25px;">下单成功</div>
<div style="width:100%;text-align:center;">
<div style="margin:0 auto;height:35px;line-height:35px;margin-top:50px;width:150px;background-color:#ff8854;font-size:17px;color:#ffffff;text-align:center;border-radius:20px;" onclick="presentorderlist()">查看我的订单</div>
</div>
</body>
<script>
function presentorderlist(){
	window.location.href="./presentorderlist";
}
</script>
</html>