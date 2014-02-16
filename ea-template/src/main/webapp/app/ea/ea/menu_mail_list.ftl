<#include "../../../common/freemarker/include_header.ftl">

<#macro digui_rolegroup treeNodes  flag type>
	<#list treeNodes as node>
		      <#if flag==""> 
		     <br>	<b>${node.name}</b>
   				   <#list node.getRoles() as role>
				    <br>${role.name?if_exists}:<#list role.getUsers() as u>${u.email?if_exists};</#list>
				  </#list>
			 <br>
		     
		     
			  <#else>
			      <table>
				      <tr>
				      	 <td>${flag}</td>
					  	 <td><a href="common_notify_send_email.do?rolegroupId=${node.id}"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })"><b>[${node.name?if_exists}]</b></a>
						    <#list node.getRoles() as role><#list role.getUsers() as u>${u.email?if_exists};</#list></#list>					  	 
					  	 
					  	  <#list node.getRoles() as role>
					      <br>
					      <a href="common_notify_send_email.do?roleId=${role.id}"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">&nbsp;&nbsp;${role.name?if_exists}</a>:
					   	 	 <#list role.getUsers() as u>  <#if u.email?exists>   ${u.email?if_exists};<#else>${u.name?if_exists};</#if></#list>
					  	  </#list>
					  	 
					      </td>
					  </tr>
				  </table>
			  </#if>
		  <#if !(node.getChildRolegroups()?size<1)> 
		      <@digui_rolegroup node.getChildRolegroups()?sort_by('sortNob') ,flag+"&nbsp;&nbsp;&nbsp;&nbsp;" ,type/>	
		  </#if>
	</#list> 
</#macro>

<#assign userList =rhs["userList"]>
<body style="padding:10px;margin:10px;width:100%">
     
	 <a  href="common_notify_send_email.do" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })"><b>所有人邮件列表</b><br></a>
	 <#list  userList as u><#if u.email?exists>${u.email?if_exists};<#else>${u.name?if_exists};</#if></#list>  	
	 <@digui_rolegroup rhs["rolegroupRootList"],"",""/>
	   
	    <#--
	    <#macro digui_rolegroup2 treeNodes  flag type>
			<#list treeNodes as node>
				      <#if flag==""> 
				        <b>${node.name}</b><br>
					  <#else>
						  <br>${flag}${node.name}
						    <#list node.getRoles() as role>
						    <br>${role.name?if_exists}:<#list role.getUsers() as u>${u.email?if_exists};</#list>
						  </#list>
					  </#if>
				  <#if !(node.getChildRolegroups()?size<1)> 
				      <@digui_rolegroup2 node.getChildRolegroups()?sort_by('sortNob') ,flag+"&nbsp;" ,type/>	
				  </#if>
			</#list> 
		</#macro>
		<@digui_rolegroup2 rhs["rolegroupRootList"],"",""/>
	    -->
	
 </body>