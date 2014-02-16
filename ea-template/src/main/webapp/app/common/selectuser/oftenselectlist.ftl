[
<#list rhs["dataList"]?sort_by("count")?reverse as x>
	<#if x_index+1 == rhs["dataList"]?size>
		{"id":"${x.id}","pId":"1","account":"${x.selectedUserAccount}","name":"${x.selectedUserName}"}
	<#else>
		{"id":"${x.id}","pId":"1","account":"${x.selectedUserAccount}","name":"${x.selectedUserName}"},
	</#if>
</#list>	
]