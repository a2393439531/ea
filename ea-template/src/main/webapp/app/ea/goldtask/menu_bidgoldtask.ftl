[
{"maxSize" : "${rhs["maxSize"]?if_exists}", "currentPage":"${rhs["currentPage"]?if_exists}","maxPage": "${rhs["maxPage"]?if_exists}", "count": "${rhs["count"]?if_exists}"}
<#list rhs["dataList"] as x>
,{"id": "${x.id?if_exists}", 
"title": "${x.title?if_exists}", 
"detail": "${x.detail?if_exists}", 
"goldNumber": "${x.goldNumber?if_exists}", 
"endDate": "${x.endDate?if_exists}", 
"usrAccount": "${x.usrAccount?if_exists}", 
"usrAccountArray": "${x.usrAccountArray?if_exists}",
"createDate":"${x.createDate?if_exists}",
"createDateYMD":"${x.createDateYMD?if_exists}", 
"bidUsrAccount" : "${x.bidUsrAccount?if_exists}"
}
</#list>
]