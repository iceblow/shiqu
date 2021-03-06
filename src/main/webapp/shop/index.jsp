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
<link href="./css/common.css" rel="stylesheet">
<script src="./js/jquery-1.11.2.min.js"></script>
<script src="./js/login.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script type="text/javascript">
function showmask(){
	frames["topframe"].showtopmask();
}

function hidemask(){
	frames["topframe"].hidetopmask();
}

function logout(){
	window.location.href="./logout";
}

$(function(){
	var width = document.documentElement.clientWidth;
	if(parseInt(width)<1366){
	$("#middleframe").attr("rows","124px,*");
 	$("#topframe").attr("src","top2.jsp");
	}
})
</script>
<% 	
	int privilege = ((Integer)request.getSession().getAttribute("privilege")).intValue();
%>
<title>食趣商家管理平台</title>
</head>
<frameset rows="155px,*" id="middleframe" border="0px" frameborder="no">
	<frame src="top.jsp" id="topframe" name="topframe" frameborder="0" 
		scrolling="auto"/>
<% if(privilege==1){ %>
	<frame src="shopindex.jsp" frameborder="0" noresize="noresize" name="view_frame"
		scrolling="auto"/>
	<% }else if(privilege==10){ %>
	<frame src="tableindex.jsp" frameborder="0" noresize="noresize" name="view_frame"
		scrolling="auto"/>
	<% } %>
</frameset>

</html>