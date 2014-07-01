
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
	"praiseNumber": "${x.praisenumber?if_exists}",
	"fecesNumber": "${x.fecesnumber?if_exists}",
	"praiseDate": "${x.praiseDate?if_exists}",
	"praiseDays": "<#if x.praiseDate?exists>${javacall["com.utils.time.TimeUtil"].getHowManyDayFromNow("${x.praiseDate?if_exists}")}</#if>",
	"fecesDate": "${x.fecesDate?if_exists}",
	"fecesDays": "<#if x.fecesDate?exists>${javacall["com.utils.time.TimeUtil"].getHowManyDayFromNow("${x.fecesDate?if_exists}")}</#if>",
	
	"order": ""
	
}
<#if x_index+1 < rhs["datalist"]?size>,</#if>
</#list>
]


