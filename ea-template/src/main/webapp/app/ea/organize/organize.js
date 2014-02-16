
function update_preview(url){
	 document.getElementById('previewFrame').src=url;
	}
function action_organize(url,para){
  $.ajax({
         type:"POST",
         url: "ea_organize_"+url,
         data:"beanname=Organize&"+para,
         cache: false,
         success: function(html){
	          if(url=="update.do"){
	        		document.getElementById('div_action_result').innerHTML=html;
       		  }else{
	        	    document.getElementById('div_organize_tree').innerHTML=html;
	          }
	         tip_info();  
	         if(url!="delete.do"){ 
	     	 document.getElementById('previewFrame').src=document.getElementById('previewFrame').src; 
	     	 }
         }
           
  });  
}
   
// if(this.previewFrame!=null) this.previewFrame.location=this.previewFrame.location;
   
function action_organize_admin(url,para){
  $.ajax({
         type:"POST",
         url: url,
         data:para,
         cache: false,
         success: function(html){
          if(url=="update.do"){
         		 document.getElementById('div_action_result').innerHTML=html;
        	}else{
        		 
        	    document.getElementById('div_organize_admin').innerHTML=html;
        	}
       	 	tip_info();          	
         }
           
  });  
}


	
	function role_user_list(roleId,organizeId) {
	    $.ajax({
	        type:"POST",
	     	url: "ea_organize_role_user_list.do",
	     	data:"roleId="+roleId+"&organizeId="+organizeId,
	     	cache: false,
	     	success: function(html){
	     	  document.getElementById('div_select_user').innerHTML=html;  
	       }	
	    });  
	}        
 
 	 