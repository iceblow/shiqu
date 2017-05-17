<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/dishes.css" rel="stylesheet">
<link href="./css/common.css" rel="stylesheet">
<link href="./css/page.css" rel="stylesheet">
<script src="./js/jquery-1.11.2.min.js"></script>
<script src="./js/page.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	 $("#checkAll").click(function() {
	        $('input[name="user_id"]').prop("checked",this.checked); 
	    });
	    var $user_id = $("input[name='user_id']");
	    $user_id.click(function(){
	        $("#checkAll").prop("checked",$user_id.length == $("input[name='user_id']:checked").length ? true : false);
	    });
});

function sendmessagelist(){
	var idlength =   $("input[name='user_id']:checked").length;
	if(idlength == 0){
		alert("至少选择一个用户！");
		return;
	}else{
		showalert();
	}
}

function showalert(){
	window.top.showmask();
	$(".mask").show();
	$(".alert").css("top",document.documentElement.clientHeight/2-$(".alert").height()/2);
	$(".alert").css("left",document.documentElement.clientWidth/2-$(".alert").width()/2);
	$(".alert").show();
}

function Tshowalert(){
	window.top.showmask();
	$(".mask").show();
	$(".Talert").css("top",document.documentElement.clientHeight/2-$(".Talert").height()/2);
	$(".Talert").css("left",document.documentElement.clientWidth/2-$(".Talert").width()/2);
	$(".Talert").show();
}

function sendsolomessage(user_id){
	$("#alert_user_id").val(user_id);
	window.top.showmask();
	$(".mask").show();
	$(".alert").css("top",document.documentElement.clientHeight/2-$(".alert").height()/2);
	$(".alert").css("left",document.documentElement.clientWidth/2-$(".alert").width()/2);
	$(".alert").show();
}

function hide(){
	$(".mask").hide();
	$(".alert").hide();
	window.top.hidemask();
	window.parent.hidemask();
}

function Thide(){
	$(".mask").hide();
	$(".Talert").hide();
	window.top.hidemask();
	window.parent.hidemask();
}

function saveorupdate(){
	var user_id = $("#alert_user_id").val();
	var alert_title = $("#alert_title").val();
	if(alert_title == ''){
		alert("请输入标题");
		return;
	}
	var alert_content = $("#alert_content").val();
	if(alert_content == ''){
		alert("请输入内容");
		return;
	}
	
	if(user_id == ""){
		$("#title").val(alert_title);
		$("#messagecontent").val(alert_content);
		$.ajax({
			type: "post",
			url: "./sendmessagelist",
			data: $("#messageForm").serialize(),
			success: function(data){
				if(data == "success"){
					alert("发送成功！");
					hide();
					window.location.reload();
				}
			}
		});
	}else{
		$.ajax({
			type: "post",
			url: "./sendmessagelist",
			data: $("#alertmessageForm").serialize(),
			success: function(data){
				if(data == "success"){
					alert("发送成功！");
					hide();
					window.location.reload();
				}
			}
		});
	}
}

function paifacouponlist(){
	var idlength =   $("input[name='user_id']:checked").length;
	if(idlength == 0){
		alert("至少选择一个用户！");
		return;
	}else{
		Tshowalert();
	}
}

function chooseCopon(index, coupon_id){
	var flag = $("#choose_flag_"+index).val();
	var couponcount = $("#couponcount").text();
	var alert_select_coupon = $("#alert_select_coupon").val();
	if(flag == 0){
		$("#choose_div_"+index).css("background-image","url(imgs/chooseimg.png)");
		$("#choose_div_"+index).css("background-size","100% 100%");
		$("#choose_div_"+index).css("background-repeat","no-repeat");
		$("#choose_div_"+index).css("color","#fff");
		$("#couponcount").text(parseInt(couponcount)+1);
		$("#choose_flag_"+index).val(1);
		if(alert_select_coupon == ''){
			$("#alert_select_coupon").val(coupon_id);
		}else{
			$("#alert_select_coupon").val(alert_select_coupon+","+coupon_id);
		}
	}else{
		$("#choose_div_"+index).css("background-image","");
		$("#choose_div_"+index).css("background-size","");
		$("#choose_div_"+index).css("background-repeat","");
		$("#choose_div_"+index).css("color","#222222");
		if(couponcount == 0){
			$("#couponcount").text(0);
		}else{
			$("#couponcount").text(parseInt(couponcount)-1);
		}
		var new_select_coupon = "";
		var array = alert_select_coupon.split(',');
		for(var i=0;i<array.length;i++){
			if(array[i] == coupon_id){
			}else{
				if(new_select_coupon == ""){
					new_select_coupon = array[i];
				}else{
					new_select_coupon = new_select_coupon+","+array[i];
				}
			}
		}
		$("#alert_select_coupon").val(new_select_coupon);
		$("#choose_flag_"+index).val(0);
	}
	
}

