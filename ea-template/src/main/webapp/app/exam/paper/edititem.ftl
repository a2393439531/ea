<#if rhs["page"] == "setpaper">
	<#include "show_paper.ftl">
</#if>
<#if rhs["page"] == "setitem">
	<#include "show_template.ftl">
</#if>
<#if rhs["page"] == "editpage">
	<#include "list.ftl">
</#if>