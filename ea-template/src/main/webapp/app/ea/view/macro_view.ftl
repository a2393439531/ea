<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<style>
*{font-size: 12px;}
.zz {
	height: 1200px;	width: 958px auto;border: 0px solid #CCCCCC;
	margin-top: 5px;margin-bottom: 5px;margin-left:auto;margin-right:auto; 
}
a {font-family: "宋体";font-size: 12px;color: #000;text-decoration: none;cursor:hand}
</style>
<#--显示框，角色的名字截取18个字符-->
<#macro frame name><span style='padding:4px;border:1px solid #000;'><b><#if name?length gt 22>${name[0..22]?if_exists}...<#else>${name?if_exists}</#if></b></span></#macro>

<#macro suoxie text=''><#if text?exists&&text!=''><div style='overflow:hidden;width:130px;height:24px;'>${text?if_exists}</div></#if></#macro>

<#macro style_img  width=80 height=90>style='width:${width}px;height:${height}px;border:0px #006699 solid;border:solid 1px #aaa;display:block;padding:3px;margin:7px'</#macro>	
<#macro temp_photo><#if (RequestParameters["img"]=='yes') ><image  <@style_img/>  src=<@context/>common/images/np2.png  /><br></#if></#macro>
<#--情况1：角色下面有没有人，如果有角色，没有人，就显示照片-->
<#macro show_no_user role><table><tr><td width=150px align=center><#if role.getUsers()?size<1 ><#if (RequestParameters["img"]=='yes') ><br><image  style='width:${RequestParameters["width"]}px;height:${RequestParameters["height"]}px'  src=<@context/>common/images/np2.png  /></#if><br><span style='color:red'>空缺</span></#if></td></tr></table></#macro>
<#--情况2：有人就显示照片,number是显示图片的个数最多显示几个人-->
<#macro show_user role number><#if role.getUsers()?size<number&&(RequestParameters["img"]=='yes')><table><tr><#list role.getUsers() as u><td width=150px align=center><#if u.imgfilename?exists><image  <@style_img/>  src='<@context/>file/photo/${u.imgfilename?if_exists}'  ></images></#if><div style='margin:10px'>${u.name?if_exists}${u.account}&nbsp;</div></td></#list></tr></table><#else><div style='margin:10px'><#list role.getUsers() as u>${u.name}${u.account}&nbsp;</#list></div></#if></#macro>
<#--情况3：高亮显示特别某人-->
<#macro show_user_by_id role userId><div style='margin:10px'><#list role.getUsers() as u><#if (u.id==userId) ><#if u.imgfilename?exists><image  <@style_img/>  src='<@context/>file/${u.imgfilename?if_exists}'  ></images></#if><b style='color:red'>${u.name}&nbsp;</b><#else>${u.name}&nbsp;</#if></#list></div></#macro>

<#macro roletext role ><@frame role.name /> <@show_no_user role />   <@show_user role , 4/></#macro>	
<#--显示重要任务-->
<#macro roletext_user_important role userId><@frame role.name/> <@show_user_by_id role , userId/></#macro>	

  
<#macro draw>
	var OrgShows=new OrgShow(n1);
	OrgShows.Top=135;
	OrgShows.Left=20;
	OrgShows.IntervalWidth=2;
	OrgShows.IntervalHeight=50;
	OrgShows.ShowType=1; //2代表文字是竖的
	OrgShows.BoxHeight=22; //高度
	OrgShows.BoxWidth=174; //宽度
	OrgShows.LineSize=2;  //设置线条大小
	OrgShows.LineColor="#000";  //设置线条颜色
	OrgShows.Run();
</#macro>


<#macro digui_organize_win organizeNodes    >
	<#list organizeNodes as organize>
			<div class="highslide-html-content" id="win_${organize.id?if_exists}">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">${organize.name?if_exists}
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				<#if organize.imgfilename?exists&&organize.imgfilename!=''>
				   <img src=<@context/>file/${organize.imgfilename?if_exists} />
				</#if>
				   <p>
				   ${organize.name?if_exists}<br>
				   ${organize.organizedescription?if_exists}
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_${organize.id?if_exists}" onclick='return hs.htmlExpand(this, { contentId: "win_${organize.id?if_exists}" } )'  class=highslide>${organize.name?if_exists}</a>
			
			<script>
				function win_${organize.id?if_exists}()
				{ document.getElementById("link_win_${organize.id?if_exists}").onclick();}
			</script>
		
	  	<#if !(organize.getChildOrganizes()?size<1)> 
		    <@digui_organize_win organize.getChildOrganizes()?sort_by('sortNob') />	
		</#if>
	</#list> 
</#macro>




<#--晋级图-->
<#macro digui_rolegroup rolegroupNodes  flag >
	<#list rolegroupNodes as rolegroup>
		<tr>
	        <td align=center style="border-bottom:1px solid #ccc;">
		        <img  src=<@context/>common/images/up-arrow.png /><br>
    			<b>${rolegroup.name?if_exists}</b>
	        </td>		
			<td align=center style="border-bottom:1px solid #ccc;">
			   <table >
				   <tr>
				   <#list rolegroup.getRoles() as role>
				   		<td >
					   		  <table >
						   		  <tr>
						   		  	<td align=center><span style="">${role.name}</span> </td>
								  </tr>
						   		  <tr>
						   		  	<td align=center >
						   		  	<#if role.getUsers()?size<1 >
						   		  	      <@show_no_user role />
						   		  	 <#else>
  		   				   		  		  <@show_user role , 15/>
  		   				   		  		</#if>  
						   		  	</td>
								  </tr>	
							   </table>						  
				   		 </td>
				   </#list> 
				   </tr>
			   </table>
	    	</td>
	    </tr>
		  <#if !(rolegroup.getChildRolegroups()?size<1)> 
		      <@digui_rolegroup rolegroup.getChildRolegroups()?sort_by('sortNob'),flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />	
		  </#if>
	</#list> 
</#macro>

<#macro digui_role_v treeNodes  varname  width=20 height=50>
   	<#list treeNodes as role>
   	    var ${varname}${role_index+1}=new OrgNode();
		${varname}${role_index+1}.Text="<@roletext role />";
		${varname}${role_index+1}.Description="${role.name?if_exists}:管理人数${role.allUserUnderRole()?size}人"
		${varname}${role_index+1}.Link="window.open ('ea_view_picture_role_user_v.do?roleId=${role.id?if_exists}&img=yes&width=50&height=80', 'newwindow', '');";
		${varname}.Nodes.Add(${varname}${role_index+1});
		<#if !(role.getChildRoles()?size<1)> 
			<@digui_role_v role.getChildRoles()?sort_by("id") ,'${varname}${role_index+1}'/>	
		</#if>
	</#list> 
</#macro>



<#macro digui_organize_v organizeNodes   varname  show=''>
	<#list organizeNodes as organize>
   	        var organize${organize.id}=new OrgNode(); 
     	    organize${organize.id}.Text="<@frame organize.name /><#if organize.imgfilename?exists&&organize.imgfilename!=''><table><tr><td width=150px align=center><image <@style_img/>  onmouseover='' src=<@context/>file/${organize.imgfilename?if_exists}  /></td></tr></table></#if><div style='margin:10px;'><@suoxie organize.organizedescription /></div> <#if show=='user'><div ><#list organize.getRoles() as role><#list role.getUsers() as u>${u.name}&nbsp;</#list></#list></div></#if>";
			organize${organize.id}.Description="${organize.name?if_exists}";
			organize${organize.id}.Link="win_${organize.id?if_exists}()";
			${varname}.Nodes.Add(organize${organize.id});
	  	<#if !(organize.getChildOrganizes()?size<1)> 
		    <@digui_organize_v organize.getChildOrganizes()?sort_by('sortNob'),'organize'+organize.id />	
		</#if>
	</#list> 
</#macro>