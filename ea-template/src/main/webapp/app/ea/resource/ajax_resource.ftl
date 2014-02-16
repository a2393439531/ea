
<#macro digui_resource resourceNodes  flag >
	<#list resourceNodes as resource>
	    <tr>
	    	<td style="WIDTH: 240px">
	    		${flag} <input  value="${resource.name?if_exists}" 
			      style="WIDTH: 140px"  onchange="javascript:action_resource('update.do','column=name&id=${resource.id?if_exists}&columnValue='+this.value)" /> 
			</td>
	    	<td >
	    		  <input  value="${resource.actionUrl?if_exists}" 
			      style="WIDTH: 250px"  onchange="javascript:action_resource('update.do','column=actionUrl&id=${resource.id?if_exists}&columnValue='+this.value)" /> 
			</td>			
			<td   style="WIDTH: 550px">		 	     
  		  		<a  onclick="javascript:action_resource('create.do','id=${resource.id}');" class="ui-icon ui-icon-plus" ></a>
 			<#if (resource.getChildResources()?size<1)> 
				<a title="删除节点" onclick="javascript:action_resource('delete.do','id=${resource.id}');" class="ui-icon ui-icon-trash"  title=删除 ></a>
		  	</#if> 				
			<#if resourceNodes?size?string=="1" > 
				<a onclick="javascript:action_resource('change_level.do','id=${resource.id?if_exists}');" class="ui-icon ui-icon-arrowthick-1-w" title=前1级 ></a>     
			<#else>
				<#assign index =resource_index>                                                
			 	<#if index?string=="0">
			 	    <a  onclick="javascript:action_resource('change_rank.do','id_from=${resource.id?if_exists}&id_to=${resourceNodes[resource_index+1].id}')"     class="ui-icon ui-icon-arrowthick-1-s"  title=下移></a>
			  	    <a  onclick="javascript:action_resource('change_level.do','id=${resource.id?if_exists}')"       class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>   
			 	<#else>
			 	    <#if resource_has_next>
				 	    <a  onclick="javascript:action_resource('change_rank.do','id_from=${resource.id?if_exists}&id_to=${resourceNodes[resource_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
						<a  onclick="javascript:action_resource('change_rank.do','id_from=${resource.id?if_exists}&id_to=${resourceNodes[resource_index+1].id}')"  class="ui-icon ui-icon-arrowthick-1-s" title=下移></a>
					<#else>
					    <a onclick="javascript:action_resource('change_rank.do','id_from=${resource.id?if_exists}&id_to=${resourceNodes[resource_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
					</#if>
					<a onclick="javascript:action_resource('change_level.do','id=${resource.id?if_exists}')"  class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>      
	 				<a onclick="javascript:action_resource('change_level.do','id=${resource.id?if_exists}&parentId=${resourceNodes[resource_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-e" title=后1级></a>	
			 	</#if>
			</#if>
			    <#--get_resource_rolegroup_list(${resource.id?if_exists})-->
				<a title="access control" onclick="resourceId='${resource.id?if_exists}';get_resource_rolegroup_list(resourceId);">positon</a>
			  	<a title="access control" onclick="resourceId='${resource.id?if_exists}';get_resource_role_list(${resource.id?if_exists});">role</a>
			  	<a title="access control" onclick="resourceId='${resource.id?if_exists}';get_resource_user_list(${resource.id?if_exists});">user</a>

			</td>	
		</div>
		  
		  <#if !(resource.getChildResources()?size<1)> 
		      <@digui_resource resource.getChildResources()?sort_by('sortNob'),flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />	
		  </#if>
	</#list> 
</#macro>

<table class="table table-bordered    table-condensed" style="WIDTH: 700px" >
     <thead>
		<tr>
			<th>资源名称 </th><th> url</th><th>操作</th>
		</tr>
	</thead>   
	<@digui_resource rhs["resourceRootList"]?sort_by('sortNob'),"&nbsp;&nbsp;&nbsp;"/>	
</table>

<span id="div_action_result" style="display:none">
	${rhs["info"]?if_exists}
</span>