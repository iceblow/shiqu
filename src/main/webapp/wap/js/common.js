 $(function(){
	 var index = $("#bottom_index").val();
	 $("#bottom_"+index).css("color","#ff8854");
	 $("#bottom_img_"+index).attr("src","./imgs/bottom_icon_"+index+".png");
	 
	var s= document.documentElement.clientHeight;
	var height = s-33;
		
	var contentheight = $("#content_form").height();
	if(height>contentheight){
		$("#content_left").css("min-height",height);
	}else{
		$("#content_left").css("min-height",contentheight);
	}
 })
 