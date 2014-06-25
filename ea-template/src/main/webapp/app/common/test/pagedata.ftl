[
{"maxSize" : "${rhs["maxSize"]?if_exists}", "currentPage":"${rhs["currentPage"]?if_exists}","maxPage": "${rhs["maxPage"]?if_exists}", "count": "${rhs["count"]?if_exists}"}
<#list rhs["dataList"] as x>
,{"id": "${x.id?if_exists}", 
"content": "${x.content?if_exists}"
}
</#list>
]