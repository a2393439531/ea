<#include "../../../common/freemarker/include_header.ftl">
<#assign count = 1 >


<div class="btn-group btn-group-xs" style="margin-left:500px;padding-bottom:10px">
	<#if rhs["type"] == 'season'>
		<h4>${rhs["year"]}年季度报告汇总</h4>
	<#elseif rhs["type"] == 'month'>
		<h4>${rhs["year"]}年月报汇总</h4>
	<#elseif rhs["type"] == 'week'>
		<h4>${rhs["year"]}年周报汇总</h4>
	</#if>
</div>

<#if rhs["type"] == 'day'>
	<div class="panel panel-default" style="margin-left:700px;margin-top:10px">
		            <div class="panel-body">
		              <form  action="ea_report_sumReport.do"  method="POST" >			
							<a>开始日期 </td><td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input  name="fromDate" type="text"  value="${rhs["fromDateI"]?if_exists}"  onClick="WdatePicker()" /></a>
							<a>结束日期 </td><td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input  name="toDate" type="text"  value="${rhs["toDateI"]?if_exists}"  onClick="WdatePicker()" /></a>
		
	      				<input  class="btn btn-xs btn-primary"   type="submit"   value="查询"> 
	    				<input  name="theYear" value="${rhs["year"]}" type="hidden"  />
	   					 <input  name="type" value="day" type="hidden"  />
	   				 	<input  name="userAccount" value="" type="hidden"  />
	    
	    			</form>
		            </div>
		          </div>		
<h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日报汇总</h4>         
</#if>

 <table class="table table-condensed table-striped " >
 	<tbody>
		<#list rhs["sumReport"]?sort_by("date") as sumReport>	
			<#if count==5>
				<tr>	
				<#assign count = count -4 >							        			
			</#if>	
			<td>
			
			<td width=300px valign=top>
		         <div class="panel panel-default">
		            <div class="panel-heading">
		              <h4 class="panel-title">
		         <#---字符串出错
				<#if rhs["type"]=="week">	
		        	<h5><strong>第${sumReport.date?substring(5)}周</strong></h5>		        
		        <#elseif rhs["type"]=="season">
		        	<h5><strong>第${sumReport.date?substring(5)}季度</strong></h5>	
		        <#else>
		        	<h5><strong>${sumReport.date?substring(5)}</strong></h5>
		        </#if>
		        -->	
						</h4>
		            </div>
		            <div class="panel-body">
		            <textarea  cols="35" rows="4"  id="textarea" name="content" style="border-left:0px;border-top:0px;border-right:0px;border-bottom:0px">${sumReport.content}</textarea>
		              
		            </div>
		          </div>
			
				        
		        
	        <td>
	        <#if count==5>
				</tr>
								        			
			</#if>	
		    <#assign count = count +1 >
		</#list> 
	</tbody>
</table>

<a class="btn btn-xs btn-info" style = "margin-left:545px" href="ea_report_report.do?year=${rhs["year"]}" target="mainFrame">-返回</a>
