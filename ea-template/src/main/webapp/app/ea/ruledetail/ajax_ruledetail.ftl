<#include "../../../common/freemarker/include_select_align.ftl">
 <div id=div_ruledetail_table>
     <table   class="table  table-condensed">
	    <thead>
			<tr>
			    <th width=25px >ID</th>
				<th>内容编辑</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<#list rhs["dataList"]?sort_by("sortNob") as x>
			<tr>
				<td class=nob >
					${x_index+1}
				</td>		
				<td>
				    <a   href='common_edit_edit_bean_property.do?objectname=Ruledetail&op=r&propertyname=name&id=${x.id}' onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">编辑文字</a>&nbsp;&nbsp;&nbsp; 
                   	
                   	<a  href="common_file_image_upload.do?id=${x.id?if_exists}&beanname=Ruledetail&op=r&propertyfilepath=imagefilepath" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">插入图片</a>&nbsp;&nbsp;&nbsp;
                  
					<a  href="common_file_file_upload.do?id=${x.id?if_exists}&beanname=Ruledetail&op=r&propertyfilepath=videofilepath" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">插入视频</a>&nbsp;&nbsp;&nbsp;

					<a  href="common_file_file_upload.do?id=${x.id?if_exists}&beanname=Ruledetail&op=r&propertyfilepath=attachfilepath&propertyfilename=attachfilename" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">插入附件</a>

				    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    <#if x.imagefilepath?exists&& x.imagefilepath!="">
	 	         	               图片宽度<input type="text" style="width:30px" value='${x.imagewidth?if_exists}' onchange="javascript:action_ruledetail('update.do','parentId=${rhs["rule"].id?if_exists}&column=imagewidth&id=${x.id?if_exists}&columnValue='+this.value)" />
						   图片高度<input type="text" style="width:30px" value='${x.imageheight?if_exists}' onchange="javascript:action_ruledetail('update.do','parentId=${rhs["rule"].id?if_exists}&column=imageheight&id=${x.id?if_exists}&columnValue='+this.value)" />
					</#if>    
					&nbsp;&nbsp;&nbsp;
				    <#if x.videofilepath?exists&& x.videofilepath!="">
	 	         	               视频宽度<input type="text" style="width:30px" value='${x.videowidth?default("250")}' onchange="javascript:action_ruledetail('update.do','parentId=${rhs["rule"].id?if_exists}&column=videowidth&id=${x.id?if_exists}&columnValue='+this.value)" />
						   视频高度<input type="text" style="width:30px" value='${x.videoheight?default("150")}' onchange="javascript:action_ruledetail('update.do','parentId=${rhs["rule"].id?if_exists}&column=videoheight&id=${x.id?if_exists}&columnValue='+this.value)" />
					</#if>					      
				</td>
				
				<td>
				   
 					<a title="删除节点" onclick="javascript:action_ruledetail('delete.do','parentId=${rhs["rule"].id?if_exists}&id=${x.id}');" class="ui-icon ui-icon-trash"  title=删除 ></a>
				    <#if (rhs["dataList"]?size!=1)>
					    <#if (x_index?string=="0")> 
							<a  onclick="javascript:action_ruledetail('change_rank.do','parentId=${rhs["rule"].id?if_exists}&id_from=${x.id?if_exists}&id_to=${rhs["dataList"]?sort_by("sortNob")[x_index+1].id}')"  class="ui-icon ui-icon-arrowthick-1-s" title=下移></a>
						<#else>
							<a  onclick="javascript:action_ruledetail('change_rank.do','parentId=${rhs["rule"].id?if_exists}&id_from=${x.id?if_exists}&id_to=${rhs["dataList"]?sort_by("sortNob")[x_index-1].id}')"  class="ui-icon ui-icon-arrowthick-1-n" title=上移></a>
					    	<#if x_has_next>
				 	 			<a  onclick="javascript:action_ruledetail('change_rank.do','parentId=${rhs["rule"].id?if_exists}&id_from=${x.id?if_exists}&id_to=${rhs["dataList"]?sort_by("sortNob")[x_index+1].id}')"  class="ui-icon ui-icon-arrowthick-1-s" title=下移></a>
					        </#if>
					 	</#if> 						
				    </#if> 						  
				  	<#--刷新页面的方式，带来路径问题 -->
				    <select title=对齐 style="width:50px" onchange="javascript:action_ruledetail('update.do','parentId=${rhs["rule"].id?if_exists}&column=align&id=${x.id?if_exists}&columnValue='+this.value)"
						    >
						<#if  x?exists&&x.align?exists&&x.align!=""> <option value="${x.align?if_exists}"><@align  x.align?if_exists /></option></#if> 
						<option value="up">上</option>
						<option value="down">下</option>
						<option value="left">左</option>
						<option value="right">右</option>		   
				    </select> 	
				     
					
				</td>
			</tr>
		</#list> 
		</tbody>
	</table>    
</div>        
	<span id="div_action_result" style="display:none">${rhs["info"]?if_exists}</span>
