<#macro digui_organize organizeNodes  flag >
	<#list organizeNodes as organize>
	      ,{"id":"${organize.id}","pId":"${flag}","name":"${organize.name}"}
	        	 <#list organize.allUser() as u>
	  	      	  ,{"id":"u_${u.id}","pId":"${organize.id}","account":"${u.account}","name":"${u.name}"}
	  	      </#list>	     
	
		  <#if !(organize.getChildOrganizes()?size<1)> 
		      <@digui_organize organize.getChildOrganizes()?sort_by('sortNob'), organize.id/>	
		  </#if>
	</#list> 
</#macro>
[{"id":"0","pId":"0","name":"组织架构"}	
<#assign organizeRootList=rhs["organizeRootList"]/>
	<@digui_organize organizeRootList?sort_by('sortNob'),"0" />	
]