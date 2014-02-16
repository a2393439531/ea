<link href="view/view.css" rel="stylesheet">
<#include "include_highslide.ftl">
<#include "include_highslide_rolegroup.ftl">
<#include "macro_view.ftl">
<table>
   <tr>
       <#list  rhs["rolegroupRootList"] as rolegroup>
       <td valign=top>
	 		<table style="width:800px">
	 		    <tr><td colspan=2 align=center><b>${rolegroup.name}晋升图</b></td></tr>
				<tr>
				    <td valign=bottom width=150px> <br><img  width=150px height=120px src=../../common/images/up.png / ></td>
					<td valign=bottom>
						<table>
						    <@digui_rolegroup rolegroup.getChildRolegroups()?sort_by('sortNob'),"" />	
						</table>
					</td>
				</tr>
			</table>
       </td>
       </#list> 
   </tr>
</table>


