<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<link rel="stylesheet" href="css/order.css" type="text/css" media="screen">
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<title>支付成功</title>
</head>
<body>
<div style="height: 20px;"></div>
<div style="width: 92%; height: 160px; margin: 0 auto;">
	<img src="imgs/pay_success_icon.png" style="width: 100%; height: 160px;">
</div>
<div style="height: 50px;"></div>
<div style="width: 100%; text-align: center; font-size: 24px;">恭喜您，已成功付款</div>
<div style="height: 29px;"></div>
<div style="width: 100%; text-align: center; font-size: 12px; color: #857777;">
此单共<span style="color: #ff4532;">${order.total_price }</span>元
<c:if test="${not empty coupon }">
,共优惠<span style="color: #ff4532;">${coupon.coupon.amount }</span>元
</c:if>
</div>
<input type="hidden" value="2" id="bottom_index" name="bottom_index"/>
<jsp:include page="bottom.jsp"/>
</body>
</html>