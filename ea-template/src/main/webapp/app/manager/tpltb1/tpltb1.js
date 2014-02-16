function action_tpltb1(url,para){
	  alert(url+"?"+para);
    $.ajax({
        type:"POST",
        url: "manager_tpltb1_"+url,
        data:"beanname=Tpltb1&"+para,
        cache: false,
        success: function(html){
        	if(url=="update.do"){
        		document.getElementById('div_action_result').innerHTML=html;
        	}else{
        	    document.getElementById('div_tpltb1_table').innerHTML=html;
        	}
       	 	tip_info();   	 
        }
    });  
}

