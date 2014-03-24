function action_systempara(url,para){
	  alert(url);

  $.ajax({
         type:"POST",
         url: "ea_systempara_"+url,
         data:"beanname=Systempara&"+para,
         cache: false,
         success: function(html){
          if(url=="update.do"){
         	   	document.getElementById('div_action_result').innerHTML=html;
        	}else{
        	    document.getElementById('div_systempara_tree').innerHTML=html;
        	}        	
          if(url=="create.do"){
     		 location.reload();
     	 }
        	 tip_info();
           }
  });  
}
function update_system_config(paraname,value){
	  $.ajax({
	         type:"POST",
	         url: "ea_systempara_updateSystemConfig.do",
	         data:"paraname="+paraname+"&value="+value,
	         cache: false,
	         success: function(html){
	        	// alert(html);
	        	 $('#div_action_result',window.parent.parent.frames['topFrame'].document).html(html);
	             setTimeout( "$('#div_action_result',window.parent.parent.frames['topFrame'].document).html('')", 2000);

	           }
	  });  
	}


