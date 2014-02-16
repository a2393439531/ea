<#--只能显示一种特效-->
<a href="#" onclick="return hs.htmlExpand(this, { contentId: 'highslide-phone' } )"class="highslide">通讯录</a>
<a href="#" onclick="return hs.htmlExpand(this, { contentId: 'highslide-duty' } )"class="highslide">职位职责</a>
<#--<a href="#" onclick="return hs.htmlExpand(this, { contentId: 'highslide-version' } )"class="highslide">显示企业愿景</a>-->

<br>
<span style="color:green">【职位说明】</span>
<#macro list_role_link treeNodes>
    <#list treeNodes as role>
		<a href="#" onclick="return hs.htmlExpand(this, { contentId: 'roleid_${role.id?if_exists}' } )"  class="highslide"> ${role.name}</a>
		<#if !(role.getChildRoles()?size<1)> 
		    <@list_role_link role.getChildRoles()?sort_by("id") />	
		</#if>
	</#list> 
</#macro>
<a href="#" onclick="return hs.htmlExpand(this, { contentId: 'roleid_${rhs["role"].id?if_exists}' } )"class="highslide"> ${rhs["role"].name}</a>
<@list_role_link rhs["role"].getChildRoles()/>



<#macro list_role_positiondescription treeNodes>
    <#list treeNodes as role>
		<div class="highslide-html-content" id="roleid_${role.id?if_exists}">
			<div class="highslide-header">
				<ul>
					<li class="highslide-move">${role.name?if_exists}
						<a href="#" onclick="return false"></a>
					</li>
				</ul>
			</div>
			<div class="highslide-body">
				 ${role.positiondescription?if_exists}<br>
			</div>
		    <div class="highslide-footer">
		        <div>
		            <span class="highslide-resize" title="Resize">
		            </span>
		        </div>
		    </div>
		</div>
		<#if !(role.getChildRoles()?size<1)> 
		    <@list_role_positiondescription role.getChildRoles()?sort_by("id") />	
		</#if>
	</#list> 
</#macro>
<div class="highslide-html-content" id="roleid_${rhs["role"].id?if_exists}">
	<div class="highslide-header">
		<ul>
			<li class="highslide-move">${rhs["role"].name?if_exists}
				<a href="#" onclick="return false"></a>
			</li>
		</ul>
	</div>
	<div class="highslide-body">
	     <br>
		 ${rhs["role"].positiondescription?if_exists}<br>
	</div>
    <div class="highslide-footer">
        <div>
            <span class="highslide-resize" title="Resize">
            </span>
        </div>
    </div>
</div>
<@list_role_positiondescription rhs["role"].getChildRoles()/>


<br>
<span style="color:green">【员工信息】</span>
<#list rhs["role"].allUserUnderRole() as user>
	<a href="#" onclick="return hs.htmlExpand(this, { contentId: 'userid_${user.id?if_exists}' } )"class="highslide"> ${user.name}</a>
</#list>






<#list rhs["role"].allUserUnderRole() as user>
<div class="highslide-html-content" id="userid_${user.id?if_exists}">
	<div class="highslide-header">
		<ul>
			<li class="highslide-move"> 姓名:${user.name?if_exists}
				<a href="#" onclick="return false"></a>
			</li>
		</ul>
	</div>
	<div class="highslide-body">
		<table   class="table  table-condensed" >
		    <tr><td align=right ><b> 手机</b></td><td>${user.phoneNumber?if_exists}</td></tr>
		    <tr><td align=right ><b> e-mail</b></td><td>${user.email?if_exists}</td></tr>
		    <tr><td align=right ><b> qq</b></td><td>${user.qq?if_exists}</td></tr>
		    <tr><td align=right  ><b> 地址</b></td><td>${user.address?if_exists}</td></tr>
		   <tr><td align=right  > <b> 工作经验</b></td><td>${user.experience?if_exists}</td></tr>
		</table>			
	</div>
    <div class="highslide-footer">
        <div>
            <span class="highslide-resize" title="Resize">
            </span>
        </div>
    </div>
</div>
</#list>






<#macro list_role treeNodes>
    <#list treeNodes as role>
		<tr ><td align=left style="border:1px solid #ccc;"><b>${role.name}</b></td>
		<td align=left style="border:1px solid #ccc;">${role.positiondescription?if_exists}</td></tr>
		<#if !(role.getChildRoles()?size<1)> 
		    <@list_role role.getChildRoles()?sort_by("id") />	
		</#if>
	</#list> 
</#macro>
   <div class="highslide-html-content" id="highslide-duty">
	<div class="highslide-header">
		<ul>
			<li class="highslide-move">职责说明
				<a href="#" onclick="return false"></a>
			</li>
		</ul>
	</div>
	<div class="highslide-body">
		<table   class="table  table-condensed" >
			<tr>
			    <td align=left valign=top style="border:1px solid #ccc;"><b>${rhs["role"].name}</b></td>
			    <td align=left valign=top style="border:1px solid #ccc;">${rhs["role"].positiondescription?if_exists}</td>
			</tr>
			<@list_role rhs["role"].getChildRoles()/>
		</table>	</div>
    <div class="highslide-footer">
        <div>
            <span class="highslide-resize" title="Resize">
            </span>
        </div>
    </div>
</div>

<div class="highslide-html-content" id="highslide-phone">
	<div class="highslide-header">
		<ul>
			<li class="highslide-move">联系方式
				<a href="#" onclick="return false"></a>
			</li>
		</ul>
	</div>
	<div class="highslide-body">
		<table   class="table  table-condensed" >
	    <thead>
			<tr>
				<th align=left >姓名</th>
		        <th align=left >手机</th>
		        <th align=left>QQ</th>
				<th align=left>邮箱</th>
				<th align=left>地址</th>
			</tr>
		</thead>		
			<#list rhs["role"].allUserUnderRole() as user>
			<tr>
			    <td align=left valign=top width=40px>${user.name}</td>
			    <td align=left valign=top width=80px>${user.phoneNumber?if_exists}</td>
			    <td align=left valign=top width=80px>${user.qq?if_exists}</td>
			    <td align=left valign=top width=80px>${user.email?if_exists}</td>
			     <td align=left valign=top>${user.address?if_exists}</td>
			</tr>
			</#list>
		</table>	
	</div>
    <div class="highslide-footer">
        <div>
            <span class="highslide-resize" title="Resize">
            </span>
        </div>
    </div>
</div>
<#--
<div class="highslide-html-content" id="highslide-version">
	<div class="highslide-header">
		<ul>
			<li class="highslide-move">
				<a href="#" onclick="return false"></a>
			</li>
		</ul>
	</div>
	<div class="highslide-body">
	    <br>
        <#include "../../../file/ftl/version.ftl"><br>
		<#include "../../../file/ftl/strategy.ftl"><br>
		<#include "../../../file/ftl/target.ftl">	<br>
	</div>
    <div class="highslide-footer">
        <div>
            <span class="highslide-resize" title="Resize">
            </span>
        </div>
    </div>
</div>
-->