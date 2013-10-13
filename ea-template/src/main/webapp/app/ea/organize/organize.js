function action_organize(url,para){
  $.ajax({
         type:"POST",
         url: "ea_organize_"+url,
         data:"beanname=Organize&"+para,
         cache: false,
         success: function(html){
       
           
          if(url=="update.do"||url=="updateExtp.do"){
         		
        		document.getElementById('div_action_result').innerHTML=html;
        	}else{
        	    document.getElementById('div_organize_tree').innerHTML=html;
        	}
       	 	tip_info();          	
           }
           
  });  
}
