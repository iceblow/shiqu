<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<link rel="stylesheet" href="css/outlessorder.css" type="text/css" media="screen">
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<title>外卖订单</title>
</head>
<body>
<div style="width:100%;height:90px;line-height:90px;color:#d6d6d6;font-size:16px;border-bottom:1px solid #ebebeb;">
<div style="float:left;width:50%;height:90px;">
<div style="margin-top:35px;width:60px;height:20px;line-height:20px;color:#000000;float:right;box-sizing:border-box;border-right:1px solid #ebebeb;" onclick="turnoutlessorder()">
堂食
</div>
<img src="./imgs/outunselect.png" width=22px style="margin-top:35px;float:right;margin-right:10px;" onclick="turnoutlessorder()">
</div>
<div style="float:left;width:50%;height:90px;">
<img src="./imgs/outselect.png" width=22px style="margin-top:35px;float:left;margin-left:30px;">

<div style="margin-top:35px;width:60px;height:20px;line-height:20px;color:#000000;float:left;margin-left:10px;box-sizing:border-box;">
外卖
</div>
</div>
</div>

<form id="labelForm" action="addorder" method="post">
<input type="hidden" value="${store.store_id }" name="store_id">
<input type="hidden" value="1" name="is_out">
<input type="hidden" value="${allprice}" name="allprice" >
<div class="content">
<font>配送时间</font>
<select name="send_time"  id="peoplenum" style="color:#ff4532;float:right;-webkit-appearance: none;border:none;font-size:14px;" id="peopleselect">
<option value="">尽快送达</option>
 <c:forEach items="${timechoose}" var="p">
<option value="${p }">${p }</option>
 </c:forEach>
</select>
</div>
<c:if test="${not empty deliveryaddress }">
<div style="width: 92%; height: auto; margin: 0 auto;  padding-bottom: 20px;" onclick="turnselectaddress()">
	<div style="width: 100%; height: 49px; line-height: 49px; font-size: 13px;"><span style="font-size: 17px;">${deliveryaddress.receiver }</span>&nbsp;&nbsp;${deliveryaddress.phone }
	<img src="imgs/arrow_right_icon.png" style="width: 7px; height: 12px; float: right;    margin-top: 19px;">
	</div>
	<div style="width: 100%; height: auto; overflow: hidden; font-size: 13px;">${deliveryaddress.province}${deliveryaddress.city}${deliveryaddress.area}${deliveryaddress.address }</div>
</div>
<input type="hidden" name="phone" value="${deliveryaddress.phone }">
<input type="hidden" name="address" value="${deliveryaddress.province}${deliveryaddress.city}${deliveryaddress.area}${deliveryaddress.address }">
<input type="hidden" name="ordername" value="${deliveryaddress.receiver }">
<input type="hidden" name="addressid" id="addressid" value="${deliveryaddress.id }">
</c:if>
<c:if test="${empty deliveryaddress }">
<div style="width: 92%; height: auto; margin: 0 auto;  padding-bottom: 20px;" onclick="turnselectaddress()">
	<div style="width: 100%; height: 49px; line-height: 49px; font-size: 13px;"><span style="font-size: 17px;">选择配送地址</span>
	<img src="imgs/arrow_right_icon.png" style="width: 7px; height: 12px; float: right;    margin-top: 19px;">
	</div>
</div>
<input type="hidden"  value="" id="addressid" name="addressid">
</c:if>
<img src="./imgs/outborder.png" style="width:100%;height:5px;">
<div class="menucontent" style="font-size:12px;">
菜单
</div>
 <c:forEach items="${menulist}" var="p">
<div class="menucontent" >
<font style="font-size:16px;">${p.name }</font>
<font style="margin-left:15px;color:#857777;">x${p.quantity }</font>
<font style="float:right;">${p.price }元</font>
</div>
<input type="hidden" name="menuids" value="${p.menu_id }">
<input type="hidden" name="quantitys" value="${p.quantity }">
</c:forEach>
<div class="content" style="text-align:center;font-size:12px;">
共${fn:length(menulist)}个菜&nbsp;总价:&nbsp;<font style="color:#ff4532">${allprice }元</font><c:if test="${store.send_money>0 }"><font>(含外卖费${store.send_money }元)</font></c:if>
</div>
<div style="text-align:center;padding-top:12px;height:34px;padding-bottom:70px;">
<input type="text" name="comment" style="font-size:14px;border: 1px solid #e5e5e5;border-radius:4px; -webkit-appearance: none;height:30px;line-height:30px;width:90%" placeholder="备注：" >
</div>

<div class="bottom_order">
	<div style="width: 100%; height: 50px; margin: 0 auto;">
		<div style="float:left;margin-left:12px;height:50px;line-height:50px;color:#ffffff">注：就餐后再付款</div>
		<div class="addbtn" onclick="addorder()">下单</div>
	</div>
</div>

</form>

<div id="dialog" class="dialog" style="display:none;">
</div>

</body>
<script type="text/javascript">
function addorder(){
	var addressid = $("#addressid").val();
	if(addressid==''){
		dialogFadeIn("53%","请选择外卖地址!");
	 	setTimeout("dialogFadeOut()",2000);
		return;
	}
	$("#labelForm").submit();
}

function turnoutlessorder(){
	$("#labelForm").attr("action","makeorder").submit();
}

function turnselectaddress(){
	$("#labelForm").attr("action","outaddress").submit();
}
</script>
</html>