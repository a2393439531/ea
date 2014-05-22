<#include "../../../common/freemarker/include_header.ftl">
<body> 
   		<#include "include_add_search.ftl">
		<br><br>
		<a style="margin-left:10px;margin-top:5px;" class="btn btn-primary "  href="exam_template_save.do?method=show"><@i18n "menu_template_new" /></a>
		<a class="btn btn-xs btn-info" style="margin-top:10px;" onclick="javascript:window.location.href='exam_paper_list.do';"><@i18n "return" /></a>
		
	<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong>Template List</strong></div>
      <div class="panel-body">
			
			
		
		<table class="table table-condensed table-hover">
	    <thead>
			<tr>
			    <td width=25px><strong>#</strong></td>
				<td width=500px><strong><@i18n "title_name" /></strong></td>
				<td><strong><@i18n "title_operation" /></strong></td>
				<td></td>
			</tr>
		</thead>
		<tbody>
			<#list rhs["dataList"]?sort_by("id") as x>
			 <tr>
			    <td class=nob >${x_index+1}</td>
				<td>${x.title?if_exists}</td>
				<td><a href="exam_template_load.do?method=edit&id=${x.id}"><@i18n "title_edit" /></a> | <a href="exam_template_load.do?method=show&id=${x.id}"> <@i18n "title_view" /></a> | <a href="exam_template_delete.do?id=${x.id}"><@i18n "title_delete" /></a></td>
				<td><a  class="btn btn-xs btn-info " href="exam_paper_save.do?method=choicetemplate&templateid=${x.id}"><@i18n "title_generate_paper" /></a></td>
			</tr>
			</#list>
		</tbody>
	</table>
		<#include "../../../common/freemarker/macro_pagination.ftl">
		<@pagination  "search_form" />
      </div>
    </div>
		
		
</body>