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

function addaddress(){
	window.location.href = "./toaddress";
}

function checkAddress(id){
	window.location.href = "./checkAddress?id="+id;
}
</script>
<title>外卖地址</title>
</head>
<body>
<c:forEach items="${addresslist }" var="p">
<div style="width: 100%; height: auto; overflow: hidden; border-bottom: 1px solid #e5e5e5; ">
<div style="width: 92%; height: auto; margin: 0 auto; overflow: hidden; padding-bottom: 20px;">
	<div style="float: left; width: 77%;">
	<div style="width: 100%; height: 49px; line-height: 49px; font-size: 13px;"><span style="font-size: 17px;">${p.receiver }</span>&nbsp;&nbsp;${p.phone }</div>
	<div style="width: 100%; height: auto; overflow: hidden; font-size: 13px; word-break:break-all;">${p.province}${p.city}${p.area}${p.address }</div>
	</div>
	<div style="float: right; width: 23%;" onclick="checkAddress(${p.id})">
	<c:if test="${p.is_default == 1 }">
		<img src="imgs/check_select_icon.png" style="float: right; width: 21px; height: 12px; margin-top: 40px;">
	</c:if>
	<c:if test="${p.is_default == 0 }">
		<img src="imgs/check_none_icon.png" style="float: right; width: 21px; height: 12px; margin-top: 40px;">
	</c:if>
	</div>
</div>
</div>
</c:forEach>
<div style="height: 60px;"></div>
<div style="position: fixed; bottom: 0px; width: 100%; height: 48px; background: #fff;">
<div style="position: absolute; bottom: 10px; width: 92%; height: 38px; left: 4%; background: #857777; color: #fff; text-align: center; line-height: 38px; font-size: 15px;" onclick="addaddress()">添加配送地址</div>
</div>
</body>
</html>