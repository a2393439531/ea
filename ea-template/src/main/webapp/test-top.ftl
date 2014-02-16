<#include "common/freemarker/include_header.ftl">
 <style>
 a,a:hover {
  color: #fff;

} 
 
 </style>
  <body style=" background-color: #463265;color:#fff">
  
   <blockquote class="pull-left">
	  <div >
	    EA企业架构
	        <small>version: beta-1.3</small> 
	  </div>
  </blockquote>   
    
    

  <blockquote class="pull-right">
	<#if Session?exists&&Session["userlogined"]?exists>   用户：${Session["userlogined"].name?if_exists}</#if>
	 <small>

    <#if Session?exists&&Session["currnetProject"]?exists>
	   
			&nbsp;&nbsp;PROJECT：
		
			<select style="WIDTH: 130px"  id="userid"  onchange="javascript: changeProject(this.value)">
				<option value=${Session["currnetProject"].id?if_exists}>${Session["currnetProject"].name?if_exists}</option>
			    <#list  Session["projectList"] as p>
			    <option value=${p.id?if_exists}>${p.name?if_exists} </option>
				</#list>
			</select>
		
	</#if>
    
	<#if Session?exists&&Session["currnetProject"]?exists>
		
			&nbsp;&nbsp;DEPARTMENT：     
		    <select style="WIDTH: 130px" id="userid"  onchange="javascript: changuser(this.value)">
			    <#list  Session["departmentList"] as department>
			    <option value=${department.id?if_exists}>${department.name?if_exists} </option>
				</#list>          
			</select>
		
	</#if>
	 
		<#if Session?exists&&Session["userlogined"]?exists>
		<a href="ea_ea_menu_workhomepage.do" target=mainFrame>工作手册</a> &nbsp;
		<a href="ea_user_profile.do" target=mainFrame>个人资料 </a>&nbsp;
     		<a href="reset_password.ftl" target="mainFrame">修改密码</a>
        </#if>	 
	 </small> 
  </blockquote>    
   

  </body>
</html>
