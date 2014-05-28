[
<#list rhs["datalist"] as x>
{"id": "${x.id?if_exists}", 
"goldNumber": "${x.goldNumber?if_exists}",
"toUsrAccount": "${x.toUsrAccount?if_exists}",
"fromUsrAccount": "${x.fromUsrAccount?if_exists}",
"payRemarks": "${x.payRemarks?if_exists}",
"payDate": "${x.payDate?if_exists}",
"payDateYMD": "${x.payDateYMD?if_exists}"
}
<#if x_index+1 < rhs["datalist"]?size>,</#if>
</#list>
]