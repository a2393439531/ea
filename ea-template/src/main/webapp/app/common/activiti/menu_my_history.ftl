<#include "../../../common/freemarker/include_header.ftl">
<table width="100%">
	<caption>MyHistory</caption> 
	<tr>
		<th >Id</th>
		<th >StartUser</th>
		<th >StartTime</th>
		<th >EndTime</th>
		<th >ProcessDefinitionId</th>
		<th ></th>
	</tr>
	<#list rhs["list"] as item>
		<tr>
			<td>${item.id}</td>
			<td>${item.startUserId}</td>
			<td>${item.startTime?datetime}</td>
			<td>${item.endTime?datetime}</td>
			<td>${item.processDefinitionId}</td>
			<td></td>
		</tr>
	</#list>
</table>