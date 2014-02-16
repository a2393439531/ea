<#include "../../../common/freemarker/include_header.ftl">

<#macro digui_rule ruleNodes  flag >
	<#list ruleNodes as rule>
	  ${flag} <a href="ea_rule_detail.do?id=${rule.id?if_exists}" target=_blank>${rule.name?if_exists}</a><br>
	  <#if !(rule.getChildRules()?size<1)> 
		      <@digui_rule rule.getChildRules()?sort_by('sortNob'),flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />	
		  </#if>
	</#list> 
		
</#macro>


<body style = "padding:3px;">
    <table>
         <tr>
           <td width=300px valign=top>
	           <div class="panel  panel-primary">
		            <div class="panel-heading">信息公告
		            </div>
		            <div class="panel-body">
		               <@digui_rule rhs["ruleRootList"]?sort_by('sortNob'),""/>
		            </div>
	            </div>
	  
	           <div class="panel panel-primary">
		           <div class="panel-heading">组织架构信息</div>
		           <div class="panel-body">
		                   <#list rhs["viewhistory"]?sort_by("id") as x>
								<a href="<@context/>ea_view_show_history_orgainze_pic.do?filename=${x.filename?if_exists}" target=_blank >${x.name?if_exists}</a>
								<br>
						   </#list> 
		           </div>
	           </div>
	      </td>
          <td width=500px valign=top>
	           <div class="panel  panel-primary">
		            <div class="panel-heading">工作职责</div>
		            <div class="panel-body">
						<#macro digui_role_v treeNodes  flag >
						   	<#list treeNodes as role>
						   	        <#list role.getUsers() as u>
							   	    <tr>	
							   	     	 <td>${u.name?if_exists}（${role.name}）</td>
							 	  	     <td><a   href='ea_ea_menu_view_user_handbook_detail.do?id=${u.id}'  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">检查工作手册</a>
							 	  	     </td>
								 	</tr>	  
									</#list>
								
								<#if !(role.getChildRoles()?size<1)> 
									<@digui_role_v role.getChildRoles()?sort_by("id") ,flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"/>	
								</#if>
							</#list> 
						</#macro>
						 <table   class="table table-bordered table-condensed ">
						    <thead>
						    <tr><th >职位</th><th>上级</th><th>工作详细说明</th></tr>
						    </thead>
							<#list rhs["user"].getRoles() as role>
							<tr>
								<td valign=top>
									${role.name}
								</td>
								<td valign=top>
									<#if role.getParentModel()?exists>
									<#assign parent_role=role.getParentModel()/>
									     <#list parent_role.getUsers() as u>
									   	   ${u.name?if_exists}（${parent_role.name}）
										</#list>
									
									</#if>
								</td>	
								<td valign=top width=60%>
								    <#if role.getRolegroups()[0]?exists&&role.getRolegroups()[0].positiondescription?exists>	
										岗位说明:<br>
										${role.getRolegroups()[0].positiondescription?if_exists}
									</#if>
								    <#if role.positiondescription?exists>	
										职位说明:<br>
										${role.positiondescription?if_exists}
									</#if>
								</td>
							</tr>	
							</#list>
						</table>
		            </div>
	           </div>


	           <div class="panel  panel-primary">
		            <div class="panel-heading">团队管理
		            
		            </div>
		            <div class="panel-body">
				    	<#if ( rhs["user"].getRoles()?size gt 0 )>
							<#list rhs["user"].getRoles() as role>
								<#if ( role.getChildRoles()?size gt 0 )>
									<p><b>${role.name?if_exists} </b>下属成员:</p>
									<table width=700  class="table  table-condensed">
									     <@digui_role_v role.getChildRoles()?sort_by("sortNob"),''/>
									</table>
								</#if>
							</#list>
						</#if>
		            </div>
	            </div>



          </td>
		</tr>
   </table>
         
       <#---

        <section id="tabs">
         
            <ul id="myTab" class="nav nav-tabs">
              <li class="active"><a href="#home" data-toggle="tab">信息公告</a></li>
              <li><a href="#profile" data-toggle="tab">组织架构</a></li>
               <li><a href="#job" data-toggle="tab">工作职责</a></li>
              <li><a href="#team" data-toggle="tab">下属管理</a></li> 
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">口号 <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="#version" data-toggle="tab">团队愿景</a></li>
                  <li><a href="#stragy" data-toggle="tab">团队战略</a></li>
                </ul>
              </li>
            </ul>
            
            
            <div id="myTabContent" class="tab-content" style="padding:10px">
              <div class="tab-pane fade in active" id="home">
                  <@digui_rule rhs["ruleRootList"]?sort_by('sortNob'),""/>
              </div>
              <div class="tab-pane fade" id="profile">
           		   <#list rhs["viewhistory"]?sort_by("id") as x>
						<a href="<@context/>ea_view_show_history_orgainze_pic.do?filename=${x.filename?if_exists}" target=_blank >${x.name?if_exists}</a>
						<br>
				   </#list> 
           
              </div>
              <div class="tab-pane fade" id="job" >
					<#macro digui_role_v treeNodes  flag >
					   	<#list treeNodes as role>
					   	        <#list role.getUsers() as u>
						   	    <tr>	
						   	     	 <td>${u.name?if_exists}（${role.name}）</td>
						 	  	     <td><a   href='ea_ea_menu_view_user_handbook_detail.do?id=${u.id}'  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">检查工作手册</a>
						 	  	     </td>
							 	</tr>	  
								</#list>
							
							<#if !(role.getChildRoles()?size<1)> 
								<@digui_role_v role.getChildRoles()?sort_by("id") ,flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"/>	
							</#if>
						</#list> 
					</#macro>
				
						 <table   class="table table-bordered table-condensed ">
						    <thead>
						    <tr><th >职位</th><th>上级</th><th>工作详细说明</th></tr>
						    </thead>
							<#list rhs["user"].getRoles() as role>
							<tr>
								<td valign=top>
									${role.name}
								</td>
								<td valign=top>
									<#if role.getParentModel()?exists>
									<#assign parent_role=role.getParentModel()/>
									     <#list parent_role.getUsers() as u>
									   	   ${u.name?if_exists}（${parent_role.name}）
										</#list>
									
									</#if>
								</td>	
								<td valign=top width=60%>
								    <#if role.getRolegroups()[0]?exists&&role.getRolegroups()[0].positiondescription?exists>	
										岗位说明:<br>
										${role.getRolegroups()[0].positiondescription?if_exists}
									</#if>
								    <#if role.positiondescription?exists>	
										职位说明:<br>
										${role.positiondescription?if_exists}
									</#if>
								</td>
							</tr>	
							</#list>
						</table>
			</div>
              
  			<div class="tab-pane fade" id="team">
			    	<#if ( rhs["user"].getRoles()?size gt 0 )>
						<#list rhs["user"].getRoles() as role>
							<#if ( role.getChildRoles()?size gt 0 )>
								<p><b>${role.name?if_exists} </b>下属成员:</p>
								<table width=700  class="table  table-condensed">
								     <@digui_role_v role.getChildRoles()?sort_by("sortNob"),''/>
								</table>
							</#if>
						</#list>
					</#if>
			</div>       			  
              
             
              <div class="tab-pane fade" id="version">
                <p>relax</p>
              </div>
              <div class="tab-pane fade" id="stragy">
                <p>shun qi zi ran</p>
              </div>
            
            
         
     </section>

