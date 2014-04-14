<#include "../../../common/freemarker/include_header.ftl">
<div class="panel panel-primary">
<#assign acount=0>
<#assign bcount=0>
<#assign ccount=0>
<#assign dcount=0>
  <div class="panel-heading">
  	<strong>Record List</strong>
  </div>
  <div class="panel-body">
		<table class="table table-condensed table-bordered">
				<tr>
					<td rowspan="2" width=25px><strong>#</strong></td>
					<td rowspan="2"><strong><@i18n "title_name" /></strong></td>
					<#--<td rowspan="2"><strong><@i18n "title_totalmark" /></strong></td>
					<td rowspan="2"><strong><@i18n "title_passmark" /></strong></td>-->
					<td rowspan="1" colspan="4" align="center"><strong><@i18n "title_result" /></strong></td>
					<td rowspan="2"><strong><@i18n "title_remark" /></strong></td>
				</tr>
					<tr>
						<td>Red</td>
						<td>Blue</td>
						<td>Yellow</td>
						<td>Green</td>
					</tr>
				<#list rhs["datalist"]?sort_by("id") as record>
					<#list record.result?sort_by("id") as res>
						<#if res_index < 15>
							<#if res.answer?exists&&res.answer == "1">
								<#assign acount = acount + 1>
							</#if>
							<#if res.answer?exists&&res.answer == "2">
								<#assign bcount = bcount + 1>
							</#if>
							<#if res.answer?exists&&res.answer == "3">
								<#assign ccount = ccount + 1>
							</#if>
							<#if res.answer?exists&&res.answer == "4">
								<#assign dcount = dcount + 1>
							</#if>
						<#else>
							<#if res.answer?exists&&res.answer == "1">
								<#assign dcount = dcount + 1>
							</#if>
							<#if res.answer?exists&&res.answer == "2">
								<#assign ccount = ccount + 1>
							</#if>
							<#if res.answer?exists&&res.answer == "3">
								<#assign bcount = bcount + 1>
							</#if>
							<#if res.answer?exists&&res.answer == "4">
								<#assign acount = acount + 1>
							</#if>
						</#if>
					</#list>
					<tr>
						<td>${record_index+1}</td>
						<td><a href="exam_exam_exam_record_detail.do?paperId=${record.paper.id}&recordsId=${record.id}" >${record.paper.name}</a></td><#---->
						<#--<td>${record.paper.totalmark}</td>
						<td>${record.paper.passmark}</td>-->
						<td >
							${acount}
						</td>
						<td >${bcount} </td>
						<td >${ccount}</td>
						<td >${dcount}</td>
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
