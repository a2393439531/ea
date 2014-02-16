<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript">
<#if (rhs["op"]=="w")>
	if(parent.parent.previewFrame!=null)parent.parent.previewFrame.location=parent.parent.previewFrame.location;
	if(parent.previewFrame!=null) parent.previewFrame.location=parent.previewFrame.location;
</#if>	
	function set_file_null(){
	    $.ajax({
		         type:"POST",
		         url: "ea_ea_update.do",
		         data:"beanname=${rhs["beanname"]?if_exists}&column=${rhs["propertyfilepath"]?if_exists}&id=${rhs["object"].id?if_exists}&columnValue=",
		         cache: false,
		         success: function(html){
			         if(parent.previewFrame!=null) parent.previewFrame.location=parent.previewFrame.location;
			         if(parent.parent.previewFrame!=null)parent.parent.previewFrame.location=parent.parent.previewFrame.location;
			         if(parent.window.hs!=null) 	parent.window.hs.close();
		           }
		  });  	    
	    
	}		          	
</script>
<form  name=file_upload_form action="common_file_file_upload.do"  method="POST" enctype="multipart/form-data">
	<table>
	    <tr>
				<td valign=top>	
				<#if rhs["filepath"]?exists&&rhs["filepath"]!="">
				    保存名：${rhs["filepath"]?if_exists}<br>文件名： ${rhs["filename"]?if_exists}<br> 
					<input type="button" class="btn btn-xs btn-default" value="清除文件" onclick="javascript:set_file_null();"/>
				</#if>	
				<br>
				</td>      
				<td valign=top>	
					<br>上传文件
				    <input class="btn btn-xs btn-default" type="File" name="file" size=20 >
				    <input  class="btn btn-xs btn-primary"   type="button"  onclick="javascript:file_upload_form.submit();"  value="&nbsp;&nbsp;确&nbsp;&nbsp;定&nbsp;&nbsp;"> 
			        &nbsp;&nbsp;
			   </td>
		</tr>
	</table>		    
			        <input  name="id" value="${rhs["object"].id?if_exists}" type="hidden"  />
			        <input  name="beanname" value="${rhs["beanname"]}" type="hidden"  />
			        <input  name="folder" value="${rhs["folder"]}" type="hidden"  />
			        <input  name="op" value="${rhs["op"]}" type="hidden"  />
			        <input  name="propertyfilename" value="${rhs["propertyfilename"]}" type="hidden"  />
			        <input  name="propertyfilepath" value="${rhs["propertyfilepath"]}" type="hidden"  />
		    
		  
 </form>
 <br><br>	