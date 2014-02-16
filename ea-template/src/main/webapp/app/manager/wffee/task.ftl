<#include "../../../common/freemarker/include_header.ftl">
<#include "../../../common/freemarker/include_header.ftl">
<#include "../../../common/freemarker/include_select_users.ftl">
<div class="container-fluid">
<form id="completeForm" method="post" action="manager_wffee_complete_task.do">
	<div class="panel panel-default">
       
        <div class="panel-heading"><strong>任务处理界面</strong></div>
        <div class="panel-body">
          
			<table class="table table-condensed table-hover">
				<thead>
				<tr>
					<td ><strong>任务名称:</strong></td>
					<td>${rhs["task"].name}</td>				
				</tr>
				</thead>
				<tbody>
				<#list rhs["nextTaskList"] as item>
					<tr>
						<td title="如果为空，则说明任务没有分配到人，需要 返回代办任务栏中认领任务"><strong>任务执行人:</strong></td>
						<td>
						<#if (item != "endevent1")>
        						下一步执行人:
        						<input type="hidden" id="assignee" name="taskAssigneeName" value="${rhs["task"].assignee?if_exists}"/>
								<input type="text" class="input-small" name="assigneeText" id="assigneeText" value="${rhs["task"].assignee?if_exists}"
								onclick="javascript:open_select_users_dialog(document.getElementById('assigneeText'),document.getElementById('assignee'),1);" />
						<#else>
							当前执行人:
							${rhs["task"].assignee?if_exists}
						</#if>
						</td>
						<input type="hidden" value="${rhs["task"].id}" name="taskid" />
						<#--<input type="hidden" value="${rhs["task"].assignee?if_exists}" name="taskAssigneeName" />-->
					</tr>
					<#if rhs["model"]?exists >
					<tr>
						<td><strong>报销金额</strong></td>
						<td><input type="text" value="${rhs["model"].count?if_exists}" name="count" /></td>
					</tr>
					</#if>
					<tr>
						<td colspan="1">
						<#include "../../../common/freemarker/include_activiti_complete_button.ftl">
						</td>
					</tr>
					</#list>
				</tbody>
			</table>
        </div>
      </div>
			
			
			</form>
</div>