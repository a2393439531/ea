	<#list  rhs["usersList"]?sort_by("name") as user>
	   	       <input type="checkbox"  
		   	<#list  rhs["role"].getUsers() as x>
		  		<#if x.id==user.id> checked</#if>
			</#list>
		   		onclick="createUserRoleRelation(${user.id},${rhs["role"].id});" >
		   <lable>${user.name?if_exists}</lable> </input>
   	</#list>
   	<br>
   	 <a class="btn btn-xs btn-default"  onclick="window.location.reload();">确定</a>
   	