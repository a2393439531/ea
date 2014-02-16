<#include "../../../common/freemarker/include_header.ftl">

<script>
$(function() {
	$("#tabs").tabs();
});
</script>
<div id="tabs">
	<#--<ul>
	    <li><a href="#tabs-1">Candidate Task</a></li>
	    <li><a href="common_activiti_menu_task_list.do" target=org-right>Current Task</a></li>
	    <li><a href="common_activiti_menu_history_task_list.do" >History Task</a></li>
	</ul>-->
	<div id="tabs-1">
		<div class="container-fluid">
			<table class="table table-condensed table-hover">
				<thead>
				<tr>
					<th width=25px>#</th>
					<th >Initiator</th>
					<th >Handle Task </th>
					<#---->
					<th >Task title</th>
					
					<th >Create Time</th>
					<th >Status</th>
					<th >Operate</th>
				</tr>
				</thead>
				<tbody>
				<#list rhs["candidateoatasklist"] as item>
					<tr>
						<td>${item_index+1}</td>
						<td><@getName item.initiator/></td>
						<td><a href="${item.handleTaskUrl?if_exists}&taskId=${item.task.id}">
						${item.busiDesc?if_exists}
						${item.task.name?if_exists}</a></td>
						<#---->
						<td>
							${item.task.description?if_exists}: <#if item.businessModel?exists>${item.businessModel.title?if_exists}</#if>
						</td>
						
						<td>${item.task.createTime?datetime}</td>
						<td align="center">
							<a href="common_activiti_process_diagram.do?processInstanceId=${item.task.processInstanceId}" target=_blank>
								View
							</a>
						</td>
						<td><a href="common_activiti_claim_task.do?taskid=${item.task.id}">Claim</a></td>
					</tr>
				</#list>
				</tbody>
			</table>
			<form action="common_activiti_menu_task_list.do" id="search_form" method="post" style="display:none;">
				<input type="hidden" name="search" value="search">
				<input type="hidden" name="pageId" id="pageId">
				<input type="hidden" name="maxSize" id="pageMaxSize">
			</form>
			<#include "../../../common/freemarker/macro_pagination.ftl">
			<@pagination  "search_form" />
		</div>
	</div>
</div>
