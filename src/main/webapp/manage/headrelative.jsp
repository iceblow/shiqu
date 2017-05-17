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
<link href="./css/page.css" rel="stylesheet">
<script type="text/javascript" src="./bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/page.js"></script>
<script type="text/javascript">
	$(function() {
		$("#menu2").addClass('active');
		$("#checkAll").click(function() {
	        $('input[name="store_id"]').prop("checked",this.checked); 
	    });
	    var $store_id = $("input[name='store_id']");
	    $store_id.click(function(){
	        $("#checkAll").prop("checked",$store_id.length == $("input[name='store_id']:checked").length ? true : false);
	    });
	})
	
	function relativemany(){
		var idlength =   $("input[name='store_id']:checked").length;
		if(idlength == 0){
			alert("至少选择一个商店！");
			return;
		}else{
			$.ajax({
				type: "post",
				url: "./relativeheadStore",
				data: $("#storeForm").serialize(),
				success: function(data){
					if(data == "success"){
						alert("关联成功!");
						window.location.reload();
					}
				}
			});
		}
	}
	
	function relative(id){
		var headid =  $("#headid").val();
		$.ajax({
			type: "post",
			url: "./relativeheadStore",
			data: {store_id :id, headid :headid},
			success: function(data){
				if(data == "success"){
					alert("关联成功!");
					window.location.reload();
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
									<button class="btn btn-small btn-info" type="button" onclick="relativemany()" style="float: left;margin-left: 5px;">关联商店</button>
								</div>
								<div class="span2">
								</div>
							</div>
							<form action="" id="storeForm" method="post">
							<input type="hidden" value=${headid } name="headid" id="headid"/>
							<table class="table table-condensed table-hover table-bordered">
								<thead>
									<tr>
										<th><input id="checkAll" type="checkbox" name="checall"/></th>
										<th>店铺名</th>
										<th>电话</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${storelist}" var="s">
										<tr>
											<td><input type="checkbox" name="store_id" value="${s.store_id }"/></td>
											<td>${s.store_name}</td>
											<td>${s.phone}</td>
											<td>
												<button class="btn btn-small btn-info" type="button" onclick="relative(${s.store_id})" style="float: left;margin-left: 5px;">关联商店</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							</form>
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
                                    a[a.length] = "<li><a onclick=\"previousPage("+pageindex+",'./relativeStore?')\" class=\"page_prev\">&laquo;</a></li>";
                                  }
                                  function setPageList() {
                                    if (pageindex == i) {
                                      a[a.length] = "<li class='active'><a onclick=\"goPage('./relativeStore?',"+i+")\" class=\"on\">" + i + "</a></li>";
                                    } else {
                                      a[a.length] = "<li><a onclick=\"goPage('./relativeStore?',"+i+")\">" + i + "</a></li>";
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
                                      a[a.length] = "...<li><a onclick=\"goPage('./relativeStore?',"+count+")\">" + count + "</a></li>";
                                    } else if (pageindex >= count - 3) {
                                      a[a.length] = "<li><a onclick=\"goPage('./relativeStore?',1)\">1</a></li>...";
                                      for (var i = count - 4; i <= count; i++) {
                                        setPageList();
                                      };
                                    } else { //当前页在中间部分
                                      a[a.length] = "<li><a onclick=\"goPage('./relativeStore?',1)\">1</a></li>...";
                                      for (var i = pageindex - 2; i <= pageindex+2; i++) {
                                        setPageList();
                                      }
                                      a[a.length] = "...<li><a onclick=\"goPage('./relativeStore?',"+count+")\">" + count + "</a></li>";
                                    }
                                  }
                                  if (pageindex == count) {
                                        a[a.length] = "<li class='disabled'><a style='border-bottom-right-radius:4px;border-top-right-radius:4px; ' onclick=\"\" class=\"hide_page_next unclicknext\">&raquo;</a></li>"+
                                     	"<li>共"+count+"页  到第  "+
                                        "<input type=\"text\" class=\"jump_num\" id=\"topage\" style='width: 27px; margin-bottom: 1px; height: 15px;'/> <span style='margin-right: 2px;border: 0px;'>页</span></li>"+
                                        "<li><a style='border-left-width: 1px; border-radius: 4px;' class=\"jump_btn\" onclick=\"gotoPage('./relativeStore?',"+$("#pageSize").val()+")\")\">确定</li>";
                                      } else {
                                        a[a.length] = 
                                            "<li><a style='border-bottom-right-radius:4px;border-top-right-radius:4px; ' onclick=\"nextPage("+$("#pageIndex").val()+",'./relativeStore?')\" "+
                                            "class=\"page_next\">&raquo;</a></li> "+
                                            "<li>共"+count+"页 到第 "+
                                        "<input type=\"text\" class=\"jump_num\" id=\"topage\" style='width: 27px; margin-bottom: 1px; height: 15px;'/><span style='margin-right: 2px; border: 0px;'>页</span></li>"+
                                        "<li><a style='border-left-width: 1px; border-radius: 4px;' class=\"jump_btn\" onclick=\"gotoPage('./relativeStore?',"+$("#pageSize").val()+")\">确定</li>";
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
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="clearinput()">&times;</button>
					<h4 class="modal-title" id="myModalLabel">添加门店用户</h4>
				</div>
				<form action="./addheadshop" method="post">
					<div class="container" style="margin: 20px;">
					<input id="sid" type="hidden" name="id" value="0" />
						<fieldset>
							<label>门店名称：</label>
							<input type="text" name="name" id="alert_name" value="" />
						</fieldset>
						<fieldset>
							<label>登录密码：</label>
							<input id="password" type="password" name="password" value="" />
						</fieldset>
					</div>


					<div class="modal-footer">
						<button type="submit" class="btn btn-primary btn-primary" onclick="return checkstore_name()">添加</button>
						<button type="button" class="btn btn-default" data-dismiss="modal" onclick="clearinput()">关闭</button>
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