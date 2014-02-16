
<#macro digui_systempara systemparaNodes  flag >
	<#list systemparaNodes as systempara>
	    <tr>
	    	<td >
	    		${flag}<b><#if flag=="">参数类别<#else>-[key]</#if></b><input  value="${systempara.keyname?if_exists}" 
			      style="WIDTH: 180px"  onchange="javascript:action_systempara('update.do','column=keyname&id=${systempara.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /> 
					<b><#if flag=="">&nbsp;说明:<#else>-[value]</#if></b><input  value="${systempara.value?if_exists}" 
			      style="WIDTH: 180px"  onchange="javascript:action_systempara('update.do','column=value&id=${systempara.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /> 
					
			</td>
		
			<td width=100px>		 	     
  		  		<a  onclick="javascript:action_systempara('create.do','id=${systempara.id}');" class="ui-icon ui-icon-plus" ></a>
 			<#if (systempara.getChildSystemparas()?size<1)> 
				<a title="删除节点" onclick="javascript:action_systempara('delete.do','id=${systempara.id}');" class="ui-icon ui-icon-trash"  title=删除 ></a>
		  	</#if> 				
			<#if systemparaNodes?size?string=="1" > 
				<a onclick="javascript:action_systempara('change_level.do','id=${systempara.id?if_exists}');" class="ui-icon ui-icon-arrowthick-1-w" title=前1级 ></a>     
			<#else>
				<#assign index =systempara_index>                                                
			 	<#if index?string=="0">
			 	    <a  onclick="javascript:action_systempara('change_rank.do','id_from=${systempara.id?if_exists}&id_to=${systemparaNodes[systempara_index+1].id}')"     class="ui-icon ui-icon-arrowthick-1-s"  title=下移></a>
			  	    <a  onclick="javascript:action_systempara('change_level.do','id=${systempara.id?if_exists}')"       class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>   
			 	<#else>
			 	    <#if systempara_has_next>
				 	    <a  onclick="javascript:action_systempara('change_rank.do','id_from=${systempara.id?if_exists}&id_to=${systemparaNodes[systempara_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
						<a  onclick="javascript:action_systempara('change_rank.do','id_from=${systempara.id?if_exists}&id_to=${systemparaNodes[systempara_index+1].id}')"  class="ui-icon ui-icon-arrowthick-1-s" title=下移></a>
					<#else>
					    <a onclick="javascript:action_systempara('change_rank.do','id_from=${systempara.id?if_exists}&id_to=${systemparaNodes[systempara_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
					</#if>
					<a onclick="javascript:action_systempara('change_level.do','id=${systempara.id?if_exists}')"  class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>      
	 				<a onclick="javascript:action_systempara('change_level.do','id=${systempara.id?if_exists}&parentId=${systemparaNodes[systempara_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-e" title=后1级></a>	
			 	</#if>
			</#if>
			</td>
		  <#if !(systempara.getChildSystemparas()?size<1)> 
		      <@digui_systempara systempara.getChildSystemparas()?sort_by('sortNob'),flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />	
		  </#if>
	</#list> 
</#macro>  
 
<table class="table table-bordered   table-hover table-condensed" style="width:700px">
	<@digui_systempara rhs["systemparaRootList"]?sort_by('sortNob'),""/>
</table>

<span id="div_action_result" style="display:none">${rhs["info"]?if_exists}</span>
