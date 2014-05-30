<#include "../../../common/freemarker/include_header.ftl">
<form name="form_item" action="exam_exam_complete_task.do" method="post">
<input type="hidden" value="<#if rhs.method?exists >${rhs["method"]}</#if>" name="method" />
<input type="hidden" value="<#if rhs["task"]?exists >${rhs["task"].id}</#if>" name="taskId" />
<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong><@i18n "title_judge" /></strong></div>
      <div class="panel-body">
      <table class="table table-condensed table-bordered table-striped">
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
      	<#assign i = 0 >
  		<table class="table table-condensed table-bordered table-striped">
		  	<strong><@i18n "title_single" /></strong>(total:${rhs["paper"].singlechoice + rhs["paper"].rmdsinglechoice}, each: ${rhs["paper"].singlechoicemark})
		  	<#list rhs["singleitems"]?sort_by("id") as singleitem>
				<tr>
					<td><strong>${singleitem_index+1}.&nbsp;${singleitem.item.content}</strong> <div class="pull-right"><@i18n "title_score" />：<input type="text" name="result[${i}].mark" value="<#if singleitem.answer?exists&&singleitem.answer == singleitem.item.refkey ><#if singleitem.item.mark?exists>${singleitem.item.mark}<#else>${singleitem.mark}</#if><#else>0</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></div></td>
				<tr>
				<#list singleitem.item.choiceitem?sort_by("id") as choiceitem>
					<tr>
						<td <#if singleitem.item.refkey?number==choiceitem.refid> style='color:red;'</#if> ><input disabled  type="radio" value="${choiceitem.refid}" name="" <#if singleitem.answer?exists&&singleitem.answer?number==choiceitem.refid> checked</#if> /> ${choiceitem.value}</td>
					</tr>
				</#list>
				<input type="hidden" value="${singleitem.id}" name="result[${i}].id" />
				<#assign i = i + 1 > 
		  	</#list>
      	</table>
      	
      	<table class="table table-condensed table-bordered table-striped">
	      	<strong><@i18n "title_multi" /></strong>(total:${rhs["paper"].multichoice + rhs["paper"].rmdmultichoice}, each: ${rhs["paper"].multichoicemark})
	      	<#list rhs["multiitems"]?sort_by("id") as multiitem>
	      		<tr>
					<td><strong>${multiitem_index+1}.&nbsp;${multiitem.item.content}</strong> <div class="pull-right"><@i18n "title_score" />：<input type="text" name="result[${i}].mark" value="<#if multiitem.answer?exists&&multiitem.answer == multiitem.item.refkey ><#if multiitem.item.mark?exists>${multiitem.item.mark}<#else>${multiitem.mark}</#if><#else>0</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></div></td>
				<tr>
				<#list multiitem.item.choiceitem?sort_by("id") as choiceitem>
					<tr>
						<td <#list multiitem.item.refkey?split(",") as key><#if (key?trim)?number==choiceitem.refid> style='color:red;'</#if> </#list>><input disabled  type="checkbox" value="${choiceitem.refid}" name="" <#if multiitem.answer?exists><#list multiitem.answer?split(",") as key><#if (key?trim)?number==choiceitem.refid> checked</#if> </#list></#if> /> ${choiceitem.value}</td>
					</tr>
				</#list>
				<input type="hidden" value="${multiitem.id}" name="result[${i}].id" />
				<#assign i = i + 1 > 
	      	</#list>
      	</table>
      	<table class="table table-condensed table-bordered table-striped">
	      	<strong><@i18n "title_blank" /></strong>(total:${rhs["paper"].blank + rhs["paper"].rmdblank}, each: ${rhs["paper"].blankmark})
	      	<#list rhs["blankitems"]?sort_by("id") as blankitem>
	      		<tr>
					<td><strong>${blankitem_index+1}.&nbsp;${blankitem.item.content}</strong> <div class="pull-right"><@i18n "title_score" />：<input type="text" name="result[${i}].mark" value="<#if blankitem.answer?exists&&blankitem.answer == blankitem.item.refkey ><#if blankitem.item.mark?exists>${blankitem.item.mark}<#else>${blankitem.mark}</#if><#else>0</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></div></td>
				<tr>
				<tr>
					<td><input disabled type="text" value="${blankitem.answer}" name=""/> <@i18n "title_refkey" />: ${blankitem.item.refkey}</td>
				</tr>
				<input type="hidden" value="${blankitem.id}" name="result[${i}].id" />
				<#assign i = i + 1 > 
	      	</#list>
      	</table>
      	<table class="table table-condensed table-bordered table-striped">
	      	<strong><@i18n "title_essay" /></strong>(total:${rhs["paper"].essay + rhs["paper"].rmdessay}, each: ${rhs["paper"].essaymark})
	      	<#list rhs["essayitems"]?sort_by("id") as essayitem>
	      		<tr>
					<td><strong>${essayitem_index+1}.&nbsp;${essayitem.item.content}</strong> <div class="pull-right"><@i18n "title_score" />：<input type="text" name="result[${i}].mark" value="<#if essayitem.answer?exists&&essayitem.answer == essayitem.item.refkey ><#if essayitem.item.mark?exists>${essayitem.item.mark}<#else>${essayitem.mark}</#if><#else>0</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></div></td>
				<tr>
				<tr>
					<td><textarea disabled name="" style="width:400px;height:100px;">${essayitem.answer}</textarea> <@i18n "title_refkey" />：${essayitem.item.refkey}</td>
				</tr>
				<input type="hidden" value="${essayitem.id}" name="result[${i}].id" />
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
		if (confirm("Are you sure submit the paper?")){
			var btn = $(this);
			btn.button('loading');
			$('#dialog').dialog('open');
			document.getElementsByName("form_item")[0].submit();
		}
	});
</script>