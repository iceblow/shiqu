<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>商户管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="./bootstrap/jquery-2.0.0.min.js"></script>
<script type="text/javascript" src="./bootstrap/jquery-ui"></script>
<link href="./bootstrap/bootstrap-combined.min.css" rel="stylesheet" media="screen">
<script type="text/javascript" src="./bootstrap/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#menu1").addClass('active');
	})
	
	
	function edit(sid) {
		$("#sid").val(sid);
		$.ajax({ url: "./getstoreuser?sid="+sid, 
			async: false, 
			success: function(data){
				$("#suserid").val(data.id);
				$("#phone").val(data.phone);
				$("#password").val(data.password.substr(0,8));
				}
	      });
		$("#editModal").modal('show');
	 } 

	 function submitform(){
		 $.ajax({url:'./editstoreuser',
				data:$('#storeuserform').serialize(),
				type:"POST",
				success:function(data){
					$("#editModal").modal('hide');
					if(data=="success"){
						alert("操作成功");
					}else{
						alert("操作失败");
					}
				}
			});
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
								<a data-target=".navbar-responsive-collapse" data-toggle="collapse" class="btn btn-navbar">
									<span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
								</a>
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
								<div class="span4">
									<div class="btn-group">
										<button class="btn">请选择分类</button>
										<button data-toggle="dropdown" class="btn dropdown-toggle">
											<span class="caret"></span>
										</button>
										<ul class="dropdown-menu">
											<!-- <li><a href="#">操作</a></li>
											<li><a href="#">设置栏目</a></li>
											<li><a href="#">更多设置</a></li> -->
										</ul>
									</div>
								</div>
								<div class="span6">
									<form class="form-search">
										<input class="input-medium search-query" type="text" style="width: 40%" />
										<button type="submit" class="btn">查找</button>
									</form>
								</div>
								<div class="span2">
									<button class="btn btn-primary" type="button" style="float: right;" data-toggle="modal" data-target="#addModal">添加商户</button>
								</div>
							</div>
							<table class="table table-condensed table-hover table-bordered">
								<thead>
									<tr>
										<th>商店名</th>
										<th>分类</th>
										<th>电话</th>
										<th>支持外卖</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${result.dataList}" var="s">
										<tr>
											<td>${s.store_name}</td>
											<td>${s.category_name}</td>
											<td>${s.phone}</td>
											<td><c:if test="${s.is_out==1}">支持</c:if> <c:if test="${s.is_out==0}">不支持</c:if></td>
											<td><button class="btn btn-small btn-info" type="button" onclick="edit(${s.store_id})" style="float: left;">店长账号</button></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<c:if test="${result.total/15 > 1}">
								<div class="pagination pagination-centered">
									<ul>
										<li><a href="#">上一页</a></li>
										<li><a href="#">1</a></li>
										<li><a href="#">2</a></li>
										<li><a href="#">3</a></li>
										<li><a href="#">4</a></li>
										<li><a href="#">5</a></li>
										<li><a href="#">下一页</a></li>
									</ul>
								</div>
							</c:if>
						</div>
					</div>








				</div>
			</div>
		</div>

	</div>



	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">添加新的商户</h4>
				</div>
				<form action="./addshop" method="post">
					<div class="container" style="margin: 20px;">
						<fieldset>
							<label>商店名称：</label>
							<input type="text" name="store_name" value="" />
						</fieldset>
					</div>


					<div class="modal-footer">
						<button type="submit" class="btn btn-primary btn-primary">添加</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</form>
			</div>
		</div>
	</div>




	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">修改店长账户</h4>
				</div>
				<form id="storeuserform" action="./editstoreuser" method="post">
					<div class="container" style="margin: 20px;">
						<fieldset>
							<label>店长手机：</label>
							<input id="phone" type="text" name="phone" value="" />
						</fieldset>
						<fieldset>
							<label>登录密码：</label>
							<input id="password" type="password" name="password" value="" />
						</fieldset>
					</div>

					<input id="sid" type="hidden" name="sid" value="" />
					<input id="suserid" type="hidden" name="suserid" value="" />
					<div class="modal-footer">
						<button type="button" class="btn btn-primary btn-primary" onclick="submitform()">提交</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</form>
			</div>
		</div>
	</div>


</body>
</html>