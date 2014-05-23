<#--<#list rhs["datalist"] as paper>
	<a href="#" onclick="javascript:ajax_show_paper('exam_paper_load.do','method=show&id=${paper.id}');" >${paper.name}</a><br/>
	<input type="hidden" name="paperid" value="${paper.id}">
</#list>-->
<#include "macro_papergroup_input.ftl">
<#if rhs["papergroup"].getPapers()?exists>
	<div style="height:150px;overflow:auto;" id="paperid">
			<@digui_papergroup rhs["papergroup"].getPapers()?sort_by("sortNob"),'${rhs["readonly"]?string}',rhs["papergroup"] />
	</div>
</#if>