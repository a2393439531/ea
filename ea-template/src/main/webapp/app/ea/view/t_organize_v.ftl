
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<#include "../../../common/freemarker/include_header.ftl">
<script language="javascript" src="app/ea/view/view_organize.js"></script>
<#include "macro_view.ftl">

<@digui_organize_win organizeRootList?sort_by('sortNob') />
	<div class="zz">
		<script language="javascript"> 
			var n1=new OrgNode();
			n1.Text="<@frame rootname />";
			n1.Description="";
			n1.Link="";
			<@digui_organize_v organizeRootList?sort_by('sortNob'),"n1" ,show/>
			<@draw/>
		</script>
	</div>	    
</body>
