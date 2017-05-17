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
<script type="text/javascript">

var myScroll;
function loaded() {
	myScroll = new iScroll('wrapper',{ onScrollEnd: function () {  
        //如果滑动到底部，则加载更多数据（距离最底部10px高度）  
        if ((this.y - this.maxScrollY) <5) {
        	var pushflg = $("#pushflg").val();
        	if (pushflg == 0) {
        		loadMoreStoreList();
        	}
        }  
    } ,vScroll:true,vScrollbar:false});
}
document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
document.addEventListener('DOMContentLoaded', function () { setTimeout(loaded, 100); }, false); 

function setAddress(lon,lat){
	var category_id = $("#category_id").val();
	var area = $("#area").val();
	var sort = $("#sort").val();
	$(".store_list").empty();
	$("#load_more").remove();
	$.ajax({
		url:'./storelist',
		type:'post',
		data:{'lon':lon,'lat':lat,'category_id':category_id,'area':area,'sort':sort},
		success:function(msg){
			var storelist = msg.store_list;
			if(storelist==null||storelist.length==0){
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


function loadMoreStoreList() {
	$("#loadmorecontent").text("努力加载中......");
	$("#pushflg").val(1);
	var pageIndex = $("#pageIndex").val();
	pageIndex = parseInt(pageIndex) + 1;
	var lat = $("#lat").val();
	var lon = $("#lon").val();
	var category_id = $("#category_id").val();
	var area = $("#area").val();
	var sort = $("#sort").val();
	$.ajax({
		url:'./storelist',
		type:'post',
		data:{'lon':lon,'lat':lat,'pageIndex':pageIndex,'category_id':category_id,'area':area,'sort':sort},
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


</script>
<title></title>
</head>
<body>

<div class="fixedposition" >
<select id="areaselect" onchange="changeselect()" style="margin-left:10%;width:20%;text-align:center;border:none;-webkit-appearance:none; box-sizing:border-box;color:#ff8854;font-size:12px;margin-top:5px;">
<option value="">全部城区</option>
<c:forEach items="${arealist}" var="p">
<option value="${p.name }">${p.name }</option>
</c:forEach>
</select>

<select id="cateselect" onchange="changeselect()" style="margin-left:10%;width:25%;text-align:center;border:none;-webkit-appearance:none; box-sizing:border-box;color:#ff8854;font-size:12px;margin-top:5px;">
<option value="0">全部分类</option>
<c:forEach items="${categorylist}" var="p">
<option value="${p.id }">${p.name }</option>	
</c:forEach>
</select>
<select id="sortselect" onchange="changeselect()" style="margin-left:10%;width:20%;text-align:center;border:none;-webkit-appearance:none; box-sizing:border-box;color:#ff8854;font-size:12px;margin-top:5px;">
<option value="1">综合排序</option>
<option value="2">热度最高</option>
</select>
<!-- <img src="./imgs/orgright.png" style="float:right; width: 6px;position: relative;top: 12px;"> -->
<!-- <font style="float:right;color:#ff8854;font-size:10px;margin-right:5px;">修改</font> -->
</div>
<div id="wrapper" style="clear:both;margin-bottom:49px;">
<div id="scroller">
<div class="store_list" >
	
	
</div>
</div>
</div>
<input type="hidden" value="1" id="pageIndex">
<input type="hidden" value="0" id="pushflg">
<input type="hidden" value="0" id="category_id" name="category_id">
<input type="hidden" value="1" id="sort" name="sort">
<input type="hidden" value="${city }" id="hidcity" name="city">
<input type="hidden" value="${lon }" id="lon" name="lon">
<input type="hidden" value="${lat }" id="lat" name="lat">
<input type="hidden" value="" id="area" name="area">
<input type="hidden" value="1" id="bottom_index" name="bottom_index"/>
<jsp:include page="bottom.jsp"/>
</body>
<script>
$(function(){
	var lon = $("#lon").val();
	var lat = $("#lat").val();
	if(lon!=''&&lat!=''){
		setAddress(lon,lat); 	
	}
})

function changeselect(){
	$("#pageIndex").val(1);
	var area = $("#areaselect").val();
	var cateselect = $("#cateselect").val();
	var sortselect = $("#sortselect").val();
	$("#sort").val(sortselect);
	$("#category_id").val(cateselect);
	$("#area").val(area);
	var lon = $("#lon").val();
	var lat = $("#lat").val();
	setAddress(lon,lat); 
}
</script>
</html>