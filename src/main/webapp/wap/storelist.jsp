<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<link rel="stylesheet" href="css/store.css" type="text/css" media="screen">
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<link rel="stylesheet" href="iscroll/iscroll2.css">
<script type="text/javascript" src="iscroll/iscroll.js"></script>
<script type="text/javascript" src="iscroll/storeListIscroll.js"></script>
<script type="text/javascript">

function storedetail(id){
	window.location.href = "./storedetail?store_id="+id;
}
	

 var myScroll;
function loaded() {
	myScroll = new iScroll('wrapper',{ onScrollEnd: function () {  
        //如果滑动到底部，则加载更多数据（距离最底部10px高度）  
        if ((this.y - this.maxScrollY) <5) {
             pullUpAction();   
        }  
    } ,vScroll:true,vScrollbar:false});
}
document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
document.addEventListener('DOMContentLoaded', function () { setTimeout(loaded, 100); }, false); 
 

function showPosition(position)
 {
	var url2 = "http://api.map.baidu.com/geoconv/v1/?coords="+position.coords.longitude+ "," +position.coords.latitude+
		"&from=1&to=5&ak=N0qQQgEE7fAe8boAQOdkxvBl";
	$.ajax({ 
		type: "GET", 
		dataType: "jsonp", 
		url: url2, 
		success: function (json) { 
		if (json == null || typeof (json) == "undefined") { 
		return; 
		} 
		if (json.status != "0") { 
		return; 
		} 
		  var result = json.result;
	        var lon = result[0].x;//经度
	        var lat = result[0].y;//纬度
	    	var url = "http://api.map.baidu.com/geocoder/v2/?ak=N0qQQgEE7fAe8boAQOdkxvBl" + 
	    	"&callback=renderReverse" + 
	    	"&location=" + lat + "," +lon + 
	    	"&output=json" + 
	    	"&pois=0"; 
	    	$.ajax({ 
	    		type: "GET", 
	    		dataType: "jsonp", 
	    		url: url, 
	    		success: function (json) { 
	    		if (json == null || typeof (json) == "undefined") { 
	    		return; 
	    		} 
	    		if (json.status != "0") { 
	    		return; 
	    		} 
//	        window.location.href="storeListWap.do?longitude="+json.result.location.lng+"&latitude="+json.result.location.lat;
	    		setAddress(json.result.addressComponent.city,json.result.formatted_address,lon,lat); 
	    		}, 
	    		error: function (XMLHttpRequest, textStatus, errorThrown) { 
	    			setAddress('杭州市','武林广场',120.169848,30.276734); 	
// 	    			$(".errormsg").text("[x:" + x + ",y:" + y + "]地址位置获取失败,请手动选择地址");
	    		} 
	    		}); 
		}, 
		error: function (XMLHttpRequest, textStatus, errorThrown) { 
			setAddress('杭州市','武林广场',120.169848,30.276734); 	
		} 
		}); 
	
 }

function setAddress(city,address,lon,lat){
	$("#hidcity").val(city);
	$("#address").text(address);
	$("#hidaddress").val(address);
	$("#lon").val(lon);
	$("#lat").val(lat);
	var category_id = $("#category_id").val();
	$.ajax({
		url:'./storelist',
		type:'post',
		data:{'lon':lon,'lat':lat,'category_id':category_id},
		success:function(msg){
			var storelist = msg.store_list;
			if(storelist==null||storelist.length==0){
				$("#loadmsg").hide();
				$(".store_list").after('<div id="load_more" class="load_more"><span id="loadmorecontent">暂无更多店铺!</span></div>');
			}else{
				var html = "";
				for(var i=0;i<storelist.length;i++){
					html += '<div class="storediv" onclick="storedetail('+storelist[i].store_id+')">';
					html += '<div class="storemarginauto" >';
					html += '<div style="height: 10px;"></div>';
					html += '<div style="width: 100%; height: 41px;">';
					html += '<div style="width: 16%;height: 41px; float:left;">';
					html += '<img src="'+storelist[i].pic_url+'" style="width: 41px; height: 41px; border-radius: 8px;">';
					html += '</div><div style="width: 80%; height: 41px; float:left; margin-left: 4%;" class="overflow_hidden">';
					html += '<div style="width: 100%; height: 21px; font-size: 15px; line-height: 21px;"><font style="float: left;">'+storelist[i].store_name+'</font><font style="float: right;">';
					if(storelist[i].distance<1000){
						html += parseInt(storelist[i].distance)+"m";
					}else{
						html += parseInt(storelist[i].distance/1000)+"km";
					}
					html += '</font></div>';
					html += '<div style="width: 100%; height: 20px; color: #857777; font-size: 12px; line-height: 20px;" >';
					html += storelist[i].sales_num+'总销量&nbsp;&nbsp;';
					if(storelist[i].sales_num==1){
						html += '|&nbsp;&nbsp;起送价'+storelist[i].min_send+'元&nbsp;&nbsp;';
					}
					if(typeof(storelist[i].category_name)!="undefined"){
					html += '|&nbsp;&nbsp;'+storelist[i].category_name;
					}
					html +=	'</div></div></div><div style="width: 100%; height: 41px;"><div style="width: 80%; height: 41px; margin-left: 20%;"><div style="height: 11px;"></div>';
					if(storelist[i].is_new==1){
						html +=	'<div style="width: 19px; height: 19px; border-radius: 19px; background: #3ad4d4; color: #fff; text-align: center; font-size: 11px; line-height: 19px; float:left;margin-right:4px">新</div>';	
					}
					if(storelist[i].has_coupon>0){
						html +=	'<div style="width: 19px; height: 19px; border-radius: 19px; background: #ffba3f; color: #fff; text-align: center; font-size: 11px; line-height: 19px; float:left; margin-right: 4px;">券</div>';
					}
					if(storelist[i].sales_num==1){
						html +='<div style="width: 19px; height: 19px; border-radius: 19px; background: #ff4532; color: #fff; text-align: center; font-size: 11px; line-height: 19px; float:left;">外</div>';
					}
					html +=	'</div></div></div></div>';
				}
				$(".store_list").empty();
				$(".store_list").append(html);
				if(storelist.length==10){
					$(".store_list").after('<div id="load_more" class="load_more"><span id="loadmorecontent">下拉加载更多</span></div>');
				}else{
					$(".store_list").after('<div id="load_more" class="load_more"><span id="loadmorecontent">暂无更多店铺!</span></div>');
				}
				
				myScroll.refresh();
			}
		}
	})
}

