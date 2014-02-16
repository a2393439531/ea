	$(function(){
		$('#dialog').dialog({
			autoOpen: false,
			modal: true,
			width: 600
		});
	});


function action_tpltb2(url,para){
	
  $.ajax({
	     type:"POST",
         url: url,
         data:para,
         cache: false,
         success: function(html){
        	 document.getElementById('div_tpltb2_table').innerHTML=html;
        	 tip_info();
           }
  });  
}
function action_tpltb2_dialog(url,para){
	  
	  $.ajax({
	         type:"POST",
	         url: url,
	         data:para,
	         cache: false,
	         success: function(html){
	        	// alert(html);
	        	 document.getElementById('div_tpltb2_dialog').innerHTML=html;
	           }
	  });  
	}


