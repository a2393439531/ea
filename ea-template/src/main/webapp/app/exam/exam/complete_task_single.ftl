<#if rhs["finsh"]>
	<script type="text/javascript">
		window.close();
	</script>
<#else>
	<#include "single.ftl">
</#if>
<#--<form name="form_item" action="exam_exam_complete_task_single.do" method="post">
<input type="hidden" value="<#if rhs.examrecordId?exists >${rhs["examrecordId"]}</#if>" name="examrecordId" />
<input type="hidden" value="<#if rhs["task"]?exists >${rhs["task"].id}</#if>" name="taskId" />
<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong>Start Exam</strong></div>
      <div class="panel-body">
      	<table class="table table-condensed table-bordered table-striped">
      	<tr><td colspan="8"><font color="red"><strong>考试中请勿关闭浏览器，否则会导致考试失败</strong></font></td></tr>
      		<tr>
      			<td><strong><@i18n "title_name" /></strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].name}</#if></td>
      			<td><strong><@i18n "title_examtime" /></strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].time}</#if></td>
      			<td><strong><@i18n "title_totalmark" /></strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].totalmark}</#if></td>
      			<td><strong><@i18n "title_passmark" /></strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].passmark}</#if></td>
      		</tr>
      	</table>
  		<table class="table table-condensed table-bordered table-striped">
		  	<strong><@i18n "title_single" /></strong>(total:${rhs["template"].singlechoice + rhs["template"].rmdsinglechoice}, each: ${rhs["paper"].singlechoicemark})
					<tr>
						<td><strong>#.&nbsp;${rhs["item"].content}</strong></td>
					<tr>
					<#if rhs["item"].type == 1>
						<#list rhs["item"].choiceitem?sort_by("id") as choiceitem>
							<tr>
								<td><input type="radio" value="${choiceitem.refid}" name="result[${rhs["index"]}].answer"/> ${choiceitem.value}</td>
							</tr>
						</#list>
					</#if>
					<#if rhs["item"].type == 2>
						<#list rhs["item"].choiceitem?sort_by("id") as choiceitem>
							<tr>
								<td><input type="checkbox" value="${choiceitem.refid}" name="result[${rhs["index"]}].answer"/> ${choiceitem.value}</td>
							</tr>
						</#list>
					</#if>
					<#if rhs["item"].type == 3>
						<tr>
							<td><input type="text"  name="result[${rhs["index"]}].answer"/></td>
						</tr>
					</#if>
					<#if rhs["item"].type == 4>
						<tr>
							<td><textarea name="result[${rhs["index"]}].answer"> </textarea></td>
						</tr>
					</#if>
				<input type="hidden" value="${rhs["item"].id}" name="result[${rhs["index"]}].item.id" />
				<input type="hidden" value="${rhs["index"]}" name="index" />
				<input type="hidden" value="${rhs["score"]?if_exists}" name="score" />
				<input type="hidden" value="<#if rhs["item"].mark?exists >${rhs["item"].mark}<#else>${rhs["paper"].singlechoicemark}</#if>" name="result[${rhs["index"]}].mark" />
      	</table>
	    <table class="table table-condensed table-bordered table-striped">
	    	<tr>
      			<td><input type="button" class="btn btn-xs btn-info" value="Next" id="submitButton"/></td>
      		</tr>
	    </table>
      </div>
</div>
</form>-->