<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>商户管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="./bootstrap/jquery-2.0.0.min.js"></script>
<script type="text/javascript" src="./bootstrap/jquery-ui"></script>
<link href="./bootstrap/bootstrap-combined.min.css" rel="stylesheet"
	media="screen">
<link href="./css/style.css" rel="stylesheet" media="screen">
<script type="text/javascript" src="./bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/page.js"></script>
<script type="text/javascript">
	$(function() {
		$("#menu5").addClass('active');
	})

	function findshoplist() {
		var keywords = $("#keywords").val();
		window.location.href = "./userlist?keywords=" + keywords;
	}
</script>
</head>
<body>
	<div
		style="margin: 10px; border-width: 1px; border-style: solid; border-color: #DDD; border-collapse: separate; border-radius: 5px;">

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
									<form class="form-search">
										<input class="input-medium search-query" value="${keywords }"
											type="text" id="keywords" name="keywords" style="width: 40%" />
										<button type="submit" class="btn" onclick="findshoplist()">查找</button>
									</form>
								</div>
								<div class="span2">
									<!-- 									<button class="btn btn-primary" type="button" style="float: right;" data-toggle="modal" data-target="#addModal">添加代理商</button> -->
								</div>
							</div>
							<table class="table table-condensed table-hover table-bordered">
								<thead>
									<tr>
										<th>头像</th>
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
											<td><c:if test="${not empty s.avatar_url}">
													<img src="${s.avatar_url }"
														style="width: 50px; height: 50px; margin-left: 5px;">
												</c:if> <c:if test="${empty s.avatar_url}">
													<img src="imgs/defalut.png"
														style="width: 50px; height: 50px; margin-left: 5px;">
												</c:if></td>
											<td>${s.user_name}</td>
											<td>${s.real_name}</td>
											<td>${s.nick_name}</td>
											<td>${s.phone}</td>

											<td><fmt:formatDate value="${s.birthday }"
													pattern="yyyy-MM-dd" /></td>
											<td>${s.gender}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<c:if test="${pageCount>1}">
								<div class="pagination pagination-centered"
									style="cursor: pointer;">
									<input type="hidden" value="${pageCount }" id="pageSize" /> <input
										type="hidden" value="${pageIndex }" id="pageIndex" />
									<ul id="untreatedpage">
									</ul>
									<script type="text/javascript">
										//container 容器，count 总页数 pageindex 当前页数
										function setPage(container, count,
												pageindex) {
											var container = container;
											var count = parseInt(count);
											var pageindex = parseInt(pageindex);
											var keywords = $("#keywords").val();
											var a = [];
											//总页数少于10 全部显示,大于10 显示前3 后3 中间3 其余....
											if (pageindex == 1) {
												//alert(pageindex);
												a[a.length] = "<li class='disabled'><a onclick=\"\" class=\"hide_page_prev unclickprev on\">&laquo;</a></li>";
											} else {
												a[a.length] = "<li><a onclick=\"previousPage("
														+ pageindex
														+ ",'./userlist?keywords="
														+ keywords
														+ "&')\" class=\"page_prev\">&laquo;</a></li>";
											}
											function setPageList() {
												if (pageindex == i) {
													a[a.length] = "<li class='active'><a onclick=\"goPage('./userlist?keywords="
															+ keywords
															+ "&',"
															+ i
															+ ")\" class=\"on\">"
															+ i + "</a></li>";
												} else {
													a[a.length] = "<li><a onclick=\"goPage('./userlist?keywords="
															+ keywords
															+ "&',"
															+ i
															+ ")\">"
															+ i
															+ "</a></li>";
												}
											}
											//总页数小于10
											if (count <= 10) {
												for (var i = 1; i <= count; i++) {
													setPageList();
												}
												;
											} else {
												//总页数大于10页
												if (pageindex <= 4) {
													for (var i = 1; i <= 5; i++) {
														setPageList();
													}
													a[a.length] = "...<li><a onclick=\"goPage('./userlist?keywords="
															+ keywords
															+ "&',"
															+ count
															+ ")\">"
															+ count
															+ "</a></li>";
												} else if (pageindex >= count - 3) {
													a[a.length] = "<li><a onclick=\"goPage('./userlist?keywords="
															+ keywords
															+ "&',1)\">1</a></li>...";
													for (var i = count - 4; i <= count; i++) {
														setPageList();
													}
													;
												} else { //当前页在中间部分
													a[a.length] = "<li><a onclick=\"goPage('./userlist?keywords="
															+ keywords
															+ "&',1)\">1</a></li>...";
													for (var i = pageindex - 2; i <= pageindex + 2; i++) {
														setPageList();
													}
													a[a.length] = "...<li><a onclick=\"goPage('./userlist?keywords="
															+ keywords
															+ "&',"
															+ count
															+ ")\">"
															+ count
															+ "</a></li>";
												}
											}
											if (pageindex == count) {
												a[a.length] = "<li class='disabled'><a style='border-bottom-right-radius:4px;border-top-right-radius:4px; ' onclick=\"\" class=\"hide_page_next unclicknext\">&raquo;</a></li>"
														+ "<li>共"
														+ count
														+ "页  到第  "
														+ "<input type=\"text\" class=\"jump_num\" id=\"topage\" style='width: 27px; margin-bottom: 1px; height: 15px;'/> <span style='margin-right: 2px;border: 0px;'>页</span></li>"
														+ "<li><a style='border-left-width: 1px; border-radius: 4px;' class=\"jump_btn\" onclick=\"gotoPage('./userlist?keywords="
														+ keywords
														+ "&',"
														+ $("#pageSize").val()
														+ ")\")\">确定</li>";
											} else {
												a[a.length] = "<li><a style='border-bottom-right-radius:4px;border-top-right-radius:4px; ' onclick=\"nextPage("
														+ $("#pageIndex").val()
														+ ",'./userlist?keywords="
														+ keywords
														+ "&')\" "
														+ "class=\"page_next\">&raquo;</a></li> "
														+ "<li>共"
														+ count
														+ "页 到第 "
														+ "<input type=\"text\" class=\"jump_num\" id=\"topage\" style='width: 27px; margin-bottom: 1px; height: 15px;'/><span style='margin-right: 2px; border: 0px;'>页</span></li>"
														+ "<li><a style='border-left-width: 1px; border-radius: 4px;' class=\"jump_btn\" onclick=\"gotoPage('./userlist?keywords="
														+ keywords
														+ "&',"
														+ $("#pageSize").val()
														+ ")\">确定</li>";
											}
											container.innerHTML = a.join("");
										}
										setPage(
												document
														.getElementById("untreatedpage"),
												parseInt($("#pageSize").val()),
												parseInt($("#pageIndex").val()));
									</script>
								</div>
							</c:if>
						</div>
					</div>








				</div>
			</div>
		</div>

	</div>



	<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
		aria-labelledby="addModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" onclick="clearinput()">&times;</button>
					<h4 class="modal-title" id="myModalLabel">添加代理商用户</h4>
				</div>
				<form action="./addagent" method="post">
					<div class="container" style="margin: 20px;">
						<input id="sid" type="hidden" name="id" value="0" />
						<fieldset>
							<label>代理商名称：</label> <input type="text" name="name"
								id="alert_name" value="" />
						</fieldset>
						<fieldset>
							<label>登录密码：</label> <input id="password" type="password"
								name="password" value="" />
						</fieldset>
					</div>


					<div class="modal-footer">
						<button type="submit" class="btn btn-primary btn-primary"
							onclick="return checkstore_name()">添加</button>
						<button type="button" class="btn btn-default" data-dismiss="modal"
							onclick="clearinput()">关闭</button>
					</div>
				</form>
			</div>
		</div>
	</div>




	<!-- 	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true"> -->
	<!-- 		<div class="modal-dialog"> -->
	<!-- 			<div class="modal-content"> -->
	<!-- 				<div class="modal-header"> -->
	<!-- 					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
	<!-- 					<h4 class="modal-title" id="myModalLabel">修改店长账户</h4> -->
	<!-- 				</div> -->
	<!-- 				<form id="storeuserform" action="./editstoreuser" method="post"> -->
	<!-- 					<div class="container" style="margin: 20px;"> -->
	<!-- 						<fieldset> -->
	<!-- 							<label>店长手机：</label> -->
	<!-- 							<input id="phone" type="text" name="phone" value="" /> -->
	<!-- 						</fieldset> -->
	<!-- 						<fieldset> -->
	<!-- 							<label>登录密码：</label> -->
	<!-- 							<input id="password" type="password" name="password" value="" /> -->
	<!-- 						</fieldset> -->
	<!-- 					</div> -->

	<!-- 					<input id="sid" type="hidden" name="sid" value="" /> -->
	<!-- 					<input id="suserid" type="hidden" name="suserid" value="" /> -->
	<!-- 					<div class="modal-footer"> -->
	<!-- 						<button type="button" class="btn btn-primary btn-primary" onclick="return submitform()">提交</button> -->
	<!-- 						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> -->
	<!-- 					</div> -->
	<!-- 				</form> -->
	<!-- 			</div> -->
	<!-- 		</div> -->
	<!-- 	</div> -->


</body>
</html>