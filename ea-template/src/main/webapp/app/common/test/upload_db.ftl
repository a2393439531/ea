
<#include "../../../common/freemarker/include_header.ftl">
<#include "../../../common/freemarker/include_custom.ftl">

<div class="control-group">
	<div class="controls" id="file_upload_div_main">
		<form  name=file_upload_form action="common_uploadfile_uploaddb.do"  method="POST" enctype="multipart/form-data">
		
			<input class="btn btn-xs btn-default" type="File" name="file" size=20 >
			<a  type="button" class="btn btn-xs btn-primary" onclick="javascript:file_upload_form.submit();">上传</a>	  	
		
		</form>
	  	
	</div>
</div>


<div class="panel panel-default">
	<div class="panel-heading"><strong>文件列表</strong></div>
	<div class="panel-body">
	<table class="moduleDisplay">
		<tr><td>名称</td><td>显示</td><td>操作</td></tr>
		
		<#list  rhs["datalist"] as item>
		<tr>
		<td>${item.fileName?if_exists}</td>
		<td>
		<#if item.fileType?exists && item.fileType?string == "image/png">
		<img style="width:100px; height:120px" src="common_uploadfile_show_image.do?id=${item.id}" />
		</#if>
		
		</td> 
		<td ><a  type="button" class="btn btn-xs btn-info" href="common_uploadfile_file_download.do?id=${item.id}">下载</a></td>
		</tr>
		</#list>
	</table>
	</div>
</div>
			


