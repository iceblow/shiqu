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
<script src="./js/bootstrap.min.js"></script>
<script src="./js/page.js"></script>
<script type="text/javascript">
$(function(){
	 $("#checkAll").click(function() {
	        $('input[name="menu_id"]').prop("checked",this.checked); 
	    });
	    var $menu_id = $("input[name='menu_id']");
	    $menu_id.click(function(){
	        $("#checkAll").prop("checked",$menu_id.length == $("input[name='menu_id']:checked").length ? true : false);
	    });
});

function delMenu(menu_id){
	if(confirm("是否删除该菜品?")){
		$.ajax({
			type: "post",
			url: "./delMenu",
			data: {menu_id :menu_id},
			success: function(data){
				if(data == "error"){
					alert("删除失败！");
					window.location.reload();
				}else{
					alert("删除成功！");
					window.location.reload();
				}
			}
		});
	}
}

function delMenuList(){
	var menulength =   $("input[name='menu_id']:checked").length;
	if(menulength == 0){
		alert("至少选择一个菜！");
		return;
	}else{
		$.ajax({
			type: "post",
			url: "./delMenuList",
			data: $("#delForm").serialize(),
			success: function(data){
				if(data == "success"){
					alert("删除成功！");
					window.location.reload();
				}
			}
		});
	}
}

function menuDetail(menu_id){
	window.location.href = "./menuDetail?menu_id="+menu_id;
}

function editorMenu(menu_id){
	window.location.href = "./editorMenu?menu_id="+menu_id;
}

function search(){
	var keyword = $("#keyword").val();
	window.location.href = "./dishesManage?keyword="+keyword;
}
</script>
<title>食趣商家管理平台</title>
</head>
<body>
<div id="content">
	<div style="width: 100%; height: 83px; min-width: 440px;">
		<div style="width: 100%; height: 21px;"></div>
		<div class="delbutton" onclick="delMenuList()">-&nbsp;&nbsp;删除</div>
		<div class="addbutton" style="margin-left: 18px;" onclick="editorMenu(0)">+&nbsp;&nbsp;添加</div>
		<div class="searchbutton" onclick="search()"></div>
		<input type="text" value="${keyword }" name="keyword" id="keyword" style="width: 167px; height: 39px; border: 1px solid #bdc6d7; float:right; margin-right: 10px; padding-left: 5px;	"/>
	</div>
	<form action="" id="delForm" method="post">
	<table class="table" style="th:border-top: 0px;" border="0" cellspacing="0" cellpadding="0">
	<tr class="tablehead">
	<th style="width:4%;"><input id="checkAll" type="checkbox" name="checall"/></th>
	<th style="width:10%;">名称</th> 	 
	<th style="width:10%;">分类</th> 	 
	<th style="width:10%;">单位</th> 	 
	<th style="width:10%;">单价(元)</th> 	 
	<th style="width:10%;">图片</th> 	 
	<th style="width:36%;">描述</th> 	 
	<th style="width:10%;">操作</th> 	 
	</tr>
	<c:forEach items="${menulist}" var="p" varStatus="status">
	<tr>
	<th style="width:4%;" class="border_right tablethcss"><input type="checkbox" name="menu_id" value="${p.menu_id }"/></th>
	<th style="width:10%;" class="border_right tablethcss">${p.menu_name }</th> 	 
	<th style="width:10%;" class="border_right tablethcss">${p.category }</th> 	 
	<th style="width:10%;" class="border_right tablethcss">${p.unit }</th> 	 
	<th style="width:10%;" class="border_right tablethcss">${p.price }</th> 	 
	<th style="width:10%; min-width:50px; " class="border_right tablethcss">
		<c:if test="${empty p.pic_url }">
			<img src="imgs/defalut.png" style="width: 50px; height: 50px;"/>
		</c:if>
		<c:if test="${not empty p.pic_url }">
			<img src="${p.pic_url }" style="width: 50px; height: 50px;"/>
		</c:if>
	</th> 	 
	<th style="width:36%; text-align: left;  height: 69px; overflow: hidden;" class="border_right tablethcss">${p.description }</th> 	 
	<th style="width:10%; min-width: 140px;" class="tablethcss">
		<div class="table_del_button" onclick="delMenu(${p.menu_id})" style="margin-left:2%; width: 59px; ">
			<div class="table_button_del_icon"></div>
			<div class="table_button_text" style="color: #ff3333;">删除</div>
		</div>	
		<div style="width:1px; height:26px; border: 1px solid #d3d6d8; float: left;margin-left:2%;"></div>
		<div class="table_editor_button" onclick="editorMenu(${p.menu_id})" style="margin-left:2%; width: 59px; ">
			<div class="table_button_editor_icon"></div>
			<div class="table_button_text" style="color: #6097fb;">编辑</div>
		</div>