function errorCallback(error){
	 switch(error.code){  
     case error.TIMEOUT:  
//          $(".errormsg").text("连接超时，请重试");  
		 setAddress('杭州市','武林广场',120.169848,30.276734); 	
         break;  
     case error.PERMISSION_DENIED:  
//          $(".errormsg").text("您拒绝了使用位置共享服务，查询已取消");  
		 setAddress('杭州市','武林广场',120.169848,30.276734); 	
         break;  
     case error.POSITION_UNAVAILABLE:  
//          $(".errormsg").text("亲爱的火星网友，非常抱歉，我们暂时无法为您所在的星球提供位置服务");  
		 setAddress('杭州市','武林广场',120.169848,30.276734); 	
         break;  
 }
}
</script>
<title></title>
</head>
<body>

<div class="fixedposition">
<font id="address">正在定位您的位置，请稍后</font>
<!-- <img src="./imgs/orgright.png" style="float:right; width: 6px;position: relative;top: 12px;"> -->
<!-- <font style="float:right;color:#ff8854;font-size:10px;margin-right:5px;">修改</font> -->
</div>
<div id="wrapper" style="clear:both;margin-bottom:49px;">
<div id="scroller">
	<div class="categorydiv">
	<c:forEach items="${categorylist}" var="p">
	<div style="float:left;margin-left:12px;margin-right:12px;margin-top:10px;"  onclick="categorystore(${p.id})">
	<img src="${p.pic_url }" width=60px height=60px>
	<div style="text-align:center;">${p.name }</div>
	</div>
	</c:forEach>
	<div style="float:left;margin-left:12px;margin-right:12px;margin-top:10px;"  onclick="turenOtherStore()">
	<img src="./imgs/othercate.png" width=60px height=60px>
	<div style="text-align:center;">其他分类</div>
	</div>
	</div>
	<div style="margin-top:15px;margin-bottom:15px;margin-left:12px;margin-right:12px;height:28px;text-align: center;line-height: 28px;background-color:#e5e5e5;border-radius:12px;" onclick="turensearch()">
	<img src="./imgs/search.png" style="width:11.5px;margin-top:2.5px;"><font style="margin-left:5px;">想要搜索：餐厅/美食</font>
	</div>
	<hr  style="height:0px; border-top:1px solid #e5e5e5; border-right:0px; border-bottom:0px; border-left:0px; "/> 
	<div class="store_list">
		<c:if test="${empty lon && empty lat }">
		<div id="loaddiv" style="width: 100%; text-align:center;border-bottom: 1px solid #e5e5e5;padding-top:30px;padding-bottom:30px;" >
		<img src="./imgs/loading.gif" >
		<br>
		<font id="loadmsg">食趣正在努力为你加载外卖!</font>
		</div>
		</c:if>
	</div>
	
</div>
</div>
<input type="hidden" value="1" id="pageIndex">
<input type="hidden" value="0" id="pushflg">
<input type="hidden" value="${category_id }" id="category_id" name="category_id">
<input type="hidden" value="${address }" id="hidaddress" name="address">
<input type="hidden" value="${city }" id="hidcity" name="city">
<input type="hidden" value="${lon }" id="lon" name="lon">
<input type="hidden" value="${lat }" id="lat" name="lat">
<input type="hidden" value="1" id="bottom_index" name="bottom_index"/>
<jsp:include page="bottom.jsp"/>
</body>
<script>
$(function(){
	var lon = $("#lon").val();
	var lat = $("#lat").val();
	if(lon!=''&&lat!=''){
		var address = $("#hidaddress").val();
		var city = $("#hidcity").val();
		setAddress(city,address,lon,lat); 	
	}else{
		if (navigator.geolocation)
		{
			navigator.geolocation.getCurrentPosition(showPosition,errorCallback);
		}else{
					//页面输出设备不支持
			setAddress('杭州市','武林广场',120.169848,30.276734); 	
		}
	}
})

function categorystore(category_id){
	var address = $("#hidaddress").val();
	var  city = $("#hidcity").val();
	var lon = $("#lon").val();
	var lat = $("#lat").val();
	window.location.href="./storeindex?category_id="+category_id+"&lon="+lon+"&lat="+lat+"&address="+address+"&city="+city;
}

function turenOtherStore(){
	var  city = $("#hidcity").val();
	var lon = $("#lon").val();
	var lat = $("#lat").val();
	window.location.href="./otherstore?lon="+lon+"&lat="+lat+"&city="+city;
}

function turensearch(){
	var address = $("#hidaddress").val();
	var lon = $("#lon").val();
	var lat = $("#lat").val();
	var category_id = $("#category_id").val();
	var  city = $("#hidcity").val();
	window.location.href="./storelistsearch?category_id="+category_id+"&lon="+lon+"&lat="+lat+"&address="+address+"&city="+city;
}
</script>
</html>