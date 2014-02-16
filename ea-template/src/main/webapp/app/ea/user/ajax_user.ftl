 <table   class="table table-bordered table-condensed  table-indie">
    <thead>
		<tr>

  		   	
			<th>姓名</th>
			<th>帐号</th>
			<th>密码</th>
			<th>手机号码</th>
			<th>身份证</th>						
			<th>QQ</th>	
			<#if rhs["system_para_map"]?exists&& rhs["system_para_map"]["user-status"]?exists>
			<th>状态</th>
			</#if>
			<th>级别</th>
			<th>email</th>
			<#---
			<th>score</th>
			<th>kso</th>
			<th>sog</th>
			-->
			<th></th>
			
		</tr>
	</thead>
	<tbody>
    <#assign sortName=Session["sortName"]?default("id")> 
	<#list rhs["dataList"]?sort_by(sortName) as x>                                                                                    
		<tr>
			<td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input style="width:50px" type="text"  value='${x.name?if_exists}' onchange="javascript:action_user('update.do','column=name&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))"/></td>
			<td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input style="width:100px"  type="text"  value='${x.account?if_exists}'   onchange="javascript:action_user('update.do','column=account&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /></td>
			<td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input style="width:100px"  type="text"  value='${x.passwd?if_exists}' onchange="javascript:action_user('update.do','column=passwd&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))"/></td>
	        <td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input  style="width:100px" type="text"  value='${x.phoneNumber?if_exists}'  onchange="javascript:action_user('update.do','column=phoneNumber&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /></td>
		    <td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input style="width:100px"  type="text"  value='${x.identityCard?if_exists}'   onchange="javascript:action_user('update.do','column=identityCard&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /></td>
   		   	<td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input  style="width:100px" type="text"  value='${x.qq?if_exists}'  onchange="javascript:action_user('update.do','column=qq&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))"  />
   		   
					
			<#if  rhs["system_para_map"]?exists&&rhs["system_para_map"]["user-status"]?exists>
			<td onmouseover="rowOver(this)" onmouseout="rowOut(this)">
				<select   style="width:50px"  onchange="javascript:action_user('update.do','column=status&id=${x.id?if_exists}&columnValue='+this.value)">
				    <#if x.status?exists><option value="${x.status?if_exists}">${rhs["system_para_map"]["user-status"][x.status]?if_exists}</option>
				    <#else><option value="normal">在职</option></#if>
				    <#list  rhs["system_para_map"]["user-status"]?keys as key>
					   <option value="${key}">${rhs["system_para_map"]["user-status"][key]?if_exists}</option>
					</#list> 
				</select> 	
			</td>			
			</#if>
			
			<td onmouseover="rowOver(this)" onmouseout="rowOut(this)">
				<select  style="width:50px" onchange="javascript:action_user('update.do','column=assessLev&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" >
				    <option value="${x.assessLev?if_exists}">${x.assessLev?if_exists}</option>
	  				<option value="T">T</option>
	  				<option value="A">A</option>
	  				<option value="B">B</option>
	  				<option value="C">C</option>
	  			<select>
			</td>
			
			<td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input  style="width:200px"   type="text"  value='${x.email?if_exists}' onchange="javascript:action_user('update.do','column=email&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /></td>					
			<#--
			<td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input  style="width:30px"   type="text"  value='${x.score?if_exists}' onchange="javascript:action_user('update.do','column=score&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /></td>					
			<td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input  style="width:30px"   type="text"  value='${x.sognumber?if_exists}' onchange="javascript:action_user('update.do','column=sognumber&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /></td>					
			<td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input  style="width:30px"   type="text"  value='${x.ksonumber?if_exists}' onchange="javascript:action_user('update.do','column=ksonumber&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /></td>					
			-->
			
			<td >
			<span style="width:220px">
			
				<a  class="btn btn-xs btn-info" href='ea_user_profile_edit.do?${x.id?if_exists}' onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">信息</a>
			     <a target="mainFrame" href='common_edit_edit_bean_property.do?objectname=User&op=r&propertyname=mark&id=${x.id?if_exists}' onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">评价</a>&nbsp;&nbsp;
	   <a  href="common_notify_send_email.do?userId=${x.id?if_exists}" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">email</a>&nbsp;&nbsp;
				
	   
	    
				<a  href="common_file_image_upload.do?id=${x.id?if_exists}&beanname=User&op=r&propertyfilepath=imgfilename" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">照片</a>&nbsp;&nbsp;
					
				<a  href="ea_ea_iframe_get_rolelist_of_user.do?id=${x.id?if_exists}" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">职位</a>&nbsp;&nbsp;
				
				<a  title="删除" onclick="javascript:action_user('delete.do','id=${x.id}');"  title=删除 >删除</a>
			</span>
			
			</td>
		</tr>
	</#list> 
	</tbody>
</table>     
	<p class="pull-right">
				<#if (rhs.currentPage > 1) ><a onclick="javascript:action_user('ajax_page_data.do','pageId=1')">第一页</a></#if>
				<#if (rhs.currentPage > 1) ><a   onclick="javascript:action_user('ajax_page_data.do','pageId=${rhs.currentPage-1}')">上一页</a></#if>
				<#if (rhs.currentPage < rhs.maxPage) ><a  onclick="javascript:action_user('ajax_page_data.do','pageId=${rhs.currentPage+1}')">下一页</a></#if>
				<#if (rhs.currentPage < rhs.maxPage) ><a   onclick="javascript:action_user('ajax_page_data.do','pageId=${rhs.maxPage}')">最后页</a></#if>

			第${rhs.currentPage}页&nbsp;
			共${rhs.maxPage}页&nbsp;
			总${rhs.count}条记录
			显示条数<select style="WIDTH: 60px"   onchange="javascript:action_user('change_page_number.do','maxSize='+this.value)" >
					    <option value="${rhs["maxSize"]}">${rhs["maxSize"]}</option>
		  				<option value="5">5</option>
		  				<option value="10">10</option>
		  				<option value="20">20</option>
		  				<option value="50">50</option>
		  				<option value="200">200</option>
		  				<option value="1000">1000</option>
		 			<select>		

	</p>
<span id="div_action_result" style="display:none">${rhs["info"]?if_exists}</span>   