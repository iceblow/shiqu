<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ page import="java.util.List"%>  
<%@ page import="com.daoshun.shiqu.pojo.MenuStatistics"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="./css/account.css" rel="stylesheet">
<script src="./js/jquery-1.11.2.min.js"></script>
<script src="./js/Chart.js"></script>
<% 
List<MenuStatistics> menulist = (List<MenuStatistics>)request.getAttribute("menulist");
long  menucount = ((Long)request.getAttribute("menucount")).longValue();
%>
<title>充值统计</title>
</head>
<body>
<div style="width:90%;margin-left:4%;">
<div style="width:100%;height:90px;">

<div class="statediv  <c:if test="${type==1 }">onchoose </c:if>" style="margin-left:0px;"  onclick="menucount(1)">
日统计
</div>
<%-- <div class="statediv  <c:if test="${type==2 }">onchoose </c:if>" > --%>
<!-- 周统计 -->
<!-- </div> -->
<div class="statediv  <c:if test="${type==3 }">onchoose </c:if>"  onclick="menucount(3)">
月统计
</div>

</div>
<div style="width:100%;height:50px;line-height:50px;background-color:#e5e6ea;margin-bottom:20px;padding-left:20px;font-size:'宋体';font-weight:bold;">
<div style="float:left;height:50px;line-height:50px;color:#484b6a;">
<c:if test="${type==1 }">本日总销售：</c:if><c:if test="${type==3 }">本月总销售：</c:if><font style="color:#5f97fa"><%=menucount %></font> 份
</div>
</div>
<% if(menulist != null && menulist.size() > 0){ 
	for(MenuStatistics data : menulist){
%>
<div style="float:left;width:18%;margin-right:2%;">
<canvas id="myChart" class="myChart" style="width:100%;"></canvas>
<div style="text-align:center;line-height:34px;">
<%=data.getMenu_name()+":"+data.getTotal_sell() %>
</div>
</div>
<% }
	} %>
</div>
</body>
<script>
var datas;
<%if(menulist != null && menulist.size() > 0){ 
	for(int i = 0; i<menulist.size();i++){ %>
	datas = [
	         {
	        	 value: <%=menulist.get(i).getTotal_sell()%>, 
	        	 color:"#6097fb",
	        	label:'<%=menulist.get(i).getMenu_name()%>',
	         },
			{
	        	 value: <%=menucount-menulist.get(i).getTotal_sell()%>,
	        	 color:"#f2f3f5",
	        	 label:'其他',
				}
	       ]
	
var ctx = $(".myChart").get(<%=i%>).getContext("2d");
//This will get the first returned node in the jQuery collection.
new Chart(ctx).Doughnut(datas);
<% }}%>

function menucount(type){
	window.location.href='./menucount?type='+type;
}
</script>

</html>