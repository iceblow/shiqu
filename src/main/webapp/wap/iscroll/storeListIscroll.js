function pullUpAction() {
	var pushflg = $("#pushflg").val();
	if (pushflg == 0) {
		loadMoreShopList();
	}
}

function loadMoreShopList() {
	$("#loadmorecontent").text("努力加载中......");
	$("#pushflg").val(1);
	var pageIndex = $("#pageIndex").val();
	pageIndex = parseInt(pageIndex) + 1;
	var lat = $("#lat").val();
	var lon = $("#lon").val();
	var category_id = $("#category_id").val(); 
	$.ajax({
		url:'./storelist',
		type:'post',
		data:{'lon':lon,'lat':lat,'pageIndex':pageIndex,'category_id':category_id},
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

function  pullOrderUpAction(){
	var pushflg = $("#pushflg").val();
	if (pushflg == 0) {
		loadOrderMoreShopList();
	}
}

function loadOrderMoreShopList(){
	$("#loadmorecontent").text("努力加载中......");
	$("#pushflg").val(1);
	var pageIndex = $("#pageIndex").val();
	pageIndex = parseInt(pageIndex) + 1;
	$.ajax({
		url:'./pullpresentorderlist',
		type:'post',
		data:{'pageIndex':pageIndex},
		success:function(msg){
//			var msgdata = eval("("+msg+")");
			var orderlist = msg.orderlist;
			if(orderlist==null||orderlist.length==0){
				$("#loadmorecontent").text("暂无更多订单!");
			}else{
				var html = '<div style="background: #f0f0f0; width: 100%; height: 9px;"></div>';
				for(var i=0;i<orderlist.length;i++){
					html += '<div style="width: 100%; height: 182px; background: #fff;">';
					html += '<div style="width: 92%; height: 182px; margin: 0 auto;">';
					html += '<div style="width: 100%; height: 14px; text-align: center; margin-top: 15px;">';
					html += '<img src="imgs/small_store_icon.png" style="width: 14px; height: 14px;"></div>';	
					html += '<div style="width: 100%; height: 43px; text-align: center; line-height: 43px; color: #ffba3f; font-size: 17px; border-bottom: 1px solid #e5e5e5;">'+orderlist[i].store.store_name+'</div>';
					html += '<div style="width: 100%; height: 40px; text-align: left; line-height: 40px; font-size: 14px; overflow: hidden; ">';
					if(orderlist[i].menu_list.length <= 2){
						for(var j = 0; j < orderlist[i].menu_list.length; j++){
							if(j == orderlist[i].menu_list.length -1){
								html += orderlist[i].menu_list[j].menu_name;
							}else{
								html += orderlist[i].menu_list[j].menu_name+'、';
							}
						}
					}else{
						for(var j = 0; j < 2; j++){
							if(j == 1){
								html += orderlist[i].menu_list[j].menu_name;
							}else{
								html += orderlist[i].menu_list[j].menu_name+'、';
							}
						}
						html += '&nbsp;&nbsp;等'+orderlist[i].menu_list.length+'样菜';
					}
					html += '</div>';
					html += '<div style="width: 100%; height: 25px; text-align: left; font-size: 12px; color: #cfcfcf;border-bottom: 1px solid #e5e5e5;">时间:';
					if(orderlist[i].check_time != null){
						html += orderlist[i].str_Check_time+'&nbsp;&nbsp;结账</div>';
					}else{
						html += orderlist[i].str_Order_time+'&nbsp;&nbsp;下单</div>';
					}
					html += '<div style="height: 41px; line-height: 41px; float:left;">';
					html += '<span style="text-align: left;">金额：<font style="color: #ff4532;">'+parseInt(orderlist[i].total_price)+'元</font></span></div>';
					html += '<div style="height: 41px; line-height: 41px; float:right;">';
					html += '<span style="text-align: right; color:#857777;">';
					if(orderlist[i].is_out == 0){
						html += '堂食：';
					}
					if(orderlist[i].is_out == 1){
						html += '外卖：';
					}
					if(orderlist[i].state == 1){
						html += '<font style="color: #ffba40;">店家未确认</font></span></div>';
					}
					if(orderlist[i].state == 2){
						html += '<font style="color: #57ceb0;">店家已确认</font></span></div>';
					}
					html += '</div></div>';
					if(i != orderlist.length -1){
						html += '<div style="background: #f0f0f0; width: 100%; height: 9px;"></div>';
					}
				}
				$("#loadmorecontent").text("下拉加载更多");
				$(".orderlist").append(html);
				$("#pageIndex").val(pageIndex);
				$("#pushflg").val(0);
				myScroll.refresh();
			}
		}
	})
}

function pullhereOrderUpAction(){
	var pushflg = $("#pushflg").val();
	if (pushflg == 0) {
		loadhereOrderMoreShopList();
	}
}

function loadhereOrderMoreShopList(){
	$("#loadmorecontent").text("努力加载中......");
	$("#pushflg").val(1);
	var pageIndex = $("#pageIndex").val();
	pageIndex = parseInt(pageIndex) + 1;
	$.ajax({
		url:'./pullhereorderlist',
		type:'post',
		data:{'pageIndex':pageIndex, 'is_out' :0},
		success:function(msg){
			var orderlist = msg.orderlist;
			if(orderlist==null||orderlist.length==0){
				$("#loadmorecontent").text("暂无更多订单!");
			}else{
				var html = '<div style="background: #f0f0f0; width: 100%; height: 9px;"></div>';
				for(var i=0;i<orderlist.length;i++){
					html += '<div style="width: 100%; height: 182px; background: #fff;">';
					html += '<div style="width: 92%; height: 182px; margin: 0 auto;">';
					html += '<div style="width: 100%; height: 14px; text-align: center; margin-top: 15px;">';
					html += '<img src="imgs/small_store_icon.png" style="width: 14px; height: 14px;"></div>';	
					html += '<div style="width: 100%; height: 43px; text-align: center; line-height: 43px; color: #ffba3f; font-size: 17px; border-bottom: 1px solid #e5e5e5;">'+orderlist[i].store.store_name+'</div>';
					html += '<div style="width: 100%; height: 40px; text-align: left; line-height: 40px; font-size: 14px; overflow: hidden; ">';
					if(orderlist[i].menu_list.length <= 2){
						for(var j = 0; j < orderlist[i].menu_list.length; j++){
							if(j == orderlist[i].menu_list.length -1){
								html += orderlist[i].menu_list[j].menu_name;
							}else{
								html += orderlist[i].menu_list[j].menu_name+'、';
							}
						}
					}else{
						for(var j = 0; j < 2; j++){
							if(j == 1){
								html += orderlist[i].menu_list[j].menu_name;
							}else{
								html += orderlist[i].menu_list[j].menu_name+'、';
							}
						}
						html += '&nbsp;&nbsp;等'+orderlist[i].menu_list.length+'样菜';
					}
					html += '</div>';
					html += '<div style="width: 100%; height: 25px; text-align: left; font-size: 12px; color: #cfcfcf;border-bottom: 1px solid #e5e5e5;">时间:';
					if(orderlist[i].check_time != null){
						html += orderlist[i].str_Check_time+'&nbsp;&nbsp;结账</div>';
					}else{
						html += orderlist[i].str_Order_time+'&nbsp;&nbsp;下单</div>';
					}
					html += '<div style="height: 41px; line-height: 41px; float:left;">';
					html += '<span style="text-align: left;">金额：<font style="color: #ff4532;">'+parseInt(orderlist[i].total_price)+'元</font></span></div>';
					html += '<div style="height: 41px; line-height: 41px; float:right;">';
					html += '<span style="text-align: right; color:#857777;">堂食：';
					if(orderlist[i].state == 3){
						html += '<font style="color: #ff837a;">店家拒单</font></span></div>';
					}
					if(orderlist[i].state == 4){
						html += '<font style="color: #12c6d1;">已付款</font></span></div>';
					}
					if(orderlist[i].state == 5){
						html += '<font style="color: #ccc7c7;">取消</font></span></div>';
					}
					html += '</div></div>';
					if(i != orderlist.length -1){
						html += '<div style="background: #f0f0f0; width: 100%; height: 9px;"></div>';
					}
				}
				$("#loadmorecontent").text("下拉加载更多");
				$(".orderlist").append(html);
				$("#pageIndex").val(pageIndex);
				$("#pushflg").val(0);
				myScroll.refresh();
			}
		}
	})
}

function pullOutOrderUpAction(){
	var pushflg = $("#pushflg").val();
	if (pushflg == 0) {
		loadOutOrderMoreShopList();
	}
}

function loadOutOrderMoreShopList(){
	$("#loadmorecontent").text("努力加载中......");
	$("#pushflg").val(1);
	var pageIndex = $("#pageIndex").val();
	pageIndex = parseInt(pageIndex) + 1;
	$.ajax({
		url:'./pullhereorderlist',
		type:'post',
		data:{'pageIndex':pageIndex, 'is_out' : 1},
		success:function(msg){
			var orderlist = msg.orderlist;
			if(orderlist==null||orderlist.length==0){
				$("#loadmorecontent").text("暂无更多订单!");
			}else{
				var html = '<div style="background: #f0f0f0; width: 100%; height: 9px;"></div>';
				for(var i=0;i<orderlist.length;i++){
					html += '<div style="width: 100%; height: 182px; background: #fff;">';
					html += '<div style="width: 92%; height: 182px; margin: 0 auto;">';
					html += '<div style="width: 100%; height: 14px; text-align: center; margin-top: 15px;">';
					html += '<img src="imgs/small_store_icon.png" style="width: 14px; height: 14px;"></div>';	
					html += '<div style="width: 100%; height: 43px; text-align: center; line-height: 43px; color: #ffba3f; font-size: 17px; border-bottom: 1px solid #e5e5e5;">'+orderlist[i].store.store_name+'</div>';
					html += '<div style="width: 100%; height: 40px; text-align: left; line-height: 40px; font-size: 14px; overflow: hidden; ">';
					if(orderlist[i].menu_list.length <= 2){
						for(var j = 0; j < orderlist[i].menu_list.length; j++){
							if(j == orderlist[i].menu_list.length -1){
								html += orderlist[i].menu_list[j].menu_name;
							}else{
								html += orderlist[i].menu_list[j].menu_name+'、';
							}
						}
					}else{
						for(var j = 0; j < 2; j++){
							if(j == 1){
								html += orderlist[i].menu_list[j].menu_name;
							}else{
								html += orderlist[i].menu_list[j].menu_name+'、';
							}
						}
						html += '&nbsp;&nbsp;等'+orderlist[i].menu_list.length+'样菜';
					}
					html += '</div>';
					html += '<div style="width: 100%; height: 25px; text-align: left; font-size: 12px; color: #cfcfcf;border-bottom: 1px solid #e5e5e5;">时间:';
					if(orderlist[i].check_time != null){
						html += orderlist[i].str_Check_time+'&nbsp;&nbsp;结账</div>';
					}else{
						html += orderlist[i].str_Order_time+'&nbsp;&nbsp;下单</div>';
					}
					html += '<div style="height: 41px; line-height: 41px; float:left;">';
					html += '<span style="text-align: left;">金额：<font style="color: #ff4532;">'+parseInt(orderlist[i].total_price)+'元</font></span></div>';
					html += '<div style="height: 41px; line-height: 41px; float:right;">';
					html += '<span style="text-align: right; color:#857777;">外卖：';
					if(orderlist[i].state == 3){
						html += '<font style="color: #ff837a;">店家拒单</font></span></div>';
					}
					if(orderlist[i].state == 4){
						html += '<font style="color: #12c6d1;">已付款</font></span></div>';
					}
					if(orderlist[i].state == 5){
						html += '<font style="color: #ccc7c7;">取消</font></span></div>';
					}
					html += '</div></div>';
					if(i != orderlist.length -1){
						html += '<div style="background: #f0f0f0; width: 100%; height: 9px;"></div>';
					}
				}
				$("#loadmorecontent").text("下拉加载更多");
				$(".orderlist").append(html);
				$("#pageIndex").val(pageIndex);
				$("#pushflg").val(0);
				myScroll.refresh();
			}
		}
	})
}
