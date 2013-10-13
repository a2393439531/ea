<#macro time_query >
	 开始时间<input style="width:70px" onclick="javascript:WdatePicker({dateFmt:'yyyy-MM-dd'});"/> 
	 结束时间<input style="width:70px" onclick="javascript:WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
</#macro>

<#macro botton text ><a class="btn btn-primary"  onclick="">${text}</a></#macro>
<#macro a text ><a  onclick="">${text}</a></#macro>

<#macro table fieldlist row >
	<table class="table table-condensed table-hover">
	    <thead>
			<tr>
			    <th width=25px>#</th>
			    <#list  fieldlist as x>
				<th> ${x?if_exists} </th>
			    </#list>
			    <th>操作</th>
			</tr>
		</thead>
			<tbody>
			<#list 1..row as x>
			<tr>
			     <td>${x_index+1}</td> <#---->
				 <#list  fieldlist as x>
				  <td>  </td>
			     </#list>
			     <td>
			        <a title="编辑" >编辑</a> 
					<a title="删除" >删除</a>
				 </td>
			</tr>
			</#list>
		</tbody>
	</table>  	  
	 
</#macro>
