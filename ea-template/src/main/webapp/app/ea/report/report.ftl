
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
	           
	           document.getElementById('div_scoll').style.display ='none';
	        }
		   }); 
		}	
		
function data_read(date,column){
	
   
	//alert("column="+para_col+"; value="+para_str);
    $.ajax({
	        type:"POST",
	        url: "ea_report_data_read.do",
	        data: "column="+column+"&value="+date,
	        cache: false,
	        success: function(html){
	          document.getElementById('content').value=html;
	        }
		   }); 


	}		
	
</script>



<body style="padding:10px">

<strong>工作汇报</strong>
	<a href="ea_report_dayReport.do?theYear=${rhs["year"]}&type=day" target="mainFrame"> 日报</a>
	<a> 周报</a><a> 月报</a><a> 季报</a>
<hr>
 
<#assign year= rhs["year"]?if_exists>
<table class ="table">
			<tr>
				<td width=80px><strong>更改年份：</strong></td>	
				<td>	
					 <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">		      
					      <li class="dropdown">
					        <a href="ea_report_report.do?year=${year}" class="dropdown-toggle" data-toggle="dropdown">${year} <b class="caret"></b></a>
					        <ul class="dropdown-menu">
					        	<#list (javacall["com.utils.time.TimeUtil"].getCurrentYear()-7)..(javacall["com.utils.time.TimeUtil"].getCurrentYear()+2) as y>					        							
									<li><a href="ea_report_report.do?year=${y}" value=y>
										${y} 
									</a></li>
								</#list>
					        </ul>
					      </li>		    
					  </div><!-- /.navbar-collapse --> 		
				  </td>	
			</tr>
		</table> 

	<div class="btn-group btn-group-xs" style="padding-bottom:10px">
        <#--
	    <a class="btn btn-xs btn-warning" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">${year}年度报告</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">第一季度</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">第二季度</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">第三季度</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">第四季度</a>
	    -->
	    <a class="btn btn-xs btn-warning" href='#'  onclick="document.getElementById('title').innerHTML=${year}+'年度报告';date=${year};retype='year';javascript:data_read(date,'date');document.getElementById('div_scoll').style.display ='';">${year}年度报告</a>
	    <a class="btn btn-xs btn-warning" href='#'  onclick="document.getElementById('title').innerHTML=${year}+'第一季度报告';date=${year}*10+1;retype='season';javascript:data_read(date,'date');document.getElementById('div_scoll').style.display ='';">第一季度</a>
	    <a class="btn btn-xs btn-warning" href='#'  onclick="document.getElementById('title').innerHTML=${year}+'第二季度报告';date=${year}*10+2;retype='season';javascript:data_read(date,'date');document.getElementById('div_scoll').style.display ='';">第二季度</a>
	    <a class="btn btn-xs btn-warning" href='#'  onclick="document.getElementById('title').innerHTML=${year}+'第三季度报告';date=${year}*10+3;retype='season';javascript:data_read(date,'date');document.getElementById('div_scoll').style.display ='';">第三季度</a>
	    <a class="btn btn-xs btn-warning" href='#'  onclick="document.getElementById('title').innerHTML=${year}+'第四季度报告';date=${year}*10+4;retype='season';javascript:data_read(date,'date');document.getElementById('div_scoll').style.display ='';">第四季度</a>
	</div>

<div id=div_scoll  style="margin-left:700px; cursor:hander;position:absolute;margin-top:50px;width:300px;z-index:10000;background-color: #ffffff;display:none">
<div id=div_panel_control style="padding:8px;border:1px solid #000;cursor:hander; ">

  <a  style="float:right" href="#" onclick="document.getElementById('div_scoll').style.display ='none';" >X</a>
 	
    录入内容：<span id=title></span>
    <br><br>
    <textarea id=content style = "width:280px" value="" rows=8 > </textarea>
    <br><br><button type="button" class="btn btn-xs btn-primary"  onclick="javascript:data_save(date,'date',retype,content);document.getElementById('div_scoll').style.display=='none';">保存</button>

