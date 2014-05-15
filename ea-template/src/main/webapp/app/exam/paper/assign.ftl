<#include "../../../common/freemarker/include_header.ftl">
<#include "../../../common/freemarker/include_select_users.ftl">

<form name="form_item" action="exam_exam_complete_task.do" method="post">
<input type="hidden" value="<#if rhs.method?exists >${rhs["method"]}</#if>" name="method"/>
<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong>Assigning User Join Exam</strong></div>
      <div class="panel-body">
      	 <table class="table table-condensed table-bordered table-striped">
      		<tr>
      			<td>试卷名称: <#if rhs["paper"]?exists > ${rhs["paper"].name?if_exists} </#if></td>
      			<input type="hidden" value="<#if rhs["paper"]?exists >${rhs["paper"].id?if_exists}</#if>" name="paperid" />
      		</tr>
      		<tr>
      		<td>选择考试人: 
      			<input type="hidden" id="assignee" name="assignee"/>
				<input type="text" class="input-small" id="assigneeText" 
					onclick="javascript:open_select_users_dialog(document.getElementById('assigneeText'),document.getElementById('assignee'),2);" />
      			</td>
      		</tr>
      		<#if rhs["autojudge"]?exists>	
      		<tr>
      			<td>选择阅卷人: 
      			<input type="hidden" id="judge" name="judge"/>
				<input type="text" class="input-small" id="assigneejudgeText" 
					onclick="javascript:open_select_users_dialog(document.getElementById('assigneejudgeText'),document.getElementById('judge'),1);" />
      			</td>
      			<input type="hidden" value="${rhs["autojudge"]?string}" name="autojudge" />
      		</tr>
      		</#if>
      		<tr>
      			<td><input type="button" class="btn btn-xs btn-info" value="Save" id="submitButton"/></td>
      		</tr>
      	</table>
      
      </div>
</div>
</form>
<script>
	$('#submitButton').click(function () {
		var btn = $(this);
		btn.button('loading');
		$('#dialog').dialog('open');
		document.getElementsByName("form_item")[0].submit();
	});
</script>