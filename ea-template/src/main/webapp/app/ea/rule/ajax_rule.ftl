
<#macro digui_rule ruleNodes  flag >
	<#list ruleNodes as rule>
		 
	    <tr>
	    	<td width=700px  onmouseover="rowOver(this)" onmouseout="rowOut(this)">
	    		${flag}<input  value="${rule.name?if_exists}" 
			      style="WIDTH: 500px"  onchange="javascript:action_rule('update.do','column=name&id=${rule.id?if_exists}&columnValue='+this.value)" /> 
			</td>
			<td width=200px  >		 	     
			    <a href=ea_ruledetail_menu_ruledetail.do?parentId=${rule.id}   target=mainFrame ><span class="glyphicon glyphicon-pencil"  title="编辑"></span></a>
			    	<a href=ea_rule_detail.do?id=${rule.id?if_exists} onclick="return hs.htmlExpand(this, { objectType: 'iframe' })"><span class="glyphicon glyphicon-search"  title="预览"></span></a>
  		  		<a  onclick="javascript:action_rule('create.do','id=${rule.id}');" class="ui-icon ui-icon-plus" ></a>
  		  		
 			<#if (rule.getChildRules()?size<1)> 
				<a title="删除节点" onclick="javascript:action_rule('delete.do','id=${rule.id}');" class="ui-icon ui-icon-trash"  title=删除 ></a>
		  	</#if> 				
			<#if ruleNodes?size?string=="1" > 
				<a onclick="javascript:action_rule('change_level.do','id=${rule.id?if_exists}');" class="ui-icon ui-icon-arrowthick-1-w" title=前1级 ></a>     
			<#else>
				<#assign index =rule_index>                                                
			 	<#if index?string=="0">
			 	    <a  onclick="javascript:action_rule('change_rank.do','id_from=${rule.id?if_exists}&id_to=${ruleNodes[rule_index+1].id}')"     class="ui-icon ui-icon-arrowthick-1-s"  title=下移></a>
			  	    <a  onclick="javascript:action_rule('change_level.do','id=${rule.id?if_exists}')"       class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>   
			 	<#else>
			 	    <#if rule_has_next>
				 	    <a  onclick="javascript:action_rule('change_rank.do','id_from=${rule.id?if_exists}&id_to=${ruleNodes[rule_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
						<a  onclick="javascript:action_rule('change_rank.do','id_from=${rule.id?if_exists}&id_to=${ruleNodes[rule_index+1].id}')"  class="ui-icon ui-icon-arrowthick-1-s" title=下移></a>
					<#else>
					    <a onclick="javascript:action_rule('change_rank.do','id_from=${rule.id?if_exists}&id_to=${ruleNodes[rule_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
					</#if>
					<a onclick="javascript:action_rule('change_level.do','id=${rule.id?if_exists}')"  class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>      
	 				<a onclick="javascript:action_rule('change_level.do','id=${rule.id?if_exists}&parentId=${ruleNodes[rule_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-e" title=后1级></a>	
			 	</#if>
			</#if>
			</td>
		 
		  
		  <#if !(rule.getChildRules()?size<1)> 
		      <@digui_rule rule.getChildRules()?sort_by('sortNob'),flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />	
		  </#if>
	</#list> 
</#macro>
 
<table    class="table table-bordered  table-condensed" style="width:1000px">
     <thead>
		<tr>
			<th>文档目录标题</th><th>操作</th>
		</tr>
	</thead>   
	<@digui_rule rhs["ruleRootList"]?sort_by('sortNob'),""/>
</table>
<span id="div_action_result" style="display:none">
	${rhs["info"]?if_exists}
</span>

