<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script src="./js/jquery-1.11.2.min.js"></script>
<script src="./js/login.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script type="text/javascript">
	function showmask(){
		frames["leftpframe"].showleftmask();
	}
	
	function hidemask(){
		frames["leftpframe"].hideleftmask();
	}
	
</script>
<title>食趣商家管理平台</title>
</head>
<frameset cols="180px,*" border="0px" frameborder="no" id="dishesframeset">
	<frame src="couponleft.jsp" id="leftpframe" name="leftpframe" frameborder="0" noresize="noresize" scrolling="no"/>
	<frame src="./couponManage" frameborder="0" noresize="noresize" name="coupon_frame"	scrolling="auto"/>
</frameset>
</html>