<!-- 		<div style="width:1px; height:26px; border: 1px solid #d3d6d8; float: left;margin-left:2%;"></div> -->
<%-- 		<div style="width: 79px; height: 26px; text-align: center; line-height: 26px; float:left;cursor: pointer;" onclick="menuDetail(${p.menu_id})">查看详情</div> --%>
	</th> 	 
	</tr>
	</c:forEach>
	<c:if test="${pageCount>1}">
	<tr style="border-bottom: 1px solid #eaeff2">
	<td colspan="8" style="height:86px;">
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
					var keyword = $("#keyword").val();
					var a = [];
					  //总页数少于10 全部显示,大于10 显示前3 后3 中间3 其余....
					  if (pageindex == 1) {
						  //alert(pageindex);
					    a[a.length] = "<a onclick=\"\" class=\"hide_page_prev unclickprev on\"></a>";
					  } else {
					    a[a.length] = "<a onclick=\"previousPage("+pageindex+",'./dishesManage?keyword="+keyword
					    		+"&')\" class=\"page_prev\"></a>";
					  }
					  function setPageList() {
					    if (pageindex == i) {
					      a[a.length] = "<a onclick=\"goPage('./dishesManage?keyword="+keyword
					    		+"&',"+i+")\" class=\"on\">" + i + "</a>";
					    } else {
					      a[a.length] = "<a onclick=\"goPage('./dishesManage?keyword="+keyword
					    		+"&',"+i+")\">" + i + "</a>";
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
					      a[a.length] = "...<a onclick=\"goPage('./dishesManage?keyword="+keyword
					    		+"&',"+count+")\">" + count + "</a>";
					    } else if (pageindex >= count - 3) {
					      a[a.length] = "<a onclick=\"goPage('./dishesManage?keyword="+keyword
					    		+"&',1)\">1</a>...";
					      for (var i = count - 4; i <= count; i++) {
					        setPageList();
					      };
					    } else { //当前页在中间部分
					      a[a.length] = "<a onclick=\"goPage('./dishesManage?keyword="+keyword
					    		+"&',1)\">1</a>...";
					      for (var i = pageindex - 2; i <= pageindex+2; i++) {
					        setPageList();
					      }
					      a[a.length] = "...<a onclick=\"goPage('./dishesManage?keyword="+keyword
					    		+"&',"+count+")\">" + count + "</a>";
					    }
					  }
					  if (pageindex == count) {
						    a[a.length] = "<a onclick=\"\" class=\"hide_page_next unclicknext\"></a> 共"+count+"页  到第  "+
						    "<input type=\"text\" class=\"jump_num\" id=\"topage\"/> 页"+
						    "<a class=\"jump_btn\" onclick=\"gotoPage('./dishesManage?keyword="+keyword
						    	+"&',"+$("#pageSize").val()+")\")\">"+
						    "<a id='page_msg'></a>";
						  } else {
						    a[a.length] = 
						    	"<a onclick=\"nextPage("+$("#pageIndex").val()+",'./dishesManage?keyword="+keyword
						    	+"&')\" "+
						    	"class=\"page_next\"></a> 共"+count+"页 到第 "+
						    "<input type=\"text\" class=\"jump_num\" id=\"topage\"/> 页"+
						    "<a class=\"jump_btn\" onclick=\"gotoPage('./dishesManage?keyword="+keyword
						    	+"&',"+$("#pageSize").val()+")\">"+
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