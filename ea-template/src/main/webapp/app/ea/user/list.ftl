<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>user.js"></script>

		<#include "include_add_search.ftl">
		
		<hr>
		<div id=div_user_table style="padding:10px ">
			 <table   class="table  table-condensed">
    <thead>
		<tr>
			<th >name</th>
			<th  >account</th>
			<th  >password</th>
			<th  >Level</th>
			<th  >email</th>
			<th  >score</th>
			<th  >mark</th>
			<#--
			<th  >QQ</th>
			
			<th  >性别</th>
			<th  >身份证</th>
			<th >生日</th>
			
			<th  >毕业日期</th>
			<th  >入职日期</th>
			assessLev
			--->
			<th ></th>
			
		</tr>
	</thead>
	<tbody>
    <#assign sortName="account">    
	<#list rhs["dataList"]?sort_by(sortName) as x>                                                                                    
		<tr>
			<td><input style="width:50px" type="text"  value='${x.name?if_exists}' onchange="javascript:action_user('update.do','column=name&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))"/></td>
			<td><input style="width:100px"  type="text"  value='${x.account?if_exists}'   onchange="javascript:action_user('update.do','column=account&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /></td>
			<td><input style="width:100px"  type="text"  value='${x.passwd?if_exists}' onchange="javascript:action_user('update.do','column=passwd&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))"/></td>
			<#--
			<td>
				<select   style="width:40px" onchange="javascript:ajax_user('${x.id}','sex',this.value)">
				    <option value="${x.sex?if_exists}">${x.sex?if_exists}</option>
	  				<option value="男">男</option>
	  				<option value="女">女</option>
	 			<select>
			</td>
			--->
			<td>
				<select  style="width:50px" onchange="javascript:action_user('update.do','column=assessLev&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" >
				    <option value="${x.assessLev?if_exists}">${x.assessLev?if_exists}</option>
	  				<option value="T">T</option>
	  				<option value="A">A</option>
	  				<option value="B">B</option>
	  				<option value="C">C</option>
	  			
	  				<#--
	  				<option value="ST" title="无需评估">ST</option>
	  				<option value="ES">ES</option>
	  				-->
	 			<select>
			</td>
			
			<td><input  style="width:200px"   type="text"  value='${x.email?if_exists}' onchange="javascript:action_user('update.do','column=email&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /></td>					
			<td><input  style="width:30px"   type="text"  value='${x.score?if_exists}' onchange="javascript:action_user('update.do','column=score&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /></td>					
			<td><input  style="width:200px"   type="text"  value='${x.mark?if_exists}' onchange="javascript:action_user('update.do','column=mark&id=${x.id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /></td>					
			
			<#--
			<td><input  style="width:120px" type="text"  value='${x.qq?if_exists}'  onchange="javascript:ajax_user('${x.id}','qq',this.value)" /></td>
			
			<td><input  type="text"  value='${x.identityCard?if_exists}'  onchange="javascript:ajax_user('${x.id}','identityCard',this.value)" /></td>
			<td><input  style="width:80px" type="text"  value='${x.birthDate?if_exists}'  onchange="javascript:ajax_user('${x.id}','birthDate',this.value)" onClick="WdatePicker()"/></td>
			<td><input  style="width:80px" type="text" value='${x.graduateDate?if_exists}'  onchange="javascript:ajax_user('${x.id}' ,'graduateDate' ,this.value)" onClick="WdatePicker()"/></td>
			<td><input  type="text" value='${x.rollDate?if_exists}'  onchange="javascript:ajax_user('${x.id}' ,'rollDate' ,this.value)" onClick="WdatePicker()"/></td>
			-->
			<td>
			<span style="width:200px">
			<a  href="ea_ea_iframe_get_rolelist_of_user.do?id=${x.id?if_exists}" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">设置职位</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a title="Edit" href="ea_user_load.do?id=${x.id}">Edit</a> 
			<a title="删除" onclick="javascript:action_user('delete.do','id=${x.id}');"  title=删除 >删除</a>
			</span>
			
			</td>
		</tr>
	</#list> 
	</tbody>
</table>     
<p>
			显示条数<select style="WIDTH: 60px"   onchange="javascript:action_user('change_page_number.do','maxSize='+this.value)" >
					    <option value="${rhs["maxSize"]}">${rhs["maxSize"]}</option>
		  				<option value="5">5</option>
		  				<option value="10">10</option>
		  				<option value="20">20</option>
		  				<option value="50">50</option>
		  				<option value="200">200</option>
		 			<select>		
				<#if (rhs.currentPage > 1) ><a class="btn btn-link btn-mini" onclick="javascript:action_user('ajax_page_data.do','pageId=1')">第一页</a></#if>
				<#if (rhs.currentPage > 1) ><a class="btn btn-link btn-mini"  onclick="javascript:action_user('ajax_page_data.do','pageId=${rhs.currentPage-1}')">上一页</a></#if>
				<#if (rhs.currentPage < rhs.maxPage) ><a class="btn btn-link btn-mini" onclick="javascript:action_user('ajax_page_data.do','pageId=${rhs.currentPage+1}')">下一页</a></#if>
				<#if (rhs.currentPage < rhs.maxPage) ><a class="btn btn-link btn-mini"  onclick="javascript:action_user('ajax_page_data.do','pageId=${rhs.maxPage}')">最后页</a></#if>
			第${rhs.currentPage}页&nbsp;
			共${rhs.maxPage}页&nbsp;
			总${rhs.count}条记录
	</p>
<span id="div_action_result" style="display:none">
	${rhs["info"]?if_exists}
</span>   
	