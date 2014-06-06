
[
<#list rhs["datalist"] as x>
{
	"account": "${x.account?if_exists}", 
	"name": "${x.name?if_exists}",
	"goldNumber": "${x.goldnumber?if_exists}",
	"phoneNumber": "${x.phoneNumber?if_exists}",
	"email": "${x.email?if_exists}",
	"parentModel":{
		"account": 	"<#if x.parentModel?exists>${x.parentModel.account?if_exists}</#if>"
	}
}
<#if x_index+1 < rhs["datalist"]?size>,</#if>
</#list>
]


