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
<script type="text/javascript">
</script>
<title>我的优惠券</title>
</head>
<body>
<div style="width: 92%; height: auto; margin: 0 auto; padding-bottom: 60px;">
	<c:forEach items="${couponlist }" var="p" varStatus="pstatus">
		<div style="width: 100%; height: 20px;"></div>
		<div style="position: relative; height: 82px;">
		<div style="width: 28%; height: 82px; color: #fff;background: #ffba3f; float:left; border-radius: 4px; font-size: 12px; overflow: hidden;">
			<div style="height: 15px;"></div>
			<span style="font-size: 19px; margin-left: 10px;">${p.coupon.amount}</span><span style="font-size: 14px;">元</span>
			<div style="height: 6px;"></div>
			<div style="margin-left: 10px;overflow: hidden;">${p.coupon.description}</div>
		</div>
		<div style="width: 71%; height: 80px;float:left; border-top-left-radius: 4px; border-bottom-left-radius: 4px; border: 1px solid #e5e5e5; overflow: hidden;" id="coupon_right_${p.coupon.coupon_id }">
			<div style="margin-left: 13px; height: 35px; font-size: 15px; line-height: 35px; overflow: hidden;">${p.store_name }</div>
			<div style="margin-left: 13px; font-size: 12px; overflow: hidden;">${p.coupon_no }</div>
			<div style="margin-left: 13px; line-height:30px; font-size: 12px; overflow: hidden; color: #857777">使用期限&nbsp;<fmt:formatDate value="${p.coupon.from_time }" pattern="yyyy-MM-dd"/>-<fmt:formatDate value="${p.coupon.end_time }" pattern="yyyy-MM-dd"/> </div>
		</div>
		<img src="${p.store_pic }" style="position: absolute; right: 10px; top: -7px; width: 29px; height:29px;">
		</div>
	</c:forEach>
</div>
<input type="hidden" value="3" id="bottom_index" name="bottom_index"/>
<jsp:include page="bottom.jsp"/>
</body>
</html>