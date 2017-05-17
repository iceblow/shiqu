<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
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

function deluser(id){
	if(confirm("该员工是否离职?")){
		$.ajax({
			type: "post",
			url: "./delstoreuser",
			data: {id :id},
			success: function(data){
				if(data == "error"){
					alert("离职失败！");
					return;
				}else{
					alert("离职成功！");
					window.location.reload();
				}
			}
		});
	}
}

function delcategorylist(){
	var idlength =   $("input[name='id']:checked").length;
	if(idlength == 0){
		alert("至少选择一个员工！");
		return;
	}else{
		$.ajax({
			type: "post",
			url: "./delStoreUserList",
			data: $("#delForm").serialize(),
			success: function(data){
				if(data == "success"){
					alert("离职成功！");
					window.location.reload();
				}
			}
		});
	}
}

function editorStoreUser(id){
	window.location.href = "./editorStoreUser?id="+id;
}
</script>
<title>食趣商家管理平台</title>
</head>
<body>
<div id="content">
	<div style="width: 100%; height: 83px;">
		<div style="width: 100%; height: 21px;"></div>
		<div class="delbutton" onclick="delcategorylist()">-&nbsp;&nbsp;离职</div>
		<div class="addbutton" style="margin-left: 18px;" onclick="editorStoreUser(0)">+&nbsp;&nbsp;添加</div>
	</div>
	<form action="" id="delForm" method="post">
	<table class="table" style="th:border-top: 0px;" border="0" cellspacing="0" cellpadding="0">
	<tr class="tablehead">
	<th style="width:4%;"><input id="checkAll" type="checkbox" name="checall"/></th>
	<th style="width:13%;">姓名</th> 	 
	<th style="width:13%;">手机号码</th> 	 
	<th style="width:13%;">权限</th> 	 
	<th style="width:13%;">折扣率</th> 	 
	<th style="width:13%;">抹零上限</th> 	 
	<th style="width:30%;">操作</th> 	 
	</tr>
	<c:forEach items="${storeuserlist}" var="p" varStatus="status">
	<tr>
	<th style="width:4%;" class="border_right tablethcss">
	<c:if test="${not status.first }">
	<input type="checkbox" name="id" value="${p.id }"/>
	</c:if>
	</th>
	<th style="width:13%;" class="border_right tablethcss">${p.name }</th> 	 
	<th style="width:13%;" class="border_right tablethcss">${p.phone }</th> 	 
	<th style="width:13%;" class="border_right tablethcss">
		<c:if test="${p.privilege == 1 }">店长</c:if>
		<c:if test="${p.privilege == 10 }">收银</c:if>
		<c:if test="${p.privilege == 20 }">跑堂</c:if>
	</th> 
	<th style="width:13%;" class="border_right tablethcss"><fmt:formatNumber type="number" value="${p.discount }" maxFractionDigits="2"/>%</th> 	 
	<th style="width:13%;" class="border_right tablethcss"><fmt:formatNumber type="number" value="${p.limitreset }" maxFractionDigits="2"/></th> 	 
	<th style="width:30%; min-width: 240px;" class="tablethcss">
		<c:if test="${p.privilege != 1 }">
		<div class="table_del_button" onclick="deluser(${p.id})" style="margin-left:2%; width: 59px; ">
			<div class="table_button_del_icon"></div>
			<div class="table_button_text" style="color: #ff3333;">离职</div>
		</div>	
		<div style="width:1px; height:26px; border: 1px solid #d3d6d8; float: left;margin-left:2%;"></div>
		</c:if>
		<div class="table_editor_button" onclick="editorStoreUser(${p.id})" style="margin-left:2%; width: 59px; ">
			<div class="table_button_editor_icon"></div>
			<div class="table_button_text" style="color: #6097fb;">编辑</div>
		</div>
	</th> 	 
	</tr>
	</c:forEach>
	<c:if test="${pageCount>1}">
	<tr style="border-bottom: 1px solid #eaeff2">
	<td colspan="7" style="height:86px;">
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
					    a[a.length] = "<a onclick=\"previousPage("+pageindex+",'./storeuser?')\" class=\"page_prev\"></a>";
					  }
					  function setPageList() {
					    if (pageindex == i) {
					      a[a.length] = "<a onclick=\"goPage('./storeuser?',"+i+")\" class=\"on\">" + i + "</a>";
					    } else {
					      a[a.length] = "<a onclick=\"goPage('./storeuser?',"+i+")\">" + i + "</a>";
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
					      a[a.length] = "...<a onclick=\"goPage('./storeuser?',"+count+")\">" + count + "</a>";
					    } else if (pageindex >= count - 3) {
					      a[a.length] = "<a onclick=\"goPage('./storeuser?',1)\">1</a>...";
					      for (var i = count - 4; i <= count; i++) {
					        setPageList();
					      };
					    } else { //当前页在中间部分
					      a[a.length] = "<a onclick=\"goPage('./storeuser?',1)\">1</a>...";
					      for (var i = pageindex - 2; i <= pageindex+2; i++) {
					        setPageList();
					      }
					      a[a.length] = "...<a onclick=\"goPage('./storeuser?',"+count+")\">" + count + "</a>";
					    }
					  }
					  if (pageindex == count) {
						    a[a.length] = "<a onclick=\"\" class=\"hide_page_next unclicknext\"></a> 共"+count+"页  到第  "+
						    "<input type=\"text\" class=\"jump_num\" id=\"topage\"/> 页"+
						    "<a class=\"jump_btn\" onclick=\"gotoPage('./storeuser?',"+$("#pageSize").val()+")\")\">"+
						    "<a id='page_msg'></a>";
						  } else {
						    a[a.length] = 
						    	"<a onclick=\"nextPage("+$("#pageIndex").val()+",'./storeuser?')\" "+
						    	"class=\"page_next\"></a> 共"+count+"页 到第 "+
						    "<input type=\"text\" class=\"jump_num\" id=\"topage\"/> 页"+
						    "<a class=\"jump_btn\" onclick=\"gotoPage('./storeuser?',"+$("#pageSize").val()+")\">"+
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
</html>