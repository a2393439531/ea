<#include "../../../common/freemarker/include_header.ftl">
<#include "../../../common/freemarker/include_custom.ftl">
<script type="text/javascript" src="<@context_module/>organizegroup.js"></script>

<div style="padding:20px">
	<a  onclick="javascript:action_organizegroup('create.do','id=root');">添加根节点</a>
	<hr>
	<div id=div_organizegroup_tree>
		<#include "ajax_organizegroup.ftl">
	</div>
</div>