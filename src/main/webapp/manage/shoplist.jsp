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
<link href="./css/style.css" rel="stylesheet" media="screen">
<script type="text/javascript" src="./bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/page.js"></script>
<script type="text/javascript">
	$(function() {
		$("#menu1").addClass('active');
		var category_id = $("#category_id").val();
		if(category_id == ""){
			 $("#selectbutton").text("请选择分类");
		}else if(category_id == 0){
			 $("#selectbutton").text("全部");
		}else{
			$("#selectbutton").text($("#category_name").val());
		}
	})
	
	
	function edit(sid) {
		$("#sid").val(sid);
		$.ajax({ url: "./getstoreuser?sid="+sid, 
			async: false, 
			success: function(data){
				$("#suserid").val("");
				$("#phone").val("");
				if(data != null){
					$("#suserid").val(data.id);
					$("#phone").val(data.phone);
				}
// 				$("#password").val(data.password.substr(0,8));
				}
	      });
		$("#editModal").modal('show');
	 } 

	function del(store_id){
		if(confirm("是否删除？")){
			$.ajax({ 
				type: "post",
				url: "./delshop?store_id="+store_id, 
				async: false, 
				success: function(msg){
					var msgdata = eval("("+msg+")");
					var code = msgdata.code;
					if(code == 1){
						alert(msgdata.message);
						window.location.reload();
					}else{
						alert(msgdata.message);
						return;
					}
				}
		      });
		}
	}
	 function submitform(){
		 var phone = $("#phone").val();
		 if(phone == ''){
			 alert("店长号码不能为空");
			 return false;
		 }
		 if($("#suserid").val() == ""){
			 var password = $("#password").val();
			 if(password == ''){
				 alert("密码不能为空");
				 return false;
			 }
		 }
			 
		 $.ajax({url:'./editstoreuser',
				data:$('#storeuserform').serialize(),
				type:"POST",
				success:function(data){
					$("#phone").val("");
					$("#password").val("");
					$("#editModal").modal('hide');
					if(data=="success"){
						alert("操作成功");
						window.location.reload();
					}else{
						alert("操作失败");
					}
				}
			});
	}
	 
	 function selectcategory(id){
         $("#category_id").val(id);
         var keywords = $("#keywords").val();
         var category_id = $("#category_id").val();
         window.location.href = "./shoplist?category_id="+category_id+"&keywords="+keywords;
     }
	 
	 function findshoplist(){
		 var keywords = $("#keywords").val();
         var category_id = $("#category_id").val();
         window.location.href = "./shoplist?category_id="+category_id+"&keywords="+keywords;
	 }

	 function checkstore_name(){
		 var store_name = $("#alert_store_name").val();
		 if(store_name == ''){
			 alert("商店名不能为空");
			 return false;
		 }
		 
	 }
	 
	 function cleareditModalForm(){
		 $("#phone").val("");
		 $("#password").val("");
	 }
	 
	 function clearaddModalForm(){
		 $("#alert_store_name").val("");
		 $("#alert_store_phone").val("");
	 }
	 
	 function salecount(store_id){
		 window.location.href = "./solosalecount?store_id="+store_id;
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
								<div class="span4">
									<div class="btn-group">
										<button class="btn" id="selectbutton">请选择分类</button>
										<button data-toggle="dropdown" class="btn dropdown-toggle">
											<span class="caret"></span>
										</button>
										<ul class="dropdown-menu">
											<li><a onclick="selectcategory(0)">全部</a></li>
											 <c:forEach items="${categorylist }" var="p">
                                            <li><a onclick="selectcategory(${p.id})">${p.name }</a></li>
                                            </c:forEach>
										</ul>
										<input type="hidden" value="${category_id }" name="category_id" id="category_id"/>
										<input type="hidden" value="${category_name}" name="category_name" id="category_name"/>
									</div>
								</div>
								<div class="span6">
									<form class="form-search">
										<input class="input-medium search-query" value="${keywords }" type="text" id="keywords" name="keywords" style="width: 40%" />
										<button type="button" class="btn" onclick="findshoplist()">查找</button>
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
											<td><button class="btn btn-small btn-info" type="button" onclick="edit(${s.store_id})" style="float: left;">店长账号</button>
											<button class="btn btn-small btn-info" type="button" onclick="salecount(${s.store_id})" style="float: left;margin-left: 5px;">营业额统计</button>
											<button class="btn btn-small btn-danger" type="button" onclick="del(${s.store_id})" style="float: left; margin-left: 5px;">删除</button></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<c:if test="${pageCount>1}">
								<div class="pagination pagination-centered" style="cursor: pointer;">
								<input type="hidden" value="${pageCount }" id="pageSize" />
                                <input type="hidden" value="${pageIndex }" id="pageIndex" />
									<ul id="untreatedpage" >
									</ul>
								<script type="text/javascript">
                                //container 容器，count 总页数 pageindex 当前页数
                                function setPage(container, count, pageindex) {
                                var container = container;
                                var count = parseInt(count);
                                var pageindex = parseInt(pageindex);
                                var keywords = $("#keywords").val();
                                var category_id = $("#category_id").val();
                                var a = [];
                                  //总页数少于10 全部显示,大于10 显示前3 后3 中间3 其余....
                                  if (pageindex == 1) {
                                      //alert(pageindex);
                                    a[a.length] = "<li class='disabled'><a onclick=\"\" class=\"hide_page_prev unclickprev on\">&laquo;</a></li>";
                                  } else {
                                    a[a.length] = "<li><a onclick=\"previousPage("+pageindex+",'./shoplist?keywords="+keywords+
                                    		"&category_id="+category_id+"&')\" class=\"page_prev\">&laquo;</a></li>";
                                  }
                                  function setPageList() {
                                    if (pageindex == i) {
                                      a[a.length] = "<li class='active'><a onclick=\"goPage('./shoplist?keywords="+keywords+
                              		"&category_id="+category_id+"&',"+i+")\" class=\"on\">" + i + "</a></li>";
                                    } else {
                                      a[a.length] = "<li><a onclick=\"goPage('./shoplist?keywords="+keywords+
                              		"&category_id="+category_id+"&',"+i+")\">" + i + "</a></li>";
                                    }
                                  }
                                  //总页数小于10
                                  if (count <= 10) {
                                    for (var i = 1; i <= count; i++) {
                                      setPageList();
                                    };
                                  } else {
                                    //总页数大于10页
                                    if (pageindex <= 4) {
                                      for (var i = 1; i <= 5; i++) {
                                        setPageList();
                                      }
                                      a[a.length] = "...<li><a onclick=\"goPage('./shoplist?keywords="+keywords+
                              		"&category_id="+category_id+"&',"+count+")\">" + count + "</a></li>";
                                    } else if (pageindex >= count - 3) {
                                      a[a.length] = "<li><a onclick=\"goPage('./shoplist?keywords="+keywords+
                              		"&category_id="+category_id+"&',1)\">1</a></li>...";
                                      for (var i = count - 4; i <= count; i++) {
                                        setPageList();
                                      };
                                    } else { //当前页在中间部分
                                      a[a.length] = "<li><a onclick=\"goPage('./shoplist?keywords="+keywords+
                              		"&category_id="+category_id+"&',1)\">1</a></li>...";
                                      for (var i = pageindex - 2; i <= pageindex+2; i++) {
                                        setPageList();
                                      }
                                      a[a.length] = "...<li><a onclick=\"goPage('./shoplist?keywords="+keywords+
                              		"&category_id="+category_id+"&',"+count+")\">" + count + "</a></li>";
                                    }
                                  }
                                  if (pageindex == count) {
                                        a[a.length] = "<li class='disabled'><a style='border-bottom-right-radius:4px;border-top-right-radius:4px; ' onclick=\"\" class=\"hide_page_next unclicknext\">&raquo;</a></li>"+
                                     	"<li>共"+count+"页  到第  "+
                                        "<input type=\"text\" class=\"jump_num\" id=\"topage\" style='width: 27px; margin-bottom: 1px; height: 15px;'/> <span style='margin-right: 2px;border: 0px;'>页</span></li>"+
                                        "<li><a style='border-left-width: 1px; border-radius: 4px;' class=\"jump_btn\" onclick=\"gotoPage('./shoplist?keywords="+keywords+
                                		"&category_id="+category_id+"&',"+$("#pageSize").val()+")\")\">确定</li>";
                                      } else {
                                        a[a.length] = 
                                            "<li><a style='border-bottom-right-radius:4px;border-top-right-radius:4px; ' onclick=\"nextPage("+$("#pageIndex").val()+",'./shoplist?keywords="+keywords+
                                    		"&category_id="+category_id+"&')\" "+
                                            "class=\"page_next\">&raquo;</a></li> "+
                                            "<li>共"+count+"页 到第 "+
                                        "<input type=\"text\" class=\"jump_num\" id=\"topage\" style='width: 27px; margin-bottom: 1px; height: 15px;'/><span style='margin-right: 2px; border: 0px;'>页</span></li>"+
                                        "<li><a style='border-left-width: 1px; border-radius: 4px;' class=\"jump_btn\" onclick=\"gotoPage('./shoplist?keywords="+keywords+
                                		"&category_id="+category_id+"&',"+$("#pageSize").val()+")\">确定</li>";
                                      }
                                  container.innerHTML = a.join("");
                                } 
                                setPage(document.getElementById("untreatedpage"),parseInt($("#pageSize").val()),parseInt($("#pageIndex").val()));
                                </script>
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
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="clearaddModalForm()">&times;</button>
					<h4 class="modal-title" id="myModalLabel">添加新的商户</h4>
				</div>
				<form action="./addshop" method="post">
					<div class="container" style="margin: 20px;">
						<fieldset>
							<label>商店名称：</label>
							<input type="text" name="store_name" id="alert_store_name" value="" />
						</fieldset>
						<fieldset>
							<label>商店电话：</label>
							<input type="text" name="phone" id="alert_store_phone" value="" />
						</fieldset>
						<fieldset>
							<label>商店分类：</label>
							<select name="category_id" id="alert_store_category_id">
							 <c:forEach items="${categorylist }" var="p">
							 	<option value="${p.id}">${p.name }</option>
							  </c:forEach>
							</select>
						</fieldset>
						<fieldset>
							<label>支持外卖：</label>
							<input type="radio" value="0" name="is_out" checked="checked"> 不支持
							<input type="radio" value="1" name="is_out"> 支持
						</fieldset>
					</div>


					<div class="modal-footer">
						<button type="submit" class="btn btn-primary btn-primary" onclick="return checkstore_name()">添加</button>
						<button type="button" class="btn btn-default" data-dismiss="modal" onclick="clearaddModalForm()">关闭</button>
					</div>
				</form>
			</div>
		</div>
	</div>




	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="cleareditModalForm()">&times;</button>
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
						<button type="button" class="btn btn-default" data-dismiss="modal" onclick="cleareditModalForm()">关闭</button>
					</div>
				</form>
			</div>
		</div>
	</div>


</body>
</html>