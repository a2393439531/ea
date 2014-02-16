function action_user(url,para){ 
 // alert(para);
  $.ajax({
         type:"POST",
         url: "ea_user_"+url,
         data:"beanname=User&"+para,
        
         cache: false,
         success: function(html){
      
         	if(url=="update.do"){
         	    // alert(document.getElementById('previewFrame').src);
         		 document.getElementById('div_action_result').innerHTML=html;
         		// if(document.getElementById('previewFrame')!=null) document.frames("previewFrame").document.location.reload(true);;
		        
         		
        	}else{
        	    document.getElementById('div_user_table').innerHTML=html;
        	}
       	 	tip_info();          	
           }
  });  
}

