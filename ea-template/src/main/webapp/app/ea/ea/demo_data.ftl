
<#include "../../../common/freemarker/include_header.ftl">
<#include "../../../common/freemarker/include_select_users.ftl">

<div  style="margin:10px">
	 <div class="panel panel-default">
	    <div class="panel-heading">
	      <h3 class="panel-title">常见选择模式</h3>
	    </div>
	    <div class="panel-body">
			<br>单选选择用户
			    <input type="hidden" id="assignee" name="assignee"/>
				<input type="text" class="input-small" id="assigneeText" 
				onclick="javascript:open_select_users_dialog(document.getElementById('assigneeText'),document.getElementById('assignee'),1);" onchange="alert('')"/>
				多选择用户
			    <input type="hidden" id="assigneeM" name="assigneeM"/>
				<input type="text" class="input-small" id="assigneeMText" 
				onclick="javascript:open_select_users_dialog(document.getElementById('assigneeMText'),document.getElementById('assigneeM'),2);" />
				
				 &nbsp;选组下拉框				        
				<select  style="width:200px" onchange="alert(this.value)">
				   <option   value="">选择“悬赏任务”的可分配组</option> 
				   <optgroup label="所有员工">
				   <option   value="all">所有员工</option> 
				   <@get_candidategroup_by_organize rhs["organizeRootList"]?sort_by('sortNob'),"" />	  
				   <@get_candidategroup_by_rolegroup rhs["rolegroupRootList"]?sort_by('sortNob'),"" />	
				</select> 		 
	    </div>
	  </div>
	    

   
	<!-- Table -->
	<table class="table table-bordered">
	    <thead>
		    <tr>
		        <th>企业组织架构测试数据</th><th>组织架构图</th>
		    </tr>
	    </thead>
	  	<tbody>
	        <tr>
	        	<td>
		        	<table class="table table-bordered">
					    <thead>
						    <tr>
						        <th>岗位</th><th>职位</th>
						        
						    </tr>
					    </thead>		
						<tbody>
					        <tr> <td> CEO</td><td>	 xx企业-CEO 	</td></tr>
					         <tr> <td> 部门经理</td><td>	 生产部-部门经理 <br> 客服部-部门经理</td></tr>
					        <tr> <td> 员工</td><td>	 生产部-员工	 <br> 客服部-员工</td></tr>
					    </tbody>		  	
					</table>	

	       
                </td>
	      	    <td><a href="ea_view_picture_role_user_v.do?roleId=1&img=yes&width=70&height=80" target=_blank><img src=common/images/demo/user.png width=400 height=450/></a>
				</td>
	      	</tr>
	      
	  	</tbody>
	</table>


	 <table   class="table table-bordered table-condensed  table-indie">
	    <thead>
			<tr>
				<th>姓名</th>
				<th>帐号</th>
				<th>密码</th>
				<th>所属组 </th>			
				<th>所属组[职位]</th>
				<th>所属组[岗位]</th>
				<th>所属组[部门]</th>
	
			</tr>
		</thead>
		<tbody>
		<#list rhs["userList"] as u>                                                                                    
			<tr>
				<td>${u.name?if_exists}</td>
				<td>${u.account?if_exists}</td>
				<td>${u.passwd?if_exists}</td>
				<td>
				${u.candidateGroups()?if_exists}
				
				</td>			
				<td>
					<#list u.getRoles()  as role>
			    	  ${role.name} <span title="${role.name}">${role.alias},</span>
		    	    </#list>				
				</td>
				<td>
					<#list u.getRoles()  as role>
					   <#list role.getRolegroups()  as r>
			    	   ${r.name} <span title="${r.name}">${r.alias},</span>
			    	    </#list>
		    	    </#list>				
				</td>
				<td>
					<#list u.getRoles()  as role>
					   <#list role.getOrganizes()  as o>
			    	   ${o.name}<span title="${o.name}">${o.alias},</span>
			    	    </#list>
		    	    </#list>				
				</td>	
									
			</tr>
		</#list> 
		</tbody>
	</table>     
		

	
</div>

