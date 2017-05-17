<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Banner管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="./bootstrap/jquery-2.0.0.min.js"></script>
<script type="text/javascript" src="./bootstrap/jquery-ui"></script>
<link href="./bootstrap/bootstrap-combined.min.css" rel="stylesheet" media="screen">
<script type="text/javascript" src="./bootstrap/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#menu23").addClass('active');
		if ($("#edit_success").is(":visible")) {
			setTimeout(function() {
				$("#edit_success").fadeOut("normal");
			}, 2000);

		}
	})
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

					<c:if test="${edit}">
						<div class="row-fluid" id="edit_success">
							<div class="span12">
								<div class="alert alert-success">
									<button type="button" class="close" data-dismiss="alert">×</button>
									<h4>成功!</h4>
									修改成功！
								</div>
							</div>
						</div>
					</c:if>

					<form action="./editversion" method="post" enctype="multipart/form-data">
						<div class="row-fluid">
							<div class="span12">
								内部版本号：
								<input type="number" value="${innerversion}" name="innerversion" />
							</div>
						</div>
						<div class="row-fluid">
							<div class="span12">
								用户版本号：
								<input type="text" value="${userversion}" name="userversion" />
							</div>
						</div>
						<div class="row-fluid">
							<div class="span12">
								关&nbsp;于&nbsp;我&nbsp;们&nbsp;：
								<textarea rows="5" cols="50" name="aboutus">${aboutus}</textarea>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span12">
								apk&nbsp;地&nbsp;址：
								<input type="file" value="" name="apkfile" />
							</div>
						</div>
						<div class="row-fluid" style="margin-top: 15px;">
							<div class="span12">
								<button class="btn btn-primary" type="submit">修改信息</button>
							</div>
						</div>
					</form>



				</div>
			</div>
		</div>
	</div>



</body>
</html>