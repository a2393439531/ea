	$(function(){
		$('#dialog').dialog({
			autoOpen: false,
			modal: true,
			width: 600
		});
	});


function action_viewhistory_dialog(url,para){
	  
	  $.ajax({
	         type:"POST",
	         url: url,
	         data:para,
	         cache: false,
	         success: function(html){
	        	
	        	 document.getElementById('div_viewhistory_dialog').innerHTML=html;
	           }
	  });  
	}


function action_viewhistory(url,para){ 

  $.ajax({
	     type:"POST",
          url: "ea_viewhistory_"+url,
         data:"beanname=Viewhistory&"+para,
         cache: false,
         success: function(html){
        	if(url=="update.do"){
        	    document.getElementById('div_action_result').innerHTML=html;
         	}else{
        	    document.getElementById('div_viewhistory_table').innerHTML=html;
        	}
       	 	tip_info();          	
           }
          
  });  
}




