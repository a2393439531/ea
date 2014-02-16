<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>user.js"></script>
<script language="javascript">
	function createUserRolegroupRelation(userId,roleId) {
		$.ajax({
	        type:"POST",
	     	url: "ea_ea_create_user_role_relation.do",
	     	data:"userId="+userId+"&roleId="+roleId,
	     	cache: false,
	     	success: function(html){
	       }	
	    });  
	}	
</script>

<body style="padding:20px">

 <table   class="table table-condensed  table-indie">
 <thead>
	<tr>
		<th>个人信息编辑</th>
		<th>选择擅长技能</th>
	</tr>
</thead>
    <tr>
   		<td valign=top >
   		    <table class="table  table-bordered table-condensed    " >
				 <tr><td>中文姓名 </td><td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input  name="user.name" value="${rhs["user"].name?if_exists}"  onchange="javascript:action_user('update.do','column=name&id=${rhs["user"].id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /></td></tr>
   		   		 <tr><td>邮箱</td><td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input   style="width:250px"   type="text"  value='${rhs["user"].email?if_exists}'   onchange="javascript:action_user('update.do','column=email&id=${rhs["user"].id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /></td></tr>
   		   		 <tr><td>QQ </td><td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input   type="text"  value='${rhs["user"].qq?if_exists}'  onchange="javascript:action_user('update.do','column=qq&id=${rhs["user"].id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))"  /></tr>
   		   		 <tr><td>生日 </td><td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input   type="text"  value='${rhs["user"].birthDate?if_exists}'  onClick="WdatePicker()"  onchange="javascript:action_user('update.do','column=birthDate&id=${rhs["user"].id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))" /></td></tr>
   		   		 <tr><td>毕业日期 </td><td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input  name="user.graduateDate" type="text"  value='${rhs["user"].graduateDate?if_exists}'  onClick="WdatePicker()" onchange="javascript:action_user('update.do','column=graduateDate&id=${rhs["user"].id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))"/></td></tr>
  		   		 <tr><td>入职日期 </td><td onmouseover="rowOver(this)" onmouseout="rowOut(this)"><input  name="user.rollDate" type="text"  value='${rhs["user"].rollDate?if_exists}'  onClick="WdatePicker()" onchange="javascript:action_user('update.do','column=rollDate&id=${rhs["user"].id?if_exists}&columnValue='+escape(encodeURIComponent(this.value)))"/></td></tr>
     		</table>
	    </td>
    	<td  valign=top>
   		    <table class="table  table-condensed  table-bordered  " >
			<#list rhs["organizelist"]  as organize>
				<#list organize.getRoles() as role>	
				 <tr>
				 	<td onmouseover="rowOver(this)" onmouseout="rowOut(this)">
					  <input type="checkbox"  
					    		onclick="createUserRolegroupRelation('${rhs["user"].id?if_exists}','${role.id?if_exists}');" 
					  <#list rhs["user"].getRoles()  as x>
			    	   	<#if x.name==role.name>
			    	    checked
			    	    </#if>
		    	    </#list>					    		
					> </input>	
					 </td>
					 <td >
					 ${role.name?if_exists}
					</td>
				</tr>
  			     				  
				</#list> 	        		    
			</#list>            
     		</table>
        </td>	    
    </tr>	
</table>		
			<p align=center>
	        <input type="button" class="btn btn-xs btn-default" value="关闭刷新个人简历" onclick="javascript:if(parent.window.hs!=null) 	parent.window.hs.close();if(parent.previewFrame!=null) parent.previewFrame.location=parent.previewFrame.location;"/>
	        </p>
<br><br>
	