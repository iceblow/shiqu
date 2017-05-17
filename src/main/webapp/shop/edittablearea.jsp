<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/table.css" rel="stylesheet">
<script src="./js/jquery-1.11.2.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<title>桌台区域管理</title>
</head>
<body>
	<div style="width: 94%;margin-left:3%; height: 83px; ">
		<div style="width: 100%; height: 38px;"></div>
		<div style="float: left; background-image: url(imgs/hicon.png); background-repeat: no-repeat;height: 17px;width: 11px;"></div>
		<span style="float:left; font-size: 12px;">&nbsp;桌台管理&nbsp;&nbsp;&gt;&nbsp;&nbsp;<font style="color: #5f97fa;">桌台区域编辑</font></span>
	</div>
	<form action="./savetablearea" method="post">
	<div style="width:94%;margin-left:3%;margin-top:40px;margin-bottom:30px;border-top:solid 1px #e5e6ea;">
	<c:if test="${not empty area }"><input type="hidden" name="id" value="${area.id }"></c:if> 
	<div style="width: 100%; height: 75px; border-bottom: 1px solid #eaeff2;">
	<div style="font-size:12px;font-weight:bold;float:left; width: 110px; height: 100%; line-height: 75px;padding-right:30px; border-right: 1px solid #eaeff2;text-align: right;">名字</div>
	<div style="height: 100%; line-height: 75px; float:left; margin-left: 20px;">
			<input type="text" class="form-control" name="area_name" value="${area.area_name }" required="required" style="width: 400px; height: 33px; padding-left:5px; margin-top: 20px;">
	</div>
	</div>
	<div style="width: 100%; height: 75px; border-bottom: 1px solid #eaeff2;">
	<div style="font-size:12px;font-weight:bold;float:left; width: 110px; height: 100%; line-height: 75px;padding-right:30px; border-right: 1px solid #eaeff2;text-align: right;">打印机1</div>
	<div style="height: 100%; line-height: 75px; float:left; margin-left: 20px;">
		<select style="float:right;margin-right:20px;" class="category" id="print_id1" name="print_id1">
		<c:forEach items="${printlist}" var="p" varStatus="status">  
		<c:if test="${area.print_id1==p.id }">
		<option value="${p.id }" selected="selected">${p.print_name }</option>
		</c:if>
		<c:if test="${area.print_id1!=p.id }">
		<option value="${p.id }" >${p.print_name }</option>
		</c:if>
		</c:forEach>
		</select>
	</div>
	</div>
	<div style="width: 100%; height: 75px; border-bottom: 1px solid #eaeff2;">
	<div style="font-size:12px;font-weight:bold;float:left; width: 110px; height: 100%; line-height: 75px;padding-right:30px; border-right: 1px solid #eaeff2;text-align: right;">打印机2</div>
	<div style="height: 100%; line-height: 75px; float:left; margin-left: 20px;">
		<select style="float:right;margin-right:20px;" class="category" id="print_id2" name="print_id2">
		<option value="0"></option>
		<c:forEach items="${printlist}" var="p" varStatus="status">  
		<c:if test="${area.print_id2==p.id }">
		<option value="${p.id }" selected="selected">${p.print_name }</option>
		</c:if>
		<c:if test="${area.print_id2!=p.id }">
		<option value="${p.id }" >${p.print_name }</option>
		</c:if>
		</c:forEach>
		</select>
	</div>
	</div>
		<div style="width: 100%; height: 75px; border-bottom: 1px solid #eaeff2;">
	<div style="font-size:12px;font-weight:bold;float:left; width: 110px; height: 100%; line-height: 75px;padding-right:30px; border-right: 1px solid #eaeff2;text-align: right;">打印机3</div>
	<div style="height: 100%; line-height: 75px; float:left; margin-left: 20px;">
		<select style="float:right;margin-right:20px;" class="category" id="print_id3" name="print_id3">
		<option value="0"></option>
		<c:forEach items="${printlist}" var="p" varStatus="status">  
		<c:if test="${area.print_id3==p.id }">
		<option value="${p.id }" selected="selected">${p.print_name }</option>
		</c:if>
		<c:if test="${area.print_id3!=p.id }">
		<option value="${p.id }" >${p.print_name }</option>
		</c:if>
		</c:forEach>
		</select>
	</div>
	</div>
	
	<button type="submit" class="btn btn-primary detail_submit" style="margin-right:130px;width:180px;margin-top:60px;background-image: none;" aria-haspopup="true" aria-expanded="false" >保存</button>
	
	
	</div>
	</form>
</body>
</html>