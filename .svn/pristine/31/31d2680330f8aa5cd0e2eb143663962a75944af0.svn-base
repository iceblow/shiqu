<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/dishes.css" rel="stylesheet">
<link href="./css/common.css" rel="stylesheet">
<link href="./css/page.css" rel="stylesheet">
<script src="./js/jquery-1.11.2.min.js"></script>
<script src="./js/page.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./js/common.js"></script>
<script type="text/javascript">
	$(function(){
		if($("#menu_id").val() == ""){
			$("#menu_id").val(0);
		}
	});
	
	function delTask(index){
		$("#task_input_"+index).val("");
		$("#task_"+index).hide();
	}
	
	function delTaskinput(index){
		$("#addTask_input_"+index).val("");
		$("#addTask_"+index).hide();
	}
	
	function addTask(index){
		var nextindex = index+1;
		$("#addTaskbutton").attr("onclick", "addTask("+nextindex+")");
		var html = "<div id='addTask_"+nextindex+"' style='width: 280px; height: 48px; clear:both; margin-left: 1%;'>"+
		"<input type='text' id='addTask_input_"+nextindex+"' name='taste' style='margin-top: 0px; width: 174px; height: 38px; float:left;'/>"+
		"<span style='line-height: 48px;cursor: pointer;' onclick='delTaskinput("+nextindex+")'>&nbsp;&nbsp;-&nbsp;&nbsp;删除口味</span>"+
		"</div>"
		$("#addTask_"+index).before(html);
	}
	
	function checkForm(){
		var menu_name = $("#menu_name").val();
		if(menu_name == ""){
			alert("名称不能为空");
			$("#menu_name").focus();
			return false;
		}
		var price = $("#price").val();
		if(price == ""){
			alert("单价不能为空");
			$("#price").focus();
			return false;
		}
		var origin_price = $("#origin_price").val();
		if(origin_price == ""){
			alert("原价不能为空");
			$("#origin_price").focus();
			return false;
		}
		var unit = $("#unit").val();
		if(unit == ""){
			alert("点菜单位不能为空");
			$("#unit").focus();
			return false;
		}
// 		var description = $("#description").val();
// 		if(description == ""){
// 			alert("菜品描述不能为空");
// 			$("#description").focus();
// 			return false;
// 		}
	}
	
	function clearinput(){
		$("#menu_name").val("");
		$("#price").val("");
		$("#origin_price").val("");
		$("#kitunit").val("");
		$("#description").val("");
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
	 
	 function changeunit(name){
		$("#unit").val(name);
	 }
	 
	 function changekitunit(name){
		 $("#kitunit").val(name);
	 }
	 
	 function showUnit(){
		 $("#menuUnit").show();
	 }
	 
	 function hideUnit(){
		 setTimeout(function(){
			 $("#menuUnit").hide();
		},200);
	 }
	 
	 function showKitUnit(){
		 $("#menuKitUnit").show();
	 }
	 
	 function hideKitUnit(){
		 setTimeout(function(){
			 $("#menuKitUnit").hide();
		 },200);
	 }
</script>
<title>食趣商家管理平台</title>
</head>
<body>
<div id="content">
	<div style="width: 100%; height: 83px; border-bottom: 1px solid #e5e6ea;">
		<div style="width: 100%; height: 38px;"></div>
		<div style="float: left; background-image: url(imgs/hicon.png); background-repeat: no-repeat;height: 17px; background-position-y: 5px;width: 11px;"></div>
		<span style="float:left; font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;菜品管理&nbsp;&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;菜品管理&nbsp;&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;<font style="color: #5f97fa;">添加菜品</font></span>
	</div>
	<form action="./saveorupdateMenu" id="menuForm" method="post" enctype="multipart/form-data">
	<input type="hidden" value="${menu.menu_id }" id="menu_id" name="menu_id"/>
	<input type="hidden" value="${shopid }" id="store_id" name="store_id"/>
	<div class="detailItem">
		<div class="detailItemLeft"><span style="margin-right: 15%;">名称</span></div>
		<div class="detailItemRight"><input value="${menu.menu_name }" id="menu_name" name="menu_name"/></div>
	</div>
	<div class="detailItem">
		<div class="detailItemLeft"><span style="margin-right: 15%;">所属分类</span></div>
		<div class="detailItemRight">
			<select name="category_id">
			<c:if test="${empty menu }">
				<c:forEach items="${categorylist }" var="p">
					<option value="${p.id }">${p.name }</option>
				</c:forEach>
			</c:if>
			<c:if test="${not empty menu }">
				<c:forEach items="${categorylist }" var="p">
					<c:if test="${menu.category_id == p.id }">
						<option value="${p.id }" selected="selected">${p.name }</option>
					</c:if>
					<c:if test="${menu.category_id != p.id }">
						<option value="${p.id }">${p.name }</option>
					</c:if>
				</c:forEach>
			</c:if>
			</select>
		</div>
	</div>
	<div class="detailItem">
		<div class="detailItemLeft"><span style="margin-right: 15%;">单价(元)</span></div>
		<div class="detailItemRight"><input value="${menu.price }" id="price" name="price" onkeyup="checkKeyForFloat(event, 'price')"/></div>
	</div>
	<div class="detailItem">
		<div class="detailItemLeft"><span style="margin-right: 15%;">原价(元)</span></div>
		<div class="detailItemRight"><input value="<c:if test="${empty menu }">0</c:if><c:if test="${not empty menu }">${menu.origin_price }</c:if>" id="origin_price" name="origin_price" onkeyup="checkKeyForFloat(event, 'origin_price')"/></div>
	</div>
	<div class="detailItem">
		<div class="detailItemLeft"><span style="margin-right: 15%;">点菜单位</span></div>
		<div class="detailItemRight">
		<input value="${menu.unit }" autocomplete="off" id="unit" name="unit" maxlength="10" onfocus="showUnit()" onblur="hideUnit()"/>
		<div id="menuUnit" style="display:none; position: relative; width: 243px; border: 1px solid #bdc6d7; border-top: 0px; left: 1%; background-color: #fff; cursor: pointer; ">
			<c:forEach items="${unitlist }" var="u" varStatus="ustatus">
			<c:if test="${not ustatus.last }">
				<div style="width: 100%; height: 27px; line-height: 27px; text-align: left; border-bottom: 1px dotted #bdc6d7;" onclick="changeunit('${u.unit_name }')">${u.unit_name }</div>
			</c:if>
			<c:if test="${ ustatus.last }">
				<div style="width: 100%; height: 27px; line-height: 27px; text-align: left;" onclick="changeunit('${u.unit_name }')">${u.unit_name }</div>
			</c:if>
			</c:forEach>
		</div>
		</div>
	</div>
	<div class="detailItem">
		<div class="detailItemLeft"><span style="margin-right: 15%;">送厨单位</span></div>
		<div class="detailItemRight">
		<input value="${menu.kitunit }" name="kitunit" id="kitunit"  autocomplete="off" onfocus="showKitUnit()" onblur="hideKitUnit()"/>
		<div id="menuKitUnit" style="display:none; position: relative; width: 243px; border: 1px solid #bdc6d7; border-top: 0px; left: 1%; background-color: #fff; cursor: pointer; ">
			<c:forEach items="${unitlist }" var="u" varStatus="ustatus">
			<c:if test="${not ustatus.last }">
				<div style="width: 100%; height: 27px; line-height: 27px; text-align: left; border-bottom: 1px dotted #bdc6d7;" onclick="changekitunit('${u.unit_name }')">${u.unit_name }</div>
			</c:if>
			<c:if test="${ ustatus.last }">
				<div style="width: 100%; height: 27px; line-height: 27px; text-align: left;" onclick="changekitunit('${u.unit_name }')">${u.unit_name }</div>
			</c:if>
			</c:forEach>
		</div>
		</div>
	</div>
	<div class="detailItem" style="height: auto; border-bottom: 0px;">
		<div class="detailItemLeft"><span style="margin-right: 15%;">口味</span></div>
		<div class="detailItemRight" style="height: auto; min-height: 74px;">
		<c:forEach items="${tastelist }" var="p" varStatus="status">
		<div id="task_${status.index }" style="position:relative; width: 84px; height: 38px; border-radius: 4px; color: #fff; float:left; margin-right: 10px; top: 20px;margin-bottom: 10px;">
		<input id="task_input_${status.index }" name="taste" style="width: 84px; height: 38px; border-radius: 4px; background: #6097fb; color: #fff; text-align: center; margin-top: 0px; overflow: hidden;" readonly="readonly" value="${p }"/>
		<div style="position: absolute ; width: 20px; height: 20px; border-radius: 10px; background: #929a9e; 
		color: #fff; text-align: center; line-height: 18px;top: -10px;right: -8px; cursor: pointer;" onclick="delTask(${status.index })">x</div>
		</div>
		</c:forEach>
		<div style="clear: both; padding: 10px;"></div>
		<div id="addTask_0" style="width: 280px; height: 48px; clear:both; margin-left: 1%;">
			<input type="text" id="addTask_input_0" name="taste" style="margin-top: 0px; width: 174px; height: 38px; float:left;"/>
			<span style="line-height: 48px;cursor: pointer;" id="addTaskbutton" onclick="addTask(0)">&nbsp;&nbsp;+&nbsp;&nbsp;添加口味</span>
		</div>
		</div>
	</div>
	<div style="clear: both; border-top: 1px solid #e5e6ea;"></div>
	<div class="detailItem">
		<div class="detailItemLeft"><span style="margin-right: 15%;">打印机</span></div>
		<div class="detailItemRight">
			<select name="print_id1" style="float:left;">
				<option value="0">--请选择--</option>
				<c:forEach items="${printlist }" var ="pr1">
					<c:if test="${pr1.id == menu.print_id1 }">
					<option value="${pr1.id }" selected="selected">${pr1.print_name }</option>
					</c:if>
					<c:if test="${pr1.id != menu.print_id1 }">
					<option value="${pr1.id }">${pr1.print_name }</option>
					</c:if>
				</c:forEach>
			</select>
			<select name="print_id2" style="float:left;">
				<option value="0">--请选择--</option>
				<c:forEach items="${printlist }" var ="pr2">
					<c:if test="${pr2.id == menu.print_id2 }">
					<option value="${pr2.id }" selected="selected">${pr2.print_name }</option>
					</c:if>
					<c:if test="${pr2.id != menu.print_id2 }">
					<option value="${pr2.id }">${pr2.print_name }</option>
					</c:if>
				</c:forEach>
			</select>
			<select name="print_id3" style="float:left;">
				<option value="0">--请选择--</option>
				<c:forEach items="${printlist }" var ="pr3">
					<c:if test="${pr3.id == menu.print_id3 }">
					<option value="${pr3.id }">${pr3.print_name }</option>
					</c:if>
					<c:if test="${pr3.id != menu.print_id3 }">
					<option value="${pr3.id }">${pr3.print_name }</option>
					</c:if>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="detailItem" style="height:110px;">
		<div class="detailItemLeft"><span style="margin-right: 15%;">图片</span></div>
		<div class="detailItemRight">
		<c:if test="${menu.pic_url  eq  null }">
			<img src="./imgs/img_default.png" id="picfile_img" width="100px" height="100px" style="float:left;margin-top:5px;margin-left:10px;">
		</c:if>
		<c:if test="${not empty menu.pic_url  }">
		<img src="${menu.pic_url }" id="picfile_img" width="100px" height="100px" style="float:left;margin-top:5px;margin-left:10px;">
		</c:if>
			<input type="file" id="picFile" name="picFile" style="position: relative; width: 105px; height: 40px; opacity:0; float: left;cursor: pointer;" onchange="change('picfile_img','picFile');"/>
			<button type="button" class="btn btn-primary " aria-haspopup="true" aria-expanded="false" style="width: 105px; height: 40px; margin-top: 20px;margin-left: -105px; float:left;">本地浏览...</button>
			<span style="color: #bdc6d7; line-height: 74px;float: left;">(支持上传单张5M以下的gif,jpg,png文件)</span>
		</div>
	</div>
	<div class="detailItem" style="height: 145px;">
		<div class="detailItemLeft"><span style="margin-right: 15%;">菜品描述</span></div>
		<div class="detailItemRight">
			<textarea id="description" name="description" style="resize: none;">${menu.description }</textarea>
		</div>
	</div>
	<div class="detailItem">
		<div class="detailItemLeft"><span style="margin-right: 15%;">其他</span></div>
		<div class="detailItemRight">
			<c:if test="${ menu.can_discount == 1 }">
			<input type="checkbox" style="float:left; margin-left: 1%; width: 20px; height: 20px; border: 0px; margin-top: 30px;" checked="checked" value="1" name="can_discount"/><span style="float:left;line-height: 74px;">打折</span>
			</c:if>
			<c:if test="${menu.can_discount == 0 }">
			<input type="checkbox" style="float:left; margin-left: 1%; width: 20px; height: 20px; border: 0px; margin-top: 30px;" value="1" name="can_discount"/><span style="float:left;line-height: 74px;">打折</span>
			</c:if>
			<c:if test="${menu.is_weigh == 1 }">
			<input type="checkbox" style="float:left; margin-left: 69px;  width: 20px; height: 20px; border: 0px; margin-top: 30px" value="1" checked="checked" name="is_weigh"/><span style="float:left;line-height: 74px;">称重</span>
			</c:if>
			<c:if test="${menu.is_weigh == 0 }">
			<input type="checkbox" style="float:left; margin-left: 69px;  width: 20px; height: 20px; border: 0px; margin-top: 30px" value="1" name="is_weigh"/><span style="float:left;line-height: 74px;">称重</span>
			</c:if>
			<c:if test="${menu.sell_out == 1 }">
			<input type="checkbox" style="float:left; margin-left: 69px;  width: 20px; height: 20px; border: 0px; margin-top: 30px" value="1" checked="checked" name="sell_out"/><span style="float:left;line-height: 74px;">沽清</span>
			</c:if>
			<c:if test="${menu.sell_out == 0 }">
			<input type="checkbox" style="float:left; margin-left: 69px;  width: 20px; height: 20px; border: 0px; margin-top: 30px" value="1" name="sell_out"/><span style="float:left;line-height: 74px;">沽清</span>
			</c:if>
			<c:if test="${menu.is_hot == 1 }">
			<input type="checkbox" style="float:left; margin-left: 69px;  width: 20px; height: 20px; border: 0px; margin-top: 30px" value="1" checked="checked" name="is_hot"/><span style="float:left;line-height: 74px;">热销</span>
			</c:if>
			<c:if test="${menu.is_hot == 0 }">
			<input type="checkbox" style="float:left; margin-left: 69px;  width: 20px; height: 20px; border: 0px; margin-top: 30px" value="1" name="is_hot"/><span style="float:left;line-height: 74px;">热销</span>
			</c:if>
			<c:if test="${empty menu}">
				<input type="checkbox" style="float:left; margin-left: 1%;  width: 20px; height: 20px; border: 0px;margin-top: 30px;" value="1" checked="checked" name="can_discount"/><span style="float:left;line-height: 74px;">打折</span>
				<input type="checkbox" style="float:left; margin-left: 69px; width: 20px; height: 20px; border: 0px; margin-top: 30px" value="1" name="is_weigh"/><span style="float:left;line-height: 74px;">称重</span>
				<input type="checkbox" style="float:left; margin-left: 69px;  width: 20px; height: 20px; border: 0px; margin-top: 30px" value="1" name="sell_out"/><span style="float:left;line-height: 74px;">沽清</span>
				<input type="checkbox" style="float:left; margin-left: 69px;  width: 20px; height: 20px; border: 0px; margin-top: 30px" value="1" name="is_hot"/><span style="float:left;line-height: 74px;">热销</span>
			</c:if>
		</div>
	</div>
	<div style="width: 100%;height: 40px;"></div>
	<input type="submit" class="saveorupdate" style="float:left;" value="确定并上传" onclick="return checkForm();"/>
	<div class="clearinput" style="float:left;" onclick="clearinput()">清空填写内容</div>
	<div style="width: 100%;height: 40px;"></div>
	</form>
</div>
</body>
</html>