<#macro digui_rolegroup_v treeNodes  flag type  objectname="Rolegroup">
   	<#list treeNodes as rolegroup>
			<li><div>&nbsp;</div></li>
		    <li>			  
			  <#if flag==""> 
				 <div class="section" style="color:green;"><b>${rolegroup.name}</b></div>  
			  <#else>
			  	  <div class="section" style="color:green;">  
			  	  <#if objectname=="Rolegroup"&&(type=="position"||type=="kpi")>  <#--岗位职责和KPI-->
			  	      <a href="ea_ea_edit_bean_property.do?objectname=${objectname}&id=${rolegroup.id?if_exists}&op=r&propertyname=${type}description" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" >	
 					 	${rolegroup.name}</a>
 				  <#else>
 				  	   ${rolegroup.name}
				  </#if>			  	
				    
			  	  </div>  
			  	  <#if type=="view_postion"> 
				  </#if>	

			  	  <#if objectname=="Role"&type=="view_role"> 
			  	      <@view_role_list rolegroup  ,""/>
			  	  </#if>
			     <#if objectname=="Role"> 
			  	      <#assign url ="ea_ea_edit_bean_property.do?objectname=Role&op=r&propertyname=positiondescription&id=">
			  	  	  <@view_role_list rolegroup  ,url/>
			  	  </#if>
	
			  	  <#if type=="view_user_handbook_define"> 
			  	      <#assign url ="ea_ea_edit_bean_property.do?objectname=User&op=r&propertyname=positiondescription&id=">
			  	  	  <@view_user_list rolegroup  ,url/>
				  </#if>	
			  	  <#if type=="view_user_handbook"> 
			  	        <#assign url ="ea_menu_view_user_handbook.do?id=">
			  	  	  <@view_user_list rolegroup  ,url/>
				  </#if>
			  	  <#if type=="view_user_kpi_define"> 
			  	      <#assign url ="ea_edit_bean_property.do?objectname=User&op=r&propertyname=kpidescription&id=">
			  	  	  <@view_user_list rolegroup  ,url/>
				  </#if>	

			  	  <#if type=="view_user_handbook_detail"> 
			  	        <#assign url ="ea_menu_view_user_handbook_detail.do?id=">
			  	  	  <@view_user_list rolegroup  ,url/>
				  </#if>
			  </#if>
	  		</li>
			<#if !(rolegroup.getChildRolegroups()?size<1)> 
			    <ul>
			        <@digui_rolegroup_v rolegroup.getChildRolegroups()?sort_by("id") ,flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;", type, objectname/>	
			    </ul>
			</#if>
		</#list> 
	
</#macro>

<link href="/apm/common/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/apm/common/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">

<style type="text/css">
<!--
body {background: none;font-size:12px;}
	* {font-family:inherit,Arial,verdana,tahoma;margin:0px;padding:0px;line-height:20px;
		font-size:12px;
	}

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
<#include "../../../common/freemarker/macro_common.ftl">
<link rel="stylesheet" type="text/css" href="<@context/>common/highslide/highslide.css" />
<script type="text/javascript"          src="<@context/>common/highslide/highslide-with-html.js"></script>
<script type="text/javascript" >
	hs.graphicsDir = '<@context/>common/highslide/graphics/';
	hs.outlineType = 'rounded-white';
	hs.wrapperClassName = 'draggable-header';
	hs.minWidth=700;
	hs.minHeight=750;
	hs.Height=750;
	
	
</script>	
<div style="padding:10px">
<ul>  
	<li>
		<div ><b>岗位说明编辑</b></div> 
		<ul>  
		    <@digui_rolegroup_v rhs["roleGroupRootList"],"","position"/>	
		</ul>
    </li>
</ul>  
</div>






