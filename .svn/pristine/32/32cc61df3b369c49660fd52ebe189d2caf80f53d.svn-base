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
<link rel="stylesheet" href="iscroll/iscroll2.css">
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="iscroll/iscroll.js"></script>
<script type="text/javascript" src="iscroll/storeListIscroll.js"></script>
<script type="text/javascript">
	function showrechargeRecord(id){
		window.location.href = "./cardrecord?card_id="+id;
	}
</script>
<title>充值记录</title>
</head>
<body>
<div style="width: 100%; height: 98px; background: #ff8854; color: #fff; font-size: 28px; text-align: center;">
<div style="line-height: 62px;">${card.money }</div>
<div style="font-size: 12px;">余额(元)</div>
</div>
<div style="padding-bottom: 60px;">
<c:forEach items="${recordlist }" var="p" varStatus="statue">
<c:if test="${not statue.last }">
	<c:if test="${p.type == 1 }">
	<div style="width: 92%; height: 92px; margin: 0 auto; border-bottom: 1px solid #e5e5e5;font-size: 12px;">
		<div style="width: 100%; height: 55px; margin-top: 24px;">
			<div style="height: 100%; float:left; ">
				<div>操作时间：<fmt:formatDate value="${p.charge_time }" pattern="yyyy-MM-dd HH:mm"/></div>
				<div style="padding-top: 10px;">充值：${p.charge_money }元</div>
				<div style="padding-top: 10px;">实付：<font style="color: #57ceb1;">${p.money }元</font></div>
			</div>
			<img src="imgs/arrow_rigth_deep_icon.png" style="width: 7px; height: 12px; float: right; margin-top: 35px;">
		</div>
	</div>
	</c:if>
	<c:if test="${p.type == 2 }">
	<div style="width: 92%; height: 73px; margin: 0 auto;border-bottom: 1px solid #e5e5e5;font-size: 12px;">
		<div style="width: 100%; height: 35px; margin-top: 24px;">
			<div style="height: 100%; float:left; ">
				<div>操作时间：<fmt:formatDate value="${p.charge_time }" pattern="yyyy-MM-dd HH:mm"/></div>
				<div style="padding-top: 10px;">消费：<font style="color: #ff4532;">${p.money }元</font></div>
			</div>
			<img src="imgs/arrow_rigth_deep_icon.png" style="width: 7px; height: 12px; float: right; margin-top: 20px;">
		</div>
	</div>
	</c:if>
</c:if>
<c:if test="${statue.last }">
	<c:if test="${p.type == 1 }">
	<div style="width: 92%; height: 92px; margin: 0 auto; font-size: 12px;">
		<div style="width: 100%; height: 55px; margin-top: 24px;">
			<div style="height: 100%; float:left; ">
				<div>操作时间：<fmt:formatDate value="${p.charge_time }" pattern="yyyy-MM-dd HH:mm"/></div>
				<div style="padding-top: 10px;">充值：${p.charge_money }元</div>
				<div style="padding-top: 10px;">实付：<font style="color: #57ceb1;">${p.money }元</font></div>
			</div>
			<img src="imgs/arrow_rigth_deep_icon.png" style="width: 7px; height: 12px; float: right; margin-top: 35px;">
		</div>
	</div>
	</c:if>
	<c:if test="${p.type == 2 }">
	<div style="width: 92%; height: 73px; margin: 0 auto; font-size: 12px;">
		<div style="width: 100%; height: 35px; margin-top: 24px;">
			<div style="height: 100%; float:left; ">
				<div>操作时间：<fmt:formatDate value="${p.charge_time }" pattern="yyyy-MM-dd HH:mm"/></div>
				<div style="padding-top: 10px;">消费：<font style="color: #ff4532;">${p.money }元</font></div>
			</div>
			<img src="imgs/arrow_rigth_deep_icon.png" style="width: 7px; height: 12px; float: right; margin-top: 20px;">
		</div>
	</div>
	</c:if>
</c:if>
</c:forEach>
</div>
<input type="hidden" value="3" id="bottom_index" name="bottom_index"/>
<jsp:include page="bottom.jsp"/>
</body>
</html>