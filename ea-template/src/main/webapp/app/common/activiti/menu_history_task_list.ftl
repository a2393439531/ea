<#include "../../../common/freemarker/include_header.ftl">
<div class="container-fluid">
	<table class="table table-condensed table-hover">
		<thead>
		<tr>
			<th width=25px>#</th>
			<th >发起人</th>
			<th >任务名称</th>
			<th >任务描述</th>
			<th >结束时间</th>
		</tr>
		</thead>
		<tbody>
		<#list rhs["oatasklist"] as item>
			<tr>
				<td>${item_index+1}</td>
				<td><#if item.initiator?exists><@getName item.initiator/></#if></td>
				<td>${item.historyTask.name?if_exists}</td>
				<td>
					${item.historyTask.description?if_exists}: ${item.busiDesc?if_exists}
				</td>
				<td>${item.historyTask.endTime?datetime}</td>
			</tr>
		</#list>
		</tbody>
	</table>
</div>