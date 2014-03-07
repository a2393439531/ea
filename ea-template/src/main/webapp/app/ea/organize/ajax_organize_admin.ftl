<div id="div_organize_admin">
<table    class="table  table-condensed" >
     <thead>
		<tr>
			<th>职位名称</th><th>设置上级</th>
		</tr>
	</thead>   
<@digui_role rhs["organize"].rootRoles()?sort_by('sortNob'),"" />	
   </table>
</div>
<span id="div_action_result" style="display:block">${rhs["info"]?if_exists}</span>
<#macro digui_role roleNodes  flag >
	<#list roleNodes as role>
	    <tr >
	    	<td style="width:480px" style="border:1px solid #ccc;">
	    		${flag} <input  value="${role.name?if_exists}" 
			      style="WIDTH: 150px"  onchange="javascript:action_role('update.do','column=name&id=${role.id?if_exists}&columnValue='+this.value)" /> 
			  
				
				  	<a   onclick="scrolldiv_('div_scoll',2);document.getElementById('div_scoll').style.display ='';document.getElementById('div_add_new_user').style.display ='';document.getElementById('div_select_user').style.display ='none';document.getElementById('organize_id').value ='${rhs["organize"].id}';document.getElementById('operation_title').innerHTML='新增员工';document.getElementById('role_id').value ='${role.id}'" class="btn btn-xs  btn-default" title="添加新员工"><span class="ui-icon ui-icon-circle-plus"></span> </a>
					<a   onclick="scrolldiv_('div_scoll',2);document.getElementById('div_scoll').style.display ='';document.getElementById('div_add_new_user').style.display ='none';document.getElementById('div_select_user').style.display ='';document.getElementById('operation_title').innerHTML='现有员工';role_user_list('${role.id}','${rhs["organize"].id}');" class="btn btn-xs btn-default"><span class="ui-icon ui-icon-circle-zoomin" title="选择现有员工"></span> </a>
					<a   onclick="javascript:action_organize_admin('ea_organize_delete_role.do','roleId=${role.id}&organizeId=${rhs["organize"].id}');"  class="btn btn-xs btn-default"><span class="ui-icon ui-icon-trash"   title="删除"></span></a>				 	     
 				
				<table class="table-condensed" >
					<tr><td>${flag}</td>
					<td class="userList">
				     <#list role.getUsers() as u>
			            ${u.name}&nbsp;&nbsp 
			         </#list>
			         </td>
			         </tr>
		         </table>
		         
			</td>
			<td style="border:1px solid #ccc;">
	  			<select style="width:180px" onchange= "javascript:action_organize_admin('ea_organize_change_role_level.do','id=${role.id}'+'&parentId='+this.value+'&beanname=Role&organizeId=${rhs["organize"].id}')">
	  			    <#if role.getParentModel()?exists>  
		             <option   value="${role.getParentModel().id?if_exists}">${role.getParentModel().name?if_exists}</option> 
					<#else>
					 <option   value="">无上级</option>
					</#if>
				    <#list rhs["organize"].getRoles() as x>
				        <#if x.id!=role.id>  
					    <option   value="${x.id}">${x.name?if_exists}</option> 
					    </#if>
				    </#list> 	
				    <#list rhs["organize"].getParentModel().getRoles() as x>
					<option   value="${x.id}">${x.name?if_exists}</option> 
				    </#list> 	
				    <#if role.getParentModel()?exists>  
		             <option   value="">无上级</option>
					<#else>
					</#if>
					   	
				</select>      
 			</td>
		  <#if !(role.getChildRoles()?size<1)> 
		      <@digui_role role.getChildRoles()?sort_by('sortNob'),flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />	
		  </#if>
	</#list> 
</#macro> 
 