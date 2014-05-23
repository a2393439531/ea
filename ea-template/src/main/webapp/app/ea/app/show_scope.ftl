<#include "../../../common/freemarker/include_header.ftl"> 
 		 <table   class="table table-bordered table-condensed ">
		    <thead>
		    <tr><th >职位</th><th>上级</th><th>工作详细说明</th></tr>
		    </thead>
			<#list rhs["user"].getRoles() as role>
			<tr>
				<td valign=top>
					${role.name}
				</td>
				<td valign=top>
					<#if role.getParentModel()?exists>
					<#assign parent_role=role.getParentModel()/>
					     <#list parent_role.getUsers() as u>
					   	   ${u.name?if_exists}（${parent_role.name}）
						</#list>
					
					</#if>
				</td>	
				<td valign=top width=60%>
				    <#if role.getRolegroups()[0]?exists&&role.getRolegroups()[0].positiondescription?exists>	
						岗位说明:<br>
						${role.getRolegroups()[0].positiondescription?if_exists}
					</#if>
				    <#if role.positiondescription?exists>	
						职位说明:<br>
						${role.positiondescription?if_exists}
					</#if>
				</td>
			</tr>	
			</#list>
		</table>
 