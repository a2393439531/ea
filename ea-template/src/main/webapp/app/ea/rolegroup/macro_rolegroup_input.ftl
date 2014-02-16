<#macro digui_rolegroup rolegroupNodes  flag >
	<#list rolegroupNodes as rolegroup>
	    <tr>
	    	<td width=700px>
	    		${flag} 名称<input  value="${rolegroup.name?if_exists}" 
			      style="WIDTH: 120px"  onchange="javascript:action_rolegroup('update.do','column=name&id=${rolegroup.id?if_exists}&columnValue='+this.value)" /> 
					别名<input  value="${rolegroup.alias?if_exists}" 
			      style="WIDTH: 120px"  onchange="javascript:action_rolegroup('update.do','column=alias&id=${rolegroup.id?if_exists}&columnValue='+this.value)" /> 
			
			  
			</td>
			<td width=200px>		 	     
				<a  title="本项由管理层定义，符合该岗位的基本素质" href="ea_ea_edit_bean_property.do?objectname=Rolegroup&id=${rolegroup.id?if_exists}&op=r&propertyname=positiondescription" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" class="ui-icon ui-icon-pencil"></a>               
			
  		  		<a  onclick="javascript:action_rolegroup('create.do','id=${rolegroup.id}');" class="ui-icon ui-icon-plus" ></a>
 			               
 			<#if (rolegroup.getChildRolegroups()?size<1)> 
				<a title="删除节点" onclick="javascript:action_rolegroup('delete.do','id=${rolegroup.id}');" class="ui-icon ui-icon-trash"  title=删除 ></a>
		  	</#if> 				
			<#if rolegroupNodes?size?string=="1" > 
				<a onclick="javascript:action_rolegroup('change_level.do','id=${rolegroup.id?if_exists}');" class="ui-icon ui-icon-arrowthick-1-w" title=前1级 ></a>     
			<#else>
				<#assign index =rolegroup_index>                                                
			 	<#if index?string=="0">
			 	    <a  onclick="javascript:action_rolegroup('change_rank.do','id_from=${rolegroup.id?if_exists}&id_to=${rolegroupNodes[rolegroup_index+1].id}')"     class="ui-icon ui-icon-arrowthick-1-s"  title=下移></a>
			  	    <a  onclick="javascript:action_rolegroup('change_level.do','id=${rolegroup.id?if_exists}')"       class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>   
			 	<#else>
			 	    <#if rolegroup_has_next>
				 	    <a  onclick="javascript:action_rolegroup('change_rank.do','id_from=${rolegroup.id?if_exists}&id_to=${rolegroupNodes[rolegroup_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
						<a  onclick="javascript:action_rolegroup('change_rank.do','id_from=${rolegroup.id?if_exists}&id_to=${rolegroupNodes[rolegroup_index+1].id}')"  class="ui-icon ui-icon-arrowthick-1-s" title=下移></a>
					<#else>
					    <a onclick="javascript:action_rolegroup('change_rank.do','id_from=${rolegroup.id?if_exists}&id_to=${rolegroupNodes[rolegroup_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
					</#if>
					<a onclick="javascript:action_rolegroup('change_level.do','id=${rolegroup.id?if_exists}')"  class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>      
	 				<a onclick="javascript:action_rolegroup('change_level.do','id=${rolegroup.id?if_exists}&parentId=${rolegroupNodes[rolegroup_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-e" title=后1级></a>	
			 	</#if>
			</#if>
			</td>
		 
		  
		  <#if !(rolegroup.getChildRolegroups()?size<1)> 
		      <@digui_rolegroup rolegroup.getChildRolegroups()?sort_by('sortNob'),flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />	
		  </#if>
	</#list> 
</#macro>