function solocoupon(user_id){
	$("#Talert_user_id").val(user_id);
	window.top.showmask();
	$(".mask").show();
	$(".Talert").css("top",document.documentElement.clientHeight/2-$(".Talert").height()/2);
	$(".Talert").css("left",document.documentElement.clientWidth/2-$(".Talert").width()/2);
	$(".Talert").show();
}
function paifacoupon(){
	var user_id = $("#Talert_user_id").val();
	var alert_select_coupon = $("#alert_select_coupon").val();
	if(alert_select_coupon == ""){
		alert("到少选择1张优惠券");
		return;
	}
	if(user_id == ""){
		$("#coupon_ids").val(alert_select_coupon);
		$.ajax({
			type: "post",
			url: "./distriCouponlist",
			data: $("#messageForm").serialize(),
			success: function(data){
				if(data == "success"){
					alert("发送成功！");
					Thide();
					window.location.reload();
				}
			}
		});
	}else{
		$.ajax({
			type: "post",
			url: "./distriCouponlist",
			data: $("#paifacouponForm").serialize(),
			success: function(data){
				if(data == "success"){
					alert("发送成功！");
					Thide();
					window.location.reload();
				}
			}
		});
	}
}

function search(){
	var keyword = $("#keyword").val();
	window.location.href ="./usermanage?keyword="+keyword;
}
</script>
<title>食趣商家管理平台</title>
</head>
<body>
<div id="content">
	<div style="width: 100%; height: 97px;">
		<div style="width: 100%; height: 21px;"></div>
		<div class="sendmessage" onclick="sendmessagelist()"><img src="imgs/message_icon.png" style="width: 12px; height: 12px; margin-left: 10px; margin-right: 5px;">群发消息</div>
		<div class="paifabutton" style="margin-left: 18px;" onclick="paifacouponlist()"><img src="imgs/pai.png" style="width: 12px; height: 12px; margin-left: 10px; margin-right: 5px;">发代金券</div>
		<span style="float: left; margin-left: 18px; line-height: 46px; color: #bdc6d7;">共${total }名收藏用户</span>
		<div class="searchbutton" onclick="search()"></div>
		<input type="text" value="${keyword }" name="keyword" id="keyword" style="width: 167px; height: 39px; border: 1px solid #bdc6d7; float:right; margin-right: 10px; padding-left:5px;"/>
	</div>
	<form action="" id="messageForm" method="post">
	<input type="hidden" value="" name="title" id="title"/>
	<input type="hidden" value="" name="messagecontent" id="messagecontent"/>
	<input type="hidden" value="" name="coupon_ids" id="coupon_ids"/>
	<table class="table" style="th:border-top: 0px;" border="0" cellspacing="0" cellpadding="0">
	<tr class="tablehead">
	<th style="width:4%;"><input id="checkAll" type="checkbox" name="checall"/></th>
	<th style="width:15%;">头像</th> 	 
	<th style="width:10%;">昵称</th> 	 
	<th style="width:10%;">姓名</th> 	 
	<th style="width:10%;">用户名</th> 	 
	<th style="width:10%;">性别</th> 	 
	<th style="width:10%;">出生年月</th> 	 
	<th style="width:10%;">手机号</th> 	 
	<th style="width:20%;">操作</th> 	 
	</tr>
	<c:forEach items="${userlist}" var="p">
	<tr>
	<th style="width:4%;" class="border_right tablethcss"><input type="checkbox" name="user_id" value="${p.user_id }"/></th>
	<th style="width:15%;" class="border_right tablethcss" style="min-width: 50px;">
		<c:if test="${empty p.avatar_url }">
			<img src="imgs/defalut.png" style="width: 50px; height: 50px;"> 
		</c:if>
		<c:if test="${not empty p.avatar_url }">
			<img src="${p.avatar_url }" style="width: 50px; height: 50px;"> 
		</c:if>
	</th> 	 
	<th style="width:10%;" class="border_right tablethcss">${p.nick_name }</th> 	 
	<th style="width:10%;" class="border_right tablethcss">${p.real_name }</th> 	 
	<th style="width:10%;" class="border_right tablethcss">${p.user_name }</th> 	 
	<th style="width:10%;" class="border_right tablethcss">${p.gender }</th> 	 
	<th style="width:10%;" class="border_right tablethcss"><fmt:formatDate value="${p.birthday }" pattern="yyyy.MM.dd"/> </th> 	 
	<th style="width:10%;" class="border_right tablethcss">${p.phone }</th> 	 
	<th style="width:20%; min-width: 240px;" class="tablethcss">
		<div class="table_message_button" onclick="sendsolomessage(${p.user_id})" style="margin-left:2%; width: 104px; ">
			<div class="table_button_message_icon"></div>
			<div class="table_button_text" style="color: #6097fb;">发送消息</div>
		</div>
		<div style="width:1px; height:26px; border: 1px solid #d3d6d8; float: left;margin-left:2%;"></div>
		<div class="table_paifa_button" onclick="solocoupon(${p.user_id})" style="margin-left:2%; width: 104px; ">
			<div class="table_button_paifa_icon"></div>
			<div class="table_button_text" style="color: #35aa47;">派发优惠券</div>
		</div>
	</th> 	 
	</tr>
	</c:forEach>
	<c:if test="${pageCount>1}">
	<tr style="border-bottom: 1px solid #eaeff2">
	<td colspan="9" style="height:86px;">
	<input type="hidden" value="${pageCount }"/>
				<input type="hidden" value="${pageCount }" id="pageSize" />
				<input type="hidden" value="${pageIndex }" id="pageIndex" />
				<div id="untreatedpage" ></div>
				<script type="text/javascript">
					//container 容器，count 总页数 pageindex 当前页数
					function setPage(container, count, pageindex) {
					var container = container;
					var count = parseInt(count);
					var pageindex = parseInt(pageindex);
					var keyword = $("#keyword").val();
					var a = [];
					  //总页数少于10 全部显示,大于10 显示前3 后3 中间3 其余....
					  if (pageindex == 1) {
						  //alert(pageindex);
					    a[a.length] = "<a onclick=\"\" class=\"hide_page_prev unclickprev on\"></a>";
					  } else {
					    a[a.length] = "<a onclick=\"previousPage("+pageindex+",'./usermanage?keyword="+keyword+"&')\" class=\"page_prev\"></a>";
					  }
					  function setPageList() {
					    if (pageindex == i) {
					      a[a.length] = "<a onclick=\"goPage('./usermanage?keyword="+keyword+"&',"+i+")\" class=\"on\">" + i + "</a>";
					    } else {
					      a[a.length] = "<a onclick=\"goPage('./usermanage?keyword="+keyword+"&',"+i+")\">" + i + "</a>";
					    }
					  }
					  //总页数小于10
					  if (count <= 10) {
					    for (var i = 1; i <= count; i++) {
					      setPageList();
					    };
					  } else {
						//总页数大于10页
					    if (pageindex <= 4) {
					      for (var i = 1; i <= 5; i++) {
					        setPageList();
					      }
					      a[a.length] = "...<a onclick=\"goPage('./usermanage?keyword="+keyword+"&',"+count+")\">" + count + "</a>";
					    } else if (pageindex >= count - 3) {
					      a[a.length] = "<a onclick=\"goPage('./usermanage?keyword="+keyword+"&',1)\">1</a>...";
					      for (var i = count - 4; i <= count; i++) {
					        setPageList();
					      };
					    } else { //当前页在中间部分
					      a[a.length] = "<a onclick=\"goPage('./usermanage?keyword="+keyword+"&',1)\">1</a>...";
					      for (var i = pageindex - 2; i <= pageindex+2; i++) {
					        setPageList();
					      }
					      a[a.length] = "...<a onclick=\"goPage('./usermanage?keyword="+keyword+"&',"+count+")\">" + count + "</a>";
					    }
					  }
					  if (pageindex == count) {
						    a[a.length] = "<a onclick=\"\" class=\"hide_page_next unclicknext\"></a> 共"+count+"页  到第  "+
						    "<input type=\"text\" class=\"jump_num\" id=\"topage\"/> 页"+
						    "<a class=\"jump_btn\" onclick=\"gotoPage('./usermanage?keyword="+keyword+"&',"+$("#pageSize").val()+")\")\">"+
						    "<a id='page_msg'></a>";
						  } else {
						    a[a.length] = 
						    	"<a onclick=\"nextPage("+$("#pageIndex").val()+",'./usermanage?keyword="+keyword+"&')\" "+
						    	"class=\"page_next\"></a> 共"+count+"页 到第 "+
						    "<input type=\"text\" class=\"jump_num\" id=\"topage\"/> 页"+
						    "<a class=\"jump_btn\" onclick=\"gotoPage('./usermanage?keyword="+keyword+"&',"+$("#pageSize").val()+")\">"+
						    "<a id='page_msg'></a>";
						  }
					  container.innerHTML = a.join("");
					} 
					setPage(document.getElementById("untreatedpage"),parseInt($("#pageSize").val()),parseInt($("#pageIndex").val()));
					</script>
		</td>
		</tr>
		</c:if>
	</table>
	</form>
