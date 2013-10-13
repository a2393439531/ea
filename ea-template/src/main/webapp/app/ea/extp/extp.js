function action_extp(url,para){
    $.ajax({
        type:"POST",
        url: "ea_extp_"+url,
        data:"beanname=Extp&"+para,
        cache: false,
        success: function(html){
        	if(url=="update.do"){
        		document.getElementById('div_action_result').innerHTML=html;
        	}else{
        	    document.getElementById('div_extp_table').innerHTML=html;
        	}
       	 	tip_info();   	 
        }
    });  
}

