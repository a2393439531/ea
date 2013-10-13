<div class="span11 content" id=div_extp_table>



<table class="table table-condensed table-hover">
    <thead>
		<tr>
		    <th width=25px>ID</th>
			<th>属性名称</th>
			<th>别名</th>
			<th>model</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody>
<#list rhs["dataList"]?sort_by("sortNob") as x>
	<tr>
		<td class=nob >
			${x_index+1}
		</td>
		<td>
			<input type="text" value='${x.name?if_exists}' onchange="javascript:action_extp('update.do','column=name&id=${x.id?if_exists}&modelname=${rhs["modelname"]?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" />  
		</td>
		<td>
			<input type="text" value='${x.alias?if_exists}' onchange="javascript:action_extp('update.do','column=alias&id=${x.id?if_exists}&modelname=${rhs["modelname"]?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" />  
		</td>
		<td>
			${x.modelname?if_exists}
		</td>
		<td>
			    <a title="删除节点" onclick="javascript:action_extp('delete.do','id=${x.id}&modelname=${rhs["modelname"]?if_exists}');" class="ui-icon ui-icon-trash"  title=删除 ></a>
			    <#if (rhs["dataList"]?size!=1)>
				    <#if (x_index?string=="0")> 
						<a  onclick="javascript:action_extp('change_rank.do','id_from=${x.id?if_exists}&id_to=${rhs["dataList"]?sort_by("sortNob")[x_index+1].id}&modelname=${rhs["modelname"]?if_exists}')"  class="ui-icon ui-icon-arrowthick-1-s" title=下移></a>
					<#else>
						<a  onclick="javascript:action_extp('change_rank.do','id_from=${x.id?if_exists}&id_to=${rhs["dataList"]?sort_by("sortNob")[x_index-1].id}&modelname=${rhs["modelname"]?if_exists}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
				    	<#if x_has_next>
			 	 			<a  onclick="javascript:action_extp('change_rank.do','id_from=${x.id?if_exists}&id_to=${rhs["dataList"]?sort_by("sortNob")[x_index+1].id}&modelname=${rhs["modelname"]?if_exists}')"  class="ui-icon ui-icon-arrowthick-1-s" title=下移></a>
				        </#if>
				 	</#if> 				
			    </#if> 				
		</td>		
	</tr>
</#list> 
	
	</tbody>
</table>
</div>
<span id="div_action_result" style="display:none">${rhs["info"]?if_exists}</span>



