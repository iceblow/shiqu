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
		 $("#dishes_left_"+index).addClass("active");
	 }
</script>
<body style="margin-top:15px;margin-left:15px;margin-bottom:15px;background-color:#f5f6fa">
<ul class="nav nav-pills" style="margin-top:20px;">
  <li role="presentation"  class="leftli active" id="dishes_left_1" onclick="attrAction(1);"><a href="./dishesClass" target="dishes_frame">分类管理</a></li>
  <li role="presentation"  class="leftli " id="dishes_left_2" onclick="attrAction(2);"><a href="./dishesManage" target="dishes_frame">菜品管理</a></li>
  <li role="presentation"  class="leftli " id="dishes_left_3" onclick="attrAction(3);"><a href="./setmealManage" target="dishes_frame">套餐管理</a></li>
</ul>
</body>
<div class="mask" style="display:none;"></div>