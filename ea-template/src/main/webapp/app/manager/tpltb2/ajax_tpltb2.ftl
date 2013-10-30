<head>
<style>
blockquote.pull-right {
	border-right-style: none;
	padding-right: 0px;
}
</style>
</head>
<div id=div_tpltb2_table>
    <table   class="table  table-condensed">
	    <thead>
			<tr>
			    <th width=25px>ID</th>
				<th>姓名</th>
				<th>性别</th>
				<th>生日</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<#list rhs["dataList"]?sort_by("id") as x>
			<tr>
				<td class=nob >${x_index+1}</td>		
				<td>${x.name?if_exists}</td>
				<td>${x.sex?if_exists}</td>
				<td>${x.birthDate?if_exists}</td>  
				<td>                                                                 
					<a  title="编辑" onclick="javascript:action_tpltb2_dialog('manager_tpltb2_load.do','id=${x.id}');$('#dialog').dialog('open');" >编辑</a> 
					<a  title="删除" onclick="javascript:action_tpltb2('manager_tpltb2_delete.do','id=${x.id}')" >删除</a>
				</td>
			</tr>
		</#list> 
		</tbody>
	</table>            
	<p class="pull-right">
		<span id="div_action_result" class="small text-${rhs["info_type"]?if_exists} ">
			${rhs["info"]?if_exists}
		</span>
		<#if (rhs.currentPage > 1) ><a class="btn btn-link btn-mini" onclick="javascript:action_tpltb2('manager_tpltb2_ajax_page_data.do','pageId=1')">第一页</a></#if>
		<#if (rhs.currentPage > 1) ><a class="btn btn-link btn-mini"  onclick="javascript:action_tpltb2('manager_tpltb2_ajax_page_data.do','pageId=${rhs.currentPage-1}')">上一页</a></#if>
		<#if (rhs.currentPage < rhs.maxPage) ><a class="btn btn-link btn-mini" onclick="javascript:action_tpltb2('manager_tpltb2_ajax_page_data.do','pageId=${rhs.currentPage+1}')">下一页11</a></#if>
		<#if (rhs.currentPage < rhs.maxPage) ><a class="btn btn-link btn-mini"  onclick="javascript:action_tpltb2('manager_tpltb2_ajax_page_data.do','pageId=${rhs.maxPage}')">最后页</a></#if>
		第${rhs.currentPage}页&nbsp;
		共${rhs.maxPage}页&nbsp;
		总${rhs.count}条记录
		
		显示条数
		<select style="WIDTH: 60px"   onchange="javascript:action_tpltb2('manager_tpltb2_change_page_number.do','maxSize='+this.value)" >
			<option value="${rhs.maxSize}">${rhs.maxSize}</option>
	  		<option value="5">5</option>
	  		<option value="10">10</option>
	  		<option value="20">20</option>
	  		<option value="50">50</option>
	  		<option value="200">200</option>
	 	</select>	
	</p>
</div>