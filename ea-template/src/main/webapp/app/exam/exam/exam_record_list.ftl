<#include "../../../common/freemarker/include_header.ftl">
<div class="panel panel-primary">
       
  <div class="panel-heading">
  	<strong>Exam History List</strong>
  </div>
  <div class="panel-body">
		<table class="table table-condensed table-bordered">
				<tr>
					<td width=25px><strong>#</strong></td>
					<td ><strong><@i18n "title_name" /></strong></td>
					<#--<td ><strong>User ID</strong></td>-->
					<td ><strong><@i18n "title_totalmark" /></strong></td>
					<td ><strong><@i18n "title_passmark" /></strong></td>
					<td></td>
					<#--<td ><strong><@i18n "title_result" /></strong></td>-->
					<#--<td ><strong><@i18n "title_remark" /></strong></td>-->
				</tr>
				<#assign index=1 />
				<#list rhs["datalist"]?keys as papername>
					<tr>
						<td>${index}</td>
						<td onclick="javascript:showresult(${rhs["datalist"][papername][0].paper.id});">${papername} </td>
						<td>${rhs["datalist"][papername][0].paper.totalmark}</td>
						<td>${rhs["datalist"][papername][0].paper.passmark}</td>
						<td><#if rhs["export"]><div class="pull-right"><a href="exam_exam_export_record.do?paperId=${rhs["datalist"][papername][0].paper.id}" class="btn btn-xs btn-primary" >Export to Excel</a></div></#if></td>
					</tr>
					<#assign index=index+1 />
					<tr id="${rhs["datalist"][papername][0].paper.id}" style="display:none;">
						<td colspan="5" >
							<table class="table table-condensed table-bordered table-hover">
								<#assign i=1>
								<tr>
									<td><strong>></strong></td>
									<td><strong>User ID</strong></td>
									<td ><strong><@i18n "title_result" /></strong></td>
									<td colspan="2"></td>
								</tr>
								<#list rhs["datalist"][papername] as record>
									<tr>
										<td>${i}</td>
										<#--<td ></td><a href="exam_exam_exam_record_detail.do?paperId=${record.paper.id}&recordsId=${record.id}" ></a>-->
										<td>${record.userid}</td>
										<#--<td>${record.paper.totalmark}</td>-->
										<#--<td>${record.paper.passmark}</td>-->
										<td>${record.singlechoicemark?number + record.multichoicemark?number + record.blankmark?number + record.essaymark?number}</td>
										<td colspan="2"></td>
										<#--<td >${record.remark?if_exists}</td>-->
									</tr>
									<#assign i = i + 1 />
								</#list>
							</table>
						</td>
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
<#macro listresult papername>
	
</#macro>
<script>
	function showresult(paperid){
		var resultstyle = $("#"+paperid).attr("style");
		if(resultstyle.indexOf("none") < 0){
			$("#"+paperid).attr("style","display:none;");
		}else{
			$("#"+paperid).attr("style","display:");
		}
	
	}
</script>