</div>
</body>
<div class="mask" style="display:none;"></div>
<div class="alert" id="alertdiv" style="width: 450px; height: 395px; display:none">
<form action="" id="alertmessageForm">
	<input type="hidden" value="" id="alert_user_id" name="user_id"/>
	<div style="width: 100%; height: 65px; background: #f5f6fa;">
		<div style="height: 19px;"></div>
		<div style="width: 400px; height: 27px;margin: 0 auto;text-align: left;">
			发送消息
			<img src="imgs/alertclose.png" style="float:right;cursor: pointer;" onclick="hide()">
		</div>
	</div>
	<div style="width: 100%; height: 45px;"></div>
	<span style="margin-left: 15px;">标题:</span><input type="text" value="" id="alert_title" name="title" style="border: 1px solid #bdc6d7; width: 305px; height: 43px; padding-left: 5px; margin-left: 12px;"/>
	<div style="width: 100%; height: 10px;"></div>
	<span style="margin-left: 15px;">内容:</span><textarea id="alert_content" name="messagecontent" style="width: 305px; height: 150px; border: 1px solid #bdc6d7;padding-left: 5px; margin-left: 12px;resize: none;"></textarea>
	<div style="width: 100%; height: 10px;"></div>
	<div style="width: 75px; height: 45px; background: #6097fb; text-align: center; line-height: 45px; float:right; color: #fff; margin-top: 14px; margin-right: 15px; cursor: pointer;" onclick="saveorupdate()">确定</div>
