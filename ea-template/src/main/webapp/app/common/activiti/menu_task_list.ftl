<#include "../../../common/freemarker/include_header.ftl">
<div class="panel panel-primary">
       
  <div class="panel-heading">
  	<strong>Process List</strong>
  </div>
  <div class="panel-body">
		<table class="table table-condensed table-hover">
				<thead>
				<tr>
					<td width=25px><strong>#</strong></td>
					<td ><strong>Initiator</strong></td>
					<td ><strong>Handle Task</strong></td>
					<td ><strong>Task title</strong></td>
					<td ><strong>Create Time</strong></td>
					<td ><strong>Diagram</strong></td>
				</tr>
				</thead>
				<tbody>
				<#list rhs["oatasklist"] as item>
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
						<td >
							<a href="common_activiti_process_diagram.do?processInstanceId=${item.task.processInstanceId}" target=_blank>
								View
							</a>
						</td>
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
