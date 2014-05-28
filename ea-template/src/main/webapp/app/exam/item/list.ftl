<#include "../../../common/freemarker/include_header.ftl">
<body> 
   		<#include "include_add_search.ftl">
		<br><br>
		<a style="margin-left:7px;margin-top:5px;" class="btn btn-primary "  href="exam_item_save.do?method=show"><@i18n "menu_item_new" /></a>
		<a style="margin-left:10px;margin-top:5px;" class="btn btn-xs btn-info "  href="exam_knowledge_menu_knowledge.do"><@i18n "menu_knowledge" /></a>
		
		
	<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong><@i18n "title_item" /></strong></div>
      <div class="panel-body">
			
			
		
		<table class="table table-condensed table-hover">
	    <thead>
			<tr>
			    <td width=25px><strong>#</strong></td>
				<td width=500px><strong><@i18n "title_title" /></strong></td>
				<td width=120px><strong><@i18n "title_type" /></strong></td>
				<td><strong><@i18n "title_operation" /></strong></td>
				<td></td>
			</tr>
		</thead>
		<tbody>
			<#list rhs["dataList"]?sort_by("id") as x>
			 <tr>
			    <td class=nob >${x_index+1}</td>
				<td>${x.content?if_exists}</td>
				<td>
					<#if x.type == 1>
						<@i18n "title_single" />
					</#if>
					<#if x.type == 2>
						<@i18n "title_multi" />
					</#if>
					<#if x.type == 3>
						<@i18n "title_blank" />
					</#if>
					<#if x.type == 4>
						<@i18n "title_essay" />
					</#if>
				</td>
				<td><a href="exam_item_load.do?method=edit&id=${x.id}"><@i18n "title_edit" /></a> | <a href="exam_item_load.do?method=show&id=${x.id}"> <@i18n "title_view" /></a> | <a href="exam_item_delete.do?id=${x.id}"><@i18n "title_delete" /></a></td>
				<td></td>
			</tr>
			</#list>
		</tbody>
	</table>
				<form action="exam_item_list.do" id="search_form" method="post" style="display:none;">
				<input type="hidden" name="search" value="search">
				<input type="hidden" name="pageId" id="pageId">
				<input type="hidden" name="maxSize" id="pageMaxSize">
			</form>
		<#include "../../../common/freemarker/macro_pagination.ftl">
		<@pagination  "search_form" />
      </div>
    </div>
		
		
</body>