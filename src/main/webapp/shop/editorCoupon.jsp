<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script src="./js/common.js"></script>
<script type="text/javascript" src="./js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(function() {
		if ($("#coupon_id").val() == "") {
			$("#coupon_id").val(0);
		}
	});

	function checkForm() {
		var amount = $("#amount").val();
		if (amount == "") {
			alert("面值不能为空");
			$("#amount").focus();
			return false;
		}
		var min_money = $("#min_money").val();
		if (min_money == "") {
			alert("最低消费不能为空");
			$("#min_money").focus();
			return false;
		}
		if (parseInt(amount) > parseInt(min_money)) {
			alert("面值不能大于最低消费");
			$("#amount").focus();
			return false;
		}
		var startTime = $("#startTime").val();
		if (startTime == "") {
			alert("开始时间不能为空");
			$("#startTime").focus();
			return false;
		}
		var endtime = $("#endtime").val();
		if (endtime == "") {
			alert("结束时间不能为空");
			$("#endtime").focus();
			return false;
		}
		var limit_num = $("#limit_num").val();
		if (limit_num == "") {
			$("#limit_num").val(0);
		}
	}

	function clearinput() {
		$("#amount").val("");
		$("#description").val("");
		$("#min_money").val("");
		$("#startTime").val("");
		$("#endtime").val("");
		$("#limit_num").val("");
		$("#is_valid").val(1);
	}
</script>
<title>食趣商家管理平台</title>
</head>
<body>
	<div id="content">
		<div style="width: 100%; height: 83px; border-bottom: 1px solid #e5e6ea;">
			<div style="width: 100%; height: 38px;"></div>
			<div style="float: left; background-image: url(imgs/hicon.png); background-repeat: no-repeat; height: 17px; background-position-y: 5px; width: 11px;"></div>
			<span style="float: left; font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;卡券管理&nbsp;&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;优惠券&nbsp;&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;<font
				style="color: #5f97fa;">添加优惠券</font></span>
		</div>
		<form action="./saveorupdateCoupon" id="couponForm" method="post" enctype="multipart/form-data">
			<input type="hidden" value="${coupon.coupon_id }" id="coupon_id" name="coupon_id" />
			<input type="hidden" value="${shopid }" id="store_id" name="store_id" />
			<div class="detailItem">
				<div class="detailItemLeft">
					<span style="margin-right: 15%;">面值(元)</span>
				</div>
				<div class="detailItemRight">
					<input value="${coupon.amount }" id="amount" name="amount" onkeyup="checkKeyForFloat(event, 'amount')" />
				</div>
			</div>
			<div class="detailItem">
				<div class="detailItemLeft">
					<span style="margin-right: 15%;">说明</span>
				</div>
				<div class="detailItemRight">
					<input value="${coupon.description }" id="description" name="description" />
				</div>
			</div>
			<div class="detailItem">
				<div class="detailItemLeft">
					<span style="margin-right: 15%;">最低消费</span>
				</div>
				<div class="detailItemRight">
					<input value="${coupon.min_money }" id="min_money" name="min_money" onkeyup="checkKeyForFloat(event, 'min_money')" />
				</div>
			</div>
			<div class="detailItem">
				<div class="detailItemLeft">
					<span style="margin-right: 15%;">使用期限</span>
				</div>
				<div class="detailItemRight">
					<input value="<fmt:formatDate value="${coupon.from_time }" pattern="yyyy.MM.dd" />" id="startTime" name="startTime" onClick="WdatePicker({dateFmt:'yyyy.MM.dd',qsEnabled:false})" />
					<span style="margin-left: 1%;">-</span>
					<input value="<fmt:formatDate value="${coupon.end_time }" pattern="yyyy.MM.dd" />" id="endtime" name="endtime" onClick="WdatePicker({dateFmt:'yyyy.MM.dd',qsEnabled:false})" />
				</div>
			</div>
			<div class="detailItem">
				<div class="detailItemLeft">
					<span style="margin-right: 15%;">限领数量</span>
				</div>
				<div class="detailItemRight">
					<input value="${coupon.limit_num }" id="limit_num" name="limit_num" maxlength="6" onkeyup="checkNum(event, 'limit_num');" />
				</div>
			</div>
			<div class="detailItem">
				<div class="detailItemLeft">
					<span style="margin-right: 15%;">状态</span>
				</div>
				<div class="detailItemRight">
					<select name="is_valid" id="is_valid">
						<c:if test="${empty coupon }">
							<option value="1">可用</option>
							<option value="0">停用</option>
						</c:if>
						<c:if test="${coupon.is_valid == 1 }">
							<option value="1" selected="selected">可用</option>
							<option value="0">停用</option>
						</c:if>
						<c:if test="${coupon.is_valid == 0 }">
							<option value="1">可用</option>
							<option value="0" selected="selected">停用</option>
						</c:if>
					</select>
				</div>
			</div>
			<div style="width: 100%; height: 40px;"></div>
			<input type="submit" class="saveorupdate" style="float: left;" value="确定并上传" onclick="return checkForm();" />
			<div class="clearinput" style="float: left;" onclick="clearinput()">清空填写内容</div>
			<div style="width: 100%; height: 40px;"></div>
		</form>
	</div>
</body>
</html>