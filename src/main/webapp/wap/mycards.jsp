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
<title>充值卡</title>
</head>
<body>
<div style="padding-bottom: 60px;">
<c:forEach items="${cardlist }" var="p" varStatus="statue">
<c:if test="${not statue.last }">
	<div style="width: 92%; height: 81px;margin: 0 auto; border-bottom: 1px solid #e5e5e5;" onclick="showrechargeRecord(${p.id })">
		<div style="width: 100%; height: 41px; margin-top: 24px; line-height: 32px;">
			<div style="width: 69%; height: 100%; line-height: 41px; float:left; font-size: 15px;">
				<img src="${p.store.pic_url }" style="width: 41px; height: 41px; float:left; border-radius: 8px;">
				<div style="padding-left: 15px; float:left;">${p.store.store_name }</div>
			</div>
			<div style="width: 1px; height: 32px; margin-top: 4px;  border-right: 1px solid #e5e5e5; float:left;"></div>
			<div style="width: 30%; height: 100%; float:right; text-align: right;">
				<div style="height: 20px; color: #cfcfcf; font-size: 12px; line-height: 12px;">余额</div>
				<div style="height: 21px; color: #ff4532; font-size: 15px; line-height: 12px;">${p.money }元</div>
			</div>
		</div>
	</div>
</c:if>
<c:if test="${statue.last }">
	<div style="width: 92%; height: 81px; margin: 0 auto;" onclick="showrechargeRecord(${p.id })">
		<div style="width: 100%; height: 41px; margin-top: 24px; line-height: 32px;">
			<div style="width: 69%; height: 100%; line-height: 41px; float:left; font-size: 15px;">
				<img src="${p.store.pic_url }" style="width: 41px; height: 41px; float:left; border-radius: 8px;">
				<div style="padding-left: 15px; float:left;">${p.store.store_name }</div>
			</div>
			<div style="width: 1px; height: 32px; margin-top: 4px;  border-right: 1px solid #e5e5e5; float:left;"></div>
			<div style="width: 30%; height: 100%; float:right; text-align: right;">
				<div style="height: 20px; color: #cfcfcf; font-size: 12px; line-height: 12px;">余额</div>
				<div style="height: 21px; color: #ff4532; font-size: 15px; line-height: 12px;">${p.money }元</div>
			</div>
		</div>
	</div>
</c:if>
</c:forEach>
</div>
<input type="hidden" value="3" id="bottom_index" name="bottom_index"/>
<jsp:include page="bottom.jsp"/>
</body>
</html>