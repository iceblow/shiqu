<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
</script>
<title>食趣商家管理平台</title>
</head>
<body>
<div id="content">
	<div style="width: 100%; height: 83px;">
	</div>
	<form action="" id="delForm" method="post">
	<table class="table" style="th:border-top: 0px;" border="0" cellspacing="0" cellpadding="0">
	<tr class="tablehead">
	<th style="width:30%;">用户名</th> 	 
	<th style="width:30%;">单总金额(元)</th> 	 
	<th style="width:30%;">使用时间</th> 	 
	</tr>
	<c:forEach items="${couponuserlist}" var="p">
	<tr>
	<th style="width:30%;" class="border_right tablethcss">${p.user_name }</th> 	 
	<th style="width:30%;" class="border_right tablethcss">${p.allAmount }</th> 	 
	<th style="width:30%; min-width: 240px;" class="tablethcss"><fmt:formatDate value="${p.use_time }" pattern="yyyy-MM-dd HH:mm:ss"/> </th> 	 
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
					var a = [];
					  //总页数少于10 全部显示,大于10 显示前3 后3 中间3 其余....
					  if (pageindex == 1) {
						  //alert(pageindex);
					    a[a.length] = "<a onclick=\"\" class=\"hide_page_prev unclickprev on\"></a>";
					  } else {
					    a[a.length] = "<a onclick=\"previousPage("+pageindex+",'./couponuserlist?')\" class=\"page_prev\"></a>";
					  }
					  function setPageList() {
					    if (pageindex == i) {
					      a[a.length] = "<a onclick=\"goPage('./couponuserlist?',"+i+")\" class=\"on\">" + i + "</a>";
					    } else {
					      a[a.length] = "<a onclick=\"goPage('./couponuserlist?',"+i+")\">" + i + "</a>";
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
					      a[a.length] = "...<a onclick=\"goPage('./couponuserlist?',"+count+")\">" + count + "</a>";
					    } else if (pageindex >= count - 3) {
					      a[a.length] = "<a onclick=\"goPage('./couponuserlist?',1)\">1</a>...";
					      for (var i = count - 4; i <= count; i++) {
					        setPageList();
					      };
					    } else { //当前页在中间部分
					      a[a.length] = "<a onclick=\"goPage('./couponuserlist?',1)\">1</a>...";
					      for (var i = pageindex - 2; i <= pageindex+2; i++) {
					        setPageList();
					      }
					      a[a.length] = "...<a onclick=\"goPage('./couponuserlist?',"+count+")\">" + count + "</a>";
					    }
					  }
					  if (pageindex == count) {
						    a[a.length] = "<a onclick=\"\" class=\"hide_page_next unclicknext\"></a> 共"+count+"页  到第  "+
						    "<input type=\"text\" class=\"jump_num\" id=\"topage\"/> 页"+
						    "<a class=\"jump_btn\" onclick=\"gotoPage('./couponuserlist?',"+$("#pageSize").val()+")\")\">"+
						    "<a id='page_msg'></a>";
						  } else {
						    a[a.length] = 
						    	"<a onclick=\"nextPage("+$("#pageIndex").val()+",'./couponuserlist?')\" "+
						    	"class=\"page_next\"></a> 共"+count+"页 到第 "+
						    "<input type=\"text\" class=\"jump_num\" id=\"topage\"/> 页"+
						    "<a class=\"jump_btn\" onclick=\"gotoPage('./couponuserlist?',"+$("#pageSize").val()+")\">"+
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