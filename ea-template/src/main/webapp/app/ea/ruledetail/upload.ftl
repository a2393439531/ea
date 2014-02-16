<#include "../../../common/freemarker/include_header.ftl">
<script language="javascript">
	function  checkimgfile(){
		var name = document.userRegedit.file.value;
		if (name.length == 0){
		alert("文件地址不能为空");
		return false;
	    }
		if(/^.+\.(gif|jpg|ico|png|bmp)$/i.test(name)){
			document.getElementById('bt-sure').disabled=false;
		}
		else{
			uploadPicForm.reset();
			alert("支持的图片文件格式：gif|jpg|ico|png|bmp");}
		return true;
	}	
</script>
<div class="area-edit">

	<div  class="title"><p class=bold>上传资源${RequestParameters["column"]}</p></div>
	<div class="content">
		<form name=file_form  action="ea_ruledetail_upload_save.do"  method="POST" enctype="multipart/form-data">
        <br>选择文件<input class=input type="File" name="file" size=20 >
        <input type="hidden" name="id" value="${RequestParameters["id"]}">
        <input type="hidden" name="column" value="${RequestParameters["column"]}">
        <input type="hidden" name="parentId" value="${RequestParameters["parentId"]}">
        
        <input type="button" value="确定"  style='width:90px' onclick='file_form.submit();'>
		</form>
    </div>
	<#if (rhs["ruledetail"].imagefilepath?exists)>
		<img style="width:300px; height=400px" src=/ea/file/resource/${rhs["ruledetail"].imagefilepath?if_exists}  />
	</#if>
</div>						
		     
	     
	     
	