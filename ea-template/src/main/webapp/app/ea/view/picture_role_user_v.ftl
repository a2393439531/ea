<#include "../../../common/freemarker/include_header.ftl">
<#include "macro_view.ftl">


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script language="javascript" src="<@context_module/>view_organize.js"></script>
<body>
<span style="color:green"></span>
	<div class="zz">
		<script language="javascript"> 
			var n1=new OrgNode();
			n1.Text="<@roletext rhs["role"] />";
			n1.Description="根节点";
			n1.Link="";
			<@digui_role_v rhs["role"].getChildRoles()?sort_by("sortNob"),"n1" ,30/>
			<@draw/>
		</script>
	</div>	    
</body>