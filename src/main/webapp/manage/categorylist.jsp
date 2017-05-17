<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>店铺分类管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="./bootstrap/jquery-2.0.0.min.js"></script>
<script type="text/javascript" src="./bootstrap/jquery-ui"></script>
<link href="./bootstrap/bootstrap-combined.min.css" rel="stylesheet" media="screen">
<script type="text/javascript" src="./bootstrap/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#menu22").addClass('active');
	})

 	function edit(cid, name, pic_url) {
		$("#hidden_cid").val(cid);
		$("#alert_name").val(name);
		if(pic_url != ""){
			document.getElementById("picimgs").src=pic_url;
		}
		$("#myModal").modal('show');
	 } 
	
	function clearForm(){
		$("#alert_name").val("");
		$("#hidden_cid").val("");
		$("#picfile").val("");
		document.getElementById("picimgs").src="imgs/img_default.png";
	}
	
	 function change(a, b) {
	 		var pic = document.getElementById(a);
			var file = document.getElementById(b);

			var fileval = $("#" + b).val();
			if (fileval == "") {
				return;
			}
			// gif在IE浏览器暂时无法显示
			if (!/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(file.value)) {
				alert("图片类型必须是.gif,jpeg,jpg,png中的一种,请重新上传!");
				file.outerHTML = file.outerHTML.replace(/(value=\").+\"/i, "$1\"");
				return;
			}

			var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
			var fileSize = 0;
			if (isIE && !file.files) {
				var filePath = file.value;
				var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
				var fileImg = fileSystem.GetFile(filePath);
				fileSize = fileImg.Size;
			} else {
				fileSize = file.files[0].size;
			}
			var size = fileSize / 1024 * 1024; //单位B
//			if (size > (1024 * 1024)) {
//				alert("文件大小不能超过1M,请重新编辑后上传");
//				file.outerHTML = file.outerHTML.replace(/(value=\").+\"/i, "$1\"");
//				return;
//			}

			// IE浏览器
			if (document.all) {
				file.select();
				var reallocalpath = document.selection.createRange().text;
				var ie6 = /msie 6/i.test(navigator.userAgent);
				// IE6浏览器设置img的src为本地路径可以直接显示图片
				if (ie6)
					pic.src = reallocalpath;
				else {
					// 非IE6版本的IE由于安全问题直接设置img的src无法显示本地图片，但是可以通过滤镜来实现
					pic.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='image',src=\""
							+ reallocalpath + "\")";
					// 设置img的src为base64编码的透明图片 取消显示浏览器默认图片
					pic.src = 'data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==';
				}
			} else {
				html5Reader(file, pic);
			}
			$(".selectedfile").val(file.value);
		}

	 function html5Reader(file, pic) {
			var file = file.files[0];
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = function(e) {

				pic.src = this.result;
			};
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
							<button class="btn btn-primary btn-large" type="button" style="float: right;" data-toggle="modal" data-target="#myModal">添加分类</button>
						</div>
					</div>


					<table class="table table-bordered table-hover" style="margin-top: 10px;">
						<thead>
							<tr>
								<th>分类名</th>
								<th>图片</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${categorylist}" var="c">
								<tr>
									<td>${c.name}</td>
									<td>
									<c:if test="${empty c.pic_url}"><img src="imgs/defalut.png" style="width: 100px; height: 100px;"></c:if>
									<c:if test="${not empty c.pic_url }">
									<img src="${c.pic_url}" style="width: 100px; height: 100px;"> 
									</c:if>
									</td>
									<td><button class="btn btn-small btn-info" type="button" onclick="edit(${c.id},'${c.name }','${c.pic_url }')" style="float: left;">编辑</button>
										<form action="./delcategory" method="post" style="float: left; margin-left: 5px; margin-bottom: 0px;">
											<button class="btn btn-danger btn-small" type="submit">删除</button>
											<input type="hidden" name="cid" value="${c.id}" />
										</form></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>




				</div>
			</div>
		</div>
	</div>



	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="clearForm()">&times;</button>
					<h4 class="modal-title" id="myModalLabel">商店分类</h4>
				</div>


				<div class="row-fluid">
					<form action="./editcategory" method="post" enctype="multipart/form-data">
						<div class="span10">
							<fieldset style="margin: 15px;">
								<div style="line-height: 40px; margin-left: 10px;">
									分类名称：&nbsp;
									<input type="text" id="alert_name" name="name" value="" style="width: 240px; margin-top: 5px;" />
								</div>
								<input type="hidden" id="hidden_cid" name="cid" value="" />
							</fieldset>
							<fieldset style="margin: 15px;">
								<div style="line-height: 40px; margin-left: 10px;">
									图&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;片：&nbsp;
									<img src="imgs/img_default.png" style="width: 100px; height: 100px;margin-top: 5px;" id="picimgs">
									<input type="file" id="picfile" name="picfile" style="position: relative; width: 100px; height: 100px;top: 3px; left: -103px; opacity: 0; " onchange="change('picimgs','picfile');"/>
								</div>
								<input type="hidden" id="hidden_cid" name="cid" value="" />
							</fieldset>
						</div>
						<div class="span2">
							<button class="btn btn-primary btn-primary" style="margin-top: 110px; margin-bottom: 20px; margin-right: 15px; float: right;" type="submit">提交</button>
						</div>
					</form>
				</div>




				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" onclick="clearForm()">关闭</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>