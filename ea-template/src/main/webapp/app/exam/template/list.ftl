<#include "../../../common/freemarker/include_header.ftl">
<body> 
   		<#include "include_add_search.ftl">
		<br><br><a style="margin-left:10px;margin-top:5px;" class="btn btn-primary "  href="exam_template_save.do?method=show">新建模板</a>
		
	<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong>Template List</strong></div>
      <div class="panel-body">
			
			
		
		<table class="table table-condensed table-hover">
	    <thead>
			<tr>
			    <td width=25px><strong>#</strong></td>
				<td width=500px><strong>模板标题</strong></td>
				<td><strong>操作</strong></td>
				<td></td>
			</tr>
		</thead>
		<tbody>
			<#list rhs["dataList"]?sort_by("id") as x>
			 <tr>
			    <td class=nob >${x_index+1}</td>
				<td>${x.title?if_exists}</td>
				<td><a href="exam_template_load.do?method=edit&id=${x.id}">编辑</a> | <a href="exam_template_load.do?method=show&id=${x.id}"> 查看</a> | <a href="exam_template_delete.do?id=${x.id}">删除</a></td>
				<td></td>
			</tr>
			</#list>
		</tbody>
	</table>
		<#include "../../../common/freemarker/macro_pagination.ftl">
		<@pagination  "search_form" />
      </div>
    </div>
		
		
</body>