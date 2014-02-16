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
  	
    <a  type="button" class="btn btn-xs btn-info" href='ea_user_profile_edit.do?id=${rhs["user"].id}' onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">修改个人信息</a>
   	<a  type="button" class="btn btn-xs btn-info" href='common_edit_edit_bean_property.do?objectname=User&op=r&propertyname=experience&id=${rhs["user"].id}' onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">编辑项目经验</a>
   	<a  type="button" class="btn btn-xs btn-info" href='common_edit_edit_bean_property.do?objectname=User&op=r&propertyname=positiondescription&id=${rhs["user"].id}' onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">编辑日常工作内容</a>
    <a  type="button" class="btn btn-xs btn-info" href="common_file_image_upload.do?id=${rhs["user"].id?if_exists}&beanname=User&op=r&propertyfilepath=imgfilename&folder=photo" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">上传照片</a>
   	<br> 
<#--<a href=# onclick="document.frames('previewFrame').location.reload(true);" >刷新简历</a>-->
<br>
<iframe id="previewFrame" name="previewFrame"  src="ea_user_resume.do?id=${rhs["user"].id?if_exists}" style="width:900px;height:600px;" frameborder="1"  noresize="noresize"  />

</body>

<span id="div_action_result" style="display:none">${rhs["info"]?if_exists}</span>   
	