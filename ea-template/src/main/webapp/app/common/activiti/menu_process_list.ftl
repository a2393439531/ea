<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>tpltb2.js"></script>
<div class="container-fluid" >

	<div class="panel panel-default">
       
        <div class="panel-heading"><strong>企业流程</strong></div>
        <div class="panel-body">
          <table class="table table-condensed table-hover">
				<thead>
				<tr>
					
					<th >流程列表</th>
					<th width="150">操作</th>
				</tr>
				</thead>
				<tbody>
				<#list rhs["list"] as item>
					<tr title="file${item[0].name}">
						<td title="${item[0].name} Version: ${item[0].version}"><b>${item[0].name}</b> ${item[0].getDescription()?if_exists}</td>
						<#--<td>${item[1].id}</td>
						<td>${item[0].key}</td>
						<td>${(item[1].getDeploymentTime()?if_exists)?datetime}</td>-->
						<td>
							<a href="common_activiti_start_process_pre.do?processKey=${item[0].key}&assignee=${Session["userlogined"].account?if_exists}" target=org-right > 启动</a>
							<a href="common_activiti_process_diagram.do?processDefinitionId=${item[0].id}" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">
								流程图
							</a>
						
						</td>
					</tr>
					</#list>
				</tbody>
			</table>
        </div>
      </div>
		
			

	</div>
</div>

						
						
