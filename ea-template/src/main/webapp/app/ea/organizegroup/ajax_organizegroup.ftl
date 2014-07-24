<#include "macro_organizegroup.ftl">
<#include "../../../common/freemarker/include_custom.ftl">

<table class="table table-condensed" style="width:1000px">
     <thead>
		<tr>
			<th>分组</th><th>操作</th>
		</tr>
	</thead>   
    
<@digui_organizegroup rhs["organizegroupRootList"]?sort_by('sortNob'),"" />	

</table>
<span id="div_action_result" style="display:none" class="small text-${rhs["info_type"]?if_exists} ">
	${rhs["info"]?if_exists}
</span>