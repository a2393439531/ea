<#include "../../../common/freemarker/include_header.ftl">

<div class="container-fluid" style="padding:5px">
<form id="completeForm" method="post" action="manager_wfdemo_complete_task.do">

      <div class="panel panel-default">
       
        <div class="panel-heading"><strong>任务处理界面</strong></div>
        <div class="panel-body">
			<table class="table table-condensed ">
				<thead>
				<tr>
					<td ><strong>任务名称:</strong></td>
					<td>${rhs["task"].name}</td>

					<#--<th >Process Key</th>
					<th >Deployment Date</th>-->					
				</tr>
				</thead>
				<tbody>
				<#list rhs["nextTaskList"] as item>
					<tr>
						<td title="如果为空，则说明任务没有分配到人，需要 返回代办任务栏中认领任务"><strong>任务执行人:</strong></td>
						<td>${rhs["task"].assignee?if_exists}
						<#--
							<select  style="width:200px" onchange="alert(this.value)">
						   		<option   value="">${rhs["task"].assignee?if_exists}</option> 
						   		<optgroup label="所有员工">
						   		<option   value="all">所有员工</option> 
						   		<@digui_candidategroup_by_organize rhs["organizeRootList"]?sort_by('sortNob'),"" />	  
						   		<@digui_candidategroup_by_rolegroup rhs["rolegroupRootList"]?sort_by('sortNob'),"" />	
							</select> 
							-->
						</td>
						<input type="hidden" value="${rhs["task"].id}" name="taskid" />
						<input type="hidden" value="${rhs["task"].assignee?if_exists}" name="taskAssigneeName" />
					</tr>
					<#if rhs["model"]?exists >
					<tr>
						<td><strong>借款额度:</strong></td>
						<td><input type="text" value="${rhs["model"].name?if_exists}" name="name" /></td>
					</tr>
					</#if>
					<tr>
						<td colspan="2">
						
						</td>
					</tr>
					</#list>
				</tbody>
			</table>
			<#include "../../../common/freemarker/include_activiti_complete_button.ftl">
        </div>
      </div>



			</form>
</div>