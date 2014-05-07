<#list rhs["datalist"] as paper>
	<a href="#" onclick="javascript:ajax_show_paper('exam_paper_load.do','method=show&id=${paper.id}');" >${paper.name}</a><br/>
	<input type="hidden" name="paperid" value="${paper.id}">
</#list>