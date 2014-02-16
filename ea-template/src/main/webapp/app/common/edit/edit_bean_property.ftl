<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript"          src="common/jquery151/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="common/ckeditor363/ckeditor.js"></script>
<script type="text/javascript">
	window.onload = function()
	{
		CKEDITOR.replace( 'textarea',
		{   
			skin : 'office2003',
			width:500,
			hegith:100,
	
			toolbar : [ 
							
							['Bold','Italic','Underline'] ,
							['Font','FontSize','TextColor','BGColor' ]
					  ]
		}); 
	}	
	function data_submit(){
	   // var value = CKEDITOR.instances.textarea.getData();
	   var value =escape(encodeURIComponent(CKEDITOR.instances.textarea.getData()));
	   
	    $.ajax({
		         type:"POST",
		         url: "ea_ea_update.do",
		         data:"beanname=${rhs["objectname"]?if_exists}&column=${rhs["propertyname"]?if_exists}&id=${rhs["id"]?if_exists}&columnValue="+value,
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
				<textarea cols="20" rows="2"  id="textarea" name="content" >${rhs["content"]?if_exists}</textarea>
				<input type="hidden" name="objectname" value="${rhs["objectname"]?if_exists}" />
				<input type="hidden" name="op" value="w" />
				<input type="hidden" name="id" value="${rhs["id"]?if_exists}" />
				<input type="hidden" name="propertyname" value="${rhs["propertyname"]?if_exists}" />			
			    </td>
			</tr>
			<tr>  
				<td style="text-align:center;">
				<br>
				
				<button type="button" class="btn btn-xs btn-primary"  onclick="javascript:data_submit();">保存编辑内容</button>
				<br><br>	<br><br><br><br><br><br>&nbsp;
				</td>	
			</tr>
		</table>
	
	<br><br><br><br><br><br><br><br><br><br><br>
</div>
