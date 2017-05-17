<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/login.css" rel="stylesheet">
<title>欢迎登陆食趣商家管理平台</title>
</head>
<body>
<div style=" background-color: #ffffff;background:url(./imgs/top-bg.png) no-repeat ;    padding-bottom: 20px;background-size: 100% 100%; font-family:'微软雅黑';">
<div style="text-align:center;font-size:9em;margin:auto;color:#fff;">
Welcome
</div>
<div class="top-content" style="width:376px;height:131px;">
<div style="font-size:2.5em;">食趣商家管理平台</div>
<div style="font-size:1em;margin-top:10px;">The boring business management platform </div>
</div>
</div>
 <form class="form-signin" action="login" method="post">
 <div class="container" style="width:470px;">

       <div class="user-circle" id="user-circle"><img src="./imgs/user-circle.png" ></div>
       
       <input type="text" required="required" name="phone" id="phone" style="margin-top:20px;width:378px;" class="form-control floating-label" onfocus="divonfocus('user-circle')" onblur="divonblur('user-circle')" placeholder="用户名">

        <div class="user-circle" id="unlock" style="padding-left:17px;" id="unlock"><img src="./imgs/unlock.png"></div>
        <input type="password" required="required" name="password" id="password" style="margin-top:20px;width:378px;" class="form-control floating-label" onfocus="divonfocus('unlock')" onblur="divonblur('unlock')" placeholder="密码">
       <div class="alert alert-danger" style="margin-bottom:0px;display:none" role="alert"></div>
       <button class="btn btn-large  loginbtn"  type="button" onclick="getStoreList()">选择店铺</button>
      
		<input type="hidden" id="err" value="${err }">
    </div> <!-- /container -->
    
    <div class="mask" style="display:none;"></div>
    <div id="choosealert" class="choosealert" style="display: none;">
    <div style="background-color:#f5f6fa;width:100%;height:50px;line-height:50px;padding-left:20px;font-size:14px;font-family:'宋体';font-weight: bold;" >
	选择登陆店铺
	<img src="./imgs/delete.png"  style="float: right;margin-top: 11px;margin-right: 15px;cursor: pointer;" onclick="hiddenchooseAlert()">
	</div>
	<div style="height:85px;line-height:85px;text-align:center;">
	<select style="margin-right:20px;margin-top:30px;" class="category" id="store_id" name="store_id" >
	</select>
	</div>
	<button type="submit" class="btn btn-primary detail_upload"  aria-haspopup="true" aria-expanded="false"  >确定</button>
    </div>
    </form>
</body>
<script src="./js/jquery-1.11.2.min.js"></script>
<script src="./js/common.js"></script>
<script src="./js/login.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script>
      $(function(){
    	var err = $("#err").val();
    	if(err!=''){
    		if(err==1){
    			$(".alert").text("用户名或密码错误！");
    			$(".alert").show();
    		}else if(err==2){
    			$(".alert").text("请先登录！");
    			$(".alert").show();
    		}else if(err==3){
    			$(".alert").text("该用户无权限登录！");
    			$(".alert").show();
    		}
    	}
    	
    	$(document).keydown(
    			function(event) {
    				if (event.keyCode == 13) { 
    					$('form').each(function() { 
    						event.preventDefault();     }
    					);
    					getStoreList();
    					} 
    				});


      })
      
</script>
</html>