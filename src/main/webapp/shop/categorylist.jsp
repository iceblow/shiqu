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
<script type="text/javascript">
$(function(){
	 $("#checkAll").click(function() {
	        $('input[name="id"]').prop("checked",this.checked); 
	    });
	    var $id = $("input[name='id']");
	    $id.click(function(){
	        $("#checkAll").prop("checked",$id.length == $("input[name='id']:checked").length ? true : false);
	    });
});

function delcategory(id){
	if(confirm("是否不启用该分类?")){
		$.ajax({
			type: "post",
			url: "./delcategory",
			data: {id :id},
			success: function(msg){
				var msgdata = eval("("+msg+")");
				var code = msgdata.code;
				if(code == 1){
					alert("不启用成功!");
					window.location.reload();
				}else{
					alert(msgdata.message);
					return;
				}
			}
		});
	}
}

function usecategory(id){
	if(confirm("是否启用该分类?")){
		$.ajax({
			type: "post",
			url: "./usecategory",
			data: {id :id},
			success: function(msg){
				var msgdata = eval("("+msg+")");
				var code = msgdata.code;
				if(code == 1){
					alert("启用成功!");
					window.location.reload();
				}else{
					alert(msgdata.message);
					return;
				}
			}
		});
	}
}

function delcategorylist(){
	var idlength =   $("input[name='id']:checked").length;
	if(idlength == 0){
		alert("至少选择一个分类！");
		return;
	}else{
		$.ajax({
			type: "post",
			url: "./delCategoryList",
			data: $("#delForm").serialize(),
			success: function(msg){
				var msgdata = eval("("+msg+")");
				var code = msgdata.code;
				if(code == 1){
					alert(msgdata.message);
					window.location.reload();
				}else if(code == 500){
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

function showalert(id, name){
	$("#categoryid").val(id);
	$("#name").val(name);
	window.top.showmask();
	window.parent.showmask();
	$(".mask").show();
	$(".alert").css("top",document.documentElement.clientHeight/2-$(".alert").height()/2);
	$(".alert").css("left",document.documentElement.clientWidth/2-$(".alert").width()/2);
	$(".alert").show();
}

function hide(){
	$(".mask").hide();
	$(".alert").hide();
	window.top.hidemask();
	window.parent.hidemask();
}

function saveorupdate(){
	var id = $("#categoryid").val();
	var name = $("#name").val();
	if(name == ''){
		alert("请输入分类名称");
		return;
	}
	$.ajax({
		type: "post",
		url: "./checkCategoryName",
		data: {id :id , name :name},
		success: function(data){
			if(data == "error"){
				alert("分类名已存在!");
				return;
			}else{
				$("#saveupdateForm").submit();
				hide();
			}
		}
	});
}
</script>
<title>食趣商家管理平台</title>
</head>
<body>
<div id="content">
	<div style="width: 100%; height: 83px;">
		<div style="width: 100%; height: 21px;"></div>
		<div class="delbutton" onclick="delcategorylist()">-&nbsp;&nbsp;不启用</div>
		<div class="addbutton" style="margin-left: 18px;" onclick="showalert(0, '')">+&nbsp;&nbsp;添加</div>
	</div>
	<form action="" id="delForm" method="post">
	<table class="table" style="th:border-top: 0px;" border="0" cellspacing="0" cellpadding="0">
	<tr class="tablehead">
	<th style="width:4%;"><input id="checkAll" type="checkbox" name="checall"/></th>
	<th style="width:50%;">名称</th> 	 
	<th style="width:46%;">操作</th> 	 
	</tr>
	<c:forEach items="${categorylist}" var="p">
	<tr>
	<th style="width:4%;" class="border_right tablethcss"><input type="checkbox" name="id" value="${p.id }"/></th>
	<th style="width:50%;" class="border_right tablethcss">${p.name }</th> 	 
	<th style="width:46%; min-width: 240px;" class="tablethcss">
		<c:if test="${p.delflg == 0 }">
		<div class="table_del_button" onclick="delcategory(${p.id})" style="margin-left:2%; width: 59px; ">
			<div class="table_button_text" style="color: #ff3333;">不启用</div>
		</div>	
		</c:if>
		<c:if test="${p.delflg == 1 }">
		<div class="table_del_button" onclick="usecategory(${p.id})" style="margin-left:2%; width: 59px; ">
			<div class="table_button_text" style="color: #00CC33;">启用</div>
		</div>	
		</c:if>
		<div style="width:1px; height:26px; border: 1px solid #d3d6d8; float: left;margin-left:2%;"></div>
		<div class="table_editor_button" onclick="showalert(${p.id}, '${p.name }')" style="margin-left:2%; width: 59px; ">
			<div class="table_button_editor_icon"></div>
			<div class="table_button_text" style="color: #6097fb;">编辑</div>
		</div>
	</th> 	 
	</tr>
	</c:forEach>
	<c:if test="${pageCount>1}">
	<tr style="border-bottom: 1px solid #eaeff2">
	<td colspan="3" style="height:86px;">
	<input type="hidden" value="${pageCount }"/>
				<input type="hidden" value="${pageCount }" id="pageSize" />
				<input type="hidden" value="${pageIndex }" id="pageIndex" />
				<div id="untreatedpage" ></div>
				<script type="text/javascript">
					//container 容器，count 总页数 pageindex 当前页数
					function setPage(container, count, pageindex) {
					var container = container;
					var count = parseInt(count);
					var pageindex = parseInt(pageindex);
					var a = [];
					  //总页数少于10 全部显示,大于10 显示前3 后3 中间3 其余....
					  if (pageindex == 1) {
						  //alert(pageindex);
					    a[a.length] = "<a onclick=\"\" class=\"hide_page_prev unclickprev on\"></a>";
					  } else {
					    a[a.length] = "<a onclick=\"previousPage("+pageindex+",'./dishesClass?')\" class=\"page_prev\"></a>";
					  }
					  function setPageList() {
					    if (pageindex == i) {
					      a[a.length] = "<a onclick=\"goPage('./dishesClass?',"+i+")\" class=\"on\">" + i + "</a>";
					    } else {
					      a[a.length] = "<a onclick=\"goPage('./dishesClass?',"+i+")\">" + i + "</a>";
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
					      a[a.length] = "...<a onclick=\"goPage('./dishesClass?',"+count+")\">" + count + "</a>";
					    } else if (pageindex >= count - 3) {
					      a[a.length] = "<a onclick=\"goPage('./dishesClass?',1)\">1</a>...";
					      for (var i = count - 4; i <= count; i++) {
					        setPageList();
					      };
					    } else { //当前页在中间部分
					      a[a.length] = "<a onclick=\"goPage('./dishesClass?',1)\">1</a>...";
					      for (var i = pageindex - 2; i <= pageindex+2; i++) {
					        setPageList();
					      }
					      a[a.length] = "...<a onclick=\"goPage('./dishesClass?',"+count+")\">" + count + "</a>";
					    }
					  }
					  if (pageindex == count) {
						    a[a.length] = "<a onclick=\"\" class=\"hide_page_next unclicknext\"></a> 共"+count+"页  到第  "+
						    "<input type=\"text\" class=\"jump_num\" id=\"topage\"/> 页"+
						    "<a class=\"jump_btn\" onclick=\"gotoPage('./dishesClass?',"+$("#pageSize").val()+")\")\">"+
						    "<a id='page_msg'></a>";
						  } else {
						    a[a.length] = 
						    	"<a onclick=\"nextPage("+$("#pageIndex").val()+",'./dishesClass?')\" "+
						    	"class=\"page_next\"></a> 共"+count+"页 到第 "+
						    "<input type=\"text\" class=\"jump_num\" id=\"topage\"/> 页"+
						    "<a class=\"jump_btn\" onclick=\"gotoPage('./dishesClass?',"+$("#pageSize").val()+")\">"+
						    "<a id='page_msg'></a>";
						  }
					  container.innerHTML = a.join("");
					} 
					setPage(document.getElementById("untreatedpage"),parseInt($("#pageSize").val()),parseInt($("#pageIndex").val()));
					</script>
		</td>
		</tr>
		</c:if>
	</table>
	</form>
</div>
</body>
<div class="mask" style="display:none;"></div>
<div class="alert" id="alertdiv" style="width: 450px; height: 215px; display:none">
<form action="./saveupdateCategory" id="saveupdateForm" method="post">
	<input type="hidden" value="0" id="categoryid" name="id"/>
	<div style="width: 100%; height: 65px; background: #f5f6fa;">
		<div style="height: 19px;"></div>
		<div style="width: 400px; height: 27px;margin: 0 auto;text-align: left;">
			添加分类
			<img src="imgs/alertclose.png" style="float:right;cursor: pointer;" onclick="hide()">
		</div>
	</div>
	<input type="text" value="" id="name" name="name" style="border: 1px solid #bdc6d7; width: 305px; height: 43px; padding-left: 5px; float:left; margin-top: 45px; margin-left: 12px;"/>
	<div style="width: 75px; height: 45px; background: #6097fb; text-align: center; line-height: 45px; float:left; color: #fff; margin-top: 45px; margin-left: 15px; cursor: pointer;" onclick="saveorupdate()">确定</div>
</form>
</div>
</html>