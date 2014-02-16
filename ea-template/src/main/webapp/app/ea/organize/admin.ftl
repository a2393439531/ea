

<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context/>app/ea/ea/ea.js"></script>
<script type="text/javascript" src="<@context/>app/ea/role/role.js"></script>
<script type="text/javascript" src="<@context_module/>organize.js"></script>
<#macro digui_rolegroup rolegroupNodes  flag >
	<#list rolegroupNodes as rolegroup>
		<#if !(rolegroup.getParentModel()?exists)> 
		<optgroup label="${rolegroup.name?if_exists}">
		<#else>
		 	<option   value="${rolegroup.id}">${flag} ${rolegroup.name?if_exists}</option> 
		</#if>
		<#if !(rolegroup.getChildRolegroups()?size<1)> 
		      <@digui_rolegroup rolegroup.getChildRolegroups()?sort_by('sortNob'),flag+"&nbsp;&nbsp;&nbsp;" />	
		</#if>
		<#if !(rolegroup.getParentModel()?exists)>  
		</optgroup>
		</#if>
	</#list> 
</#macro>

<script>
	$(function() {$( "#div_scoll" ).draggable();});  
	
	function  scrolldiv_(id,h){  //定位层
	   obj=document.getElementById(id);
	   obj.style.top =  document.body.scrollTop;
	}
	
	function  show_dir(){  //定位层
	  if( document.getElementById('div_scoll').style.display=='none'){
	  	document.getElementById('div_scoll').style.display='block';
	  }else{
	    document.getElementById('div_scoll').style.display='none';
	  }
	}
</script>

<body onload="document.getElementById('div_scoll').style.display ='none';">
<table width=520>
	<tr>
		<td valign=top >
			<b>${rhs["organize"].name}</b>
			&nbsp;&nbsp;&nbsp;
			
			<select  style="width:150px" onchange="action_organize_admin('ea_organize_create_role_in_organize.do','organizeId=${rhs["organize"].id?if_exists}'+'&rolegroupId='+this.value)">
			   <option   value="">请选择岗位</option> 
			   <@digui_rolegroup rhs["rolegroupRootList"]?sort_by('sortNob'),"" />	
			</select> 
			 *选择下拉框中的岗位后会自动创建职位角色
			<hr>
			<#include "ajax_organize_admin.ftl">
</table>
    
						
<div id="div_scoll"  class="well"  style="margin-left:150px;margin-top:100px; cursor:hander;position:absolute;width:300px;z-index:10000;">
 	<a class="pull-right" href="#" onclick="show_dir();" ><span class="glyphicon glyphicon-remove"></span></a>
 	<div id=div_panel_control style="border:2px solid #eee;">
 		<div id=div_select_user style="cursor:hander;"> </div>
	    <div id=div_add_new_user style="display:none;cursor:hander;padding:10px">
		    <b> 新用户身份登记 </b> 
		    <table class="table table-condensed ">
		         <tr><td>中文姓名 </td><td><input id=name value="" style="WIDTH: 120px"   /></td></tr>
		         <tr><td>英文帐号</td><td><input id=account value="" style="WIDTH: 120px"   /></td></tr>
		         <tr><td colspan=2 align=center>			   	<button class="btn btn-xs btn-primary"  onclick= "javascript:action_organize_admin('ea_organize_create_new_user_in_role.do','name='+document.getElementById('name').value+'&account='+document.getElementById('account').value+'&roleId='+document.getElementById('role_id').value+'&organizeId=${rhs["organize"].id}');">新增用户</button>
		            </td>
		         </tr>
		    </table>
			<input id=role_id  type=hidden   value=""/>
		    <input id=organize_id name=id type=hidden value=""/>
	    </div>
	</div>
</div>
	 	
<br><br><br><br><br><br><br><br><br><br><br><br>
<span id="div_action_result" style="display:none"></span>
<#--
-->