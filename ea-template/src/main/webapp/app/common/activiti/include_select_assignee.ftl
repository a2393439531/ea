
	<#include "../../../common/freemarker/include_select_users.ftl">
	<div id="assignee_div" class="control-group">
		<div style="display:none;">
			<iframe src="common_activiti_next_tasks.do?taskId=${rhs.task.id}"></iframe>
		</div>
		<label style="float:left; margin-right:8px;" class="control-label" for="assigneeText">Select Assignee:</label>
		<div class="controls">
			<div id="loading_next_tasks_div" style="display:block;"><img src="<@context/>image/loading.gif"/></div>
			<div id="select_users_div"></div>
		</div>
	</div>  