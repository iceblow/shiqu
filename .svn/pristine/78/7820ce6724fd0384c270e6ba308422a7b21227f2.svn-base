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
	$(function(){
		var is_out = $("#is_out").val();
		if(is_out == 0){
			$("#herediv").show();
			$("#outdiv").hide();
		}else{
			$("#outdiv").show();
			$("#herediv").hide();
		}
	});
	function cancelorder(order_id){
		$.ajax({
			type: "post",
			url: "./cancelorder",
			data: {order_id :order_id},
			success: function(msg){
				var msgdata = eval("("+msg+")");
				var code = msgdata.code;
				if(code != 1){
					$(".messgealert").text(msgdata.message);
					$(".mask").show();
					$(".messgealert").css("top",document.documentElement.clientHeight/2-$(".alert").height()/2);
					$(".messgealert").css("left",document.documentElement.clientWidth/2-$(".alert").width()/2);
					$(".messgealert").show();
					hidealert();
					 history.back();
				}else{
					window.location.href = "./orderdetail?order_id="+order_id;
				}
			}
		});
	}
	
	function hidealert(){
		 setTimeout(function(){
			 $(".mask").hide();
			 $(".messgealert").hide();
		},2000);
	 }
	
	function selectcoupon(order_id, coupon_id){
		window.location.href = "./selectcoupon?order_id="+order_id+"&coupon_id="+coupon_id;
	}
</script>
<title>订单详情</title>
</head>
<body>
<div class="order_detail_top">
	<input type="hidden" value="${order.is_out }" id="is_out"/>
	<div style="width: 92%; height: 100%; margin: 0 auto;">
	<img src="imgs/small_store_2icon.png" style="width: 13px; height: 14px; margin-top: 20px; float:left;">
	<div style="float:left; font-size: 14px; line-height: 54px; margin-left: 10px;">${order.store.store_name }</div>
	<a href="tel:${order.store.phone }"><img src="imgs/phone_icon.png" style="width: 24px; height: 24px; margin-top: 15px; float:right; cursor: pointer;"></a>
	</div>
</div>
<div class="interimdiv"></div>
<div style="width: 100%; height: 48px; line-height: 48px; font-size: 14px; border-bottom: 1px solid #f0f0f0">
<div style="width: 92%; height: 100%; margin: 0 auto;">
	<div style="float:left;">支付方式</div>
	<img src="imgs/arrow_right_icon.png" style="width: 7px; height: 12px; margin-top: 18px; float: right;">
	<div style="float:right	; color: #ff4532; margin-right: 10px;">微信支付</div>
</div>
</div>
<div style="width: 100%; height: 48px; line-height: 48px; font-size: 14px;">
<c:if test="${conponcount == 0}">
<div style="width: 92%; height: 100%; margin: 0 auto;">
	<div style="float:left;">优惠券</div>
	<img src="imgs/arrow_right_icon.png" style="width: 7px; height: 12px; margin-top: 18px; float: right;">
	<div style="float:right	; color: #ff4532; margin-right: 10px; color: #857777; font-size: 12px;">没有可用优惠券</div>
</div>
</c:if>
<c:if test="${conponcount != 0}">
<div style="width: 92%; height: 100%; margin: 0 auto;" >
	<div style="float:left;">优惠券</div>
	<img src="imgs/arrow_right_icon.png" style="width: 7px; height: 12px; margin-top: 18px; float: right;">
	<c:if test="${empty coupon }">
	<div style="float:right	; color: #ff4532; margin-right: 10px; color: #857777; font-size: 12px;" onclick="selectcoupon(${order.order_id},0)">有${conponcount }张可用优惠券</div>
	</c:if>
	<c:if test="${not empty coupon }">
	<div style="float:right	; color: #ff4532; margin-right: 10px; color: #857777; font-size: 12px;" onclick="selectcoupon(${order.order_id}, ${coupon.coupon_id})">${coupon.description }</div>
	</c:if>
