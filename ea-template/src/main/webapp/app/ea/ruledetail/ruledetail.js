function action_ruledetail(url,para){
	
  $.ajax({
         type:"POST",
         url: "ea_ruledetail_"+url,
              
         data:"beanname=Ruledetail&"+para,
         cache: false,
         success: function(html){
        	 document.getElementById('div_ruledetail_table').innerHTML=html;
        	 $('#div_action_result',window.parent.frames['topFrame'].document).html(document.getElementById('div_action_result').innerHTML);
        	 setTimeout( " $('#div_action_result',window.parent.frames['topFrame'].document).html('')", 2000);
        	
	     	 document.getElementById('previewFrame').src=document.getElementById('previewFrame').src; 
	     	

           }
  });  
}

