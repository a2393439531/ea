<#if rhs["task"].assignee?exists >
							<button type="submit" class="btn btn-xs btn-warning" 
							>完成</button>
						</#if>
							<button type="button" class="btn btn-xs btn-warning" 
							onclick="javascript:document.location.href = 'common_activiti_menu_task_list.do';">返回代办任务</button>
							<#if !(rhs["task"].assignee?exists) >
							<a class="btn btn-xs btn-info" href="common_activiti_claim_task.do?taskid=${rhs["task"].id}">
									认领
								</a>
								</#if>