<#include "../../../common/freemarker/include_header.ftl">
<form name="form_item" action="exam_exam_complete_task.do" method="post">
<input type="hidden" value="<#if rhs.method?exists >${rhs["method"]}</#if>" name="method" />
<input type="hidden" value="<#if rhs["task"]?exists >${rhs["task"].id}</#if>" name="taskId" />
<input type="hidden" value="<#if rhs["paper"]?exists >${rhs["paper"].id}</#if>" name="paperid" />
<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong>Input Reason</strong></div>
      <div class="panel-body">
      	<table class="table table-condensed table-bordered table-striped">
      		<tr><td colspan="4"><font color="red"><strong>由于您上次该试卷没有正常完成，导致考试失败，请输入失败理由</strong></font></td></tr>
      		<tr>
      			<td width="100px;"><strong>试卷名称</strong></td>
      			<td width="300px;"><#if rhs["paper"]?exists > ${rhs["paper"].name}</#if></td>
      			<td width="100px;"><strong>考试成绩</strong></td>
      			<td>0</td>
      		</tr>
      		<tr>
      			<td><strong>失败理由</strong></td>
      			<td colspan="3">
      				<textarea name="reason" style="width:400px;height:90px;"> </textarea>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="4"><input type="button" class="btn btn-xs btn-info" value="Save" id="submitButton"/></td>
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