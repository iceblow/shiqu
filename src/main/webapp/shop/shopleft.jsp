<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/left.css" rel="stylesheet">
<link href="./css/common.css" rel="stylesheet">
<script src="./js/jquery-1.11.2.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script type="text/javascript">
	function showleftmask(){
		$(".mask").show();
	}
	
	function hideleftmask(){
		$(".mask").hide();
	}
	
	 
	 function attrAction(index){
		 $(".leftli").removeClass("active");
		 $("#shop_left_"+index).addClass("active");
	 }
</script>
<body style="margin-top:15px;margin-left:15px;margin-bottom:15px;background-color:#f5f6fa">
<ul class="nav nav-pills" style="margin-top:20px;">
  <li role="presentation" class="leftli active" id="shop_left_1" onclick="attrAction(1)"><a href="./detail" target="shop_frame">店铺信息</a></li>
  <li role="presentation"  class="leftli " id="shop_left_2" onclick="attrAction(2)"><a href="./print" target="shop_frame">打印机管理</a></li>
</ul>
</body>
<div class="mask" style="display:none;"></div>
