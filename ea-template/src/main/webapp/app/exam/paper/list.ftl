<#include "../../../common/freemarker/include_header.ftl">
<script>

	function action_paper_start_process(id, assignee){
		$('#startProcess' + id).text('waitting');
		$("#startProcess" + id).attr("onclick","");
		$.ajax({
			type: 'post',
			url: 'exam_paper_assign.do',
			data: 'id=' + id,
			cache: false,
			success: function(html){
			   document.location.href = "exam_paper_list.do";
			}
		});  
	}

</script>
<body> 
   		<#include "include_add_search.ftl">
		<br><br><a style="margin-left:10px;margin-top:5px;" class="btn btn-primary "  href="exam_paper_save.do?method=show">新建试卷</a>
		
	<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong>Template List</strong></div>
      <div class="panel-body">
			
			
		
		<table class="table table-condensed table-hover">
	    <thead>
			<tr>
			    <td width=25px><strong>#</strong></td>
				<td width=500px><strong>试卷标题</strong></td>
				<td width=100px><strong>通过分</strong></td>
				<td width=100px><strong>总分</strong></td>
				<td width=100px><strong>考试时间</strong></td>
				<td><strong>操作</strong></td>
				<td></td>
			</tr>
		</thead>
		<tbody>
			<#list rhs["dataList"] as x>
			 <tr>
			    <td class=nob >${x_index+1}</td>
				<td>${x.businessModel.name?if_exists}</td>
				<td>${x.businessModel.passmark?if_exists}</td>
				<td>${x.businessModel.totalmark?if_exists}</td>
				<td>${x.businessModel.time?if_exists} &nbsp;(Minutes)</td>
				<td><a href="exam_paper_load.do?method=edit&id=${x.businessModel.id}">编辑</a> | <a href="exam_paper_load.do?method=show&id=${x.businessModel.id}"> 查看</a> | <a href="exam_paper_delete.do?id=${x.businessModel.id}">删除</a></td>
				<td>
				<a id="startProcess${x.businessModel.id}" title="Start Process" class="btn btn-xs btn-primary"
					    		href="exam_paper_assign.do?id=${x.businessModel.id}" >
					    		Start</a>
				</td>
			</tr>
			</#list>
		</tbody>
	</table>       
		<#include "../../../common/freemarker/macro_pagination.ftl">
		<@pagination  "search_form" />
      </div>
    </div>
		
		
</body>