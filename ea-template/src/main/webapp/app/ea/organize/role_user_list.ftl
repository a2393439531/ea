
		  
		  <#list  rhs["usersList"]?sort_by("name") as user>
		   <input type="checkbox" style="width:50px" <#list  rhs["role"].getUsers() as x><#if x.id==user.id> checked</#if></#list>
		   	onclick="javascript:action_organize_admin('ea_organize_create_user_role_relation.do','userId=${user.id}&roleId=${rhs["role"].id}&organizeId=${rhs["organize"].id}');" >${user.name?if_exists} </input>
		  </#list>
		 

   	
   	<br>
   	 