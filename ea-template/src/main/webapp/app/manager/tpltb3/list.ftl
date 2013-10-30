<#include "../../../common/freemarker/include_header.ftl">
<!-- 
<script>
$(function() {
	$( "#tabs" ).tabs();
});
</script>
-->
<div id="tabs">
	<div id="tabs-1">
		<#include "include_add_search.ftl">
		<table class="table table-condensed table-hover">
		    <thead>
				<tr>
				    <th width=25px>#</th>
					<th>request-id</th>
					<th>工单标题</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			<#list rhs["dataList"]?sort_by("id") as x>
				<tr>
					<td>${x_index+1}</td>		
					<td>${x.requestid?if_exists}</td>
					<td>${x.title?if_exists}</td>
					<td>
						<a title="编辑" href="manager_tpltb3_load.do?id=${x.id}" >编辑</a> 
						<a title="删除" href="manager_tpltb3_delete.do?id=${x.id}" >删除</a>
					</td>
				</tr>
			</#list> 
			</tbody>
		</table>       
		<#include "../../../common/freemarker/macro_pagination.ftl">
		<@pagination "searchFromId"/>
	</div>
</div>