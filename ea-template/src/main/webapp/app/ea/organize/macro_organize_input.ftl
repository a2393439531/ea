<#macro digui_organize organizeNodes  flag >
	<#list organizeNodes as organize>
	    <tr>
	    	<td >
		    		${flag}<input  value="${organize.name?if_exists}" 
			      style="WIDTH: 120px"
			       onclick="window.parent.frames['org-right'].document.location='ea_view_picture_organize_v.do?id=<#if organize.getParentModel()?exists>${organize.getParentModel().id?if_exists}<#else>${organize.id?if_exists}</#if>'" onchange="javascript:action_organize('update.do','column=name&id=${organize.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /> 
			     <#--
			       onclick="javascript:document.getElementById('previewFrame').src='ea_view_picture_organize_v.do?id=<#if organize.getParentModel()?exists>${organize.getParentModel().id?if_exists}<#else>${organize.id?if_exists}</#if>'" onchange="javascript:action_organize('update.do','column=name&id=${organize.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /> 

					英文<input  value="${organize.alias?if_exists}" 
			      style="WIDTH: 120px"  onchange="javascript:action_organize('update.do','column=alias&id=${organize.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /> 
			    -->
			
			<#if flag!="">  
				<a   href="ea_organize_admin.do?organizeId=${organize.id}" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" class="btn btn-xs btn-default"><span class="ui-icon ui-icon-gear" title="设置"></span></a>
			</#if>    
			</td>
			<td width=250px>		 	  
			    <div class="btn-group">
			   
				<a  onclick="javascript:action_organize('create.do','id=${organize.id}');" class="ui-icon ui-icon-plus" ></a>
 		  
				<a title="编辑架构说明" href="common_edit_edit_bean_property.do?objectname=Organize&op=r&propertyname=organizedescription&id=${organize.id}" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" class="ui-icon ui-icon-pencil"></a>               
 			    <a  href="common_file_image_upload.do?id=${organize.id}&beanname=Organize&op=r&propertyfilepath=imgfilename" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })"  class="ui-icon ui-icon-image" ></a>
			    <a title="浏览本组织架构" href="ea_view_picture_organize_v.do?id=${organize.id?if_exists}" target=_blank class="ui-icon ui-icon-extlink"></a>	 	




  		  		
 			<#if (organize.getChildOrganizes()?size<1)> 
				<a  title="删除节点" onclick="javascript:action_organize('delete.do','id=${organize.id}');" class="ui-icon ui-icon-trash"  title=删除 ></a>
		  	</#if> 				
			<#if organizeNodes?size?string=="1" > 
				<a  onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}');" class="ui-icon ui-icon-arrowthick-1-w" title=前1级 ></a>     
			<#else>
				<#assign index =organize_index>                                                
			 	<#if index?string=="0">
			 	    <a  onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index+1].id}')"     class="ui-icon ui-icon-arrowthick-1-s"  title=下移></a>
			  	    <a  onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}')"       class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>   
			 	<#else>
			 	    <#if organize_has_next>
				 	    <a  onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
						<a  onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index+1].id}')"  class="ui-icon ui-icon-arrowthick-1-s" title=下移></a>
					<#else>
					    <a onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
					</#if>
					<a onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}')"  class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>      
	 				<a onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}&parentId=${organizeNodes[organize_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-e" title=后1级></a>	
			 	</#if>
			</#if>
			
			
			  <#--
				   <a type="button"  onclick="javascript:action_organize('create.do','id=${organize.id}');" class="btn btn-xs  btn-default"> <span class="glyphicon glyphicon-plus"  title="新增"></span></a>
                 
					<a title="编辑架构说明" href="common_edit_edit_bean_property.do?objectname=Organize&op=r&propertyname=organizedescription&id=${organize.id}" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" class="btn btn-xs  btn-default"><span class="glyphicon glyphicon-pencil"  title="编辑"></span></a>               
	 			    <a  href="common_file_image_upload.do?id=${organize.id}&beanname=Organize&op=r&propertyfilepath=imgfilename" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" class="btn btn-xs  btn-default"><span class="glyphicon glyphicon-picture"  title="编辑"></span></a>
				    <a title="浏览本组织架构" href="ea_view_picture_organize_v.do?id=${organize.id?if_exists}" target=_blank  class="btn btn-xs  btn-default"><span class="glyphicon glyphicon-search"  title="预览"></span></a>	 	
-->
			
 	        <#--
			<#if organizeNodes?size?string=="1" > 
				<a  onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}');" class="btn btn-xs  btn-default"> <span class="glyphicon glyphicon-arrow-left"  title="前一级"></span></a>     
			<#else>
				<#assign index =organize_index>                                                
			 	<#if index?string=="0">
			 	    <a  onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index+1].id}')"    class="btn btn-xs  btn-default"> <span class="glyphicon glyphicon-arrow-down"  title="下"></span></a>
			  	    <a  onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}')"  class="btn btn-xs  btn-default"> <span class="glyphicon glyphicon-arrow-left"  title="前1级"></span></a>
			 	<#else>
			 	    <#if organize_has_next>
				 	    <a  onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index-1].id}')"   class="btn btn-xs  btn-default"> <span class="glyphicon glyphicon-arrow-up"  title="上"></span></a>
						<a  onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index+1].id}')"   class="btn btn-xs  btn-default"> <span class="glyphicon glyphicon-arrow-down"  title="下"></span></a>
					<#else>
					    <a onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index-1].id}')"  class="btn btn-xs  btn-default"> <span class="glyphicon glyphicon-arrow-up"  title="上"></span></a>
					</#if>
					<a onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}')"  class="btn btn-xs  btn-default"> <span class="glyphicon glyphicon-arrow-left"  title="前1级"></span></a>          
	 				<a onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}&parentId=${organizeNodes[organize_index-1].id}')" class="btn btn-xs  btn-default"> <span class="glyphicon glyphicon-arrow-right"  title="后1级"></span></a>
			 	</#if>
			</#if>  
			<#if (organize.getChildOrganizes()?size<1)> 
				<a  title="删除节点" onclick="javascript:action_organize('delete.do','id=${organize.id}');" type="button" class="btn btn-xs btn-default"  title=删除 ><span class="glyphicon glyphicon-trash"  title="删除"></span></a>
		  	</#if> 						       
           -->
			  
			  </div>
  
  <#--
  	   
  		  		<a  onclick="javascript:action_organize('create.do','id=${organize.id}');" class="ui-icon ui-icon-plus" ></a>
 			<#if (organize.getChildOrganizes()?size<1)> 
				<a  title="删除节点" onclick="javascript:action_organize('delete.do','id=${organize.id}');" class="ui-icon ui-icon-trash"  title=删除 ></a>
		  	</#if> 				
			<#if organizeNodes?size?string=="1" > 
				<a  onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}');" class="ui-icon ui-icon-arrowthick-1-w" title=前1级 ></a>     
			<#else>
				<#assign index =organize_index>                                                
			 	<#if index?string=="0">
			 	    <a  onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index+1].id}')"     class="ui-icon ui-icon-arrowthick-1-s"  title=下移></a>
			  	    <a  onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}')"       class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>   
			 	<#else>
			 	    <#if organize_has_next>
				 	    <a  onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
						<a  onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index+1].id}')"  class="ui-icon ui-icon-arrowthick-1-s" title=下移></a>
					<#else>
					    <a onclick="javascript:action_organize('change_rank.do','id_from=${organize.id?if_exists}&id_to=${organizeNodes[organize_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
					</#if>
					<a onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}')"  class="ui-icon ui-icon-arrowthick-1-w" title=前1级></a>      
	 				<a onclick="javascript:action_organize('change_level.do','id=${organize.id?if_exists}&parentId=${organizeNodes[organize_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-e" title=后1级></a>	
			 	</#if>
			</#if>
				<a title="编辑架构说明" href="common_edit_edit_bean_property.do?objectname=Organize&op=r&propertyname=organizedescription&id=${organize.id}" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" class="ui-icon ui-icon-pencil"></a>               
 			    <a  href="common_file_image_upload.do?id=${organize.id}&beanname=Organize&op=r&propertyfilepath=imgfilename" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })"  class="ui-icon ui-icon-image" ></a>
			    <a title="浏览本组织架构" href="ea_view_picture_organize_v.do?id=${organize.id?if_exists}" target=_blank class="ui-icon ui-icon-extlink"></a>	 	
-->
			</td>
			
		  
		  <#if !(organize.getChildOrganizes()?size<1)> 
		      <@digui_organize organize.getChildOrganizes()?sort_by('sortNob'),flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />	
		  </#if>
	</#list> 
</#macro>