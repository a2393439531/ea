<#include "../../../common/freemarker/include_header.ftl">
<#include "../../../common/freemarker/include_select_users.ftl">
<div class="container-fluid" style="border: 1px solid;">
<form id="completeForm" method="post" action="manager_wfproduct_complete_task.do">
			<div class="panel panel-default">
       
        <div class="panel-heading"><strong>任务处理界面</strong></div>
        <div class="panel-body">
			<table class="table table-condensed table-hover">
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
						<td id="selectUser">
						<#if (item != "endevent1")>
							<#if (item != "exclusivegateway1")>
        						
        						<input type="hidden" id="assignee" name="taskAssigneeName" value="${rhs["task"].assignee?if_exists}"/>
								<input type="text" class="input-small" id="assigneeText" value="${rhs["task"].assignee?if_exists}"
								onclick="javascript:open_select_users_dialog(document.getElementById('assigneeText'),document.getElementById('assignee'),1);" />
							<#else>
							<div id="assigneediv1">
						
        						<select id="assignee1" style="width:200px" onchange="" name="taskAssigneeName">
						   			<option   value="">${rhs["task"].assignee?if_exists}</option> 
						   			<optgroup label="所有员工">
						   			<option   value="all">所有员工</option> 
						   			<@get_candidategroup_by_organize rhs["organizeRootList"]?sort_by('sortNob'),"" />	  
						   			<@get_candidategroup_by_rolegroup rhs["rolegroupRootList"]?sort_by('sortNob'),"" />	
								</select>
							</div>
							<div id="assigneediv2" style="display:none;">
							
        						<input type="hidden" id="assignee2" name="" value="${rhs["task"].assignee?if_exists}"/>
								<input type="text"  class="input-small" id="assigneeText1" value="${rhs["task"].assignee?if_exists}"
								onclick="javascript:open_select_users_dialog(document.getElementById('assigneeText1'),document.getElementById('assignee1'),1);" />
							</div>
						</#if>
						<#else>
							${rhs["task"].assignee?if_exists}
						</#if>
						</td>
						<input type="hidden" value="${rhs["task"].id}" name="taskid" />
					</tr>
					<#if rhs["model"]?exists >
					<tr>
						<td><strong>产品名称：</strong></td>
						<td><input type="text" value="${rhs["model"].name?if_exists}" name="name" /></td>
					</tr>
					<tr>
						<td><strong>产品用途：</strong></td>
						<td><input type="text" value="${rhs["model"].purpose?if_exists}" name="purpose" /></td>
					</tr>
					<tr>
					<#if (item == "exclusivegateway1")>
						<td><strong>审批：</strong></td>
						<td>
							<select  style="width:200px" onchange="javascript:setSelect(this.value);" name="approve">
						   	<option   value="true">批准</option>
						   	<option   value="false">驳回</option> 
						   </select> 
						</td>
					</#if>
					
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
<script type="text/javascript">
function setSelect(value){
	if (value == "true") {
		$("#assigneediv1").attr("style","display:block");
		$("#assigneediv2").attr("style","display:none");
		$("assignee1").attr("name","taskAssigneeName");
		$("assignee2").attr("name","");
		
	}else {
		//document.getElementById('selectUser').innerHTML="驳回给:<input type='text' id='assignee' name='taskAssigneeName' value='${rhs['initiator']?if_exists}'/>";
		$("#assigneediv1").attr("style","display:none");
		$("#assigneediv2").attr("style","display:block");
		$("assignee1").attr("name","");
		$("assignee2").attr("name","taskAssigneeName");
	}
}
</script>