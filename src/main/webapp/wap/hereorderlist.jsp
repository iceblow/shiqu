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
var myScroll;
function loaded() {
	myScroll = new iScroll('wrapper',{ onScrollEnd: function () {  
        //如果滑动到底部，则加载更多数据（距离最底部10px高度）  
        if ((this.y - this.maxScrollY) <5) {
             pullhereOrderUpAction();   
        }  
    } ,vScroll:true,vScrollbar:false});
}
document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
document.addEventListener('DOMContentLoaded', function () { setTimeout(loaded, 100); }, false); 

function hereorderlist(){
	window.location.href ="./hereorderlist?is_out=0";
}

function outorderlist(){
	window.location.href ="./outorderlist?is_out=1";
}

function orderdetail(order_id){
	window.location.href = "./orderdetail?order_id="+order_id;
}
</script>
<title>堂食</title>
</head>
<body>
<div style="height: 44px; width: 100%; background: #fff; position: fixed; z-index: 101;">
<div style="float:left; width: 50%; border-bottom: 1px solid #ff8854; font-size: 15px; text-align: center; line-height: 43px;" onclick="hereorderlist()">堂食</div>
<div style="float:left; width: 50%; border-bottom: 1px solid #f9f9f9; font-size: 15px; text-align: center; line-height: 43px;" onclick="outorderlist()">外卖</div>
</div>
<div id="wrapper" style="margin-bottom: 49px;">
<div id="scroller">
<div class="orderlist">
<c:forEach items="${orderlist }" var="p" varStatus="ostatus">
<div style="width: 100%; height: 182px; background: #fff;" onclick="orderdetail(${p.order_id})">
	<div style="width: 92%; height: 182px; margin: 0 auto;">
	<div style="width: 100%; height: 14px; text-align: center; margin-top: 15px;">
		<img src="imgs/small_store_icon.png" style="width: 14px; height: 14px;">
	</div>
	<div style="width: 100%; height: 43px; text-align: center; line-height: 43px; color: #ffba3f; font-size: 17px; border-bottom: 1px solid #e5e5e5;">${p.store.store_name }</div>
	<div style="width: 100%; height: 40px; text-align: left; line-height: 40px; font-size: 14px; overflow: hidden; ">
	<c:forEach items="${p.menu_list }" var="m" begin="0" end="1" varStatus="mstatus">
	<c:if test="${mstatus.last }">
	${m.menu_name }
	</c:if>
	<c:if test="${not mstatus.last }">
	${m.menu_name }、
	</c:if>
	</c:forEach>
	<c:if test="${fn:length(p.menu_list) > 2}">等${fn:length(p.menu_list)}样菜</c:if>
	</div>
	<div style="width: 100%; height: 25px; text-align: left; font-size: 12px; color: #cfcfcf;border-bottom: 1px solid #e5e5e5;">
	时间:<c:if test="${not empty p.check_time }"><fmt:formatDate value="${p.check_time }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;&nbsp;结账</c:if><c:if test="${empty p.check_time }"><fmt:formatDate value="${p.order_time }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;&nbsp;下单</c:if>
	</div>
	<div style="height: 41px; line-height: 41px; float:left;">
		<span style="text-align: left;">金额：<font style="color: #ff4532;"> ${p.total_price }元</font></span>
	</div>
	<div style="height: 41px; line-height: 41px; float:right;">
		<span style="text-align: right; color:#857777;">堂食：
		<c:if test="${p.state == 3 }"><font style="color: #ff837a;">店家拒单</font></c:if>
		<c:if test="${p.state == 4 }"><font style="color: #12c6d1;">已付款 </font></c:if>
		<c:if test="${p.state == 5 }"><font style="color: #ccc7c7;">取消 </font></c:if>
		</span>
	</div>
	</div>
</div>
<c:if test="${not ostatus.last }">
<div style="background: #f0f0f0; width: 100%; height: 9px;"></div>
</c:if>
</c:forEach>
</div>
<c:if test="${empty orderlist}">
<div id="load_more" class="load_more"><span id="loadmorecontent">暂无订单</span></div>
</c:if>
<c:if test="${not empty orderlist}">
	<c:if test="${fn:length(orderlist) >= pageSize }">
		<div id="load_more" class="load_more"><span id="loadmorecontent">下拉加载更多</span></div>
	</c:if>
</c:if>
</div>
</div>
<input type="hidden" value="1" id="pageIndex">
<input type="hidden" value="0" id="pushflg">
<input type="hidden" value="2" id="bottom_index" name="bottom_index"/>
<jsp:include page="bottom.jsp"/>
</body>
</html>