function shopdetail(){
	window.location.href="./lookdetail";
}

function changeProvience(){
	var provienceid = $("#provienceid").val();
	if(provienceid>0){
		$.ajax({
			url:'./changeArea',
			type:'POST',
			data:{id:provienceid},
			success:function(msg){
				var msgdata = eval("("+msg+")");
				var arealist = msgdata.arealist;
				var html = "";
				$("#cityid").empty();
				html +="<option value='0'>--</option>";
				for(var i=0;i<arealist.length;i++){
					html += "<option value='"+arealist[i].id+"'>"+arealist[i].name+"</option>";
				}
				$("#cityid").append(html);
			}
		})
	}else{
		var html ="<option value='0'>--</option>";
		$("#cityid").empty();
		$("#cityid").append(html);
		$("#areaid").empty();
		$("#areaid").append(html);
	}
}

function changeCity(){
	var cityid = $("#cityid").val();
	if(cityid>0){
		$.ajax({
			url:'./changeArea',
			type:'POST',
			data:{id:cityid},
			success:function(msg){
				var msgdata = eval("("+msg+")");
				var arealist = msgdata.arealist;
				var html = "";
				$("#areaid").empty();
				html +="<option value='0'>--</option>";
				for(var i=0;i<arealist.length;i++){
					html += "<option value='"+arealist[i].id+"'>"+arealist[i].name+"</option>";
				}
				$("#areaid").append(html);
			}
		})
	}else{
		$("#areaid").empty();
		var html ="<option value='0'>--</option>";
		$("#areaid").append(html);
	}
}


function imgupload(fileid){
// 	alert(template_id);
	$.ajaxFileUpload({
	url : './imgupload',//用于文件上传的服务器端请求地址
	secureuri : false,          //一般设置为false
	fileElementId : 'file_'+fileid,     //文件上传空间的id属性  <input type="file" id="file" name="file" />
	dataType : 'json',          //返回值类型 一般设置为json
	success : function(data) {
		if(data.code==1){
			$("#picid_"+fileid).val(data.picid);
		}
	},
	});
}

function logoupload(){
	$.ajaxFileUpload({
		url : './imgupload',//用于文件上传的服务器端请求地址
		secureuri : false,          //一般设置为false
		fileElementId : 'logo',     //文件上传空间的id属性  <input type="file" id="file" name="file" />
		dataType : 'json',          //返回值类型 一般设置为json
		success : function(data) {
			if(data.code==1){
				$("#pic").val(data.picid);
			}
		},
		});
}

function removeimgdiv(index){
	$("#imgdiv_"+index).remove();
	var height = $("#storeimg").height()-135;
	$("#storeimg").height(height);
}

function addimg(){
	var html ="";
	var index = $("#imgindex").val();
	html += '<div style="clear:both;margin-top:10px;width:400px;height:125px;position:relative;background-color:#f4f8fa;" id="imgdiv_'+index+'">';
	html += '<img src="./imgs/img_default.png" id="img_'+index+'" width=100px height=100px style="position:absolute;left:13px;bottom:12px;">';
	html += '<button type="button" class="btn btn-primary detail_upload" style="bottom:13px;left:140px;" aria-haspopup="true" aria-expanded="false" >本地浏览...</button>'
	html += '<input type="file" id="file_'+index+'" name="imgfile" style="position: absolute;bottom:13px ;left:140px;; width:100px; height: 40px; opacity:0; cursor: pointer;" onchange="change(\'img_'+index+'\',\'file_'+index+'\');imgupload(\''+index+'\');">';
	html += '<input type="hidden" name="picid" id="picid_'+index+'" value="">';
	html += '<img src="./imgs/img_delete.png" style="position:absolute;right:0px;bottom:0px;cursor:pointer" onclick="removeimgdiv('+index+')"></div>';
	$("#imgindex").before(html);
	$("#imgindex").val(parseInt(index)+1);
	var height = $("#storeimg").height()+135;
	$("#storeimg").height(height);
}

function showalert(){
	var height = $("#content").height();
	$("#alert_body").height(height);
	window.top.showmask();
	window.parent.showmask();
	$(".mask").show();
	$("#box_detail").show();
	$("#r-result").hide();
	for(var i = 0; i < mark.length; i++){
		map.removeOverlay(mark[i]);
	}
	
}

function hiddenAlert(){
	$("#box_detail").hide();
	$(".mask").hide();
	window.top.hidemask();
	window.parent.hidemask();
}

function sureAlert(){
	var address = $("#alertaddress").val();
	$("#address").val(address);
	var longitude = $("#alertlongitude").val();
	$("#longitude").val(longitude);
	var latitude = $("#alertlatitude").val();
	$("#latitude").val(latitude);
	$("#box_detail").hide();
	$(".mask").hide();
	window.top.hidemask();
	window.parent.hidemask();
}
