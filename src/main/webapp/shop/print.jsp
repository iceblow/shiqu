<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/common.css" rel="stylesheet">
<link href="./css/print.css" rel="stylesheet">
<link href="./css/page.css" rel="stylesheet">
<script src="./js/jquery-1.11.2.min.js"></script>
<script src="./js/page.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./js/print.js"></script>
<script>
$(function(){
	 $("#checkAll").click(function() {
	        $('input[name="id"]').prop("checked",this.checked); 
	    });
	    var $id = $("input[name='id']");
	    $id.click(function(){
	        $("#checkAll").prop("checked",$id.length == $("input[name='id']:checked").length ? true : false);
	    });
});


</script>
<title>打印机管理</title>
</head>
<body>
<div id="content">
	<div style="width: 100%; height: 83px;">
		<div style="width: 100%; height: 21px;"></div>
		<div class="delbutton" onclick="delselprint()">-&nbsp;&nbsp;删除</div>
		<div class="addbutton" style="margin-left: 18px;" onclick="editprint(0)">+&nbsp;&nbsp;添加</div>
	</div>
	<form action="./delprint" method="post" id="labelForm">
	<table class="table" style="th:border-top: 0px;" border="0" cellspacing="0" cellpadding="0">
	<tr class="tablehead">
	<th style="width:4%;"><input id="checkAll" type="checkbox" name="checall"/></th>
	<th style="width:13%;">名称</th> 	 
	<th style="width:13%;">编码</th> 	
	<th style="width:13%;">秘钥</th> 
	<th style="width:13%;">份数</th> 
	<th style="width:13%;">打印宽度</th> 
	<th style="width:13%;">打印格式</th> 
	<th style="width:13%;">操作</th> 	 
	</tr>
	<c:forEach items="${printlist}" var="p">
	<tr>
	<th style="width:4%;" class="border_right tablethcss"><input type="checkbox" name="id" value="${p.id }"/></th>
	<th style="width:13%;" class="border_right tablethcss">${p.print_name }</th> 	
	<th style="width:13%;" class="border_right tablethcss">${p.print_sn }</th> 	
	<th style="width:13%;" class="border_right tablethcss">${p.print_key }</th> 
	<th style="width:13%;" class="border_right tablethcss">${p.print_num }</th>
	<th style="width:13%;" class="border_right tablethcss">
	<c:if test="${p.type==1 }">窄型</c:if>
	<c:if test="${p.type==2 }">宽型</c:if>
	</th> 	 
	<th style="width:13%;" class="border_right tablethcss">
	<c:if test="${ empty p.scope || p.scope==1 }">通用</c:if>
	<c:if test="${p.scope==2  }">预结单</c:if>
	<c:if test="${p.scope==3  }">收银</c:if>
	<c:if test="${p.scope==4  }">送厨总单</c:if>
	<c:if test="${p.scope==5  }">送厨分单</c:if>
	</th> 	 
	<th style="width:13%; min-width: 240px;" class="tablethcss">
		<div class="table_editor_button" onclick="editprint(${p.id})" style="margin-left:2%; width: 59px; ">
			<div class="table_button_editor_icon"></div>
			<div class="table_button_text" style="color: #6097fb;">编辑</div>
		</div>
		<div style="width:1px; height:26px; border: 1px solid #d3d6d8; float: left;margin-left:2%;"></div>
		<div class="table_del_button" onclick="delprint(${p.id})" style="margin-left:2%; width: 59px; ">
			<div class="table_button_del_icon"></div>
			<div class="table_button_text" style="color: #ff3333;">删除</div>
		</div>	
	</th> 	 
	</tr>
	</c:forEach>
	<c:if test="${pageCount>1}">
	<tr style="border-bottom: 1px solid #eaeff2">
	<td colspan="4" style="height:86px;">
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
					    a[a.length] = "<a onclick=\"previousPage("+pageindex+",'./print?')\" class=\"page_prev\"></a>";
					  }
					  function setPageList() {
					    if (pageindex == i) {
					      a[a.length] = "<a onclick=\"goPage('./print?',"+i+")\" class=\"on\">" + i + "</a>";
					    } else {
					      a[a.length] = "<a onclick=\"goPage('./print?',"+i+")\">" + i + "</a>";
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
					      a[a.length] = "...<a onclick=\"goPage('./print?',"+count+")\">" + count + "</a>";
					    } else if (pageindex >= count - 3) {
					      a[a.length] = "<a onclick=\"goPage('./print?',1)\">1</a>...";
					      for (var i = count - 4; i <= count; i++) {
					        setPageList();
					      };
					    } else { //当前页在中间部分
					      a[a.length] = "<a onclick=\"goPage('./print?',1)\">1</a>...";
					      for (var i = pageindex - 2; i <= pageindex+2; i++) {
					        setPageList();
					      }
					      a[a.length] = "...<a onclick=\"goPage('./print?',"+count+")\">" + count + "</a>";
					    }
					  }
					  if (pageindex == count) {
						    a[a.length] = "<a onclick=\"\" class=\"hide_page_next unclicknext\"></a> 共"+count+"页  到第  "+
						    "<input type=\"text\" class=\"jump_num\" id=\"topage\"/> 页"+
						    "<a class=\"jump_btn\" onclick=\"gotoPage('./print?',"+$("#pageSize").val()+")\")\">"+
						    "<a id='page_msg'></a>";
						  } else {
						    a[a.length] = 
						    	"<a onclick=\"nextPage("+$("#pageIndex").val()+",'./print?')\" "+
						    	"class=\"page_next\"></a> 共"+count+"页 到第 "+
						    "<input type=\"text\" class=\"jump_num\" id=\"topage\"/> 页"+
						    "<a class=\"jump_btn\" onclick=\"gotoPage('./print?',"+$("#pageSize").val()+")\">"+
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