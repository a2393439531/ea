<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>resource.js"></script>

<div style="padding:10px">
<a class="btn btn-xs btn-default" onclick="javascript:action_resource('create.do','id=root');">添加根节点</a>
<br><br>

	<table>
		<tr>
			<td valign=top >
				<div id=div_resource_tree>
				    <#include "ajax_resource.ftl">
				</div>
			</td>
			<td valign=top width=350 style="padding:20px">
			
				<div id=ajax_resource></div>
					
			</td>
		</tr>
	</table>
</div>