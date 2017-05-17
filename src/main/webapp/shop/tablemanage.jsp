<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/tablemanage.css" rel="stylesheet">
<link href="./css/common.css" rel="stylesheet">
<script src="./js/jquery-1.11.2.min.js"></script>
<script src="./js/common.js"></script>
<script>

$(function(){
	var height = document.documentElement.clientHeight-100;
	$(".alert").height(height);
	var content_height = height-230;
	 var left = ($(window).width() - $(".alert").width())/3;   
	 $(".alert").css("left",left);
	$(".alert_content").css("height",content_height);
	 var tableleft = ($(window).width() - $(".changeTable").width())/3;   
	 $(".changeTable").css("left",tableleft);
	 $(".changeMenu").css("left",tableleft);
	 var weightleft = ($(window).width() - $(".weightAlert").width())/3;  
	 $(".weightAlert").css("left",weightleft);
	 var payorderleft = ($(window).width() - $(".payAlert").width())/3; 
	 $(".payAlert").css("left",payorderleft);
	 $(".payAlert").height(height+80);
	 var pay_content_height=height+30;
	 $("#paycontentdiv").css("height",pay_content_height);
	 var addmenuleft = ($(window).width() - $(".addmenuAlert").width())/3; 
	 $(".addmenuAlert").css("left",addmenuleft);
	 $(".addmenuAlert").height(height);
	 var addmenucontent_height = height-210;
	 $(".addmenualert_content").css("height",addmenucontent_height);
	 $(document).keydown(
    			function(event) {
    				if (event.keyCode == 13) { 
    					$('form').each(function() { 
    						event.preventDefault();     
    						}
    					);
    					var payAlertdisplay = $("#payAlert").css("display");
    					if(payAlertdisplay=="block"){
    						submitPay();
    					}else{
    					}
    					} 
    				});
	 
});


function showalert(id){
	window.top.showmask();
	window.parent.showmask();
	$(".mask").show();
	$("#box_detail_"+id).show();
}

function hiddenAlert(id){
	$("#box_detail_"+id).hide();
	$(".mask").hide();
	window.top.hidemask();
	window.parent.hidemask();
}

function precheckout(order_id){
	if(confirm("打印预结账账单?")){
		$.ajax({
			url:'./precheckout',
			type:'POST',
			data:{order_id:order_id},
			success:function(msg){
				alert("预结账订单打印成功!");
			}
		})
	}
}

function sendkitchen(order_id){
	if(confirm("打印送厨账单?")){
		$.ajax({
			url:'./sendkitchen',
			type:'POST',
			data:{order_id:order_id},
			success:function(msg){
				alert("送厨订单打印成功!");
			}
		})
	}	
}

function cleantable(table_id){
	if(confirm("确定清台?")){
		$.ajax({
			url:'./cleantable',
			type:'POST',
			data:{table_id:table_id},
			success:function(msg){
				var msgdata = eval("("+msg+")");
				var code = msgdata.code;
				if(code==1){
					alert("清台成功!");
					$("#box_detail_"+table_id).hide();
					$(".mask").hide();
					window.top.hidemask();
					window.parent.hidemask();
					window.location.href=window.location.href;
				}else{
					alert(msgdata.message);
				}
			}
		})
	}
}

function ordertable(table_id){
	if(confirm("预定桌台?")){
		$.ajax({
			url:'./ordertable',
			type:'POST',
			data:{table_id:table_id},
			success:function(msg){
				var msgdata = eval("("+msg+")");
				var code = msgdata.code;
				if(code==1){
					alert("预定桌台成功!");
					$("#box_detail_"+table_id).hide();
					$(".mask").hide();
					window.top.hidemask();
					window.parent.hidemask();
					window.location.href=window.location.href;
				}else{
					alert(msgdata.message);
				}
			}
		})
	}
}

function changeTableAlert(table_id,area_name,table_no){
	$("#changeFromTable").val(table_id);
	$("#box_detail_"+table_id).hide();
	$("#changetitle").text("(原位："+area_name+" "+table_no+")");
	$("#changeTableAlert").show();
}

function hiddenchangeAlert(){
	$("#changeTableAlert").hide();
	$(".mask").hide();
	window.top.hidemask();
	window.parent.hidemask();
}

function menuTableAlert(table_id,detail_id,area_name,table_no){
	$("#changeFromMenu").val(detail_id);
	$("#box_detail_"+table_id).hide();
	$("#menuchangetitle").text("(原位："+area_name+" "+table_no+")");
	$("#changeMenuAlert").show();
}

function hiddenMenuchangeAlert(){
	$("#changeMenuAlert").hide();
	$(".mask").hide();
	window.top.hidemask();
	window.parent.hidemask();
}

function hiddenpayAlert(){
	$("#payAlert").hide();
	$(".mask").hide();
	window.top.hidemask();
	window.parent.hidemask();
}

function changeArea(){
	var area_id = $("#alertarea_id").val();
	if(area_id>0){
	$.ajax({
		url:'./getTableList',
		type:'POST',
		data:{area_id:area_id},
		success:function(msg){
			var msgdata = eval("("+msg+")");
			var code = msgdata.code;
			var html ='';
			$("#alerttable_id").empty();
			if(code==1){
				var tablelist = msgdata.storetable; 
				for(var i=0;i<tablelist.length;i++){
					html += "<option value='"+tablelist[i].table_id+"'>"+tablelist[i].table_no+"</option>";
				}
			}else{
				html +="<option value=''>桌号选择</option>";
			}
			$("#alerttable_id").append(html);
		}
	})
	}else{
		var html ="<option value=''>桌号选择</option>";
		$("#alerttable_id").empty();
		$("#alerttable_id").append(html);
	}
}

function changeMenuArea(){
	var area_id = $("#alertmenuarea_id").val();
	if(area_id>0){
	$.ajax({
		url:'./getTableList',
		type:'POST',
		data:{area_id:area_id},
		success:function(msg){
			var msgdata = eval("("+msg+")");
			var code = msgdata.code;
			var html ='';
			$("#alertmenutable_id").empty();
			if(code==1){
				var tablelist = msgdata.storetable; 
				for(var i=0;i<tablelist.length;i++){
					html += "<option value='"+tablelist[i].table_id+"'>"+tablelist[i].table_no+"</option>";
				}
			}else{
				html +="<option value=''>桌号选择</option>";
			}
			$("#alertmenutable_id").append(html);
		}
	})
	}else{
		var html ="<option value=''>桌号选择</option>";
		$("#alertmenutable_id").empty();
		$("#alertmenutable_id").append(html);
	}
}

