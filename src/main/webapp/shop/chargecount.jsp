<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ page import="java.util.List"%>  
<%@ page import="com.daoshun.shiqu.pojo.ChargeStatistics"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="./css/account.css" rel="stylesheet">
<script src="./js/jquery-1.11.2.min.js"></script>
<script src="./js/Chart.js"></script>
<% 
List<ChargeStatistics> chargelist = (List<ChargeStatistics>)request.getAttribute("chargelist");
float max = 0f ;
int avgvalue = 0;
for(ChargeStatistics data : chargelist){
	if(data.getCharge_num()>max){
		max = data.getCharge_num();
	}
}
float total = 0f;
if(chargelist!=null&&chargelist.size()>0){
	total = chargelist.get(chargelist.size()-1).getCharge_num();
}
avgvalue  = (int) (( max + 100 )/100)*10;
%>
<title>充值统计</title>
</head>
<body>
<div style="width:90%;margin-left:4%;">
<div style="width:100%;height:90px;">

<div class="statediv  <c:if test="${type==1 }">onchoose </c:if>" style="margin-left:0px;"  onclick="chargecount(1)">
日统计
</div>
<%-- <div class="statediv  <c:if test="${type==2 }">onchoose </c:if>" > --%>
<!-- 周统计 -->
<!-- </div> -->
<div class="statediv  <c:if test="${type==3 }">onchoose </c:if>"  onclick="chargecount(3)">
月统计
</div>

</div>
<div style="width:100%;height:50px;line-height:50px;background-color:#e5e6ea;margin-bottom:20px;padding-left:20px;font-size:'宋体';font-weight:bold;">
<div style="float:left;height:50px;line-height:50px;color:#484b6a;">
<c:if test="${type==1 }">本日充值累计：</c:if><c:if test="${type==3 }">本月充值累计：</c:if><font style="color:#5f97fa"><%=total %></font> 元
</div>
</div>
<canvas id="myChart" style="width:80%;"></canvas>
</div>
</body>
<script>
var avgvalue = <%=avgvalue%> ;
var data = {
		labels : [
			<%
			 if(chargelist != null && chargelist.size() > 0) { 
				for(ChargeStatistics data : chargelist){
			%>
				"<%=data.getShow_date()%>",
			<%
			 	}
			 } %>
		],
		datasets : [
		     		{
		     			fillColor : "rgba(151,187,205,0)",
		     			strokeColor : "#35aa47",
		     			pointColor : "#35aa47",
		     			pointStrokeColor : "#fff",
		     			data :[
		     					<%
		     					if(chargelist != null && chargelist.size() > 0) { 
		     						for(ChargeStatistics data : chargelist){
		     					%>
		     							<%=data.getCharge_num()%>,
		     					<%
		     						}
		     					}
		     					%>
		     			 		],
		     			       
		     		},
		     	]
	}
	
	
</script>

<script src="./js/chargecount.js">
</script>
</html>