<#assign i=1 >
		  <table>
		  <tbody>
		  	<#list  rhs["usersList"]?sort_by("account") as user>
			
			<#if i==5>
				<tr>
				<#assign i=i-4>
			</#if>
					<td>
					  	<span style="width:90px;display:-moz-inline-box;display:inline-block;">
					  		<input type="checkbox" style="width:30px" <#list  rhs["role"].getUsers() as x><#if x.id==user.id> checked</#if></#list>
				   			onclick="javascript:action_organize_admin('ea_organize_create_user_role_relation.do','userId=${user.id}&roleId=${rhs["role"].id}&organizeId=${rhs["organize"].id}');" >${user.name?if_exists} </input>
				   		</span>
			  	    <td>
	  	    <#if i==5>
	  	    	</tr>
		  	</#if>
		  	<#assign i=i+1 >
		  	</#list>
		  </tbody>
		  
		 

   	
   	<br>
   	 