function submitChangeMenu(){
	var changeFromMenu =   $("#changeFromMenu").val();
	var changeToTable = $("#alertmenutable_id").val();
	if(changeToTable==''){
		alert("请选择转菜的桌号");
		return ;
	}
	if(confirm("确认转菜?")){
		$.ajax({
			url:'./changeDetail',
			type:'POST',
			data:{detail_id:changeFromMenu,to_id:changeToTable},
			success:function(msg){
				var msgdata = eval("("+msg+")");
				var code = msgdata.code;
				if(code==1){
					alert("转菜成功!");
					hiddenMenuchangeAlert();
					$(".mask").hide();
					window.top.hidemask();
					window.parent.hidemask();
					window.location.href=window.location.href;
				}else{
					alert(msgdata.message);
				}
			}
		})
	}
}

function submitChangeTable(){
	var changeFromTable =   $("#changeFromTable").val();
	var changeToTable = $("#alerttable_id").val();
	if(changeToTable==''){
		alert("请选择换台的桌号");
		return ;
	}
	if(confirm("确定换台？")){
		$.ajax({
			url:'./changeTable',
			type:'POST',
			data:{from_id:changeFromTable,to_id:changeToTable},
			success:function(msg){
				var msgdata = eval("("+msg+")");
				var code = msgdata.code;
				if(code==1){
					alert("转台成功，请及时清台旧桌台");
					$("#changeTableAlert").hide();
					$(".mask").hide();
					window.top.hidemask();
					window.parent.hidemask();
					window.location.href=window.location.href;
				}else{
					alert(msgdata.message);
				}
			}
		})
	}
}

function changeoper(id){
// 	alert($("#operimg_"+id).attr("src"));
	var src = $("#operimg_"+id).attr("src")
	if(src=="./imgs/oper_hide.png"){
		$("#operimg_"+id).attr("src","./imgs/oper_show.png");
		$("#oper_"+id).show();
		var height = $("#detail_"+id).height();
		$("#detail_"+id).height(height+40);	
	}else{
		$("#operimg_"+id).attr("src","./imgs/oper_hide.png");
		$("#oper_"+id).hide();
		var height = $("#detail_"+id).height();
		$("#detail_"+id).height(height-40);	
	}
}

function cancelfreeDetail(id){
	if(confirm("取消赠送?")){
		$.ajax({
			url:'./cancelfree',
			type:'POST',
			data:{detail_id:id},
			success:function(msg){
				var code = msg.code;
				if(code==1){
					alert("取消赠菜成功");
					$("#alertindex_"+id).css("width",80);
					$("#freeimg_"+id).hide();
					$("#singelprice_"+id).text("￥"+msg.price.toFixed());
					$("#detailprict_"+id).text("￥"+msg.allprice.toFixed());
					$("#freebtn_"+id).show();
					$("#cancelfreebtn_"+id).hide();
				}else{
					alert(msg.message);
				}
			}
		});
	}
}

function freeDetail(id){
	if(confirm("赠送该道菜？（注：赠菜后价格不计算菜单里）")){
		$.ajax({
			url:'./freeorder',
			type:'POST',
			data:{detail_id:id},
			success:function(msg){
				var msgdata = eval("("+msg+")");
				var code = msgdata.code;
				if(code==1){
					alert("赠菜成功!");
					$("#alertindex_"+id).css("width",60);
					$("#alertindex_"+id).after('<img style="float:left;width: 20px;margin-top: 14px;" src="./imgs/isfree.png" id="freeimg_'+id+'">');
					$("#singelprice_"+id).text("￥0.00");
					$("#detailprict_"+id).text("￥0.00");
					$("#freebtn_"+id).hide();
					$("#cancelfreebtn_"+id).show();
				}else{
					alert(msgdata.message);
				}
			}
		})
	}
}

function delOrderDetail(id){
	if(confirm("确认退菜？")){
		$.ajax({
			url:'./delorderDetail',
			type:'POST',
			data:{detail_id:id},
			success:function(msg){
				var msgdata = eval("("+msg+")");
				var code = msgdata.code;
				if(code==1){
					alert("退菜成功!");
					$("#detail_"+id).remove();
				}else{
					alert(msgdata.message);
				}
			}
		})
	}
}

function makeWeight(){
	var detail_id = $("#weightdetail_id").val();
	var weight = $("#alertweight").val();
	if(weight==''){
		alert("请输入称重重量");
		return ;
	}
	if(confirm("确定称重？")){
		$.ajax({
			url:'./makeweight',
			type:'POST',
			data:{detail_id:detail_id,weight:weight},
			success:function(msg){
				var msgdata = eval("("+msg+")");
				var code = msgdata.code;
				if(code==1){
					$("#weight_"+detail_id).text(weight);
					var weightprice = msgdata.weightprice;
					$("#detailprict_"+detail_id).text('￥'+weightprice.toFixed(2));
					alert("称重成功!");
					hideWeightAlert();
// 					$("#changeTableAlert").hide();
// 					$(".mask").hide();
// 					window.top.hidemask();
// 					window.parent.hidemask();
// 					window.location.href=window.location.href;
				}else{
					alert(msgdata.message);
				}
			}
		})
	}
}

function showWeightAlert(id,menuname,unit){
	$("#weightdetail_id").val(id);
	$("#weightname").text(menuname);
	$("#weightunit").text(unit);
	$(".alert").css("z-index","0");
	$("#weightAlert").show();
}
function hideWeightAlert(){
	$(".alert").css("z-index","10");
	$("#weightAlert").hide();
}

function getPayOrder(order_id,table_id,area_name,table_no){
// 	alert(order_id);
	$.ajax({
		url:'./getPayOrder',
		type:'POST',
		data:{order_id:order_id},
		success:function(msg){
			var msgdata = eval("("+msg+")");
			var code = msgdata.code;
			if(code==1){
				$("#payorderid").val(order_id);
				$("#box_detail_"+table_id).hide();
				$("#paytitle").text("("+area_name+" "+table_no+")");
				$("#payAlert").show();
				var totalprice = msgdata.totalprice;
				var discount = msgdata.discount;
				var discountprice = msgdata.discountprice;
				var nodiscountprice = msgdata.nodiscountprice;
				var limitreset = msgdata.limitreset;
				$("#userlimitreset").val(parseFloat(limitreset).toFixed(2));
				$("#userdiscount").val(parseFloat(discount).toFixed(2));
				$("#alerttotal").text(parseFloat(totalprice).toFixed(2));
				$("#alertprice").text(parseFloat(totalprice).toFixed(2));
				$("#alertdiscount").text(parseFloat(discountprice).toFixed(2));
				$("#alertundiscount").text(parseFloat(nodiscountprice).toFixed(2));
				$("#orderdiscount").val("");
				$("#moling").val("");
				$("#ordercoupon").val("");
				$("#coupon_id").val("");
				$("#amount").val("");
				$("#orderRechargeCard").val("");
				$("#rechargecardid").val("");
				$("#ordercash").val("");
				$("#orderzhifubao").val("");
				$("#ordercard").val("");
				countPay();
				countdiscount();
			}else{
				alert(msgdata.message);
			}
		}
	})
}