</form>
</div>
<div class="Talert" id="Talertdiv" style="width: 720px; height: 395px; display:none">
<form action="" id="paifacouponForm">
	<input type="hidden" value="" id="Talert_user_id" name="user_id"/>
	<input type="hidden" value="" id="alert_select_coupon" name="coupon_ids"/>
	<div style="width: 100%; height: 65px; background: #f5f6fa;">
		<div style="height: 19px;"></div>
		<div style="width: 676px; height: 27px;margin: 0 auto;text-align: left;">
			发代金券
			<img src="imgs/alertclose.png" style="float:right;cursor: pointer;" onclick="Thide()">
		</div>
	</div>
	<div style="width: 100%; height: 15px;"></div>
	<div style="width: 100%; height: 240px; overflow: auto;">
		<div style="width: 85%; margin: 0 auto;">
		<c:forEach items="${couponlist }" var="cp" varStatus="status">
		<c:if test="${status.index%3 == 2 }">
			<div id="choose_div_${status.index }" style="width: 188px; height: 81px; border: 1px solid #bdc6d7; float:left;margin-bottom: 10px; cursor: pointer; padding: 10px; color: #222222;" onclick="chooseCopon(${status.index}, ${cp.coupon_id })">
				<input type="hidden" value="0" id="choose_flag_${status.index }" />
				<div style="width: 100%; height: 24px;">${cp.amount }元</div>
				<div style="width: 100%; height: 22px;">满${cp.min_money }使用</div>
				<div style="width: 100%;"><fmt:formatDate value="${cp.from_time }" pattern="yyyy.MM.dd"/>-<fmt:formatDate value="${cp.end_time }" pattern="yyyy.MM.dd"/> </div>
			</div>
		</c:if>
		<c:if test="${status.index%3 != 2 }">
			<div id="choose_div_${status.index }" style="width: 188px; height: 81px; border: 1px solid #bdc6d7; float:left; margin-right: 10px; margin-bottom: 10px; cursor: pointer; padding: 10px; color: #222222;" onclick="chooseCopon(${status.index}, ${cp.coupon_id })">
				<input type="hidden" value="0" id="choose_flag_${status.index }" />
				<div style="width: 100%; height: 24px;">${cp.amount }元</div>
				<div style="width: 100%; height: 22px;">满${cp.min_money }使用</div>
				<div style="width: 100%;"><fmt:formatDate value="${cp.from_time }" pattern="yyyy.MM.dd"/>-<fmt:formatDate value="${cp.end_time }" pattern="yyyy.MM.dd"/> </div>
			</div>
		</c:if>
		</c:forEach>
		</div>
	</div>
	<div style="width: 75px; height: 45px; background: #6097fb; text-align: center; line-height: 45px; float:right; color: #fff; margin-top: 14px; margin-right: 15px; cursor: pointer;" onclick="paifacoupon()">发送(<span id="couponcount">0</span>)</div>
</form>
</div>
</html>