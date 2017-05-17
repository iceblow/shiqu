<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<script src="./js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="./js/common.js"></script>
<script type="text/javascript">
function goback(){
	function goback(){
		if(navigator.cookieEnabled){//判断是否支持Cookie
			var allCookie = document.cookie; //取出全部Cookie
		     if(allCookie.indexOf("news=") != -1 || allCookie.indexOf("$|") != -1){//判断是否为第一次浏览
		    	 window.location.herf = "/shiqu";
		     }else{//
		    	 history.back();
		     }
		}else{//不支持Cookie的处理
		     tag.innerHTML="您浏览器关闭了cookie功能，不能为您自动保存最近浏览过的网页。"
		}
	}
}
</script>
<style type="text/css">
#content{
	position:fixed;
	top: 0px;
	left: 0px;
	right: 0px;
	bottom: 0px;
	background-image: url(imgs/500error.png);
	background-repeat: no-repeat;
	background-size: 558px 356px;
	background-position-x: center;
	background-position-y: 51px;
}
</style>
<title>500</title>
</head>
<body>
<div id="content">
<div style="height: 450px;"></div>
<div style="text-align: center;height: 30px; margin-top: 27px;font-size: 20px; ">服务器产生内部错误</div>
<!-- <div style="text-align: center;height: 30px;font-size: 15px; color: #919191;line-height: 50px;">可能原因:</div> -->
<div style="cursor: pointer; margin: 0 auto; width: 185px; height: 60px; line-height: 60px; text-align: center; color: #fff; background: #4cc2ff;margin-top:25px;" onclick="goback()">返回上一页</div>
</div>
</body>
</html>