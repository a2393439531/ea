<#list rhs["datalist"] as item>
	<a href="#" onclick="javascript:ajax_show_item('exam_item_load.do','method=show&id=${item.id}');" >${item.content}</a><br/>
	<#if rhs["itemtype"] == "1" >
		<input type="hidden" name="reqsinglechoice" value="${item.id}">
	</#if>
	<#if rhs["itemtype"] == "2" >
		<input type="hidden" name="reqmultichoice" value="${item.id}">
	</#if>
	<#if rhs["itemtype"] == "3" >
		<input type="hidden" name="reqblank" value="${item.id}">
	</#if>
	<#if rhs["itemtype"] == "4" >
		<input type="hidden" name="reqessay" value="${item.id}">
	</#if>
</#list>