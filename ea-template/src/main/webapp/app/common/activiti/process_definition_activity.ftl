<#include "../../../common/freemarker/include_header.ftl">

<div class="container-fluid">
	<table class="table table-condensed table-hover">
		<thead>
			<tr>
				<th >name</th>
				<th >documentation</th>
				<th >type</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
		<#list rhs["list"] as item>
			<tr>
				<td>${item.properties["name"]?if_exists}</td>
				<td>${item.properties["documentation"]?if_exists}</td>
				<td>${item.properties["type"]?if_exists}</td>
				<td><a href='activiti_form_field_readonly.do?pdId=1&activityName=${item.properties["name"]}'>配置表单字段</a></td>
			</tr>
		</#list>
		</tbody>
	</table>
</div>