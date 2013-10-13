<#include "macro_organize_input.ftl">

<table    class="table  table-condensed" style="width:1000px">
     <thead>
		<tr>
			<th>组织架构</th><th>操作</th>
		</tr>
	</thead>   
   
<@digui_organize rhs["organizeRootList"]?sort_by('sortNob'),rhs,"" />	
</table>
<span id="div_action_result" style="display:none">${rhs["info"]?if_exists}</span>

