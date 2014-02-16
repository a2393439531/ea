<br>
	别名：<input value="${rhs["resource"].alias?if_exists}"  style="width=300"
		onchange="javascript:action_resource('update.do','column=alias&id=${rhs["resource"].id?if_exists}&columnValue='+this.value)" />
<#--
<br>
	Url：<input  value="${rhs["resource"].actionUrl?if_exists}"  style="width=300"
		onchange="javascript:action_resource('update.do','column=actionUrl&id=${rhs["resource"].id?if_exists}&columnValue='+this.value)"  />
-->
<hr>