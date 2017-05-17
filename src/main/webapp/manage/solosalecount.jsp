<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ page import="java.util.List"%>  
<%@ page import="com.daoshun.shiqu.pojo.SaleStatistics"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="./css/style.css" rel="stylesheet" media="screen">
<link href="./bootstrap/bootstrap-combined.min.css" rel="stylesheet" media="screen">
<link href="./css/account.css" rel="stylesheet">
<script src="./js/jquery-1.11.2.min.js"></script>
<script src="./js/Chart.js"></script>
<script type="text/javascript" src="./bootstrap/jquery-2.0.0.min.js"></script>
<script type="text/javascript" src="./bootstrap/jquery-ui"></script>
<script type="text/javascript" src="./bootstrap/bootstrap.min.js"></script>
<script type="text/javascript">
$(function() {
	$("#menu1").addClass('active');
})
</script>
<% 
List<SaleStatistics> salelist = (List<SaleStatistics>)request.getAttribute("salelist");
float max = 0f ;
int avgvalue = 0;
for(SaleStatistics data : salelist){
	if(data.getPaypal_num() > max ){
		max = data.getPaypal_num();
	}
	if(data.getCard_num() > max ){
		max = data.getCard_num();
	}
	if(data.getCash_num() > max ){
		max = data.getCash_num();
	}
	if(data.getCharge_num() > max){
		max = data.getCharge_num();
	}
}
float total = 0f;
if(salelist!=null&&salelist.size()>0){
	total = salelist.get(salelist.size()-1).getSale_num();
}
avgvalue  = (int) (( max + 100 )/100)*10;
%>
<title>营业统计</title>
</head>
<body>
<div style="margin: 10px; border-width: 1px; border-style: solid; border-color: #DDD; border-collapse: separate; border-radius: 5px;">
<div class="container-fluid" style="margin-top: 10px;">
<div class="row-fluid">
	<div class="span12">
		<div class="navbar">
			<div class="navbar-inner">
				<div class="container-fluid">
								<!-- <a data-target=".navbar-responsive-collapse" data-toggle="collapse" class="btn btn-navbar">
									<span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
								</a> -->
					<a href="#" class="brand">食趣后台管理</a>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="row-fluid">			
<div class="span2">
	<jsp:include page="left.jsp" />
</div>		
<div class="span10">	
<div style="width:90%;margin-left:4%;">
<div style="width:100%;height:90px;">
<input type="hidden" value=${store_id }/>
<div class="statediv  <c:if test="${type==1 }">onchoose </c:if>" style="margin-left:0px;" onclick="salecount(1,${store_id })">
日统计
</div>
<%-- <div class="statediv  <c:if test="${type==2 }">onchoose </c:if>" > --%>
<!-- 周统计 -->
<!-- </div> -->
<div class="statediv  <c:if test="${type==3 }">onchoose </c:if>" onclick="salecount(3,${store_id })" >
月统计
</div>

</div>
<div style="width:100%;height:50px;line-height:50px;background-color:#e5e6ea;margin-bottom:20px;padding-left:20px;font-size:'宋体';font-weight:bold;">
<div style="float:left;height:50px;line-height:50px;color:#484b6a;">
<c:if test="${type==1 }">本日总营业额：</c:if><c:if test="${type==3 }">本月总营业额：</c:if><font style="color:#5f97fa"><%=total %></font> 元
</div>

<div style="float:right;font-size:12px;font-family:'宋体';font-weight: normal;width:80px;">
<div style="width:16px;height:16px;background-color:#ffcd7f;float:left;margin-right:10px;margin-top: 17px;"></div>
 充值卡
</div>
<div style="float:right;font-size:12px;font-family:'宋体';font-weight: normal;width:80px;">
<div style="width:16px;height:16px;background-color:#f83a22;float:left;margin-right:10px;margin-top: 17px;"></div>信用卡
</div>
<div style="float:right;font-size:12px;font-family:'宋体';font-weight: normal;width:80px;">
<div style="width:16px;height:16px;background-color:#71c37e;float:left;margin-right:10px;margin-top: 17px;"></div>
 支付宝
</div>
<div style="float:right;font-size:12px;font-family:'宋体';font-weight: normal;width:80px;">
<div style="width:16px;height:16px;background-color:#81d4ff;float:left;margin-right:10px;margin-top: 17px;"></div> 线下
</div>

</div>
<canvas id="myChart" style="width:80%;" ></canvas>
</div>
</div>
</div>
</div>
</div>
</body>
<script>
var avgvalue = <%=avgvalue%>
var data = {
		labels : [
			<%
			 if(salelist != null && salelist.size() > 0) { 
				for(SaleStatistics data : salelist){
			%>
				"<%=data.getShow_date()%>",
			<%
			 	}
			 } %>
		],
		datasets : [
			{
				fillColor : "#fa7564",
				strokeColor : "#fa7564",
				data : [<%
	 					if(salelist != null && salelist.size() > 0) { 
	 						for(SaleStatistics data : salelist){
	 					%>
	 							<%=data.getCard_num()%>,
	 					<%
	 						}
	 					}
	 					%>]
			},
			{
				fillColor : "#81d4ff",
				strokeColor : "#81d4ff",
				data : [
						<%
							if(salelist != null && salelist.size() > 0) { 
								for(SaleStatistics data : salelist){
							%>
									<%=data.getCash_num()%>,
							<%
								}
							}
							%>
						]
			},
			{
				fillColor : "#71c37e",
				strokeColor : "#71c37e",
				data : [		<%
								if(salelist != null && salelist.size() > 0) { 
									for(SaleStatistics data : salelist){
								%>
										<%=data.getPaypal_num()%>,
								<%
									}
								}
								%>
						]
			},
			{
				fillColor : "#ffcd7f",
				strokeColor : "#ffcd7f",
				data : [		<%
								if(salelist != null && salelist.size() > 0) { 
									for(SaleStatistics data : salelist){
								%>
										<%=data.getCharge_num()%>,
								<%
									}
								}
								%>
						]
			},
		]
	}
	
</script>

<script src="./js/salecount.js">
</script>
</html>