<#include "../../../common/freemarker/include_header.ftl">
<#include "../organize/macro_organize.ftl">
<div class="capabilityTitle">员工信息完整性统计</div>
<span id=div_person_deploy_info></span>
<div style="padding:10px">
	<table id=panle_role>
		<tr>
			<@digui_orgnaize rhs["organizeRootList"],"","map_regedit_list"/>
		</tr>
	</table>
</div>
