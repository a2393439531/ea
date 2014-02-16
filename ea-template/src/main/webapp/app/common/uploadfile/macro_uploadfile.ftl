<#macro uploadfile foreignId folder readonly >

<div class="control-group">
	<div class="controls" id="file_upload_div_main">
		<div id="loading_file_div" style="display:block;"><img src="<@context/>common/images/loading.gif"/></div>
		<div id="file_upload_div"  class="form-group">
	  	</div>
	  	<#if readonly=="">
	  	<a href="#"  class="btn btn-xs btn-info" onclick="javascript:add_file_input();"><i class="icon-plus"></i>&nbsp;Add File</a>
	  	<input type="button" class="btn btn-xs btn-info" onclick="_upload_file();" value="Upload"/>
	  	</#if>
	</div>
</div>

<div style="display:none;">
	<iframe id="upload_iframe" name="upload_iframe" src="common_uploadfile_iframe_uploadfile.do?foreignId=${foreignId}&readonly=${readonly}"></iframe>
</div>


<script>
var file_input_num = 1;
function add_file_input(){
	file_input_num += 1;
	var div_id = "file_div" + file_input_num;
	var file_id = "file" + file_input_num;
	var input_id = "input" + file_input_num;
	var h1 = '<div style="margin-top:3px;" id="' + div_id + '">' +
			 '<input type="text" style="border:1px solid #428bca; margin-right:3px;" id="' + input_id + '" />' +
			 '<input type="button" value="Select File" class="btn btn-xs btn-info" style="margin-right:3px;" onclick="document.getElementById(\'upload_iframe\').contentWindow.document.getElementById(\'' + file_id + '\').click();" />' + 
			 '<a href="javascript:void(0);" onclick=remove_file_input("' + file_input_num + '") class="btn btn-xs btn-info">Delete</a>' +
	  		 '</div>';
	var h2 = '<input type="file" id="' + file_id + '" name="upload" onchange="$(\'#' + input_id + '\', parent.document.body).val(this.value)"/>';
	$("#file_upload_div").append(h1);
	$("#upload_iframe").contents().find("#upload_form").append(h2);
}

function remove_file_input(num){
	$("#file_div" + num).remove();
	$("#upload_iframe").contents().find("#file" + num).remove();
}

function _upload_file(){
	var upload_form = $("#upload_iframe").contents().find("#upload_form");
	upload_form.append("<input name='foreignId' type='text' value='${foreignId}'>");
	upload_form.append("<input name='folder' type='text' value='${folder}'>");
	upload_form.submit();
	$("#loading_file_div").css("display","block");
	upload_form.html("");
	$("#file_upload_div").html("");
}

function del_file(url, primary_id){
	<#if readonly=="">
	$.ajax({
	     type: "POST",
         url: url,
         data: "primaryId=" + primary_id,
         cache: false,
         success: function(ret){
			if(ret == "OK"){
				$("#" + primary_id).remove();
			}
         }
  	}); 
  	<#else>
  	alert('You can not delete!');
  	</#if>
}
</script>
</#macro>