</div>	
</div>	


<br>
	
<#assign  count = 1>
<#macro day_report month>
 	
    <div class="col-xs-12">
	    <div class="btn-group btn-group-xs" >
	    <#--
	    <a class="btn btn-xs btn-warning" href='ea_report_template.do?objectname=Report&op=r&propertyname=date&id=${year}-${month}-00'  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">${month}月</a>
		-->
       
		<a class="btn btn-xs btn-warning" href='#'  onclick="document.getElementById('title').innerHTML=${year}+'-'+${month}+'月报告';date=${year}*10000+${month}*100;retype='month';javascript:data_read(date,'date');document.getElementById('div_scoll').style.display ='';">${month}月</a>
		
			<#list 1..javacall["com.utils.time.TimeUtil"].getDayNumByYearMonth(year,month-1) as day>
			<#--
			<a class="btn btn-xs btn-info" href="ea_report_template.do?objectname=Report&op=r&propertyname=date&id=${year}-${month}-${day}"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">${day}</a>
			-->
			<a class="btn btn-xs btn-info" href="#"  onclick="document.getElementById('title').innerHTML=${year}+'-'+${month}+'-'+${day}+'日报告';date=${year}*10000+${month}*100+${day};retype='day';javascript:data_read(date,'date');document.getElementById('div_scoll').style.display ='';">${day}</a>
			<#assign week = javacall["com.utils.time.TimeUtil"].ifFirstDayOfWeek(year,month-1,day)>
		
				<#if week>
					<a class="btn btn-xs btn-warning" href="#"  onclick="javascript:document.getElementById('title').innerHTML=${year}+'年第'+${count}+'周报告';date=${year}*10000+${count};retype='week';data_read(date,'date');document.getElementById('div_scoll').style.display ='';">${count}周</a>
					<#assign count = count +1 >
				</#if>
			</#list>
	    </div>
	</div>
</#macro>	



<#--
<#macro day_report month>
    <div class="col-xs-12">
	    <div class="btn-group btn-group-xs" >
	    <a class="btn btn-xs btn-warning" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">${month}月</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">1</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">2</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">3</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">4</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">5</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">6</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">7</a>
	   
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">8</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">9</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">10</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">11</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">12</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">13</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">14</a>
	   
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">15</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">16</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">17</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">18</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">19</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">20</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">21</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">22</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">23</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">24</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">25</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">26</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">27</a>
	    <a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">28</a>
	    <#if month != 2>
	    	<a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">29</a>
	    	<a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">30</a>
	    	<#if month != 4 && month != 6 && month != 9 && month !=11>	    
	    		<a class="btn btn-xs btn-info" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">31</a>
	    	</#if>
	    </#if>
	    </div>
	</div>
</#macro>	
-->
<div class="row show-grid ">
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
 
  <#---
  <div class="row show-grid">
    <div class="col-xs-1">.col-xs-1</div>
    <div class="col-xs-1">.col-xs-1</div>
    <div class="col-xs-1">.col-xs-1</div>
    <div class="col-xs-1">.col-xs-1</div>
    <div class="col-xs-1">.col-xs-1</div>
    <div class="col-xs-1">.col-xs-1</div>
    <div class="col-xs-1">.col-xs-1</div>
    <div class="col-xs-1">.col-xs-1</div>
    <div class="col-xs-1">.col-xs-1</div>
    <div class="col-xs-1">.col-xs-1</div>
    <div class="col-xs-1">.col-xs-1</div>
    <div class="col-xs-1">.col-xs-1</div>
  </div>
  <div class="row show-grid">
    <div class="col-xs-8">.col-xs-8</div>
    <div class="col-xs-4">.col-xs-4</div>
  </div>
 -->

</body>