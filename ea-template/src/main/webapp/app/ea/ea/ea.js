var organizeId; 

    var roleId=0;
    function ajax_add_new_user() {
	  	$.ajax({
	        type:"POST",
	     	url: "ea_ea_ajax_save_new_user_in_role.do",
	     	data:"name="+document.getElementById('name').value+"&account="+document.getElementById('account').value+"&roleId="+document.getElementById('role_id').value,
	     	cache: false,
	     	success: function(html){
	     	    document.getElementById('div_action_result').innerHTML=html;
	     	    tip_info();
	     	    window.location.reload();
	       }	
	    });  
	}     
     
    function ajax_create_role_in_organize(organizeId,rolegroupId) {
      	$.ajax({
	        type:"POST",
	     	url: "ea_ea_ajax_create_role_in_organize.do",
	     	data:"organizeId="+organizeId+"&rolegroupId="+rolegroupId,
	     	cache: false,
	     	success: function(html){
	     	    document.getElementById('div_action_result').innerHTML=html;
	     	    tip_info();
	     	    window.location.reload();
	       }	
	    });  
	}     
          

    function ajax_delete_role(roleId) {
      	$.ajax({
	        type:"POST",
	     	url: "ea_ea_ajax_role_delete.do",
	     	data:"roleId="+roleId,
	     	cache: false,
	     	success: function(html){
	     	    document.getElementById('div_action_result').innerHTML=html;
	     	    tip_info();
	     	    window.location.reload();
	       }	
	    });  
	}     
          
	 function createUserRoleRelation(userId,roleId) {
	  	$.ajax({
	        type:"POST",
	     	url: "ea_ea_create_user_role_relation.do",
	     	data:"userId="+userId+"&roleId="+roleId,
	     	cache: false,
	     	success: function(html){
	       }	
	    });  
	}
	
	function ajax_role_user_list(roleId,organizeId) {
	    $.ajax({
	        type:"POST",
	     	url: "ea_ea_ajax_role_user_list.do",
	     	data:"roleId="+roleId+"&organizeId="+organizeId,
	     	cache: false,
	     	success: function(html){
	     	  document.getElementById('div_select_user').innerHTML=html;  
	       }	
	    });  
	}

function action_change_role(url,para){
	  //alert("beanname=Role&organizeId="+organizeId+"&"+para);
	  $.ajax({
	         type:"POST",
	         url: "ea_ea_"+url,
	         data:"beanname=Role&organizeId="+organizeId+"&"+para,
	         cache: false,
	         success: function(html){
	          //  alert(html);
	        	 document.getElementById('div_organize_rolelist').innerHTML=html;
	         	 $('#div_action_result',window.parent.frames['topFrame'].document).html(document.getElementById('div_action_result').innerHTML);
	        	 setTimeout( " $('#div_action_result',window.parent.frames['topFrame'].document).html('')", 2000);

	           }
	  });  
}
function ajax_put_organize_to_organizegroup(organizeId,orgaizeGroupId) {
		//alert("organizeId="+organizeId+"&organizegroupId="+orgaizeGroupId);
		$.ajax({
	     type:"POST",
	     url: "ea_ea_ajax_put_organize_to_organizegroup.do",
	     data:"organizeId="+organizeId+"&organizegroupId="+orgaizeGroupId,
	     cache: false,
	     success: function(html){
	    //   document.getElementById('div_organize_rolelist').innerHTML=html;
	       }
		}); 
    }
	


    
    function ajax_organize_role_list(organizeId) {
		$.ajax({
	        type:"POST",
	     	url: "ea_ea_ajax_organize_role_list.do",
	     	data:"organizeId="+organizeId,
	     	cache: false,
	     	success: function(html){
	       		document.getElementById('div_organize_rolelist').innerHTML=html;      
	       }	
	    });  
	}
	
	function bat_create_role() {
        var rolegroupIdString="";
        $("input[name='rolegroup']:checkbox").each(function(){ 
            if($(this).attr("checked")){
            	rolegroupIdString += $(this).val()+"-"
            }
        })
        //alert(rolegroupIdString);
        if(rolegroupIdString==""){
        	alert("必须选择角色类别");
        	return;
        }
        var organizeId="";
        $("input[name='organize']:radio").each(function(){ 
                if($(this).attr("checked")){
                  organizeId=$(this).val();
                  return;
                }
        })     
       if(organizeId==""){
        	alert("必须选择组织架构");
        	return;
        }	
       
		$.ajax({
	     type:"POST",
	     url: "ea_ea_ajax_bat_create_role.do",
	     data:"organizeId="+organizeId+"&rolegroupIdString="+rolegroupIdString,
	     cache: false,
	     success: function(html){
	      
	       	 document.getElementById('div_organize_rolelist').innerHTML=html;
         	 $('#div_action_result',window.parent.frames['topFrame'].document).html(document.getElementById('div_action_result').innerHTML);
        	 setTimeout( " $('#div_action_result',window.parent.frames['topFrame'].document).html('')", 2000);
	       
	       }
		});               
    }
	
	function delete_role(roleId) {
       
        var organizeId="";
        $("input[name='organize']:radio").each(function(){ 
                if($(this).attr("checked")){
                  organizeId=$(this).val();
                  return;
                }
        })     
       if(organizeId==""){
        	alert("必须选择组织架构");
        	return;
        }	
        
       	$.ajax({
	     type:"POST",
	     url: "ea_ea_delete_role.do",
	     data:"organizeId="+organizeId+"&roleId="+roleId,
	     cache: false,
	     success: function(html){
	       document.getElementById('div_organize_rolelist').innerHTML=html;
	       }
		});        
	              
    }
	
	function ajax_organize_role(id,column,columnValue){
		//alert(id+","+column+","+columnValue);
		  $.ajax({
		         type:"POST",
		         url: "ea_ea_update_organize_role_list.do",
		         data:"column="+column+"&id="+id+"&columnValue="+columnValue,
		         cache: false,
		         success: function(html){
		           document.getElementById('div_result').innerHTML="更新成功!";
		           setTimeout( "document.getElementById('div_result').innerHTML=''", 1000);
		           }
		  });  
		}
	
	