function countdiscount(){
	$("#discounterr").text("");
	$("#molingerr").text("");
	var userdiscount = parseFloat($("#userdiscount").val());
	if($("#orderdiscount").val()!=''){
		var discount = parseFloat($("#orderdiscount").val())/100;
		if(discount>1||discount<=0){
			$("#discounterr").text("请输入正确的折扣率!");
			return ;
		}
		if(discount<userdiscount){
			$("#discounterr").text("用户折扣权限不足!");
			return ;
		}
		var total  = parseFloat($("#alerttotal").text());
		var maydiscountmoney = parseFloat($("#alertdiscount").text());
		var discountmoney  = (maydiscountmoney*(1-discount)).toFixed(2);
		$("#alertdiscountmoney").text(discountmoney);
		var price =  parseFloat($("#alertprice").text());
		var undiscount =  parseFloat($("#alertundiscount").text());
		var price = (maydiscountmoney*discount+undiscount).toFixed(2);
		$("#alertprice").text(price);
	}else{
		$("#alertdiscountmoney").text(0);
		var totla = $("#alerttotal").text();
		$("#alertprice").text(totla);
	}
	if($("#amount").val()!=''){
		var amount = parseFloat($("#amount").val());
		var alertprice = parseFloat($("#alertprice").text());
		var price = alertprice-amount;
		if(price < 0){
			price = 0 ;
		}
		$("#alertprice").text(price.toFixed(2));
	}
	if($("#moling").val()!=''){
		var moling = parseFloat($("#moling").val());
		var userlimitreset = parseFloat($("#userlimitreset").val());
		var alertprice = parseFloat($("#alertprice").text());
		var price = alertprice-moling;
		if(moling<=userlimitreset){
			if(price<0){
				$("#molingerr").text("抹零金额不能大于应付金额!");
			}else{
			$("#alertprice").text(price.toFixed(2));
			}
		}else{
			$("#molingerr").text("超出抹零上限!");
		}
	}
	countPay();
}

function changePayType(){
	var height = $("#paycontentdiv").height();
	$("#paycontentdiv").removeAttr("style");
	var paytype = $("#alertpaytype").val();
	$(".paytype_div").hide();
	$("#paytype_"+paytype).show();
	var rightheight = $("#payright").height();
	var leftheight = $("#payleft").height();
	if(rightheight>height){
	if(leftheight<rightheight){
		$("#payleft").height(rightheight);	
	}else{
		$("#payleft").height(height);	
	}
	}else{
		$("#payleft").height(height);	
	}
	$("#paycontentdiv").attr("style","overflow: auto; height:"+height+"px");
}

function checkcoupon(){
	$("#couponerr").text("");
	var ordercoupon = $("#ordercoupon").val();
	if(ordercoupon==''){
		$("#couponerr").text("请输入优惠券!");
		return;
	}else{
		$.ajax({
			url:'./checkCoupon',
			type:'POST',
			data:{coupon_no:ordercoupon},
			success:function(msg){
				var msgdata = eval("("+msg+")");
				var code = msgdata.code;
				if(code==1){
					var mycoupon = msgdata.mycoupon;
					var coupon = mycoupon.coupon;
					var min_money =  parseFloat(coupon.min_money).toFixed(2);
					var amount =  parseFloat(coupon.amount).toFixed(2);
					var total = parseFloat($("#alerttotal").text()).toFixed(2);
					if(parseFloat(min_money) <= parseFloat(total)){
						var price = parseFloat($("#alertprice").text()).toFixed(2);
						if(price-amount<0){
							$("#alertprice").text(0);	
						}else{
						$("#alertprice").text((price-amount).toFixed(2));
						}
						$("#checkcouponbtn").removeAttr("onclick");
						$("#mycouponid").val(mycoupon.id);
						$("#couponerr").text("优惠券使用成功!");
						$("#amount").val(amount);
					}else{
						$("#couponerr").text("未满足使用条件");
					}
				}else{
					$("#couponerr").text(msgdata.message);
				}
			}
		})
	}
}

function checkrechargecard(){
	$("#rechargecarderr").text("");
	var cardno = $("#orderRechargeCard").val();
	$.ajax({
		url:'./checkRechangeCard',
		type:'POST',
		data:{cardno:cardno},
		success:function(msg){
			var msgdata = eval("("+msg+")");
			var code = msgdata.code;
			if(code==1){
				var rechargecard = msgdata.rechargecard;
				var money = parseFloat(rechargecard.money).toFixed(2);
				var alertprice = parseFloat($("#alertprice").text()).toFixed(2);
				if(parseFloat(money)>=parseFloat(alertprice)){
					$("#rechargecardid").val(rechargecard.id);
					$("#rechargecarderr").text("校验成功，该卡可使用!");
				}else{
					$("#rechargecardid").val("");
					$("#rechargecarderr").text("余额不足!");
				}
			}else{
				$("#rechargecarderr").text(msgdata.message);
			}
		}
	})
}

function countPay(){
	var ordercash = 0;
	if($("#ordercash").val()!=''){
		ordercash = parseFloat($("#ordercash").val());
	}
	var orderzhifubao = 0;
	if($("#orderzhifubao").val()!=''){
		orderzhifubao = parseFloat($("#orderzhifubao").val());
	}
	var ordercard = 0;
	if($("#ordercard").val()!=''){
		ordercard = parseFloat($("#ordercard").val());
	}
	var price = parseFloat($("#alertprice").text());
	if((ordercard+orderzhifubao+ordercash)-price>0){
		$("#zhaoling").text(((ordercard+orderzhifubao+ordercash)-price).toFixed(2));
	}else{
		$("#zhaoling").text("");
	}
}

