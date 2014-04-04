<#include "../../../common/freemarker/include_header.ftl">
<div class="panel panel-primary">
       
  <div class="panel-heading">
  	<strong>Record List</strong>
  </div>
  <div class="panel-body">
		<table class="table table-condensed table-bordered">
				<tr>
					<td rowspan="2" width=25px><strong>#</strong></td>
					<td rowspan="2"><strong>Exam Name</strong></td>
					<td rowspan="2"><strong>Total mark</strong></td>
					<td rowspan="2"><strong>Passmark mark</strong></td>
					<td rowspan="1" colspan="4" align="center"><strong>Result mark</strong></td>
					<td rowspan="2"><strong>Remark</strong></td>
				</tr>
					<tr>
						<td>Single Choice</td>
						<td>Multiple Choice</td>
						<td>Blank</td>
						<td>Essay</td>
					</tr>
				<#list rhs["datalist"] as record>
					<tr>
						<td>${record_index+1}</td>
						<td>${record.paper.name}</td>
						<td>${record.paper.totalmark}</td>
						<td>${record.paper.passmark}</td>
						<td >${record.singlechoicemark} (total: ${record.paper.template.singlechoice + record.paper.template.rmdsinglechoice}, each: ${record.paper.singlechoicemark})</td>
						<td >${record.multichoicemark} (total: ${record.paper.template.multichoice + record.paper.template.rmdmultichoice}, each: ${record.paper.multichoicemark})</td></td>
						<td >${record.blankmark}(total: ${record.paper.template.blank + record.paper.template.rmdblank}, each: ${record.paper.blankmark})</td>
						<td >${record.essaymark}(total: ${record.paper.template.essay + record.paper.template.rmdessay}, each: ${record.paper.essaymark})</td>
						<td >${record.remark}</td>
					</tr>
				</#list>
			</table>
			
			<form action="common_activiti_menu_task_list.do" id="search_form" method="post" style="display:none;">
				<input type="hidden" name="search" value="search">
				<input type="hidden" name="pageId" id="pageId">
				<input type="hidden" name="maxSize" id="pageMaxSize">
			</form>
			<#include "../../../common/freemarker/macro_pagination.ftl">
			<@pagination  "search_form" />
  </div>
</div>
