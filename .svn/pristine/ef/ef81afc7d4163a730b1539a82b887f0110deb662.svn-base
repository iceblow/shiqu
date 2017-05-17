
function divonfocus(id){
	$("#"+id).css("background-color","#6097fb");
}

function divonblur(id){
	$("#"+id).css("background-color","#bec5d7");
}

function getStoreList(){
	  $(".alert").hide();
	 var phone = $("#phone").val();
	 var password=  $("#password").val();
	 if(phone==''){
		$(".alert").text("请输入用户名!");
		$(".alert").show();
		return ;
	 }
	 if(password==''){
 		 $(".alert").text("请输入密码!");
 		 $(".alert").show();
 		 return ;
	 }
	 $.ajax({
		 url:'./loginStorelist',
		 type:'POST',
		 data:{phone:phone,password:password},
		 success:function(msg){
			 var msgdata = eval("("+msg+")");
			 var code = msgdata.code;
			 if(code==1){
				 $("#store_id").empty();
				 var list = msgdata.storelist;
				 var html = "";
				 for(var i = 0;i<list.length;i++){
					html += "<option value='"+list[i].store_id+"'>"+list[i].store_name+"</option>";    					 
				 }
				 $("#store_id").append(html);
				 var top = ($(window).height() - $("#choosealert").height())/2;   
			     var scrollTop = $(document).scrollTop();   
			     $("#choosealert").css( {  'top' : top + scrollTop } );  
				 $("#choosealert").show();
				  $(".mask").show();
			 }else{
				 $(".alert").text("用户名或密码错误!");
		   		 $(".alert").show();
			 }
		 }
	 })
}

function hiddenchooseAlert(){
	 $("#choosealert").hide();
	  $(".mask").hide();
}