function submitPay(){
	var isrecive = $("#isrecive").val();
	if(isrecive == 0){
	if(confirm("确认收银?")){
		$("#isrecive").val("1");
	var paytype = $("#alertpaytype").val();
	$("#rechargecarderr").text("");
	$("#submiterr").text("");
	var price =  parseFloat($("#alertprice").text());
	$("#price").val(price);
	if(paytype==0){
		var rechargecardid = $("#rechargecardid").val();
		if(rechargecardid==''){
			$("#submiterr").text("请输入充值卡并进行校验!");
			$("#isrecive").val("0");
			return;
		}
		$("#type").val(4);
	}else if(paytype==1){
		if($("#ordercash").val()!=''){
			var ordercash = parseFloat($("#ordercash").val());
		}else{
			var ordercash = 0;
		}
		if($("#orderzhifubao").val()!=''){
			var orderzhifubao = parseFloat($("#orderzhifubao").val());
		}else{
			var orderzhifubao = 0;
		}
		if($("#ordercard").val()!=''){
			var ordercard = parseFloat($("#ordercard").val());
		}else{
			var ordercard = 0;
		}
		if(ordercash>=orderzhifubao){
			if(ordercash>=ordercard){
				$("#type").val(1);
			}else{
				$("#type").val(3);
			}
		}else{
			if(orderzhifubao>=ordercard){
				$("#type").val(2);
			}else{
				$("#type").val(3);
			}
		}
		var price = parseFloat($("#alertprice").text());
		if((ordercash+orderzhifubao+ordercard)<price){
			$("#submiterr").text("付款金额必须大于等于应付价格");
			$("#isrecive").val("0");
			return ;
		}
	}else if(paytype==2){
		var qiandan_id = $("#qiandan_id").val();
		if(qiandan_id==''){
			$("#submiterr").text("请选择签单人!");
			$("#isrecive").val("0");
			return;
		}
		$("#type").val(5);
	}else if(paytype==3){
		var miandan_id = $("#miandan_id").val();
		if(miandan_id==''){
			$("#submiterr").text("请选择免单人!");
			$("#isrecive").val("0");
			return;
		}
		$("#type").val(6);
	}
	$.ajax({
		url:'./cashier',
		type:'POST',
		data:$("#payform").serialize(),
		success:function(msg){
			var msgdata = eval("("+msg+")");
			var code = msgdata.code;
			if(code==1){
				hiddenpayAlert();
				alert("收银成功，请及时清台!");
				window.location.href=window.location.href;
			}else{
				$("#submiterr").text(msgdata.message);
			}
		}
	})
	}
	}else{
		alert("正在收银，请勿重复提交!");
	}
}

function addMenu(orderid,table_id,areaname,tableno){
	$("#addorderid").val(orderid);
	$("#addmenutitle").text("("+areaname+" "+tableno+")");
	$("#box_detail_"+table_id).hide();
	$("#addmenuAlert").show();
}

function hiddenaddmenuAlert(){
	$("#addmenuAlert").hide();
	$(".mask").hide();
	window.top.hidemask();
	window.parent.hidemask();
}

function checkmenunum(id){
	var num = $("#num_"+id).val();
	if(num==''){
		$("#num_"+id).val(0);
	}
}

function changemenutype(){
	var menu_type = $("#menu_type").val();
	$.ajax({
		url:'./menulist',
		type:'POST',
		data:{menu_type:menu_type},
		success:function(msg){
			var msgdata = eval("("+msg+")");
			var menulist = msgdata.menulist;
			$("#addmenualert_content").empty();
			var html = "";
			for(var i=0;i<menulist.length;i++){
				html +='<div style="margin-left:20px;margin-right:20px;height:49px;line-height:49px;border-bottom: 1px solid #e5e6ea;" >';
				html +='<div class="alert_content_div" style="width:270px;">';
				html += menulist[i].menu_name;
				html += '</div><div class="alert_content_div" style="width:130px;">';
				html += menulist[i].price;
				html += '</div><div class="alert_content_div" style="width:100px;">';
				html +=  menulist[i].unit;
				html += '</div><div class="alert_content_div" style="width:140px;">';
				html += '<input type="hidden" name="menuid" value="'+menulist[i].menu_id+'" id="'+menulist[i].menu_id+'">'
				html += '<input type="text" class="form-control inputnum" maxlength="4" name="menunum" id="num_'+menulist[i].menu_id+'" onblur="checkmenunum('+menulist[i].menu_id+')" onkeyup="return checkNum(event,\'num_'+menulist[i].menu_id+'\')"  onkeydown="return checkNum(event,\'num_'+menulist[i].menu_id+'\')"   value="0"  >';
				html += '</div></div>';
			}
			$("#addmenualert_content").append(html);
		}
	})
}

function submitAdd(){
	if(confirm("确定加菜?")){
		$.ajax({
			url:'./addorderdetail',
			type:'POST',
			data:$("#addmenuform").serialize(),
			success:function(msg){
				var msgdata = eval("("+msg+")");
				var code = msgdata.code;
				if(code==1){
					alert("加菜成功!");
					hiddenaddmenuAlert();
					window.location.href=window.location.href;
				}else{
					alert(msgdata.message);
				}
			}
		})
	}
}

function disabletable(table_id){
	if(confirm("桌台不可用?")){
		$.ajax({
			url:'./disabletable',
			type:'POST',
			data:{table_id:table_id},
			success:function(msg){
				var msgdata  = eval("("+msg+")");
				var code = msgdata.code;
				if(code==1){
					alert("不可用成功!");
					$("#box_detail_"+table_id).hide();
					$(".mask").hide();
					window.top.hidemask();
					window.parent.hidemask();
					window.location.href=window.location.href;
				}else{
					alert(msgdata.message);
				}
			}
		})
	}
}

</script>
<title>桌台管理</title>
</head>
<body>
<div style="width:90%;margin-left:4%;">
<div class="stateview">
<font style="font-weight:bold;float:left">桌台状态:</font>
<div class="statediv" style="background-color:#5f97fa">
全部(${allcount })
</div>
<div class="statediv" style="background-color:#36aa47">
空闲(${freecount })
</div>
<div class="statediv" style="background-color:#f83a22">
有客(${usecount })
</div>
<div class="statediv" style="background-color:#DB70DB">
未清台(${nocleancount })
</div>
<div class="statediv" style="background-color:#ffc000">
预约(${ordercount })
</div>
<div class="statediv" style="background-color:#cbd0d2">
不可用(${unusecount })
</div>
</div>

<ul class="nav nav-tabs" style="margin-bottom:30px;">
 <c:forEach items="${arealist}" var="p">
 <c:if test="${p.id== area_id}">
 <li role="presentation" class="active"><a href="./tablemanage?area_id=${p.id }">${p.area_name }</a></li>
 </c:if>
 <c:if test="${p.id!= area_id}">
 <li role="presentation"><a href="./tablemanage?area_id=${p.id }">${p.area_name }</a></li>
 </c:if>
 </c:forEach>
</ul>

 <c:forEach items="${storetable}" var="p">
