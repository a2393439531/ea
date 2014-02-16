<div id=div_viewhistory_table>
    <table   class="table table-bordered  table-hover table-condensed">
	    <thead>
			<tr>
			    <th width=25px>ID</th>
				<th>名称</th>
				<th>保存时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<#list rhs["dataList"]?sort_by("id") as x>
			<tr>
				<td>${x_index+1}</td>		
				<td >
				<input style="width:200px"  type="text"  value='${x.name?if_exists}' onchange="javascript:action_viewhistory('update.do','column=name&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))"/>
				
				</td>
				 <td>${x.inputtime?if_exists}</td>
				<td>                                                                 
			
				<a href="ea_view_show_history_orgainze_pic.do?filename=${x.filename?if_exists}" target=_blank >查看</a>
				
				<#--	<a  title="编辑" onclick="javascript:action_viewhistory_dialog('load.do','id=${x.id}');$('#dialog').dialog('open');" >编辑</a> 
					-->
					<a  title="删除" onclick="javascript:action_viewhistory('delete.do','id=${x.id}')" >删除</a>
				</td>
			</tr>
		</#list> 
		</tbody>
	</table>            
	<blockquote class="pull-right">
		<span id="div_action_result" class="small text-${rhs["info_type"]?if_exists} " style="display:none">
			${rhs["info"]?if_exists}
		</span>
		显示条数<select style="WIDTH: 40px"   onchange="javascript:action_viewhistory('viewhistory_change_page_number.do','maxSize='+this.value)" >
				    <option value="${rhs.maxSize}">${rhs.maxSize}</option>
	  				<option value="5">5</option>
	  				<option value="10">10</option>
	  				<option value="20">20</option>
	  				<option value="50">50</option>
	  				<option value="200">200</option>
	 			<select>		
		<#if (rhs.currentPage > 1) ><a class="btn btn-link btn-mini" onclick="javascript:action_viewhistory('viewhistory_ajax_page_data.do','pageId=1')">第一页</a></#if>
		<#if (rhs.currentPage > 1) ><a class="btn btn-link btn-mini"  onclick="javascript:action_viewhistory('viewhistory_ajax_page_data.do','pageId=${rhs.currentPage-1}')">上一页</a></#if>
		<#if (rhs.currentPage < rhs.maxPage) ><a class="btn btn-link btn-mini" onclick="javascript:action_viewhistory('viewhistory_ajax_page_data.do','pageId=${rhs.currentPage+1}')">下一页11</a></#if>
		<#if (rhs.currentPage < rhs.maxPage) ><a class="btn btn-link btn-mini"  onclick="javascript:action_viewhistory('viewhistory_ajax_page_data.do','pageId=${rhs.maxPage}')">最后页</a></#if>
		第${rhs.currentPage}页&nbsp;
		共${rhs.maxPage}页&nbsp;
		总${rhs.count}条记录
	</blockquote>
</div>