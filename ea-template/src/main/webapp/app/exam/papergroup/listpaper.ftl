		  <table>
		  <tbody>
		  	<#list  rhs["paperlist"]?sort_by("id") as paper>
				<tr>
					<td>
					  	<span style="auto;display:-moz-inline-box;display:inline-block;">
					  		<input type="checkbox" style="width:30px" 
					  		<#list rhs["papergroup"].papers as reqpaper>
					  			<#if reqpaper.id == paper.id>
					  				checked
					  			</#if>
					  		</#list>
				   			onclick="javascript:action_paper_admin('${rhs["papergroup"].id}','${paper.id}');" > ${paper.name}</input>
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
   	 