<div class="tableview"  onclick="showalert(${p.table_id})">
<c:if test="${p.state==1 }">
<div class="tableview_name"  style="background-color:#36aa47">
${p.table_no }
</div>
</c:if>
<c:if test="${p.state==2 }">
<c:if test="${p.order.state==4 }">
<div class="tableview_name"  style="background-color:#DB70DB">
</c:if>
<c:if test="${p.order.state!=4 }">
<div class="tableview_name"  style="background-color:#f83a22">
</c:if>
${p.table_no }
</div>
</c:if>
<c:if test="${p.state==3 }">
<div class="tableview_name"  style="background-color:#ffc000">
${p.table_no }
</div>
</c:if>
<c:if test="${p.state==4 }">
<div class="tableview_name"  style="background-color:#cbd0d2">
${p.table_no }
</div>
</c:if>
<div style="border-left:#cccccc 2px solid;border-right:#cccccc 2px solid;border-bottom:#cccccc 2px solid;">
<div class="tableview_money"  >
<img src="./imgs/money.png" style="float:left;margin-top:16px;">

<div style="float:right;width:80px;font-weight:bold;" class="overflow_hidden">
<c:if test="${p.state==2 }"><c:if test="${not empty p.order}"><fmt:formatNumber value="${p.order.total_price }" type="currency"/></c:if>
<c:if test="${empty p.order}">
￥0.00
</c:if>
</c:if>
<c:if test="${p.state!=2 }">
￥0.00
</c:if>
</div>
</div>
<div class="tableview_people"  >

<img src="./imgs/people.png" style="float:left;margin-top:13px;">
<div style="float:right;width:80px;font-weight:bold;">
<c:if test="${not empty p.order}">
${p.order.people_num }
</c:if>
<c:if test="${empty p.order}">
0
</c:if>
</div>
</div>
</div>
</div>
</c:forEach>
</div>
</body>

<c:forEach items="${storetable}" var="p">
<!-- 地图弹窗 -->
<div id="box_detail_${p.table_id }" class="alert" style="display: none;">
<div style="background-color:#f5f6fa;width:100%;height:50px;line-height:50px;padding-left:20px;font-size:14px;font-family:'宋体';font-weight: bold;">
${p.table_no }
<img src="./imgs/delete.png"  style="float: right;margin-top: 11px;margin-right: 15px;cursor: pointer;" onclick="hiddenAlert(${p.table_id })">
</div>
<div>
<c:if test="${p.state==2 }">
<c:if test="${p.order.state!=4 }">
<div class="menu_div">
<c:if test="${not empty p.order}">
<div class="menu_img" onclick="precheckout(${p.order.order_id})">
</c:if>
<c:if test="${ empty p.order}">
<div class="menu_img" >
</c:if>
<img src="./imgs/yujiezhang.png">
<div class="menu_text" >预结账</div>
</div>
<img  class="ling"  src="./imgs/ling.png">
</div>

<div class="menu_div">
<div class="menu_img" onclick="sendkitchen(${p.order.order_id})">
<img src="./imgs/songchu.png">
<div class="menu_text">餐单送厨</div>
</div>
<img  class="ling"  src="./imgs/ling.png">
</div>
</c:if>
</c:if>
<c:if test="${p.state!=1 }">
<div class="menu_div">
<div class="menu_img" onclick="cleantable(${p.table_id })">
<img src="./imgs/qingtai.png">
<div class="menu_text">清台</div>
</div>
<img  class="ling"  src="./imgs/ling.png">
</div>
</c:if>

<c:if test="${p.state==1 }">
<div class="menu_div">
<div class="menu_img" onclick="ordertable(${p.table_id })">
<img src="./imgs/yuding.png">
<div class="menu_text">预定</div>
</div>
<img  class="ling"  src="./imgs/ling.png">
</div>

<div class="menu_div">
<div class="menu_img" onclick="disabletable(${p.table_id })">
<img src="./imgs/disabled.png">
<div class="menu_text">不可用</div>
</div>
<img  class="ling"  src="./imgs/ling.png">
</div>
</c:if>

<c:if test="${p.state==2 }">
<c:if test="${p.order.state!=4 }">
<div class="menu_div">
<div class="menu_img" onclick="changeTableAlert(${p.table_id },'${p.area_name }','${p.table_no }')">
<img src="./imgs/zhanyong.png">
<div class="menu_text" >换台</div>
</div>
<img  class="ling"  src="./imgs/ling.png">
</div>

<!-- <div class="menu_div"> -->
<%-- <div class="menu_img" onclick="addMenu(${p.order.order_id },${p.table_id},'${p.area_name }','${p.table_no }')"> --%>
<!-- <img src="./imgs/jiacai.png"> -->
<!-- <div class="menu_text" style="margin-top:18px">加菜</div> -->
<!-- </div> -->
<!-- <img  class="ling"  src="./imgs/ling.png"> -->
<!-- </div> -->

