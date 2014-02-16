<#include "../../../common/freemarker/include_header.ftl">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<#macro digui_orgnaize_h treeNodes  flag type>
	<#list treeNodes?sort_by("sortNob") as node>
	      <tr>
	      <#if  type="map_person_deploy"> 
		      <#if flag==""> 
		         <td align=left valign=top>
		      	    <b>${node.name}</b>
		         </td>
		         <td></td>
			  <#else>
			      <td align=left valign=top>
				 	  ${flag}${node.name}
				  </td>
				  <td align=left valign=top>
					  <#list node.getRoles()?sort_by("sortNob") as role>
					      
					      <span id=${role.id} style="color:green">
					          <#list role.getRolegroups() as rolegroup>
		 						  ${rolegroup.name} 
				              </#list>				        
					      </span>
					      <span title="${role.getUsers()?size}人"><#list role.getUsers() as u>${u.name} &nbsp;&nbsp</#list></span>
					      <br>
					  </#list>
				  </td>
			  </#if>
		   
		  </#if>	
		  </tr>		  
		  <#if !(node.getChildOrganizes()?size<1)> 
		      <@digui_orgnaize_h node.getChildOrganizes()?sort_by("id") ,flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp" ,type/>	
		  </#if>
	</#list> 
</#macro>

<#macro view_user_list   rolegroup   url>
  	  <#if rolegroup.getRoles()?sort_by("sortNob")?size<1 >					  	  
	  <#else>	
  	      <ul>
	 		  <#list rolegroup.getRoles()?sort_by("sortNob") as role>
	 			  <li>
				  	  <div class="section">${role.name}(${role.getUsers()?size}人)
				  	     <br>
				  	      <#list role.getChildRoles() as role>
			 	  	         	${role.name}
			 	  	      </#list>
			 	  	      <#-- -->
			 	  	      <br>
			 	  	      <#list role.getUsers() as u>
			 	  	          <#if url=="">
			 	  	           		${u.name}
			 	  	          <#else>
			 	  	               <a href="${url}${u.id}" target=_blank> ${u.name}</a>
			 	  	          </#if>
			 	  	      <br>
			 	  	      </#list>
			 	  	     
				  	  </div>  
	              </li>
              </#list>
          </ul> 	
	  </#if>
</#macro>

<#macro view_role_list   rolegroup   url>
  	  <#if rolegroup.getRoles()?sort_by("alias")?size<1 >		
  	      职位空缺			  	  
	  <#else>	
  	      <ul>
	 		  <#list rolegroup.getRoles()?sort_by("alias") as role>
	 			  <li>
				  	  <div class="section">
				  	   <a href="${url}${role.id}" target=_blank> ${role.name}</a>
			 	  	  </div>  
	              </li>
              </#list>
          </ul> 	
	  </#if>
</#macro>


<#macro digui_role_v treeNodes  flag >
		<#list treeNodes as role>
			<li><div>&nbsp;</div></li>
		    <li>			  
			  <#if flag==""> 
				 <div class="section" style="color:green;"><b>${role.name}</b></div>  
			  <#else>
			  	  <div class="section" style="color:green;">  
			  	      <a href="#"  target=_blank >	
 					 	${role.name}</a>
 				  </div>  
			  </#if>
	  		</li>
			<#if !(role.getChildRoles()?size<1)> 
			    <ul>
			        <@digui_role_v role.getChildRoles()?sort_by("id") ,flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"/>	
			    </ul>
			</#if>
		</#list> 
	
</#macro>




<style type="text/css">
<!--
body {background: none;font-size:12px;}

ul {clear: left;margin: 0px 0px 0px;padding: 0px;background: #fff;}
ul ul {border-top: 1px solid green;}
ul.solo {border-top: 0;}
li {float: left;list-style: none;position: relative;}
li li {margin: -1px 0 0 0;}
div {}
div.section {padding: 1px 5px;}
div.first {background: url(images/first.gif) 50% repeat-y;margin-left: 0;}
div.last {background: url(images/last.gif) 50% repeat-y;margin-right: 0;}
div.root {padding-top: 0;}
/*IE 6 (when comma-separated, IE6 didn't work, so these are duped for IE7)*/
*html  {text-align: center;}
*html  a {margin: 0; position: relative;}
/*IE 7*/
*:first-child+html  {text-align: center;}
*:first-child+html  a {margin: 0; position: relative;}
-->
</style>

