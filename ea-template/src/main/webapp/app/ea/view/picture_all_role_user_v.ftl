<#include "../../../common/freemarker/include_header.ftl">
<#include "macro_view.ftl">
<#--显示职位架构-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script language="javascript" src="<@context_module/>view_organize.js"></script>
<body>
<span style="color:green"></span>
	<div class="zz">
		<script language="javascript"> 
			var n1=new OrgNode();
			n1.Text="<b>组织架构</b>";
			n1.Text="<@frame '组织架构' />";
			n1.Description="组织架构根节点";
			n1.Link="";
			<#list rhs["roleGroupRootList"]?sort_by("sortNob") as rolegroup>
			     var rolegroup${rolegroup_index+1}=new OrgNode();
				 rolegroup${rolegroup_index+1}.Text="<@frame rolegroup.name?if_exists />";
				 rolegroup${rolegroup_index+1}.Description=""
				 rolegroup${rolegroup_index+1}.Link="";
				 n1.Nodes.Add(rolegroup${rolegroup_index+1});
				<#list rolegroup.getChildRolegroups() as subrolegroup>
					<@digui_role_v subrolegroup.RootRoles()?sort_by("sortNob"),'rolegroup'+(rolegroup_index+1),30/>
				</#list>
			</#list>
			<@draw/>
		</script>
	</div>	    
</body>