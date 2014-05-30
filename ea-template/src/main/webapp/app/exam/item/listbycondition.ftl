		  <table>
		  <tbody>
		  	<#list  rhs["itemlist"]?sort_by("id") as item>
				<tr>
					<td>
					  	<span style="auto;display:-moz-inline-box;display:inline-block;">
					  		<input type="checkbox" style="width:30px" 
					  		<#list rhs["paper"].items as reqitem>
					  			<#if reqitem.id == item.id>
					  				checked
					  			</#if>
					  		</#list>
				   			onclick="javascript:action_item_admin('${rhs["paper"].id}','${item.id}',${item.type});" > ${item.content}</input>
				   		</span>
			  	    <td>
	  	    	</tr>
		  	</#list>
		  	<#if rhs["info"]?exists >
		  		<tr>
		  			<td>${rhs["info"]}</td>
		  		</tr>
		  	</#if>
		  </tbody>
		  </table>
		 

   	
   	<br>
   	 