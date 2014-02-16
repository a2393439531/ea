<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>rolegroup.js"></script>
<div style="padding:15px">
	<a herf="#" onclick="javascript:action_rolegroup('create.do','id=root');">添加根节点</a>
	<hr>
	<div id=div_rolegroup_tree>
		<#include "ajax_rolegroup.ftl">
	</div>
</div>