<div class="menu_div">
<div class="menu_img" onclick="getPayOrder(${p.order.order_id},${p.table_id},'${p.area_name }','${p.table_no }')">
<img src="./imgs/shouyin.png">
<div class="menu_text"  style="margin-top:12px">收银</div>
</div>
</div>
</c:if>
</c:if>
</div>
<c:if test="${not empty p.order }">
<div style="clear:both;padding-left:20px;padding-right:20px;background-color:#f5f6fa;width:100%;height:48px;line-height:48px;border-top: 1px solid #ffffff;">
<div class="alert_content_div" style="width:80px;">
编号
</div>
<div class="alert_content_div" style="width:200px;">
名称
</div>
<div class="alert_content_div" style="width:100px;">
单价
</div>
<div class="alert_content_div" style="width:75px;">
数量
</div>
<div class="alert_content_div" style="width:75px;">
单位
</div>
<div class="alert_content_div" style="width:75px;">
称重
</div>
<div class="alert_content_div" style="width:75px;">
金额
</div>
<div class="alert_content_div" style="width:75px;text-align:right;">
操作
</div>
</div>
<div class="alert_content" id="alert_content" style="width:100%;overflow: auto;">
<c:forEach items="${p.order.menu_list}" var="q" varStatus="st">
<div style="margin-left:20px;margin-right:20px;height:49px;line-height:49px;border-bottom: 1px solid #e5e6ea;" id="detail_${q.id }">
<c:if test="${q.is_free==1 }">
<div class="alert_content_div_nobold" style="width:60px;">
${st.index+1 }
</div>
<img style="float:left;width: 20px;margin-top: 14px;" src="./imgs/isfree.png" id="freeimg_${q.id }">
</c:if>
<c:if test="${q.is_free!=1 }">
<div class="alert_content_div_nobold" style="width:80px;" id="alertindex_${q.id }">
${st.index+1 }
</div>
</c:if>
<div class="alert_content_div_nobold overflow_hidden" style="width:200px;">
${q.menu_name }
</div>
<div class="alert_content_div_nobold" style="width:100px;" id="singelprice_${q.id }">
<fmt:formatNumber value="${q.price }" type="currency"/>
</div>
<div class="alert_content_div_nobold" style="width:75px;" id="detailquantity_${q.id }">
${q.quantity }
</div>
<div class="alert_content_div_nobold" style="width:75px;" >
${q.unit }
</div>
<div class="alert_content_div" style="width:75px;" id="weight_${q.id }">
<c:if test="${q.is_weigh!=1 }">
无需称重
</c:if>
<c:if test="${q.is_weigh==1 }">
${q.weight }
</c:if>
</div>
<div class="alert_content_div_nobold" style="width:75px;" id="detailprict_${q.id }">
<c:if test="${q.is_weigh!=1 }">
<fmt:formatNumber value="${q.quantity*q.price }" type="currency"/>
</c:if>
<c:if test="${q.is_weigh==1 }">
<fmt:formatNumber value="${q.quantity*q.price*q.weight }" type="currency"/>
</c:if>
</div> 
<div class="alert_content_div_nobold"  style="width:75px;text-align:right;">
<c:if test="${p.state==2 }">
<c:if test="${p.order.state!=4 }">
<img src="./imgs/oper_hide.png" id="operimg_${q.id}" style="margin-top:13px" onclick="changeoper(${q.id})">
</c:if>
</c:if>
</div> 
<div style="clear: both;width:755px;height:40px;line-height:40px;display:none;" id="oper_${q.id }">
<button type="button" class="btn btn-primary oper_btn"  aria-haspopup="true" aria-expanded="false" onclick="delOrderDetail(${q.id })">退菜</button>
<button type="button" class="btn btn-primary oper_btn"  aria-haspopup="true" aria-expanded="false" onclick="menuTableAlert(${p.table_id },${q.id},'${p.area_name }','${p.table_no }')">转菜</button>
<c:if test="${q.is_weigh==1 }">
<button type="button" class="btn btn-primary oper_btn"  aria-haspopup="true" aria-expanded="false" onclick="showWeightAlert(${q.id},'${q.menu_name }','${q.unit }')">称重</button>
 </c:if>
 <c:if test="${q.is_free!=1 }">
<button type="button" class="btn btn-primary oper_btn" id="freebtn_${q.id }"  aria-haspopup="true" aria-expanded="false" onclick="freeDetail(${q.id })">赠送</button>
<button type="button" class="btn btn-primary oper_btn" style="display:none;width:55px" id="cancelfreebtn_${q.id }"  aria-haspopup="true" aria-expanded="false" onclick="cancelfreeDetail(${q.id })">取消赠送</button>
</c:if>
 <c:if test="${q.is_free==1 }">
 <button type="button" class="btn btn-primary oper_btn" style="width:55px;" id="cancelfreebtn_${q.id }"  aria-haspopup="true" aria-expanded="false" onclick="cancelfreeDetail(${q.id })">取消赠送</button>
 <button type="button" class="btn btn-primary oper_btn" style="display:none;" id="freebtn_${q.id }"  aria-haspopup="true" aria-expanded="false" onclick="freeDetail(${q.id })">赠送</button>
 </c:if>
</div>
</div>

</c:forEach>
</div>
</c:if>
</div>
</c:forEach>
<div class="mask" style="display:none;"></div>

<div id="changeTableAlert" class="changeTable" style="display: none;">
<div style="background-color:#f5f6fa;width:100%;height:50px;line-height:50px;padding-left:20px;font-size:14px;font-family:'宋体';font-weight: bold;" >
转台<font id="changetitle" style="color:red;"></font>
<img src="./imgs/delete.png"  style="float: right;margin-top: 11px;margin-right: 15px;cursor: pointer;" onclick="hiddenchangeAlert()">
</div>
<div style="height:85px;line-height:85px;text-align:center;">
<select style="margin-right:20px;margin-top:0px;" class="category" id="alertarea_id" name="alertarea_id" onchange="changeArea()">
<option value="0">区域选择</option>
<c:forEach items="${arealist}" var="p" varStatus="status">  
<option value="${p.id }" >${p.area_name }</option>
</c:forEach>
</select>

<select style="margin-top:0px;" class="category" id="alerttable_id" name="alerttable_id">
<option value="">桌号选择</option>
</select>
</div>
<input type="hidden" id="changeFromTable" value="">
<button type="button" class="btn btn-primary detail_upload"  aria-haspopup="true" aria-expanded="false"  onclick="submitChangeTable()">确定</button>
</div>


<div id="changeMenuAlert" class="changeMenu" style="display: none;">
<div style="background-color:#f5f6fa;width:100%;height:50px;line-height:50px;padding-left:20px;font-size:14px;font-family:'宋体';font-weight: bold;" >
转菜<font id="menuchangetitle" style="color:red;"></font>
<img src="./imgs/delete.png"  style="float: right;margin-top: 11px;margin-right: 15px;cursor: pointer;" onclick="hiddenMenuchangeAlert()">
</div>
<div style="height:85px;line-height:85px;text-align:center;">
<select style="margin-right:20px;margin-top:0px;" class="category" id="alertmenuarea_id" name="alertmenuarea_id" onchange="changeMenuArea()">
<option value="0">区域选择</option>
<c:forEach items="${arealist}" var="p" varStatus="status">  
<option value="${p.id }" >${p.area_name }</option>
</c:forEach>
</select>

<select style="margin-top:0px;" class="category" id="alertmenutable_id" name="alertmenutable_id">
<option value="">桌号选择</option>
</select>
</div>
<input type="hidden" id="changeFromMenu" value="">
<button type="button" class="btn btn-primary detail_upload"  aria-haspopup="true" aria-expanded="false"  onclick="submitChangeMenu()">确定</button>
</div>


<div id="weightAlert" class="weightAlert" style="display: none;">
<div style="background-color:#f5f6fa;width:100%;height:50px;line-height:50px;padding-left:20px;font-size:14px;font-family:'宋体';font-weight: bold;" >
称重重量:<font id="weightname"></font>
<img src="./imgs/delete.png"  style="float: right;margin-top: 11px;margin-right: 15px;cursor: pointer;" onclick="hideWeightAlert()">
</div>
<div style="height:80px;line-height:80px;padding-left:120px;">
<input type="text" class="form-control" id="alertweight" onkeyup="checkKeyForFloat(event, 'alertweight')" value="" required="required" style="width: 200px; height: 33px; padding-left:5px; margin-top: 23px;float:left"><font id="weightunit" style="margin-left:15px"></font>
</div>
<input type="hidden" id="weightdetail_id" value="">
<button type="button" class="btn btn-primary detail_upload"  aria-haspopup="true" aria-expanded="false"  onclick="makeWeight()">称重</button>
</div>

