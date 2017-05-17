 function dialogFadeIn(width,message){   
		$("#dialog").css("width",width);
		$("#dialog").text(message);
       var top = ($(window).height() - $("#dialog").height())/2;   
       var left = ($(window).width() - $("#dialog").width())/2;   
       var scrollTop = $(document).scrollTop();   
       var scrollLeft = $(document).scrollLeft();   
       $("#dialog").css( { position : 'absolute', 'top' : top + scrollTop, left : left + scrollLeft } ).fadeIn("normal");  
   }  	
	
 function dialogFadeOut(){
	 $("#dialog").fadeOut("slow");
}