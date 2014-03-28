<head>
<style>
.table-condensed th, .table-condensed td {
	padding-top: 0px;
	padding-bottom: 0px;
}
</style>

</head>
<#macro digui_knowledge knowledgeNodes  flag >
	<#list knowledgeNodes as knowledge>
		<tr>
	    	<td width=700px height=30px >
				${flag} 
	    		<span>名称: </span><input value="${knowledge.name?if_exists}" style="width: 120px; height: 14px;" onchange="javascript:action_knowledge('update.do','column=name&id=${knowledge.id?if_exists}&columnValue='+this.value)" /> 
			    <span>别名:</span><input value="${knowledge.alias?if_exists}" style="width: 120px; height: 14px;"  onchange="javascript:action_knowledge('update.do','column=alias&id=${knowledge.id?if_exists}&columnValue='+this.value)" /> 
			</td>
			
			<td width=200px>		 	     
  		  		<a  onclick="javascript:action_knowledge('create.do','id=${knowledge.id}');" class="ui-icon ui-icon-plus" title=添加下一级 ></a>
 			<#if (knowledge.getChildKnowledges()?size<1)> 
				<a title="删除节点" onclick="javascript:action_knowledge('delete.do','id=${knowledge.id}');" class="ui-icon ui-icon-trash"  title=删除 ></a>
		  	</#if> 				
			<#if knowledgeNodes?size?string=="1"> 
				<a onclick="javascript:action_knowledge('change_level.do','id=${knowledge.id?if_exists}');" class="ui-icon ui-icon-arrowthick-1-w" title=前1级 ></a>     
			<#else>
				<#assign index =knowledge_index>                                    
				<#if index?string=="0">
					<a onclick="javascript:action_knowledge('change_rank.do','id_from=${knowledge.id?if_exists}&id_to=${knowledgeNodes[knowledge_index+1].id}')" class="ui-icon ui-icon-arrowthick-1-s"  title=下移></a>
			  	    <a onclick="javascript:action_knowledge('change_level.do','id=${knowledge.id?if_exists}')" class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>   
			 	<#else>
			 	    <#if knowledge_has_next>
			 	    	<a onclick="javascript:action_knowledge('change_rank.do','id_from=${knowledge.id?if_exists}&id_to=${knowledgeNodes[knowledge_index-1].id}')" class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
						<a onclick="javascript:action_knowledge('change_rank.do','id_from=${knowledge.id?if_exists}&id_to=${knowledgeNodes[knowledge_index+1].id}')" class="ui-icon ui-icon-arrowthick-1-s" title=下移></a>
					<#else>
					    <a onclick="javascript:action_knowledge('change_rank.do','id_from=${knowledge.id?if_exists}&id_to=${knowledgeNodes[knowledge_index-1].id}')" class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
					</#if>
					<a onclick="javascript:action_knowledge('change_level.do','id=${knowledge.id?if_exists}')"  class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>      
	 				<a onclick="javascript:action_knowledge('change_level.do','id=${knowledge.id?if_exists}&parentId=${knowledgeNodes[knowledge_index-1].id}')" class="ui-icon ui-icon-arrowthick-1-e" title=后1级></a>	
			 	</#if>
			</#if>
			</td>
		</tr>
		  
		<#if !(knowledge.getChildKnowledges()?size<1)> 
			<@digui_knowledge knowledge.getChildKnowledges()?sort_by('sortNob'),flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />	
		</#if>
	</#list> 
</#macro>
 
<table class="table  table-condensed" style="width:1000px">
	<thead>
		<tr>
			<th>树型内容</th><th>操作</th>
		</tr>
	</thead>   
    <@digui_knowledge rhs["knowledgeRootList"]?sort_by('sortNob'),""/>
</table>

<span id="div_action_result" style="display:none">
	${rhs["info"]?if_exists}
</span>
