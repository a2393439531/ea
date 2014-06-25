
[
<#list rhs["datalist"] as x>
{
	"id": "${x.id?if_exists}",
	"account": "${x.account?if_exists}", 
	"name": "${x.name?if_exists}",
	"goldNumber": "${x.goldnumber?if_exists}",
	"phoneNumber": "${x.phoneNumber?if_exists}",
	"email": "${x.email?if_exists}",
	"qq": "${x.qq?if_exists}",
	"parentModel":{
		"account": 	"<#if x.parentModel?exists>${x.parentModel.account?if_exists}</#if>"
	},
	"order": ""
	
}
<#if x_index+1 < rhs["datalist"]?size>,</#if>
</#list>
]


