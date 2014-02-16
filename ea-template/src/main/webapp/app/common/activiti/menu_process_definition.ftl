<#include "../../../common/freemarker/include_header.ftl">
<script>
$(function() {
	$( "#tabs" ).tabs();
});
</script>
 
<div id="tabs">
	<ul>
	    <li><a href="#tabs-1">Process</a></li>
	    <li><a href="common_activiti_menu_deployment.do">Upload</a></li>
	</ul>
	<div id="tabs-1">
		<div class="container-fluid">
			<table class="table table-condensed table-hover">
				<thead>
				<tr>
					<th >Process Name</th>
					<th width="40">Version</th>
					<th >Description</th>
					<th >Process Id</th>
					<th >Process key</th>
					<th width="60">Diagram</th>
				</tr>
				</thead>
				<tbody>
				<#list rhs["list"] as item>
					<tr title="file${item.resourceName}">
						<td>${item.name}</td>
						<td>${item.version}</td>
						<td>${item.getDescription()?if_exists}</td>
						<td>${item.id}</td>
						<td>${item.key}</td>
						<td>
							<a href="common_activiti_process_diagram.do?processDefinitionId=${item.id}" title="${item.diagramResourceName?if_exists}" target=_blank> Open</a>
							<#--<a href="common_activiti_process_definition_activity.do?processDefinitionId=${item.id}"> activity</a>-->
						</td>
					</tr>
				</#list>
				</tbody>
			</table>
		</div>
	</div>
</div>