<#include "../../../common/freemarker/include_header.ftl">
<script>
	function polling()
	{
		MyMar=setInterval("ajax_polling('common_test_push_ajax.do','')",1111);   //没1S轮询一次
	}
	
	
function ajax_polling(url,para){

  $.ajax({
         type:"POST",
         url: url,
         data:para,
         cache: false,
         success: function(html){
             
	          document.getElementById('div_action_result').innerHTML=html;
         }
           
  });  
}	
	
</script>

<body onload="polling()">
   <div id=div_action_result>
   1.ajax刷新页面
   </div>
   
   
   <div id=div_iframe_result>
    2. iframe刷新页面
   </div>   
   <div style="display:none;">
		<iframe id="iframe" name="push_iframe" src="common_test_push_iframe.do"></iframe>
   </div>
   
		
			
	
</body>