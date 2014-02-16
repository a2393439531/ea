
<#include "macro_view.ftl">
<#assign organizeRootList=rhs["organizeRootList"]/>
<#assign rootname=rhs["rootname"]/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<#include "../../../common/freemarker/include_header.ftl">
<script language="javascript" src="<@context_module/>view_organize.js"></script>
<#include "macro_view.ftl">
<#if  rhs["organize"]?exists>
<body style="padding:5px">

<form action="ea_view_save.do" method="post" class="form-horizontal" >
  
	<div class="btn-group btn-group-xs" style="padding-bottom:10px">
		 <a  class="btn btn-xs btn-default" href="ea_view_picture_organize_v.do?id=${rhs["id"]?if_exists}&show=user">显示人员</a>
		  <a  class="btn btn-xs btn-default" href="ea_view_picture_organize_v.do?id=${rhs["id"]?if_exists}&show=">不显示人员</a>

			 
	</div> 
  
  <#list rhs["organize"].getRoles() as role>&nbsp;<a  class="btn btn-xs btn-default" href="ea_view_picture_role_user_v.do?roleId=${role.id}&img=yes&width=50&height=80" target=_blank>${role.name}</a> </#list>
	
  <div class="input-group input-group-sm pull-right">
        <input name=name id=name   type="text"  value="${rhs["organize"].name}${javacall["com.utils.time.TimeUtil"].getTimeStr("yyyy-MM-dd")}"></input>
		<button  title="用于保存历史组织架构图"  type="submit" class="btn btn-xs btn-default" > 保存</button>
 </div> 
    

  <input name=t id=t type=hidden value="t_organize_v">
  <input name=id id=id type=hidden value="${rhs["id"]?if_exists}">
</form>
<br><hr>


<@digui_organize_win organizeRootList?sort_by('sortNob') />
	<div class="zz" >
		<script language="javascript"> 
			var n1=new OrgNode();
			n1.Text="<@frame rhs["organize"].name /><br> <#if Session["show"]=='user'><p style='padding-top:5px'><#list rhs["organize"].getRoles() as role><#list role.getUsers() as u>${u.name}&nbsp;</#list></#list></#if>";
			n1.Description="";
			n1.Link="";
			<@digui_organize_v organizeRootList?sort_by('sortNob'),"n1",Session["show"] />
			<@draw/>
		</script>
	</div>
</#if>		    
</body>