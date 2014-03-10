
<#include "../../../common/freemarker/include_header.ftl">

<script type="text/javascript" src="<@context_module/>myReport.js"></script>

<script>
   var para_string="";
	$(function() {    $( "#div_scoll" ).draggable();});  
	function  scrolldiv_(id,h){  //定位层
	   obj=document.getElementById(id);
	   obj.style.top =  document.body.scrollTop+h;
	}
	function  show_dir(){  //定位层
	  if( document.getElementById('div_panel_control').style.display=='none'){
	  	document.getElementById('div_panel_control').style.display='block';
	  }else{
	  document.getElementById('div_panel_control').style.display='none';
	  }
	}
	
	function data_save(date,column,retype){
		   //alert("content="+document.getElementById('content').value+"&date="+para_str+"&column="+para_col);
		   $.ajax({
	        type:"POST",
	        url: "ea_report_data_save.do",
	        data:"content="+document.getElementById('content').value+"&date="+date+"&column="+column+"&retype="+retype,
	        cache: false,
	        success: function(html){
	           document.getElementById('action_result').innerHTML=html;
	           document.getElementById('div_scoll').style.display ='none';
	        }
		   }); 
		}	
		
function data_read(date,column,type){
	
   
	//alert("column="+column+"; value="+date);
    $.ajax({
	        type:"POST",
	        url: "ea_report_data_read.do",
	        data: "column="+column+"&value="+date+"&retype="+type,
	        cache: false,
	        success: function(html){
	          document.getElementById('content').value=html;
	        }
		   }); 


	}		
	
</script>

<#assign  count = 1>
<#macro day_report month>
<#assign findmonthresult = false>
<#assign findweekresult = false>
<#assign finddayresult = false>
 	
    <div class="alert alert-info">
		<#list rhs["monthMap"]?keys as datekey>
			<#if year?number*10000+month*100==datekey?number&&rhs["monthMap"][datekey] >
				<a class="btn btn-xs btn-danger" href='#'  onclick="document.getElementById('title').innerHTML=${year}+'-'+${month}+'月报告';date=${year}*10000+${month}*100;retype='month';javascript:data_read(date,'date','month');document.getElementById('div_scoll').style.display ='';">${month}月</a>
				<#assign findmonthresult = true>
				<#break>
			</#if>
		</#list>
		<#if !findmonthresult>
			<a class="btn btn-xs btn-info" href='#'  onclick="document.getElementById('title').innerHTML=${year}+'-'+${month}+'月报告';date=${year}*10000+${month}*100;retype='month';javascript:data_read(date,'date','month');document.getElementById('div_scoll').style.display ='';">${month}月</a>	
		</#if>
			<#list 1..javacall["com.utils.time.TimeUtil"].getDayNumByYearMonth(year,month-1) as day>
			<#list rhs["dayMap"]?keys as datekey>
				<#if year?number*10000+month*100+day==datekey?number&&rhs["dayMap"][datekey] >	
					<a class="btn btn-xs btn-danger" href="#"  onclick="document.getElementById('title').innerHTML=${year}+'-'+${month}+'-'+${day}+'日报告';date=${year}*10000+${month}*100+${day};retype='day';javascript:data_read(date,'date','day');document.getElementById('div_scoll').style.display ='';">${day}</a>
					<#assign finddayresult = true>
					<#break>
				</#if>
			</#list>
			<#if !finddayresult>
				<a class="btn btn-xs btn-default" href="#"  onclick="document.getElementById('title').innerHTML=${year}+'-'+${month}+'-'+${day}+'日报告';date=${year}*10000+${month}*100+${day};retype='day';javascript:data_read(date,'date','day');document.getElementById('div_scoll').style.display ='';">${day}</a>
			</#if>
			<#assign week = javacall["com.utils.time.TimeUtil"].ifFirstDayOfWeek(year,month-1,day)>
				<#if week>
					<#list rhs["weekMap"]?keys as datekey>
						<#if year?number*10000+count==datekey?number&&rhs["weekMap"][datekey] >
							<a class="btn btn-xs btn-danger" href="#"  onclick="javascript:document.getElementById('title').innerHTML=${year}+'年第'+${count}+'周报告';date=${year}*10000+${count};retype='week';data_read(date,'date','week');document.getElementById('div_scoll').style.display ='';">${count}周</a>
							<#assign findweekresult = true>
							<#break>
						</#if>
					</#list>
					<#if !findweekresult>
						<a class="btn btn-xs btn-info" href="#"  onclick="javascript:document.getElementById('title').innerHTML=${year}+'年第'+${count}+'周报告';date=${year}*10000+${count};retype='week';data_read(date,'date','week');document.getElementById('div_scoll').style.display ='';">${count}周</a>
					</#if>
					<#assign count = count +1 >
				</#if>
				<#assign finddayresult = false>
				<#assign findweekresult = false>
			</#list>
	</div>
