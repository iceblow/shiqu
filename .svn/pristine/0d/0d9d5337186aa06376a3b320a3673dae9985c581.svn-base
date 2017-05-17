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
<script type="text/javascript" src="js/dialog.js"></script>
<script type="text/javascript">
$(function(){
// 	$("#city").citySelect({prov:"", city:"", dist:""}); 
});
function hereorderlist(){
	window.location.href ="./hereorderlist?is_out=0";
}

function orderdetail(order_id){
	window.location.href = "./orderdetail?order_id="+order_id;
}

function showmyaddress(){
	window.location.href = "./myaddress";
}

function addaddress(){
	window.location.href = "./addaddress";
}

function selectcity(){
	var parent_id = $("#province").val();
	if(parent_id == ""){
		var html = '';
		$("#city").empty();
		html += '<option value="">请选择</option>';
		$("#city").append(html);
		$("#area").empty();
		$("#area").append(html);
	}else{
		$.ajax({
			type: 'post',
			url: "./selectcity",
			data: {parent_id :parent_id, type :0},
			success: function(msg){
				var msgdata = eval("("+msg+")");
				var citylist = msgdata.citylist;
				var arealist = msgdata.arealist;
				var html = '';
				var html2 = '';
				$("#city").empty();
// 				html += '<option value="">请选择</option>';
				for(var i=0;i<citylist.length;i++){
					html += '<option value="'+citylist[i].id+'">'+citylist[i].name+'</option>';
				}
				$("#city").append(html);
				$("#area").empty();
				if(arealist != null && arealist.length > 0){
					for(var i=0;i<arealist.length;i++){
						html2 += '<option value="'+arealist[i].id+'">'+arealist[i].name+'</option>';
					}
					$("#area").append(html2);
				}else{
					html2 += '<option value="">请选择</option>';
					$("#area").append(html2);
				}
			}
		});
	}
}

function selectArea(){
	var parent_id = $("#city").val();
	if(parent_id == ""){
		var html = '';
		$("#area").empty();
		html += '<option value="">请选择</option>';
		$("#area").append(html);
	}else{
		$.ajax({
			type: 'post',
			url: "./selectcity",
			data: {parent_id :parent_id},
			success: function(msg){
				var msgdata = eval("("+msg+")");
				var citylist = msgdata.citylist;
				var html = '';
				$("#area").empty();
//	 			html += '<option value="">请选择</option>';
				for(var i=0;i<citylist.length;i++){
					html += '<option value="'+citylist[i].id+'">'+citylist[i].name+'</option>';
				}
				$("#area").append(html);
			}
		});
	}
}

function addaddress(){
	var receiver = $("#receiver").val();
	if(receiver == ""){
		dialogFadeIn("53%","收货人不能为空");
	 	setTimeout("dialogFadeOut()",2000);
		return;
	}
	var phone = $("#phone").val();
	if(phone == ""){
		dialogFadeIn("53%","手机号不能为空");
	 	setTimeout("dialogFadeOut()",2000);
		return;
	}
	var reg = /^0?1[3|4|5|8][0-9]\d{8}$/;
	if(!reg.test(phone)){
		dialogFadeIn("53%","手机号格式不正确");
	 	setTimeout("dialogFadeOut()",2000);
		return;
	}
	
	var address = $("#address").val();
	if(address == ""){
		dialogFadeIn("53%","详细地址不能为空");
	 	setTimeout("dialogFadeOut()",2000);
		return;
	}
	$("#delivery").submit();
}

</script>
<style type="text/css">
::-webkit-input-placeholder { /* WebKit browsers */ 
color: #a69d9d; 
} 
:-moz-placeholder { /* Mozilla Firefox 4 to 18 */ 
color: #a69d9d; 
} 
::-moz-placeholder { /* Mozilla Firefox 19+ */ 
color: #a69d9d; 
} 
:-ms-input-placeholder { /* Internet Explorer 10+ */ 
color: #a69d9d; 
}
</style>
<title>添加地址</title>
</head>
<body>
<form action="./addAddress" method="post" id="delivery">
<div class="addressdetail">
	<div class="address_detail_left">收货人</div>
	<div class="address_detail_right"><input class="address_detail_right_input" placeholder="请输入" name="receiver" id="receiver"></div>
</div>
<div class="addressdetail">
	<div class="address_detail_left">手机号</div>
	<div class="address_detail_right"><input class="address_detail_right_input" placeholder="请输入" name="phone" id="phone" maxlength="11"></div>
</div>
<div class="addressdetail">
	<div class="address_detail_left">省份</div>
	<div class="address_detail_right">
	<select id="province" name="province_id" class="prov areaselect" onchange="selectcity()">
		<option value="">请选择</option>
		<c:forEach items="${prolist }" var="p">
			<option value="${p.id}">${p.name}</option>
		</c:forEach>
	</select>
	</div>
</div>
<div class="addressdetail">
	<div class="address_detail_left">城市</div>
	<div class="address_detail_right">
	<select id="city" name="city_id" class="city areaselect" onchange="selectArea()">
		<option value="">请选择</option>
	</select>
	</div>
</div>
<div class="addressdetail">
	<div class="address_detail_left">区域</div>
	<div class="address_detail_right">
	<select id="area" name="area_id" class="dist areaselect">
		<option value="">请选择</option>
	</select>
	</div>
</div>
<div class="addressdetail">
	<div class="address_detail_left">详细地址</div>
	<div class="address_detail_right"><input class="address_detail_right_input"  placeholder="请输入" name="address" id="address"></div>
</div>
<div style="height: 48px;"></div>
<div style="bottom: 10px; width: 92%; height: 38px; margin: 0 auto; background: #ff8854; color: #fff; text-align: center; line-height: 38px; font-size: 15px;" onclick="addaddress()">确定添加</div>
</form>
</body>
<div id="dialog" class="dialog" style="display:none;">
</div>
</html>