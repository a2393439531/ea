[
<#list rhs["datalist"] as x>
{"account": "${x.account?if_exists}", "name": "${x.name?if_exists}"}
<#if x_index+1 < rhs["datalist"]?size>,</#if>
</#list>
]