<#include "../../../common/freemarker/include_header.ftl">
<div class="panel panel-primary">
       
  <div class="panel-heading">
  	<strong>Record List</strong>
  </div>
  <div class="panel-body">
		<table class="table table-condensed table-bordered">
				<tr>
					<td rowspan="2" width=25px><strong>#</strong></td>
					<td rowspan="2"><strong><@i18n "title_name" /></strong></td>
					<td rowspan="2"><strong><@i18n "title_totalmark" /></strong></td>
					<td rowspan="2"><strong><@i18n "title_passmark" /></strong></td>
					<td rowspan="1" colspan="4" align="center"><strong><@i18n "title_result" /></strong></td>
					<td rowspan="2"><strong><@i18n "title_remark" /></strong></td>
				</tr>
					<tr>
						<td><@i18n "title_single" /></td>
						<td><@i18n "title_multi" /></td>
						<td><@i18n "title_blank" /></td>
						<td><@i18n "title_essay" /></td>
					</tr>
				<#list rhs["datalist"] as record>
					<tr>
						<td>${record_index+1}</td>
						<td><a href="exam_exam_exam_record_detail.do?paperId=${record.paper.id}&recordsId=${record.id}" >${record.paper.name}</a></td><#---->
						<td>${record.paper.totalmark}</td>
						<td>${record.paper.passmark}</td>
						<td >${record.singlechoicemark} (total: ${record.paper.template.singlechoice + record.paper.template.rmdsinglechoice}, each: ${record.paper.singlechoicemark})</td>
						<td >${record.multichoicemark} (total: ${record.paper.template.multichoice + record.paper.template.rmdmultichoice}, each: ${record.paper.multichoicemark})</td></td>
						<td >${record.blankmark}(total: ${record.paper.template.blank + record.paper.template.rmdblank}, each: ${record.paper.blankmark})</td>
						<td >${record.essaymark}(total: ${record.paper.template.essay + record.paper.template.rmdessay}, each: ${record.paper.essaymark})</td>
						<td >${record.remark?if_exists}</td>
					</tr>
				</#list>
			</table>
			
			<form action="exam_exam_exam_record_list.do" id="search_form" method="post" style="display:none;">
				<input type="hidden" name="search" value="search">
				<input type="hidden" name="pageId" id="pageId">
				<input type="hidden" name="maxSize" id="pageMaxSize">
			</form>
			<#include "../../../common/freemarker/macro_pagination.ftl">
			<@pagination  "search_form" />
  </div>
</div>
