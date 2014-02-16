<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>rule.js"></script>

<#macro digui_rule ruleNodes  flag >
	<#list ruleNodes as rule>
	    <tr>
	    	<td width=700px>
	    		<a href=ea_rule_detail.do?id=${rule.id?if_exists} onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" >${flag}${rule.name?if_exists}</a> 
			</td>
		</tr>
		  <#if !(rule.getChildRules()?size<1)> 
		      <@digui_rule rule.getChildRules()?sort_by('sortNob'),flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />	
		  </#if>
	</#list> 
</#macro>

<body style="padding:10px">
	<div id=div_rule_tree class="span11">
 		<table    class="table  table-condensed" style="width:1000px">
		 	<@digui_rule rhs["ruleRootList"]?sort_by('sortNob'),""/>
		</table>
		<span id="div_action_result" style="display:none">
			${rhs["info"]?if_exists}
		</span>
	</div>
</body>