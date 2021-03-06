<#include "../../../common/freemarker/include_header.ftl">
<div class="panel panel-primary" style="float:left;position:relative;width:50%;left:5px;">
       
  <div class="panel-heading">
  	<strong><@i18n "title_exam_list" /></strong>
  </div>
  <div class="panel-body">
		<table class="table table-condensed table-hover table-bordered">
				<tr>
					<td width=25px><strong>#</strong></td>
					<td ><strong><@i18n "title_user" /></strong></td>
					<td ><strong><@i18n "title_name" /></strong></td>
					<td ><strong><@i18n "title_passmark" /></strong></td>
					<td ><strong><@i18n "title_totalmark" /></strong></td>
					<td ><strong><@i18n "title_examtime" /></strong></td>
					<td ><strong><@i18n "title_createtime" /></strong></td>
					<td ><strong><@i18n "title_operation" /></strong></td>
				</tr>
				<#list rhs["oatasklist"] as item>
					<#if item.obj?exists>
					<tr>
						<td>${item_index+1}</td>
						<td>${item.assignee}</td>
						<td>${item.obj.name} </td>
						<td >${item.obj.passmark}</td>
						<td >${item.obj.totalmark}</td>
						<td >${item.obj.time}</td>
						<td>${item.task.createTime?datetime}</td>
						<td >
							<#--<a href="common_activiti_process_diagram.do?processInstanceId=${item.task.processInstanceId}" target=_blank>
								View
							</a>-->
							<a  href="${item.handleTaskUrl?if_exists}&taskId=${item.task.id}" target=_self class="btn btn-xs btn-primary"><#--<#if item.method == "Start"> onclick="javascript:toFull('${item.handleTaskUrl?if_exists}&taskId=${item.task.id}')"<#else></#if>-->
								${item.method}
							</a>
							<#if item.method == "Start">
								<a target=_self onclick="javascript:toFull('${item.handleTaskUrl?if_exists}&taskId=${item.task.id}&format=single')" class="btn btn-xs btn-info">
									${item.method}(Single)
								</a>
							</#if>
						</td>
					</tr>
					</#if>
				</#list>
			</table>
			<#include "../../../common/freemarker/macro_pagination.ftl">
  </div>
</div>
<script>
	function   toFull(url){
	  if(window.name=="fullscreen")
	  	return; 
	  var a =window.open(url,"fullscreen","fullscreen=1,scrollbars=yes");
	}
</script>
<div class="panel panel-primary" style="float:left;position:relative;width:46%;left:5px;">
       
  <div class="panel-heading">
  	<strong><@i18n "title_history_list" /></strong>
  </div>
  <div class="panel-body">
		<table class="table table-condensed table-bordered">
				<tr>
					<td width=25px><strong>#</strong></td>
					<td ><strong><@i18n "title_name" /></strong></td>
					<#--<td ><strong>User ID</strong></td>
					<td ><strong><@i18n "title_totalmark" /></strong></td>-->
					<td ><strong><@i18n "title_passmark" /></strong></td>
					<td ><strong><@i18n "title_exam_result" /></strong></td>
					<td><strong><@i18n "title_time" /></strong></td>
					<#--<td ><strong><@i18n "title_result" /></strong></td>-->
					<#--<td ><strong><@i18n "title_remark" /></strong></td>-->
				</tr>
				<#assign index=1 />
				<#list rhs["datalist"]?keys as papername>
					<#assign index=1>
					<#list (rhs["datalist"][papername]?sort_by("id"))?reverse as record>
					<tr>
						<td>${index}</td>
						<td><a href="exam_exam_exam_record_detail.do?paperId=${record.paper.id}&recordsId=${record.id}&user=${record.userid}" >${papername}</a> </td><#--onclick="javascript:showresult(${rhs["datalist"][papername][0].paper.id});"-->
						<td>${rhs["datalist"][papername][0].paper.passmark}</td>
						<td>
							<#if record.remark?exists && record.remark == "Wait for judge">
								${record.remark}
							<#else>
								${record.singlechoicemark?number + record.multichoicemark?number + record.blankmark?number + record.essaymark?number}
							</#if>
						</td>
						<td>${record.recorddate?if_exists}</td><#--<#if rhs["export"]><div class="pull-right"><a href="exam_exam_export_record.do?paperId=${rhs["datalist"][papername][0].paper.id}" class="btn btn-xs btn-primary" >Export to Excel</a></div></#if>-->
					</tr>
					<#assign index = index + 1 />
					</#list>
				</#list>
			</table>
			<form action="exam_exam_exam_home.do" id="search_form" method="post" style="display:none;">
				<input type="hidden" name="search" value="search">
				<input type="hidden" name="pageId" id="pageId">
				<input type="hidden" name="maxSize" id="pageMaxSize">
			</form>
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