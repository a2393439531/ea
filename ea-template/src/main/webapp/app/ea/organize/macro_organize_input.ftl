<#macro digui_organize organizeNodes rhs flag >
	<#list organizeNodes as organize>
	    <tr>
	    	<td width=700px>
	    		${flag} 名称<input  value="${organize.name?if_exists}" 
			      style="WIDTH: 120px"  onchange="javascript:action_organize('update.do','column=name&id=${organize.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /> 
					英文<input  value="${organize.alias?if_exists}" 
			        style="WIDTH: 120px"  onchange="javascript:action_organize('update.do','column=alias&id=${organize.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /> 
			
			<#--通用的扩展属性-->
			<#list rhs["extpList"] as extp>
			      ${extp.name?if_exists}
			      <input  value="<#if rhs["extvmap"][extp.alias?default('')+'_'+organize.id]?exists> ${rhs["extvmap"][extp.alias?default('')+'_'+organize.id].value?default('-')}</#if> 		" 
			      style="WIDTH: 120px"  onchange="javascript:action_organize('updateExtp.do','modelid=${organize.id?if_exists}&extpalias=${extp.alias?if_exists}&value='+escape(encodeURIComponent(this.value)))" /> 
			</#list>
			
			<br>
			
			<#--特殊的属性
   			<#list  rhs["system_para_map"]["organize_extp_hotel"]?keys as key>
		  	 	${rhs["system_para_map"]["organize_extp_hotel"][key]?if_exists}
		  	 	<input  value="<#if rhs["extvmap"][key+'_'+organize.id]?exists> ${rhs["extvmap"][key+'_'+organize.id].value?default('-')}</#if>" 
		  	 		 style="WIDTH: 120px"  onchange="javascript:action_organize('updateExtp.do','modelid=${organize.id?if_exists}&extpalias=${key}&value='+escape(encodeURIComponent(this.value)))" /> 
		  	</#list> 			
			
			    <#assign key="efee" />
		  	 	${rhs["system_para_map"]["organize_extp_hotel"][key]?if_exists}
		  	 	<input  value="<#if rhs["extvmap"][key+'_'+organize.id]?exists> ${rhs["extvmap"][key+'_'+organize.id].value?default('-')}</#if>" 
		  	    style="WIDTH: 120px"  onchange="javascript:action_organize('updateExtp.do','modelid=${organize.id?if_exists}&extpalias=${key}&value='+escape(encodeURIComponent(this.value)))" /> 
			-->
			
			
			</td>
			<td width=200px>		 	     
  		  		<a  onclick="javascript:action_organize('create.do','id=${organize.id}');" class="ui-icon ui-icon-plus" ></a>
 			<#if (organize.getChildOrganizes()?size<1)> 
				<a  title="删除节点" onclick="javascript:action_organize('delete.do','id=${organize.id}');" class="ui-icon ui-icon-trash"  title=删除 ></a>
		  	</#if> 				
			<#if organizeNodes?size?string=="1" > 
				<a  onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}');" class="ui-icon ui-icon-arrowthick-1-w" title=前1级 ></a>     
			<#else>
				<#assign index =organize_index>                                                
			 	<#if index?string=="0">
			 	    <a  onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index+1].id}')"     class="ui-icon ui-icon-arrowthick-1-s"  title=下移></a>
			  	    <a  onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}')"       class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>   
			 	<#else>
			 	    <#if organize_has_next>
				 	    <a  onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
						<a  onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index+1].id}')"  class="ui-icon ui-icon-arrowthick-1-s" title=下移></a>
					<#else>
					    <a onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
					</#if>
					<a onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}')"  class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>      
	 				<a onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}&parentId=${organizeNodes[organize_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-e" title=后1级></a>	
			 	</#if>
			</#if>
			</td>
		 
		  
		  <#if !(organize.getChildOrganizes()?size<1)> 
		      <@digui_organize organize.getChildOrganizes()?sort_by('sortNob'),rhs,flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />	
		  </#if>
	</#list> 
</#macro>