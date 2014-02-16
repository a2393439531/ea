<table >  
    <tr><td style="border: 0px;">
        <table>
		    <thead>
				<tr><td width=70>姓名</td><td width=200>权限</td></tr>
			</thead>
			<tbody>
				<tr >
					<td>${rhs["name"]?if_exists}</td>
					<td>
					<#if rhs["list"]?has_content>
						<#list rhs["list"] as x>
							${x}<br>
						</#list> 
					<#else>
						<a style="font-weight:bold;color:red; padding:10px ">没有权限</a>
					</#if>
					</td>
				</tr>
			</tbody>
		 </table>
    </td></tr>
</table>     