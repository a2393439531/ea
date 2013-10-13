<#include "../../../common/freemarker/include_header.ftl">
 
<div id="tabs">
	<div id="tabs-1">
		<#include "include_add_search.ftl">
		<table class="table table-condensed table-hover">
		    <thead>
				<tr>
				    <th width=25px>#</th>
					<th>帐号</th>
					<th>姓名</th>
					<th>身份证</th>
					<th>生日</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			<#list rhs["dataList"]?sort_by("id") as x>
				<tr>
					<td>${x_index+1}</td>		
					<td>${x.account?if_exists}</td>
					<td>${x.name?if_exists}</td>
					<td>${x.identityCard?if_exists}</td>
				
					<td>
						<a title="编辑" href="ea_user_load.do?id=${x.id}" >编辑</a> 
						<a title="删除" href="ea_user_delete.do?id=${x.id}"  >删除</a>
					</td>
				</tr>
			</#list> 
			</tbody>
		</table>       
		<#include "../../../common/freemarker/macro_pagination.ftl">
		<@pagination "searchFromId"/>
	</div>
</div>