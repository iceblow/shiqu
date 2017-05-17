<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="js/dialog.js"></script>
<link rel="stylesheet" href="css/store.css" type="text/css" media="screen">
<title>店铺详情</title>
</head>
<body>
<div style="position:fixed;top:0px;width:100%;height:45px;line-height:45px;background-color:#ffffff">
<div class="topdiv " onclick="turnmenu(${store.store_id})">菜单</div>
<div class="topdiv topselect"  >店铺</div>
</div>
<div style="margin-top:45px;border-bottom: 1px solid #e5e5e5;padding-top:15px;padding-bottom:15px;height: auto; overflow: hidden;">


<div style="padding-left:12px;height:65px;float:left;">
<img src="${store.pic_url }" width=65px height=65px style="float:left;">
</div>
<div style="float:left;margin-left:10px;">
<font style="font-size:15px;">
${store.store_name }
</font>
<p style="margin-top:10px;margin-bottom:3px;color:#857777;font-size:12px;">
${store.sales_num }总销量&nbsp;${store.category_name }
</p>
<p style="margin:0;color:#857777;font-size:12px;">
营业时间&nbsp;${store.open_time }-${store.close_time }
</p>
</div>
<div style="float:right;border-left: 1px solid #e5e5e5;height:65px;width:65px;text-align:center;" onclick="collectstore(${store.store_id})">
<c:if test="${store.is_collect==1 }">
<img src="./imgs/collect.png" width=23px style="margin-left: 21px; margin-right: 21px;margin-top:10px;margin-bottom:8px;" id="collectimg">
<font style="font-size:10px;color:#404040;" id="collecttext">取消收藏</font>
</c:if>
<c:if test="${store.is_collect==0 }">
<img src="./imgs/nocollect.png" width=23px style="margin-left: 21px; margin-right: 21px;margin-top:10px;margin-bottom:8px;" id="collectimg">
<font style="font-size:10px;color:#404040;" id="collecttext">收藏店铺</font>
</c:if>
</div>
</div>
<div style="border-bottom: 1px solid #e5e5e5;padding-left:12px;padding-right:12px;clear:both;padding-top:15px;padding-bottom:15px;height: auto; overflow: hidden;">
<div style="float:left">
<img src="./imgs/bell.png" width=15px; style="float:left">
</div>
<div style="margin-left: 30px;">
<font style="color:#404040;font-size:12px;">
${store.intro }
</font>
</div>
</div>

<div style="border-bottom: 1px solid #e5e5e5;padding-left:12px;padding-right:12px;clear:both;padding-top:15px;padding-bottom:15px;height: auto; overflow: hidden;">
<div style="float:left">
<img src="./imgs/map.png" width=15px; style="float:left">
</div>
<div style="margin-left: 30px;">
<font style="color:#404040;font-size:12px;">
${store.address }
</font>
</div>
</div>

<c:if test="${piclistsize>0 }">
<div style="border-bottom: 1px solid #e5e5e5;padding-left:12px;padding-right:12px;clear:both;padding-top:15px;padding-bottom:15px;height: auto; overflow: hidden;">
<div style="float:left">
<img src="./imgs/pic.png" width=15px; style="float:left">
</div>
<div style="margin-left: 30px;">
<c:forEach items="${store.storepic_list }" var="m">
<img src="${m.img_url }" width=100%; style="margin-bottom:10px;">
</c:forEach>
</div>
</div>
</c:if>

<div style="text-align: center;background-color:#f9fafa;padding-left:12px;padding-right:12px;clear:both;padding-top:15px;height: auto; overflow: hidden;">
<div style="padding-bottom:15px;border-bottom: 1px solid #e5e5e5;">领取本店优惠券</div>
<c:forEach items="${couponlist }" var="p">
<div style="padding-top:15px;padding-bottom:15px;border-bottom: 1px solid #e5e5e5;text-align:left;">
<font style="color:#ff4532;font-size:26px">${ p.amount}</font>
<font style="color:#ff4532;font-size:12px;">元</font>
<c:if test="${p.is_geted==0 }">
<div style="float:right;width:59px;height:23px;line-height:23px;border:1px solid #ffba3f;color:#ffba3f;text-align:center;border-radius:12px;" onclick="getCoupon(${p.coupon_id })" id="couponbtn_${p.coupon_id }">领取</div>
</c:if>
<c:if test="${p.is_geted==1 }">
<div style="float:right;width:59px;height:23px;line-height:23px;border:1px solid #ececec;color:#ececec;text-align:center;border-radius:12px;">已领取</div>
</c:if>
<p style="margin-top:10px;margin-bottom:7px;color:#404040;font-size:12px;">
${p.description }
</p>
<p style="margin:0;font-szie:12px;color:#857777;">
使用期限 <fmt:formatDate value="${p.from_time }" pattern="yyyy.MM.dd" /> - <fmt:formatDate value="${p.end_time }" pattern="yyyy.MM.dd" />
</p>
</div>
</c:forEach>
</div>

<div id="dialog" class="dialog" style="display:none;">

</div>
</body>
<script>
function turnmenu(store_id){
	window.location.href = "./storedetail?store_id="+store_id;
}

function collectstore(store_id){
	$.ajax({
		url:'./collectStore',
		data:{'store_id':store_id},
		type:"post",
		success:function(msg){
			if(msg.code==0){
				dialogFadeIn("53%","收藏成功");
			 	setTimeout("dialogFadeOut()",2000);
			 	$("#collecttext").text("取消收藏");
				$("#collectimg").attr('src',"./imgs/collect.png"); 
			}else{
				dialogFadeIn("53%","取消收藏成功");
			 	setTimeout("dialogFadeOut()",2000);
			 	$("#collecttext").text("收藏店铺");
			 	$("#collectimg").attr('src',"./imgs/nocollect.png"); 
			}
		}
	})
}

function getCoupon(coupon_id){
	$.ajax({
		url:'./getcoupon',
		data:{'coupon_id':coupon_id},
		type:"post",
		success:function(msg){
				dialogFadeIn("53%","领取成功");
			 	setTimeout("dialogFadeOut()",2000);
			 	$("#couponbtn_"+coupon_id).css("border","1px solid #ececec");
				$("#couponbtn_"+coupon_id).css("color","#ececec");
				$("#couponbtn_"+coupon_id).text("已领取");
				$("#couponbtn_"+coupon_id).removeAttr("onclick");
		}
	})
}
// $(function(){
// 	dialogFadeIn("53%","丢雷老母");
// 	setTimeout("dialogFadeOut()",2000);
// })
</script>
</html>