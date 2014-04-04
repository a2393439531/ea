<#include "../../../common/freemarker/include_header.ftl">
<form name="form_item" action="exam_exam_complete_task.do" method="post">
<input type="hidden" value="<#if rhs.method?exists >${rhs["method"]}</#if>" name="method" />
<input type="hidden" value="<#if rhs["task"]?exists >${rhs["task"].id}</#if>" name="taskId" />
<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong>Start Exam</strong></div>
      <div class="panel-body">
      	<table class="table table-condensed table-bordered table-striped">
      	<tr><td colspan="8"><font color="red"><strong>考试中请勿关闭浏览器，否则会导致考试失败</strong></font></td></tr>
      		<tr>
      			<td><strong>试卷名称</strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].name}</#if></td>
      			<td><strong>考试时间</strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].time}</#if></td>
      			<td><strong>考试总分</strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].totalmark}</#if></td>
      			<td><strong>通过分</strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].passmark}</#if></td>
      		</tr>
      	</table>
      	<#assign i = 0 >
  		<table class="table table-condensed table-bordered table-striped">
		  	<strong>Single Choice</strong>(total:${rhs["template"].singlechoice + rhs["template"].rmdsinglechoice}, each: ${rhs["paper"].singlechoicemark})
		  	<#list rhs["singleitems"]?sort_by("id") as singleitem>
				<tr>
					<td><strong>${singleitem_index+1}.&nbsp;${singleitem.content}</strong></td>
				<tr>
				<#list singleitem.choiceitem?sort_by("id") as choiceitem>
					<tr>
						<td><input type="radio" value="${choiceitem.refid}" name="result[${i}].answer"/> ${choiceitem.value}</td>
					</tr>
				</#list>
				<input type="hidden" value="${singleitem.id}" name="result[${i}].item.id" />
				<input type="hidden" value="${rhs["paper"].singlechoicemark}" name="result[${i}].mark" />
				<#assign i = i + 1 > 
		  	</#list>
      	</table>
      	
      	<table class="table table-condensed table-bordered table-striped">
	      	<strong>Multiple choice</strong>(total:${rhs["template"].multichoice + rhs["template"].rmdmultichoice}, each: ${rhs["paper"].multichoicemark})
	      	<#list rhs["multiitems"]?sort_by("id") as multiitem>
	      		<tr>
					<td><strong>${multiitem_index+1}.&nbsp;${multiitem.content}</strong></td>
				<tr>
				<#list multiitem.choiceitem?sort_by("id") as choiceitem>
					<tr>
						<td><input type="checkbox" value="${choiceitem.refid}" name="result[${i}].answer"/> ${choiceitem.value}</td>
					</tr>
				</#list>
				<input type="hidden" value="${multiitem.id}" name="result[${i}].item.id" />
				<input type="hidden" value="${rhs["paper"].multichoicemark}" name="result[${i}].mark" />
				<#assign i = i + 1 > 
	      	</#list>
      	</table>
      	<table class="table table-condensed table-bordered table-striped">
	      	<strong>Blank</strong>(total:${rhs["template"].blank + rhs["template"].rmdblank}, each: ${rhs["paper"].blankmark})
	      	<#list rhs["blankitems"]?sort_by("id") as blankitem>
	      		<tr>
					<td><strong>${blankitem_index+1}.&nbsp;${blankitem.content}</strong></td>
				<tr>
				<tr>
					<td><input type="text"  name="result[${i}].answer"/></td>
					<input type="hidden" value="${blankitem.id}" name="result[${i}].item.id" />
					<input type="hidden" value="${rhs["paper"].blankmark}" name="result[${i}].mark" />
				</tr>
				<#assign i = i + 1 > 
	      	</#list>
      	</table>
      	<table class="table table-condensed table-bordered table-striped">
	      	<strong>Essay</strong>(total:${rhs["template"].essay + rhs["template"].rmdessay}, each: ${rhs["paper"].essaymark})
	      	<#list rhs["essayitems"]?sort_by("id") as essayitem>
	      		<tr>
					<td><strong>${essayitem_index+1}.&nbsp;${essayitem.content}</strong></td>
				<tr>
				<tr>
					<td><textarea name="result[${i}].answer"> </textarea></td>
					<input type="hidden" value="${essayitem.id}" name="result[${i}].item.id" />
					<input type="hidden" value="${rhs["paper"].essaymark}" name="result[${i}].mark" />
				</tr>
				<#assign i = i + 1 > 
	      	</#list>
	    </table>
	    <table class="table table-condensed table-bordered table-striped">
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