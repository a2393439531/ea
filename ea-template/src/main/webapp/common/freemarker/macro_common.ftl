
<#macro context><#if request?exists>${request.getContextPath()}/<#else></#if></#macro>
<#macro context_module><#if request?exists>${request.getRequestURI()[0..request.getRequestURI()?last_index_of("/")]}<#else></#if></#macro>

<#macro input_user mutiple>
	<script type='text/javascript' >
		$(function() {
			$(".user").autocomplete(names,{
				minChars: 0,
				width: 150,
				multiple:${mutiple},
				multipleSeparator:",",			
				max: 20,
				matchContains: true,
				autoFill: false,
				formatItem: function(row) {
					return  row.name + "(" + row.account + ")";
				},
				formatMatch: function(row) {
					return row.name + " " + row.account;
				},
				formatResult: function(row) {
				   
					return row.name ;
				}
			});
		});
		var names = [
		<#list  Session["userList"]?sort_by('name') as u>
		{ name: "${u.name?if_exists}", account: "${u.account?if_exists}" , id:"${u.id?if_exists}"}<#if u_has_next>,<#else> </#if>
		</#list>
		];
	</script>
</#macro>

<#macro getName account>
	  <#list  Session["userList"] as user>
		   <#if  user.account==account> 
		     ${user.name?if_exists}
		   </#if>
	   </#list>
</#macro>

<#assign language_map= {
		"zh-cn":"中文",
		"zh-tw":"繁体",
		"en":"English",  
		"jp":"日文",
		"es":"Español"
	   	}
> 
<#macro get_candidategroup_by_rolegroup rolegroupNodes  flag >
	<#list rolegroupNodes as rolegroup>
		<#if !(rolegroup.getParentModel()?exists)> 
		<optgroup label=" ${rolegroup.name?if_exists}岗位">
		<#else>
		 	<option   value="${rolegroup.alias}">${flag}${rolegroup.name?if_exists}</option> 
		 	
		</#if>
		<#if !(rolegroup.getChildRolegroups()?size<1)> 
		      <@get_candidategroup_by_rolegroup rolegroup.getChildRolegroups()?sort_by('sortNob'),flag+"&nbsp;&nbsp;&nbsp;" />	
		</#if>
		<#if !(rolegroup.getParentModel()?exists)>  
		</optgroup>
		</#if>
	</#list> 
</#macro>

<#macro get_candidategroup_by_organize organizeNodes  flag >
	<#list organizeNodes as organize>
		<#if !(organize.getParentModel()?exists)> 
		<optgroup label=" ${organize.name?if_exists}">
		<#else>
		 	<option   value="${organize.alias}">${flag}[${organize.name?if_exists}]</option> 
		 	<#list organize.getRoles()  as r>
		 	<option   value="${r.alias}">${flag}${r.name?if_exists}</option> 
		 	</#list>	
		</#if>
		<#if !(organize.getChildOrganizes()?size<1)> 
		      <@get_candidategroup_by_organize organize.getChildOrganizes()?sort_by('sortNob'),flag+"&nbsp;&nbsp;&nbsp;" />	
		</#if>
		<#if !(organize.getParentModel()?exists)>  
		</optgroup>
		</#if>
	</#list> 
</#macro>
