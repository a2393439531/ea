<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>organize.js"></script>
<div style="padding:20px">
	<a  onclick="javascript:action_organize('create.do','id=root');">添加根节点</a>
	<a  href="ea_organizegroup_menu_organizegroup.do" target="_blank">分类定义</a>
	<a  href="ea_ea_menu_organize_to_organizegroup.do" target="_blank">类别关联</a>
	<a  href="ea_extp_menu_extp.do?modelname=Organize" target="_blank">扩展属性</a>

<hr>
<div id=div_organize_tree>
	<#include "ajax_organize.ftl">
</div>
</div>