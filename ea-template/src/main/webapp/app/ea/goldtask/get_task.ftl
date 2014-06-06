
[
<#list rhs["datalist"] as x>
{
	"id": "${x.id?if_exists}", 
	"title": "${x.title?if_exists}",
	"detail": "${x.detail?if_exists}",
	"endDate": "${x.endDate?if_exists}",
	"goldNumber": "${x.goldNumber?if_exists}",
	"usrAccount": "${x.usrAccount?if_exists}",
	"usrAccountArray": "${x.usrAccountArray?if_exists}",
	"bidUsrAccount": "${x.bidUsrAccount?if_exists}"
	
}
<#if x_index+1 < rhs["datalist"]?size>,</#if>
</#list>
]


