<#include "../../../common/freemarker/include_header.ftl">
<script>
$("#loading_next_tasks_div", parent.document.body).css("display","none");
var h = "";
<#if rhs["list"]?size gt 1 >
h = "<div>This task requires many parallel execution.</div>";
</#if>
<#list rhs["list"] as item>
	<#if item.taskType == 'endEvent'>
		
	    h += '<div class="input-append">' +
			 '</div>';
	<#else>
	   
		h += '<div><input type="hidden" id="${item.taskAssigneeName?if_exists}" name="${item.taskAssigneeName?if_exists}"/>' +
			 '<div class="input-append">' +
			 '<input type="text" class="input-small" id="${item.taskAssigneeName?if_exists}Text" onclick="javascript:open_select_users_dialog(document.getElementById(\'${item.taskAssigneeName?if_exists}Text\'),document.getElementById(\'${item.taskAssigneeName?if_exists}\'),1);" />' +
			 '</div>' +
			 '</div>';
	</#if>
</#list>

$("#select_users_div", parent.document.body).append(h);
</script>