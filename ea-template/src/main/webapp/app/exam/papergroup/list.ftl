<#include "../../../common/freemarker/include_header.ftl">
<body> 
		<br><br>
		<a style="margin-left:7px;margin-top:5px;" class="btn btn-info "  href="exam_papergroup_save.do?method=show"><@i18n "menu_papergroup_new" /></a>
		<a class="btn btn-xs btn-info" style="margin-top:10px;" onclick="javascript:window.location.href='exam_paper_list.do';"><@i18n "return" /></a>
		
	<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong>Paper Group List</strong></div>
      <div class="panel-body">
			
			
		
		<table class="table table-condensed table-hover">
	    <thead>
			<tr>
			    <td width=25px><strong>#</strong></td>
				<td width=300px><strong><@i18n "title_title" /></strong></td>
				<td width=150px><strong><@i18n "title_count" /></strong></td>
				<td><strong><@i18n "title_operation" /></strong></td>
				<td></td>
			</tr>
		</thead>
		<tbody>
			<#list rhs["dataList"] as x>
			 <tr>
			    <td class=nob >${x_index+1}</td>
				<td>${x.name?if_exists}</td>
				<td>${x.papers?size}</td>
				<td><a href="exam_papergroup_load.do?method=edit&id=${x.id}"><@i18n "title_edit" /></a> | <a href="exam_papergroup_load.do?method=show&id=${x.id}"> <@i18n "title_view" /></a> | <a href="exam_papergroup_delete.do?id=${x.id}"><@i18n "title_delete" /></a> </td>
			</tr>
			</#list>
		</tbody>
	</table>
		<#include "../../../common/freemarker/macro_pagination.ftl">
		<@pagination  "search_form" />
      </div>
    </div>
		
		
</body>