<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>商户管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="./bootstrap/jquery-2.0.0.min.js"></script>
<script type="text/javascript" src="./bootstrap/jquery-ui"></script>
<link href="./bootstrap/bootstrap-combined.min.css" rel="stylesheet" media="screen">
<link href="./css/style.css" rel="stylesheet" media="screen">
<script type="text/javascript" src="./bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/page.js"></script>
<script type="text/javascript">
	$(function() {
		$("#menu11").addClass('active');
		$("#checkAll").click(function() {
	        $('input[name="user_id"]').prop("checked",this.checked); 
	    });
	    var $user_id = $("input[name='user_id']");
	    $user_id.click(function(){
	        $("#checkAll").prop("checked",$user_id.length == $("input[name='user_id']:checked").length ? true : false);
	    });
	})
	
	function relativemany(){
		$("#userForm").attr("action","./sureSelectUser").submit();
	}
</script>
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


					<div class="row-fluid">
						<div class="span12">
							<div class="row-fluid">
								<div class="span6">
									<button class="btn btn-small btn-info" type="button" onclick="relativemany()" style="float: left;margin-left: 5px;">确定选择</button>
								</div>
								<div class="span2">
<!-- 									<button class="btn btn-primary" type="button" style="float: right;" data-toggle="modal" data-target="#addModal">添加代理商</button> -->
								</div>
							</div>
							<form action="" method="post" id="userForm">
							<input type="hidden" value="${title}" name="title"/>
							<input type="hidden" value="${content}" name="content"/>
							<table class="table table-condensed table-hover table-bordered">
								<thead>
									<tr>
										<th><input id="checkAll" type="checkbox" name="checall"/></th>
										<th>用户名</th>
										<th>真实姓名</th>
										<th>昵称</th>
										<th>电话</th>
										<th>生日</th>
										<th>性别</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${userlist}" var="s">
										<tr>
											<td><input type="checkbox" name="user_id" value="${s.user_id }"/></td>
											<td>${s.user_name}</td>
											<td>${s.real_name}</td>
											<td>${s.nick_name}</td>
											<td>${s.phone}</td>
											<td><fmt:formatDate value="${s.birthday }" pattern="yyyy-MM-dd"/></td>
											<td>${s.gender}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							</form>
						</div>
					</div>

				</div>
			</div>
		</div>

	</div>

</body>
</html>