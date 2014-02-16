<#include "../../../common/freemarker/include_header.ftl">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<link href="view/view.css" rel="stylesheet">

<script language="javascript" src="view/view_organize.js"></script>
<#include "macro_view.ftl">	
<#include "include_highslide.ftl">
<#include "include_highslide_rolegroup.ftl">	
<#include "include_display_info.ftl">	

<br>
<div class="zz" >

<script language="javascript"> 
	var n1=new OrgNode();
	n1.Text="<@roletext rhs["role"] />";
	n1.Description="管理人数${rhs["role"].allUserUnderRole()?size}";
	n1.Link="#";
	n1.BoxHeight=2; 
	<#list rhs["role"].getChildRoles() as role>
		     var role${role_index+1}=new OrgNode();
			 role${role_index+1}.Text="<@roletext role />";
			 role${role_index+1}.Description="管理人数${role.allUserUnderRole()?size}"
			 role${role_index+1}.Link="view_organize_node_view_v.do?id=${role.id}&width=${RequestParameters["width"]}&height=${RequestParameters["width"]}&img=${RequestParameters["img"]}";
			 n1.Nodes.Add(role${role_index+1});
		<@digui_role_v role.getChildRoles()?sort_by("sortNob"),'role'+(role_index+1),80/>
	</#list>
	<@draw/>

</script>
</div>	    