<div id="payAlert" class="payAlert" style="width:800px;display: none;">
<form action="./cashier" method="post" id="payform">
<div style="background-color:#f5f6fa;width:100%;height:50px;line-height:50px;padding-left:20px;font-size:14px;font-family:'宋体';font-weight: bold;" >
收银<font id="paytitle" style="color:red;"></font>
<img src="./imgs/delete.png"  style="float: right;margin-top: 11px;margin-right: 15px;cursor: pointer;" onclick="hiddenpayAlert()">
</div>
<div style="overflow:auto;" id="paycontentdiv">
<div id="payleft" style="width:250px;height:100%;float:left;background-color:#5f97fa;padding-left:20px;padding-right:25px;">
<div style="width:100%;height:99px;line-height:99px;font-size:28px;font-family:'微软雅黑';color:#ffffff;border-bottom:#487fe0 1px solid">
<font style="float:left">应付</font>
<font style="float:right" id="alertprice"></font>
<input type="hidden" id="price" name="price">
</div>

<div style="width:100%;height:30px;margin-top:20px;line-height:30px;font-size:18px;font-family:'微软雅黑';color:#ffffff;">
<font style="float:left">总金额</font>
<font style="float:right" id="alerttotal"></font>
</div>
<div style="width:100%;height:30px;margin-top:10px;line-height:30px;font-size:18px;font-family:'微软雅黑';color:#ffffff;">
<font style="float:left">可打折</font>
<font style="float:right" id="alertdiscount"></font>
</div>
<div style="width:100%;height:30px;margin-top:10px;line-height:30px;font-size:18px;font-family:'微软雅黑';color:#ffffff;">
<font style="float:left">优惠额</font>
<font style="float:right" id="alertdiscountmoney">0</font>
</div>
<div style="width:100%;height:30px;margin-top:10px;line-height:30px;font-size:18px;font-family:'微软雅黑';color:#ffffff;">
<font style="float:left">不可打折</font>
<font style="float:right" id="alertundiscount"></font>
</div>
</div>
<div id="payright" style="width:533px;height:100%;float:left;font-size:14px;">
<div style="height:40px;line-height:40px;margin-top:10px;">
<div style="width:100px;text-align:right;height:40px;line-height:40px;float:left;font-size:12px;font-weight:bold;">
折扣
</div>
<input type="hidden" id="userdiscount"  >
<input type="hidden" id="userlimitreset" >
<input type="text" class="form-control" id="orderdiscount"  name="discount" onkeyup="checkKeyForFloat(event, 'orderdiscount')" onblur="countdiscount()"  value=""  placeholder="请输入折扣" style="border-radius:0;margin-left:10px;width: 200px; height: 33px; padding-left:5px; margin-top: 3px;float:left">
<font style="float:left;margin-right:10px;">%</font><font style="margin-left:10px;float:left;color:red;" id="discounterr"></font>
</div>

<div style="height:40px;line-height:40px;margin-top:10px;">
<div style="width:100px;text-align:right;height:40px;line-height:40px;float:left;font-size:12px;font-weight:bold;">
抹零
</div>
<input type="text" class="form-control" id="moling" name="moling" onkeyup="checkKeyForFloat(event, 'moling')" onblur="countdiscount()"  value=""  placeholder="请输入抹零金额" style="border-radius:0;margin-left:10px;width: 200px; height: 33px; padding-left:5px; margin-top: 3px;float:left">
<font style="margin-left:10px;float:left;color:red;" id="molingerr"></font>
</div>

<div style="height:40px;line-height:40px;margin-top:10px;">
<div style="width:100px;text-align:right;height:40px;line-height:40px;float:left;font-size:12px;font-weight:bold;">
优惠券
</div>
<input type="text" class="form-control" id="ordercoupon"    value=""  placeholder="请输入优惠券号码" style="border-radius:0;margin-left:10px;width: 200px; height: 33px; padding-left:5px; margin-top: 3px;float:left">
<input type="hidden" id="mycouponid" name="coupon_id">
<input type="hidden" id="amount" >
<button type="button" style="margin-right:0px;float: left;margin-left: 10px;height: 30px;margin-top: 4px;" class="btn btn-primary detail_upload" aria-haspopup="true" aria-expanded="false" id="checkcouponbtn" onclick="checkcoupon()">校验优惠券</button>
<font style="margin-left:10px;float:left;color:red;" id="couponerr"></font>
</div>

<div style="height:40px;line-height:40px;margin-top:10px;">
<div style="width:100px;text-align:right;height:40px;line-height:40px;float:left;font-size:12px;font-weight:bold;">
支付类型
</div>
<select style="margin-right:20px;margin-top:0px;float:left;margin-left:10px;" class="category" id="alertpaytype" onchange="changePayType()" >
<option value="1">现金/支付宝/刷卡</option>
<option value="0">充值卡</option>
<option value="2">签单</option>
<option value="3">免单</option>
</select>
</div>

<div style="width:100%;height:50px;display:none;"  class="paytype_div" id="paytype_0">
<div style="height:40px;line-height:40px;margin-top:10px">
<div style="width:100px;text-align:right;height:40px;line-height:40px;float:left;font-size:12px;font-weight:bold;">
充值卡
</div>
<input type="text" class="form-control" id="orderRechargeCard"    value=""  placeholder="请输入充值卡卡号" style="border-radius:0;margin-left:10px;width: 200px; height: 33px; padding-left:5px; margin-top: 3px;float:left">
<input type="hidden" id="rechargecardid" name="card_id">
<button type="button" style="margin-right:0px;float: left;margin-left: 10px;height: 30px;margin-top: 4px;" class="btn btn-primary detail_upload" aria-haspopup="true" aria-expanded="false" id="rechargecardbtn" onclick="checkrechargecard()">校验充值卡</button>
<font style="margin-left:10px;float:left;color:red;" id="rechargecarderr"></font>
</div>
</div>

