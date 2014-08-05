
<#include "../../../common/freemarker/include_header.ftl">
<#include "../../../common/freemarker/include_custom.ftl">
<script src="common/raphael212/raphael.min.js" type="text/javascript"></script>
<script src="common/elycharts/elycharts.js" type="text/javascript"></script>
<div class="panel panel-primary" style="margin-top: 5px; margin-left:15px;">
	<div class="panel-heading"><strong>饼图</strong></div>
	<div class="panel-body">
		<div id="piechart"></div>
	</div>
</div>

<div class="panel panel-primary" style="margin-top: 5px; margin-left:15px;">
	<div class="panel-heading"><strong>柱形图</strong></div>
	<div class="panel-body">
		<div id="barchart"></div>
	</div>
</div>

<div class="panel panel-primary" style="margin-top: 5px; margin-left:15px;">
	<div class="panel-heading"><strong>曲线图</strong></div>
	<div class="panel-body">
		<div id="linechart"></div>
	</div>
</div>

<script>
//图形数据
var values=[10,20,30,40];
var labels=["label1","label2","label3","label4"];
var legend=["legend1","legend2","legend3","legend4"];
var tips = ["tip1","tip2","tip3","tip4"];
	
$(document).ready(function(){
	cratePieChart($("#piechart"));
	crateBarChart($("#barchart"));
	crateLineChart($("#linechart"));
});

function crateLineChart(elobj){
	$.elycharts.templates['line_chart'] = {
		type : "line",
		margins : [10, 10, 20, 50],
		defaultSeries : {
			plotProps : {"stroke-width" : 4},
			dot : true,
			dotProps : {stroke : "white","stroke-width" : 2}
		},
		series : {serie1 : {color : "blue"}},
		defaultAxis : {labels : true},
		features : {
			grid : {
				draw : [true, false],
				props : {"stroke-dasharray" : "-"}
		  	},
		  	legend : {
		  		horizontal : false,
		   		width : 80,
		   		height : 50,
		   		x : 220,
		   		y : 250,
		   		dotType : "circle",
		   		dotProps : {stroke : "white","stroke-width" : 2},
		   		borderProps : {opacity : 0.3, fill:"#c0c0c0","stroke-width" : 0}
		   		
		   	}
		 }
	};
	
	elobj.chart({
		template : "line_chart",
	 	tooltips : {serie1 : tips},
	 	values : {serie1 : values},
	 	defaultSeries : {
	 		fill : false,stacked : false,highlight : {scale : 2},
	 		startAnimation : {active : true,type : "grow",easing : "bounce"}
	 	}
	});
}

function crateBarChart(elobj){
	$.elycharts.templates['bar_chart'] = {
		type : "line",
		margins : [10, 10, 20, 50],
		defaultSeries : {
			plotProps : {opacity : 0.6},
			highlight : {overlayProps : {fill : "white",opacity : 0.5}},
			startAnimation : {active : true,type : "grow"},
			tooltip : {frameProps : false,height : 20,offset : [10, 0],contentStyle : "font-weight: bold"}
		},
		series : {serie1 : {color : "red"}},
	 	defaultAxis : {labels : true},
	 	features : {
	 		
	 		grid : {
	 			draw : [true, false],
	 			forceBorder : false,
	 			evenHProps : {fill : "yellow",opacity : 0.2},
	 			oddHProps : {fill : "green",opacity : 0.2}
	  		}
	 	}
	};
	
	elobj.chart({
		template : "bar_chart",
		width: 500,
		//margins : [10, 0, 0, 50], //上右下左边距
	 	tooltips : {serie1 :tips},
	 	values : {serie1 : values},
	 	labels : labels,
	 	defaultSeries : {type : "bar"},
	 	barMargins : 100
	});
}

function cratePieChart(elobj){

	$.elycharts.templates['chart_pie'] = {
		type : "pie",
		//style : {"background-color" : "black"},
		gridNX: 40,
		defaultSeries :{
			label:{ active : true,props : {fill : "white"}},
			plotProps:{ stroke : "white","stroke-width" : 2,opacity : 0.8},
		 	highlight : {move : 20},
		 	tooltip : {frameProps : {opacity : 0.5}},
		 	startAnimation : {active : true,type : "grow"}
		 },
		 features : {
		 	legend :{ 
		 		itemWidth: "auto",
		 		horizontal : false,height : 80, x : 10,y : 10, dotType : "circle",
		 		dotProps : {stroke : "white","stroke-width" : 0},
		 		
		 	}
		 }
	};
	
	
	
	elobj.chart({
		template : 'chart_pie',
		margins : [70, 0, 0, 0],
		//height: 300,
		values : {serie1 : values},
		labels : labels,
		legend : legend,
		tooltips : {serie1: tips},
		defaultSeries: {values:[{plotProps:{fill: "red"}},{plotProps:{fill: "blue"}},{plotProps:{fill: "green"}},{plotProps:{fill: "gray"}}]}
		 
	});


}
</script>

			


