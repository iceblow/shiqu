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
		$("#menu12").addClass('active');
		if ($("#add_success").is(":visible")) {
			setTimeout(function() {
				$("#add_success").fadeOut("normal");
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

					<c:if test="${is_add}">
						<div class="row-fluid" id="add_success">
							<div class="span12">
								<div class="alert alert-success">
									<button type="button" class="close" data-dismiss="alert">×</button>
									<h4>成功!</h4>
									发布公告成功！
								</div>
							</div>
						</div>
					</c:if>


					<div class="row-fluid">
						<div class="span12">
							<form action="./addnotice" method="post">
								<fieldset>
									<legend>发布公告</legend>
									<label>标题</label>
									<input type="text" name="title"/>
									<label>内容</label>
									<textarea rows="4" cols="50" name="content"></textarea>
									<br />
									<button type="submit" class="btn">提交</button>
								</fieldset>
							</form>
						</div>
					</div>



				</div>
			</div>
		</div>
	</div>



</body>
</html>