<div style="width:100%;height:150px;display:block;"  class="paytype_div" id="paytype_1">
<div style="float:left;width:60%;height:100%;">
<div style="height:40px;line-height:40px;margin-top:10px">
<div style="width:100px;text-align:right;height:40px;line-height:40px;float:left;font-size:12px;font-weight:bold;">
现金 
</div>
<input type="text" class="form-control" id="ordercash" name="ordercash" onkeyup="checkKeyForFloat(event, 'ordercash')"  onblur="countPay()"   value=""  placeholder="请输入现金支付金额" style="border-radius:0;margin-left:10px;width: 200px; height: 33px; padding-left:5px; margin-top: 3px;float:left">
</div>
<div style="height:40px;line-height:40px;margin-top:10px">
<div style="width:100px;text-align:right;height:40px;line-height:40px;float:left;font-size:12px;font-weight:bold;">
支付宝
</div>
<input type="text" class="form-control" id="orderzhifubao" name="orderzhifubao" onkeyup="checkKeyForFloat(event, 'orderzhifubao')" onblur="countPay()"  value=""  placeholder="请输入支付宝支付金额" style="border-radius:0;margin-left:10px;width: 200px; height: 33px; padding-left:5px; margin-top: 3px;float:left">
</div>
<div style="height:40px;line-height:40px;margin-top:10px">
<div style="width:100px;text-align:right;height:40px;line-height:40px;float:left;font-size:12px;font-weight:bold;">
刷卡
</div>
<input type="text" class="form-control" id="ordercard" name="ordercard" onkeyup="checkKeyForFloat(event, 'ordercard')" onblur="countPay()"    value=""  placeholder="请输入刷卡支付金额" style="border-radius:0;margin-left:10px;width: 200px; height: 33px; padding-left:5px; margin-top: 3px;float:left">
</div>
</div>
<div style="float:left;width:30%;height:100%;line-height:150px;font-size:16px;font-weight:bold;">
找零:<font id="zhaoling" style="margin-left:5px;"></font>
</div>
</div>

<div style="width:100%;height:50px;display:none;"  class="paytype_div" id="paytype_2">
<div style="height:40px;line-height:40px;margin-top:10px;">
<div style="width:100px;text-align:right;height:40px;line-height:40px;float:left;font-size:12px;font-weight:bold;">
签单人
</div>
<select style="margin-right:20px;margin-top:0px;float:left;margin-left:10px;" class="category" id="qiandan_id" name="qiandan_id" >
<option value="">请选择签单人</option>
<c:forEach items="${signerlist}" var="p" varStatus="status">  
<option value="${p.id }">${p.company }:${p.name }</option>
</c:forEach>
</select>
</div>	
</div> 

<div style="width:100%;height:50px;display:none;"  class="paytype_div" id="paytype_3">
<div style="height:40px;line-height:40px;margin-top:10px;">
<div style="width:100px;text-align:right;height:40px;line-height:40px;float:left;font-size:12px;font-weight:bold;">
免单
</div>
<select style="margin-right:20px;margin-top:0px;float:left;margin-left:10px;" class="category" id="miandan_id" name="miandan_id" >
<option value="">请选择免单人</option>
<c:forEach items="${signerlist}" var="p" varStatus="status">  
<option value="${p.id }">${p.company }:${p.name }</option>
</c:forEach>
</select>
</div>
</div>

<div style="height:120px;line-height:40px;">
<div style="width:100px;text-align:right;height:100%;line-height:40px;float:left;font-size:12px;font-weight:bold;">
备注
</div>
<textarea style="width: 420px;height: 110px; margin-left: 10px;    border: 1px solid #ccc;resize:none;" name="comment"></textarea>
</div>
<input type="hidden" id="payorderid" name="order_id">
<input type="hidden" id="type" name="type" >
<button type="button" class="btn btn-primary detail_upload" aria-haspopup="true" aria-expanded="false" onclick="submitPay()">确定收银</button>
<div  id="submiterr" style="float:right;height:40px;line-height:40px;text-align:left;margin-right:20px;width:250px;color:red;"></div>
<input type="hidden" id="isrecive" value="0">
</div>
</div>
</form>
</div>

<div id="addmenuAlert" class="addmenuAlert" style="display: none;">
<form id="addmenuform">
<div style="background-color:#f5f6fa;width:100%;height:50px;line-height:50px;padding-left:20px;font-size:14px;font-family:'宋体';font-weight: bold;" >
加菜<font id="addmenutitle" style="color:red;"></font>
<img src="./imgs/delete.png"  style="float: right;margin-top: 11px;margin-right: 15px;cursor: pointer;" onclick="hiddenaddmenuAlert()">
</div>
<div style="height:60px;line-height:60px;width:100%;text-align:center;font-family:'微软雅黑'">
所属分类:
<select style="margin-right:20px;margin-top:0px;margin-left:10px;" class="category" onchange="changemenutype()" id="menu_type" name="menu_type" >
<option value="0">全部分类</option>
<c:forEach items="${menucategorys}" var="p" varStatus="status">  
<option value="${p.id }">${p.name }</option>
</c:forEach>
</select>
</div>
<div style="clear:both;padding-left:20px;padding-right:20px;background-color:#f5f6fa;width:100%;height:48px;line-height:48px;border-top: 1px solid #ffffff;">
<div class="alert_content_div" style="width:270px;">
菜名
</div>
<div class="alert_content_div" style="width:130px;">
单价
</div>
<div class="alert_content_div" style="width:100px;">
单位
</div>
<div class="alert_content_div" style="width:150px;">
数量
</div>
</div>
<div class="addmenualert_content" id="addmenualert_content" style="width:100%;overflow: auto;">
<c:forEach items="${menulist}" var="q" varStatus="st">
<div style="margin-left:20px;margin-right:20px;height:49px;line-height:49px;border-bottom: 1px solid #e5e6ea;" >
<div class="alert_content_div" style="width:270px;">
${q.menu_name }
</div>
<div class="alert_content_div" style="width:130px;">
${q.price }
</div>
<div class="alert_content_div" style="width:100px;">
${q.unit }
</div>
<div class="alert_content_div" style="width:140px;">
<input type="hidden" name="menuid" value="${q.menu_id }" id="menu_${q.menu_id }">
<input type="text" class="form-control inputnum" maxlength="4" name="menunum" id="num_${q.menu_id }" onblur="checkmenunum(${q.menu_id})" onkeyup="return checkNum(event,'num_${q.menu_id }')"  onkeydown="return checkNum(event,'num_${q.menu_id }')"   value="0" required="required" >
</div>
</div>
</c:forEach>
</div>
<button type="button" class="btn btn-primary detail_upload" style="margin-top:5px;" aria-haspopup="true" aria-expanded="false" onclick="submitAdd()">确定添加</button>
<input type="hidden" id="addorderid" name="order_id">
</form>
</div>
</html>