</div>
</c:if>
</div>
<div class="interimdiv"></div>
<div id="herediv">
<div class="order_detail_center">
	<div style="float:left;">餐位情况</div>
	<c:if test="${empty order.table_no }">
		<div style="float:right; color: #bfbebe;">尚未确认</div>
	</c:if>
	<c:if test="${not empty order.table_no }">
		<div style="float:right; color: #ff4532;">${order.table_no }</div>
	</c:if>
</div>
<div class="order_detail_center">
	<div style="float:left;">姓名</div>
	<div style="float:right; color: #ff4532;">${order.order_name }</div>
</div>
<div class="order_detail_center">
	<div style="float:left;">联系电话</div>
	<div style="float:right; color: #ff4532;">${order.phone }</div>
</div>
<div class="order_detail_center" style="border: 0px;">
	<div style="float:left;">下单时间</div>
	<div style="float:right; color: #bfbebe;"><fmt:formatDate value="${order.order_time }" pattern="yyyy-MM-dd HH:mm:ss"/></div>
</div>
<div class="interimdiv"></div>
</div>
<div class="order_detail_center">
	<div style="float:left;">菜单&nbsp;&nbsp;共${fn:length(order.menu_list)}个菜 </div>
</div>
<c:forEach items="${order.menu_list }" var="m">
<div class="order_detail_center">
	<div style="float:left;">${m.menu_name}</div>
	<div style="float:left; color: #857777; margin-left: 13px;">X${m.quantity}</div>
	<div style="float:right;">${m.price}元</div>
</div>
</c:forEach>
<div id="outdiv" style="font-size: 12px;">
	<div class="order_detail_center" style="color: #998d8d;">
	<div style="float:left;">外送费</div>
	<div style="float:right;">${order.send_money}元</div>
	</div>
	<div style="width: 100%; background: #f9fafa; pading-bottom: 10px;">
	<div style="width: 92%; margin: 0 auto;background: #f9fafa; padding-bottom: 10px;">
		<div style="width: 100%; height: 46px; line-height: 46px;">
		<div style="float: left; width: 25%;text-align: left; min-width: 62px;"><font style="letter-spacing:24px;">姓</font>名：</div>
		<div style="float: left; width: 75%;">${order.order_name}</div>
		</div>
		<div style="width: 100%; height: 26px;">
		<div style="float: left; width: 25%;text-align: left; min-width: 62px;"><font style="letter-spacing:24px;">电</font>话：</div>
		<div style="float: left; width: 75%;">${order.phone}</div>
		</div>
		<div style="width: 100%; height: auto;overflow:hidden; padding-bottom: 10px;">
		<div style="float: left; width: 25%;text-align: left; min-width: 62px;"><font style="letter-spacing:24px;">地</font>址：</div>
		<div style="float: left; width: 75%;text-align: left; line-height: 14px; word-break:break-all;">${order.address}</div>
		</div>
		<div style="width: 100%; height: 26px;">
		<div style="float: left; width: 25%;text-align: left; min-width: 62px;">送达时间：</div>
		<div style="float: left; width: 75%;text-align: left; line-height: 14px; word-break:break-all;">${order.send_time}</div>
		</div>
		<div style="width: 100%; height: auto;overflow:hidden;">
		<div style="float: left; width: 25%;text-align: left; min-width: 62px;"><font style="letter-spacing:24px;">备</font>注：</div>
		<div style="float: left; width: 75%;text-align: left; line-height: 14px;word-break:break-all;">
			<c:if test="${empty order.comment }">暂无</c:if>
			<c:if test="${not empty order.comment }">${order.comment }</c:if>
		</div>
		</div>
	</div>
	</div>
</div>
<div style="width: 100%; height: 60px;"></div>
<div class="order_detail_bottom">
<div style="width: 92%; height: 60px; margin: 0 auto; line-height: 60px;">
	<div style="float:left; color: #fff; font-size: 19px;">${order.total_price}元</div>
	<div style="float:right; margin-top: 13px;" class="paybutton">付款</div>
	<div style="float:right; margin-right: 10px; margin-top: 13px;" class="cancelbutton" onclick="cancelorder(${order.order_id})">取消</div>
</div>
</div>
</body>
<div class="mask" style="display: none;"></div>
<div class="messgealert" style="top: 10px;display: none;"></div>
</html>