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

function hereorderlist(){
	window.location.href ="./hereorderlist?is_out=0";
}

function orderdetail(order_id){
	window.location.href = "./orderdetail?order_id="+order_id;
}

function showmyaddress(){
	window.location.href = "./myaddress";
}

function showcards(){
	var flag = $("#flag").val();
	if(flag == 0){
		$("#flag").val("1");
		$("#cards_div").show();
	}else{
		$("#flag").val("0");
		$("#cards_div").hide();
	}
}

function getMyCards(){
	window.location.href = "./getMyCards";
}

function getMyCoupon(){
	window.location.href = "./getMyCoupon";
}

function showmycollect(){
	window.location.href = "./getMyCollect";
}
</script>
<title>我的</title>
</head>
<body>
<div style="width: 92%; height: 74px; margin: 0 auto; line-height: 74px;">
	<c:if test="${empty userinfo.avatar_url }">
		<img src="imgs/defalut_avatar_icon.png" style="width: 41px; height: 41px; margin-top: 16px; border-radius: 41px; float:left;">
	</c:if>
	<c:if test="${not empty userinfo.avatar_url }">
		<img src="${userinfo.avatar_url }" style="width: 41px; height: 41px; margin-top: 16px; border-radius: 41px; float:left;">
	</c:if>
	<div style="padding-left: 13px; font-size: 15px; float:left;">${userinfo.nick_name }</div>
</div>
<div class="interimdiv"></div>
<div style="width: 100%; min-height: 44px; border-bottom: 1px solid #e5e5e5; line-height: 44px;">
	<input type="hidden" value="0" id="flag"/>
	<div style="width: 4%; float:left; height: 44px;"  onclick="showcards()"></div>
		<div style="width: 92%; height: 44px;float:left;"  onclick="showcards()">
			<img src="imgs/card_icon.png" style="width: 18px; height: 14px; float:left; margin-top: 15px;">
			<div style="margin-left: 35px; height: 44px;  border-bottom: 1px solid #e5e5e5;">
			<div style="float:left; font-size: 14px;">我的卡券包</div>
			<img src="imgs/arrow_down_icon.png" style="width: 12px; height: 7px; float: right; margin-top: 18px;">
			</div>
		</div>
	<div style="width: 4%; float:left; height: 44px;border-bottom: 1px solid #e5e5e5;" id="mycard_right_div"  onclick="showcards()"></div>
	<div id="cards_div" style="display:none">
	<div style="clear: both; width: 100%; height: 41px;color: #857777; line-height: 40px;" onclick="getMyCards()">
		<div style=" width: 4%; float:left; height: 40px;"></div>
		<div style="width: 92%; height: 40px;float:left;">
			<div style="margin-left: 35px; height: 40px;  border-bottom: 1px solid #e5e5e5;">
			<div style="float:left; font-size: 12px;">充值卡</div>
			<img src="imgs/arrow_rigth_deep_icon.png" style="width: 7px; height: 12px; float: right; margin-top: 16px;">
			</div>
		</div>
		<div style=" width: 4%; float:left; height: 40px; border-bottom: 1px solid #e5e5e5;"></div>
	</div>
	<div style="clear: both; width: 100%; height: 40px; color: #857777;  line-height: 40px;" onclick="getMyCoupon()">
		<div style=" width: 4%; float:left; height: 40px;"></div>
		<div style="width: 92%; height: 40px;float:left;">
			<div style="margin-left: 18px; height: 40px;">
			<div style="float:left; padding-left: 17px; font-size: 12px;">优惠券</div>
			<img src="imgs/arrow_rigth_deep_icon.png" style="width: 7px; height: 12px; float: right; margin-top: 16px;">
			</div>
		</div>
		<div style=" width: 4%; float:left; height: 40px;"></div>
	</div>
	</div>
</div>
<div style="width: 100%; height: 44px; border-bottom: 1px solid #e5e5e5; line-height: 44px;" onclick="showmycollect()">
	<div style="width: 92%; height: 44px; margin: 0 auto;">
		<img src="imgs/collect_icon.png" style="width: 18px; height: 14px; float:left; margin-top: 15px;">
		<div style="float:left; padding-left: 17px; font-size: 14px;">我的收藏</div>
		<img src="imgs/arrow_rigth_deep_icon.png" style="width: 7px; height: 12px; float: right; margin-top: 16px;">
	</div>
</div>
<div style="width: 100%; height: 44px; border-bottom: 1px solid #e5e5e5; line-height: 44px;" onclick="showmyaddress()">
	<div style="width: 92%; height: 44px; margin: 0 auto;">
		<img src="imgs/bycicle_icon.png" style="width: 18px; height: 14px; float:left; margin-top: 15px;">
		<div style="float:left; padding-left: 17px; font-size: 14px;">外卖地址</div>
		<img src="imgs/arrow_rigth_deep_icon.png" style="width: 7px; height: 12px; float: right; margin-top: 16px;">
	</div>
</div>
<input type="hidden" value="3" id="bottom_index" name="bottom_index"/>
<jsp:include page="bottom.jsp"/>
</body>
</html>