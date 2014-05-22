<#macro digui_papergroup paperNodes  flag paperroot >
	<#list paperNodes as paper>
	<#assign index =paper_index>                                                
		<table>
			<tr>
				<td>		
					${paper_index+1}.&nbsp;&nbsp;<a href="#" onclick="javascript:ajax_show_paper('exam_paper_load.do','method=show&id=${paper.id}');" >${paper.name}</a>
				</td>
				<td>
					<#if flag?string=="false">
					<#if index?string=="0">
					 	<a  onclick="javascript:action_paper('change_rank.do','id_from=${paper.id?if_exists}&id_to=${paperNodes[paper_index+1].id}&id=${paperroot.id}')"  class="ui-icon ui-icon-arrowthick-1-s" title=下移></a>
					<#else>
					 <#if paper_has_next>
					 	 <a  onclick="javascript:action_paper('change_rank.do','id_from=${paper.id?if_exists}&id_to=${paperNodes[paper_index+1].id}&id=${paperroot.id}')"  class="ui-icon ui-icon-arrowthick-1-s" title=下移></a>
					 	 <a  onclick="javascript:action_paper('change_rank.do','id_from=${paper.id?if_exists}&id_to=${paperNodes[paper_index-1].id}&id=${paperroot.id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
					 <#else>
					 	 <a  onclick="javascript:action_paper('change_rank.do','id_from=${paper.id?if_exists}&id_to=${paperNodes[paper_index-1].id}&id=${paperroot.id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
					 </#if>
					</#if>
					</#if>
				</td>
				<input type="hidden" name="paperid" value="${paper.id}">
			</tr>
		</table>
	</#list> 
</#macro>