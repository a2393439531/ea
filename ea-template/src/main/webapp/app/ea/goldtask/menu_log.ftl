{"options":[
<#if rhs["datalist"]?exists>
<#list rhs["datalist"] as x>
"${x?if_exists}"
<#if x_index+1 < rhs["datalist"]?size>,</#if>
</#list>
</#if>
]
}