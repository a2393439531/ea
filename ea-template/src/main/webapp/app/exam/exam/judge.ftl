<#include "../../../common/freemarker/include_header.ftl">
<form name="form_item" action="exam_exam_complete_task.do" method="post">
<input type="hidden" value="<#if rhs.method?exists >${rhs["method"]}</#if>" name="method" />
<input type="hidden" value="<#if rhs["task"]?exists >${rhs["task"].id}</#if>" name="taskId" />
<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong>Template List</strong></div>
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
		  	<strong><@i18n "title_single" /></strong>(total:${rhs["template"].singlechoice + rhs["template"].rmdsinglechoice}, each: ${rhs["paper"].singlechoicemark})
		  	<#list rhs["singleitems"]?sort_by("id") as singleitem>
				<tr>
					<td><strong>${singleitem_index+1}.&nbsp;${singleitem.item.content}</strong> <div class="pull-right"><@i18n "title_score" />：<input type="text" name="result[${i}].mark" value="<#if singleitem.answer?exists&&singleitem.answer == singleitem.item.refkey >${singleitem.mark}<#else>0</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></div></td>
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
	      	<strong><@i18n "title_multi" /></strong>(total:${rhs["template"].multichoice + rhs["template"].rmdmultichoice}, each: ${rhs["paper"].multichoicemark})
	      	<#list rhs["multiitems"]?sort_by("id") as multiitem>
	      		<tr>
					<td><strong>${multiitem_index+1}.&nbsp;${multiitem.item.content}</strong> <div class="pull-right"><@i18n "title_score" />：<input type="text" name="result[${i}].mark" value="<#if multiitem.answer?exists&&multiitem.answer == multiitem.item.refkey >${multiitem.mark}<#else>0</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></div></td>
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
	      	<strong><@i18n "title_blank" /></strong>(total:${rhs["template"].blank + rhs["template"].rmdblank}, each: ${rhs["paper"].blankmark})
	      	<#list rhs["blankitems"]?sort_by("id") as blankitem>
	      		<tr>
					<td><strong>${blankitem_index+1}.&nbsp;${blankitem.item.content}</strong> <div class="pull-right"><@i18n "title_score" />：<input type="text" name="result[${i}].mark" value="<#if blankitem.answer == blankitem.item.refkey >${blankitem.mark}<#else>0</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></div></td>
				<tr>
				<tr>
					<td><input disabled type="text" value="${blankitem.answer}" name=""/> <@i18n "title_refkey" />: ${blankitem.item.refkey}</td>
				</tr>
				<input type="hidden" value="${blankitem.id}" name="result[${i}].id" />
				<#assign i = i + 1 > 
	      	</#list>
      	</table>
      	<table class="table table-condensed table-bordered table-striped">
	      	<strong><@i18n "title_essay" /></strong>(total:${rhs["template"].essay + rhs["template"].rmdessay}, each: ${rhs["paper"].essaymark})
	      	<#list rhs["essayitems"]?sort_by("id") as essayitem>
	      		<tr>
					<td><strong>${essayitem_index+1}.&nbsp;${essayitem.item.content}</strong> <div class="pull-right"><@i18n "title_score" />：<input type="text" name="result[${i}].mark" value="<#if essayitem.answer == essayitem.item.refkey >${essayitem.mark}<#else>0</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></div></td>
				<tr>
				<tr>
					<td><textarea disabled name="">${essayitem.answer}</textarea> <@i18n "title_refkey" />：${essayitem.item.refkey}</td>
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
		var btn = $(this);
		btn.button('loading');
		$('#dialog').dialog('open');
		document.getElementsByName("form_item")[0].submit();
	});
</script>