function editprint(id){
	window.location.href="./editprint?id="+id;
}


function delselprint(){
	var idlength =   $("input[name='id']:checked").length;
	if(idlength == 0){
		alert("请选择要删除的打印机！");
		return;
	}else{
		if(confirm("确定删除选中的打印机?")){
		$("#labelForm").submit();
		}
	}
}


function delprint(id){
	if(confirm("确定删除该打印机?")){
		window.location.href="./delprint?id="+id;
	}
}
