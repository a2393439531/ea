function action_role(url,para){
  $.ajax({
         type:"POST",
         url: "ea_role_"+url,
         data:"beanname=Role&"+para,
         cache: false,
         success: function(html){
        
          if(url=="update.do"){
        		document.getElementById('div_action_result').innerHTML=html;
        	}else{
        	    document.getElementById('div_role_tree').innerHTML=html;
        	}
       	 	tip_info();          	
          
 
           }
  });  
}

