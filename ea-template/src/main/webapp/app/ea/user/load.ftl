<#include "../../../common/freemarker/include_header.ftl">
<form action="ea_user_menu_save.do" method="post" class="well form-horizontal">
<fieldset>
	<legend>User Manager</legend>

	<div class="control-group">
		<label class="control-label">name</label>
		<div class="controls">
			<input type="text" name="user.name" value='<#if rhs["user"]?exists>${rhs["user"].name?if_exists}</#if>'/>
		</div>
	</div>
	
	<div class="control-group">
		<label class="control-label">account</label>
		<div class="controls">
			<input type="text" name="user.account" value='<#if rhs["user"]?exists>${rhs["user"].account?if_exists}</#if>'/>
		</div>
	</div>
	
	<div class="control-group">
		<label class="control-label">password</label>
		<div class="controls">
			<input type="text" name="user.passwd" value='<#if rhs["user"]?exists>${rhs["user"].passwd?if_exists}</#if>'/>
		</div>
	</div>
	
	<div class="control-group">
		<label class="control-label">Level</label>
		<div class="controls">
			<select  style="width:50px" name="user.assessLev" >
				    <option value="${user.assessLev?if_exists}">${user.assessLev?if_exists}</option>
	  				<option value="T">T</option>
	  				<option value="A">A</option>
	  				<option value="B">B</option>
	  				<option value="C">C</option>
	  			
	  				<#--
	  				<option value="ST" title="无需评估">ST</option>
	  				<option value="ES">ES</option>
	  				-->
	 			<select>
		</div>
	</div>
	
	<div class="control-group">
		<label class="control-label">email</label>
		<div class="controls">
			<input type="text" name="user.email" value='<#if rhs["user"]?exists>${rhs["user"].email?if_exists}</#if>'/>
		</div>
	</div>
	
	<div class="control-group">
		<label class="control-label">score</label>
		<div class="controls">
			<input type="text" name="user.score" value='<#if rhs["user"]?exists>${rhs["user"].score?if_exists}</#if>'/>
		</div>
	</div>	
	
	<div class="control-group">
		<label class="control-label">mark</label>
		<div class="controls">
			<input type="text" name="user.mark" value='<#if rhs["user"]?exists>${rhs["user"].mark?if_exists}</#if>' />
		</div>
	</div>	
	
	<div class="controls">
		<input type="submit" class="btn" value="保存"/>
		<a title="返回" class="btn" href="ea_user_menu_list.do">返回</a> 		
	</div>
</fieldset>	
</form>
       