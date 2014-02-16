<#include "common/freemarker/include_header.ftl">
 <style>
 a,a:hover {
  color: #fff;
} 
</style>
<body style=" background-color: #463265;color:#fff">
<a href="home.ftl" target="mainFrame">
<blockquote class="pull-left"><div >EA企业架构<small>version: beta-1.3</small> </div> 
</blockquote>   
</a>
<div class="pull-right" style="padding:10px">
		<#if Session?exists&&Session["userlogined"]?exists>   用户：${Session["userlogined"].name?if_exists}</#if>
		&nbsp;&nbsp;
  
		<#if Session?exists&&Session["userlogined"]?exists>
		&nbsp;<a href="ea_ea_menu_workhomepage.do" target=mainFrame>-行政</a> 
		&nbsp;<a href="ea_user_profile.do" target=mainFrame>-个人资料 </a>
     	&nbsp;<a href="reset_password.ftl" target="mainFrame">-密码</a>
     	&nbsp;<a href="ea_report_report.do" target="mainFrame">-报告</a>
        </#if>	
	   <#if Session?exists&&Session["currnetProject"]?exists>
				&nbsp;&nbsp;项目
				<select style="WIDTH: 130px"  id="userid"  onchange="javascript: changeProject(this.value)">
					<option value=${Session["currnetProject"].id?if_exists}>${Session["currnetProject"].name?if_exists}</option>
				    <#list  Session["projectList"] as p>
				    <option value=${p.id?if_exists}>${p.name?if_exists} </option>
					</#list>
				</select>
		</#if>
	    
		<#if Session?exists&&Session["currnetProject"]?exists>
				&nbsp;&nbsp;部门     
			    <select style="WIDTH: 130px" id="userid"  onchange="javascript: changuser(this.value)">
				    <#list  Session["departmentList"] as department>
				    <option value=${department.id?if_exists}>${department.name?if_exists} </option>
					</#list>          
				</select>
			
		</#if>
             
        <br>
		<span id="div_action_result"></span>
</div>    
</body>
</html>
