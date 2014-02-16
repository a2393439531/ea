
<#include "../../../common/freemarker/include_header.ftl">
<style>
select, input[type="text"] {
	margin-bottom: 0px;
	border-style: solid ;
	box-shadow: none;
	text-align: left;
}
</style>
<script type="text/javascript"          src="${request.getContextPath()}/common/jquery151/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${request.getContextPath()}/common/ckeditor363/ckeditor.js"></script>
<script type="text/javascript">
	window.onload = function()
	
	{		 
	
	CKEDITOR.replace( 'textarea',
		{   
			skin : 'office2003',
			width : 600 ,
        	height : 100,  
			toolbar : [ 
							
							 ['Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak'],
							['Bold','Italic','Underline','NumberedList','BulletedList','Outdent','Indent' ,
							'JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'] ,
							['Styles','Format','Font','FontSize','TextColor','BGColor' ]
					  ]
		}); 
	}	
	
	function data_submit(){
	   var content_value =escape(encodeURIComponent(CKEDITOR.instances.textarea.getData('content')));
	   var to_value=escape(encodeURIComponent(document.getElementById('to').value));
	   var subject_value=escape(encodeURIComponent(document.getElementById('subject').value));
      
	    $.ajax({
		         type:"POST",
		         url: "common_notify_submit_send_mail.do",
		         data:"to="+to_value+"&subject="+subject_value+"&content="+content_value,
		         cache: false,
		         success: function(html){
		         if(parent.previewFrame!=null) parent.previewFrame.location=parent.previewFrame.location;
		         if(parent.parent.previewFrame!=null)parent.parent.previewFrame.location=parent.parent.previewFrame.location;
		         if(parent.window.hs!=null) 	parent.window.hs.close();
		           }
		  });  	    
	}
</script>
<div >
   <table>
   <tr>
	   <td>
			邮箱地址<input id=to name=to style="width:400px;" value="<#list  rhs["userList"] as u><#if u.email?exists&& u.email!=""><#if u_index!=0>;</#if>${u.email?if_exists}<#else>;空-${u.name?if_exists}</#if></#list>" ></input>
			<br>标题<input id=subject name=subject style="width:400px;" value=""></input>
			<br>
			<textarea id="textarea" name="content"  ></textarea><br>
			<p align=center> <input type="button" class="button" value="发送" onclick="javascript:data_submit();"/></p>
		    
	    </td>
	   
	</table>
	
	<br><br><br><br>	<br><br><br><br><br><br>
</div>
