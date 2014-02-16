<#macro uploadfile foreignId folder readonly="" >

<div class="control-group">
	<label class="control-label">
		<#if readonly=="">
		<a href="#"  class="btn btn-primary btn-xs" onclick="javascript:add_file_input();"><i class="icon-plus"></i>&nbsp;Add File</a>
		<#else>
		File
		</#if>
	</label>
	<div class="controls" id="file_upload_div_main">
		
		<div id="file_upload_div"  >
		
	  	</div>
	  	<#if readonly=="">
	  	<input type="button" class="btn btn-primary btn-xs" onclick="_upload_file();" value="Upload"/>
	  	</#if>
	</div>
</div>
<#--
<div style="display:none;">
	<iframe id="upload_iframe" name="upload_iframe" src="common_uploadfile_uploadfile.do?foreignId=${foreignId}&readonly=${readonly}"></iframe>
</div>
-->
<script>
	var file_input_num = 1;
	function add_file_input(){
		file_input_num += 1;
		var div_id = "file_div" + file_input_num;
		var file_id = "file" + file_input_num;
		var input_id = "input" + file_input_num;
		var h1 = '<div class=form-group id="' + div_id + '">' +
				 '<input type="text" id="' + input_id + '" />' +
				 '<input type="button" value="Select File" class="btn btn-default btn-xs" onclick="document.getElementById(\'upload_iframe\').contentWindow.document.getElementById(\'' + file_id + '\').click();" />' + 
				 '<a href="javascript:void(0);" onclick=remove_file_input("' + file_input_num + '") class="btn btn-default btn-xs">Delete</a>' +
		  		 '</div>';
		var h2 = '<input type="file" id="' + file_id + '" name="upload" onchange="$(\'#' + input_id + '\', parent.document.body).val(this.value)"/>';
		$("#file_upload_div").append(h1);
		$("#upload_iframe").contents().find("#upload_form").append(h2);
	}
	
	function remove_file_input(num){
		$("#file_div" + num).remove();
		$("#upload_iframe").contents().find("#file" + num).remove();
	}
	
	//提交文件，因为要保存文件的时间值，可以用后来来做
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
	
	function get_file_list(){
	         $.ajax({
			         type:"POST",
			         url: "common_uploadfile_get_file_list.do",
			         data:"foreignId=${foreignId}",
			         cache: false,
			         success: function(html){
				          $("#file_upload_div").html(html);
			         }
			  });  	
	  
	}

    get_file_list();


</script>
</#macro>