-->


       
       
       
       
       
       
       
       
       
       
       

	
		
		<#--<#if role.getRolegroups()[0]?exists>${role.getRolegroups()[0].name?if_exists}</#if>--->

<#--
<table width=100%>
	<tr>
		<td valign=top width=70%  style = "padding:10px">
	
			<div id="tabs">
				<ul>
				    <li><a href="#tabs-5">工作手册</a></li>
				    <li><a href="#tabs-6">职位职责</a></li>			    
					<li><a href="#tabs-1">企业战略</a></li>
					<li><a href="#tabs-2">企业愿景</a></li>
					<li><a href="#tabs-3">年度目标</a></li>
					<li><a href="#tabs-4">个人绩效KPI</a></li>
					
				</ul>
				<div id="tabs-5">${rhs["user"].positiondescription?if_exists}</div>
				<div id="tabs-6">
					<table   class="table  table-condensed">
					    <thead>
					    <tr><th width=80>岗位</th><th width=80>职位</th><th>详细</th></tr>
					    </thead>
						<#list rhs["user"].getRoles() as role>
						<tr>
							<td valign=top>
							    <#if role.getRolegroups()[0]?exists>		
									${role.getRolegroups()[0].name?if_exists}
								</#if>
							</td>
							<td valign=top >
								${role.name}
							</td>
							<td valign=top>
							    <#if role.getRolegroups()[0]?exists&&role.getRolegroups()[0].positiondescription?exists>	
									<b>岗位技能要求</b><br>
									${role.getRolegroups()[0].positiondescription?if_exists}
								</#if>
							    <#if role.positiondescription?exists>	
									<b>职位工作内容</b><br>
									${role.positiondescription?if_exists}
								</#if>
							</td>
						</tr>	
						</#list>
					</table>				
				</div>
				<div id="tabs-1"><#include "../../../file/ftl/strategy.ftl"></div>
				<div id="tabs-2"><#include "../../../file/ftl/version.ftl"></div>
				<div id="tabs-3"><#include "../../../file/ftl/target.ftl"></div>
				<div id="tabs-4">${rhs["user"].kpidescription?if_exists}</div>
			</div>	
		</td>
	</tr>	
</table> 
-->



  