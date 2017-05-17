<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<link rel="stylesheet" href="css/store.css" type="text/css" media="screen">
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<link rel="stylesheet" href="iscroll/iscroll2.css">
<script type="text/javascript" src="iscroll/iscroll.js"></script>
<title>搜索</title>
</head>
<body style="margin:0;">
<div style="margin-left:12px;margin-right:12px;height:30px;margin-top:16px;background-color:#ffffff;">
<div style="border-radius:14px;float:right;width:65px;height:30px;line-height:30px;text-align:center;color:#ffffff;background-color:#ff8854" onclick="searchKeyword()">搜索</div>
<input type="text" style="font-size:15px;background-position: 12px;background-size:16px;background-image: url(./imgs/search_b.png);background-repeat: no-repeat;background-color: transparent;border-radius:15px;border:1px solid #e8e8e8;height:26px;line-height:26px;float:left;-webkit-appearance: none;padding-left:30px;" id="searchinput">
</div>
<div id="wrapper" style="clear:both;top:61px;">
<div id="scroller">
<div class="store_list">
</div>
</div>
</div>

<input type="hidden" value="1" id="pageIndex">
<input type="hidden" value="0" id="pushflg">
<input type="hidden" value="${lon }" id="lon" name="lon">
<input type="hidden" value="${lat }" id="lat" name="lat">
<input type="hidden" value="${category_id }" id="category_id" name="category_id">
<input type="hidden" value="${address }" id="hidaddress" name="address">
<input type="hidden" value="${city }" id="hidcity" name="city">
</body>
<script>
var myScroll;
function loaded() {
	myScroll = new iScroll('wrapper',{ onScrollEnd: function () {  
        //如果滑动到底部，则加载更多数据（距离最底部10px高度）  
        if ((this.y - this.maxScrollY) <5) {
        	var pushflg = $("#pushflg").val();
        	if (pushflg == 0) {
        		loadMoreShopList();
        	}  
        }  
    } ,vScroll:true,vScrollbar:false});
}
document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
document.addEventListener('DOMContentLoaded', function () { setTimeout(loaded, 100); }, false); 
 

$(function(){
	var width = document.documentElement.clientWidth;
	var inputwidth = width - 65-24-60;
	$("#searchinput").css("width",inputwidth);
})

function searchKeyword(){
	var keyword = $("#searchinput").val();
	if(keyword!=''){
	var lat = $("#lat").val();
	var lon = $("#lon").val();
	$(".store_list").empty();
	$("#load_more").remove();
	$.ajax({
		url:'./storelist',
		type:'post',
		data:{'lon':lon,'lat':lat,'keywords':keyword},
		success:function(msg){
			var storelist = msg.store_list;
			if(storelist==null||storelist.length==0){
				$("#loadmsg").hide();
				$(".store_list").append('<img style="width:60%;margin-left:20%;margin-top:100px;" src="./imgs/noresult.png"><div style="width:100%;text-align:center;font-size:24px;color:#3e3e3e;margin-top:50px;">附近没有您搜索的店铺</div>');
				$("#pushflg").val(1);
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
					$("#pushflg").val(0);
					$(".store_list").after('<div id="load_more" class="load_more"><span id="loadmorecontent">下拉加载更多</span></div>');
				}else{
					$("#pushflg").val(1);
					$(".store_list").after('<div id="load_more" class="load_more"><span id="loadmorecontent">暂无更多店铺!</span></div>');
				}
				myScroll.refresh();
			}
		}
	})
	}
}


function loadMoreShopList() {
	$("#loadmorecontent").text("努力加载中......");
	$("#pushflg").val(1);
	var pageIndex = $("#pageIndex").val();
	pageIndex = parseInt(pageIndex) + 1;
	var lat = $("#lat").val();
	var lon = $("#lon").val();
	var keyword = $("#searchinput").val();
	if(keyword!=''){
	$.ajax({
		url:'./storelist',
		type:'post',
		data:{'lon':lon,'lat':lat,'pageIndex':pageIndex,'keyword':keyword},
		success:function(msg){
			var storelist = msg.store_list;
			if(storelist==null||storelist.length==0){
				$("#loadmorecontent").text("暂无更多店铺!");
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
				$("#loadmorecontent").text("下拉加载更多");
				$(".store_list").append(html);
				$("#pageIndex").val(pageIndex);
				$("#pushflg").val(0);
				myScroll.refresh();
			}
		}
	})
	}
}

function storedetail(id){
	window.location.href = "./storedetail?store_id="+id;
}
</script>
</html>