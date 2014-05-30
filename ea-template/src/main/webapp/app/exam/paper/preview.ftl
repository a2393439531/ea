<#include "../../../common/freemarker/include_header.ftl">
<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong><@i18n "menu_paper_view" /></strong></div>
      <div class="panel-body">
		<br />
      	<table class="table table-condensed table-bordered table-striped">
      		<tr><td colspan="8"><font color="red"><strong>
      			Preview</strong></font>
      		</td>
      		</tr>
      		<tr>
      			<td><strong><@i18n "title_name" /></strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].name?if_exists}</#if></td>
      			<td><strong><@i18n "title_examtime" /></strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].time?if_exists}</#if></td>
      			<td><strong><@i18n "title_totalmark" /></strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].totalmark?if_exists}</#if></td>
      			<td><strong><@i18n "title_passmark" /></strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].passmark?if_exists}</#if></td>
      		</tr>
      	</table>
      	<#assign i = 0 >
      	<#if (rhs["singleitems"]?size>0)>
  		<table class="table table-condensed table-bordered table-striped">
		  	<strong><@i18n "title_single" /></strong>(total:${rhs["paper"].singlechoice + rhs["paper"].rmdsinglechoice})
		  	<#list rhs["singleitems"]?sort_by("id") as singleitem>
				<tr>
					<td><strong>${singleitem_index+1}.&nbsp;${singleitem.content}</strong><div class="pull-right">&nbsp;&nbsp;&nbsp;Score:<#if singleitem.mark?exists&&singleitem.mark!="0">${singleitem.mark}<#else>${rhs["paper"].singlechoicemark}</#if></div></td>
				<tr>
				<#list singleitem.choiceitem?sort_by("id") as choiceitem>
					<tr>
						<td><input disabled type="radio" value="${choiceitem.refid}" name="result[${i}].answer"/> ${choiceitem.value}</td>
					</tr>
				</#list>
				<#assign i = i + 1 > 
		  	</#list>
      	</table>
      	</#if>
      	<#assign i = 0 >
  		<#if (rhs["multiitems"]?size>0)>
  		<table class="table table-condensed table-bordered table-striped">
		  	<strong><@i18n "title_multi" /></strong>(total:${rhs["paper"].multichoice + rhs["paper"].rmdmultichoice})
		  	<#list rhs["multiitems"]?sort_by("id") as multiitem>
				<tr>
					<td><strong>${multiitem_index+1}.&nbsp;${multiitem.content}</strong><div class="pull-right">&nbsp;&nbsp;&nbsp;Score:<#if multiitem.mark?exists&&multiitem.mark!="0">${multiitem.mark}<#else>${rhs["paper"].multichoicemark}</#if></div></td>
				<tr>
				<#list multiitem.choiceitem?sort_by("id") as choiceitem>
					<tr>
						<td><input disabled type="checkbox" value="${choiceitem.refid}" name="result[${i}].answer"/> ${choiceitem.value}</td>
					</tr>
				</#list>
				<#assign i = i + 1 >
		  	</#list>
      	</table>
      	</#if>
      	<#assign i = 0 >
  		<#if (rhs["blankitems"]?size>0)>
  		<table class="table table-condensed table-bordered table-striped">
		  	<strong><@i18n "title_blank" /></strong>(total:${rhs["paper"].blank + rhs["paper"].rmdblank})
		  	<#list rhs["blankitems"]?sort_by("id") as blankitem>
				<tr>
					<td><strong>${blankitem_index+1}.&nbsp;${blankitem.content}</strong><div class="pull-right">&nbsp;&nbsp;&nbsp;Score:<#if blankitem.mark?exists&&blankitem.mark!="0">${blankitem.mark}<#else>${rhs["paper"].blankmark}</#if></div></td>
				<tr>
				<#assign i = i + 1 >
		  	</#list>
      	</table>
      	</#if>
      	<#assign i = 0 >
  		<#if (rhs["essayitems"]?size>0)>
  		<table class="table table-condensed table-bordered table-striped">
		  	<strong><@i18n "title_essay" /></strong>(total:${rhs["paper"].essay + rhs["paper"].rmdessay})
		  	<#list rhs["essayitems"]?sort_by("id") as essayitem>
				<tr>
					<td><strong>${essayitem_index+1}.&nbsp;${essayitem.content}</strong><div class="pull-right">&nbsp;&nbsp;&nbsp;Score:<#if essayitem.mark?exists&&essayitem.mark!="0">${essayitem.mark}<#else>${rhs["paper"].essaymark}</#if></div></td>
				<tr>
				<#assign i = i + 1 >
		  	</#list>
      	</table>
      	</#if>
      </div>
</div>
