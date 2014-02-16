<#include "../../../common/freemarker/include_header.ftl">
<form id="upload_form" action="common_uploadfile_iframe_uploadfile.do" method="post" enctype="multipart/form-data"> </form>
<span id="div_new_filelist" style="display:none">${rhs["info"]?if_exists}
	<#list rhs["uploadFiles"] as x>
		<div style="margin-top:3px;" id='${x.id}'><a href='${rhs.contextPath + x.url}' onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" >${x.fileName}</a>
		<#if rhs["readonly"]!="readonly" >
		<a href='#' class="btn btn-info btn-xs" onclick="javascript:del_file('common_uploadfile_delete_uploadfile.do','${x.id}')" ><i class='icon-remove'></i>&nbsp;Delete</a>
		</#if>
		</div>
	</#list>
</span>

<script>

	$("#loading_file_div", parent.document.body).css("display","none");
	$("#file_upload_div" , parent.document.body).append(document.getElementById('div_new_filelist').innerHTML);
</script>


