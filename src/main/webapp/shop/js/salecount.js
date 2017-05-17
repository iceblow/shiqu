
var ctx = $("#myChart").get(0).getContext("2d");
//This will get the first returned node in the jQuery collection.
var myNewChart = new Chart(ctx);
myNewChart.Bar(data,{
	scaleLabel: "<%=value%>元",
	multiTooltipTemplate: "<%= value %>元",
	  scaleOverride :true ,   //是否用硬编码重写y轴网格线
      scaleSteps : 10,        //y轴刻度的个数
      scaleStepWidth : avgvalue,   //y轴每个刻度的宽度
      scaleStartValue : 0,    //y轴的起始值
	});

function salecount(type){
	window.location.href="./salecount?type="+type;
}