</#macro>	

<body id=action_result>
<!--输入框开始-,默认隐藏-->
<div id=div_scoll class="panel panel-primary" style="margin-left:700px; cursor:hander;position:absolute;margin-top:50px;width:auto;z-index:10000;background-color: #ffffff;display:none">
  	<div class="panel-heading"><strong>录入内容：<span id=title></span></strong>
  		<a  style="float:right;color:#FFFFFF" href="#" onclick="document.getElementById('div_scoll').style.display ='none';" >X</a>
  	</div>
    <div class="panel-body">
    	<div id=div_panel_control style="cursor:hander; ">
    		<textarea id=content style = "width:280px" value="" rows=8 > </textarea>
    		<br/>
    		<button style="margin-top:5px;float:right;" type="button" class="btn btn-xs btn-primary"  onclick="javascript:data_save(date,'date',retype,content);document.getElementById('div_scoll').style.display=='none';">保存</button>
    	</div>
    </div>
</div>
<!--输入框结束-->

<#assign year= rhs["year"]?if_exists>

	<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong>工作汇报</strong>&nbsp;&nbsp;&nbsp;<a href="ea_report_sumReport.do?theYear=${rhs["year"]}&type=day" target="mainFrame" style="color:#FFFFFF">日报</a>
      	<div class="pull-right">
	      	<strong>更改年份：</strong>
			<li class="dropdown" style="margin-top:-17px;margin-left:70px;">
					<a style="color:#FFFFFF;" href="ea_report_report.do?year=${year}" class="dropdown-toggle" data-toggle="dropdown">${year} <b class="caret"></b></a>
					<ul class="dropdown-menu">
					<#list (javacall["com.utils.time.TimeUtil"].getCurrentYear()-7)..(javacall["com.utils.time.TimeUtil"].getCurrentYear()+2) as y>					        							
						<li><a href="ea_report_report.do?year=${y}" value=y>
							${y} 
						</a></li>
					</#list>
					</ul>
			</li>
      	</div>
      </div>
      <div class="panel-body">
	    <div class="btn-group btn-group-xs" style="padding-bottom:10px">
		    <a style="margin-left:5px;" class="btn btn-xs btn-info" href='#'  onclick="document.getElementById('title').innerHTML=${year}+'年度报告';date=${year};retype='year';javascript:data_read(date,'date','year');document.getElementById('div_scoll').style.display ='';">${year}年度报告</a>
		    <a style="margin-left:5px;" class="btn btn-xs btn-info" href='#'  onclick="document.getElementById('title').innerHTML=${year}+'第一季度报告';date=${year}*10+1;retype='season';javascript:data_read(date,'date','season');document.getElementById('div_scoll').style.display ='';">第一季度</a>
		    <a style="margin-left:5px;" class="btn btn-xs btn-info" href='#'  onclick="document.getElementById('title').innerHTML=${year}+'第二季度报告';date=${year}*10+2;retype='season';javascript:data_read(date,'date','season');document.getElementById('div_scoll').style.display ='';">第二季度</a>
		    <a style="margin-left:5px;" class="btn btn-xs btn-info" href='#'  onclick="document.getElementById('title').innerHTML=${year}+'第三季度报告';date=${year}*10+3;retype='season';javascript:data_read(date,'date','season');document.getElementById('div_scoll').style.display ='';">第三季度</a>
		    <a style="margin-left:5px;" class="btn btn-xs btn-info" href='#'  onclick="document.getElementById('title').innerHTML=${year}+'第四季度报告';date=${year}*10+4;retype='season';javascript:data_read(date,'date','season');document.getElementById('div_scoll').style.display ='';">第四季度</a>
		</div>
		
		<!-- 显示具体信息 -->
		<div class="">
			<@day_report  1 />
			<@day_report  2 />
			<@day_report  3 />
			<@day_report  4 />
			<@day_report  5 />
			<@day_report  6 />
			<@day_report  7 />
			<@day_report  8 />
			<@day_report  9 />
			<@day_report  10 />
			<@day_report  11 />
			<@day_report  12 />
		</div>  
      </div>
   	</div>

<br>
</body>