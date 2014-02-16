<#list rhs["list"] as x>
	${x.createTime?if_exists}&nbsp;&nbsp;&nbsp;&nbsp;${x.userName?if_exists}
	<br>
	${x.log?if_exists}
	<br>
	(${x.taskName?if_exists})
	<br><br>
</#list> 