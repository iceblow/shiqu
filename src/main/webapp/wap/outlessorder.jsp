<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<script type="text/javascript" src="js/dialog.js"></script>
<title></title>
</head>
<body>
<c:if test="${store.is_out == 0 }">
<div style="width:100%;height:90px;line-height:90px;text-align:center;color:#d6d6d6;font-size:16px;border-bottom:1px solid #ebebeb;">
 此店铺支持堂食
</div>
</c:if>
<c:if test="${store.is_out == 1 }">
<div style="width:100%;height:90px;line-height:90px;color:#d6d6d6;font-size:16px;border-bottom:1px solid #ebebeb;">
<div style="float:left;width:50%;height:90px;">
<div style="margin-top:35px;width:60px;height:20px;line-height:20px;color:#000000;float:right;box-sizing:border-box;border-right:1px solid #ebebeb;">
堂食
</div>
<img src="./imgs/outselect.png" width=22px style="margin-top:35px;float:right;margin-right:10px;">
</div>
<div style="float:left;width:50%;height:90px;">
<img src="./imgs/outunselect.png" width=22px style="margin-top:35px;float:left;margin-left:30px;" onclick="turnoutorder()">

<div style="margin-top:35px;width:60px;height:20px;line-height:20px;color:#000000;float:left;margin-left:10px;box-sizing:border-box;" onclick="turnoutorder()">
外卖
</div>
</div>
</div>
</c:if>
<form id="labelForm" action="addorder" method="post">
<input type="hidden" value="${store.store_id }" name="store_id">
<input type="hidden" value="0" name="is_out">
<input type="hidden" value="${allprice}" name="allprice" >
<div class="content">
<font>就餐人数</font>
<select name="peoplenum"  id="peoplenum" style="float:right;-webkit-appearance: none;border:none;font-size:14px;color:#d6d6d6" id="peopleselect">
<option value="0">未填</option>
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<option value="11">11</option>
<option value="12">12</option>
<option value="13">13</option>
<option value="14">14</option>
<option value="15">15</option>
<option value="16">16</option>
<option value="17">17</option>
<option value="18">18</option>
<option value="19">19</option>
<option value="20">20</option>
</select>
</div>
<div style="height:5px;width:100%;background-color:#f4f4f4;">
</div>
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
共${fn:length(menulist)}个菜&nbsp;总价:&nbsp;<font style="color:#ff4532">${allprice }元</font>
</div>
<div style="text-align:center;padding-top:12px;height:34px;padding-bottom:70px;">
<input type="text" name="comment"  style="font-size:14px;border: 1px solid #e5e5e5;border-radius:4px; -webkit-appearance: none;height:30px;line-height:30px;width:90%" placeholder="备注：" >
</div>

<div class="bottom_order">
	<div style="width: 100%; height: 50px; margin: 0 auto;">
		<div style="float:left;margin-left:12px;height:50px;line-height:50px;color:#ffffff">注：就餐后再付款</div>
		<div class="addbtn" onclick="addorder()">下单</div>
	</div>
</div>

<div id="dialog" class="dialog" style="display:none;">
</div>
</form>
</body>
<script>
function addorder(){
	var peoplenum = $("#peoplenum").val();
	if(peoplenum==0){
		dialogFadeIn("53%","请选择人数!");
	 	setTimeout("dialogFadeOut()",2000);
		return;
	}
	$("#labelForm").submit();
}

function turnoutorder(){
	$("#labelForm").attr("action","outorder").submit();
}
</script>
</html>