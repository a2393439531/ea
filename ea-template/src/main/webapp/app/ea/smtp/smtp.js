function ajax_smtp(id,column,value){
	var para = "id=" + id + "&column=" + column + "&columnValue=" + value;
	 $.ajax({
	        type:"POST",
	        url: "ea_smtp_update.do",
	        data:"beanname=Smtp&"+para,
	        cache: false,
	        success: function(html){
	        	document.getElementById('div_action_result').innerHTML=html;
	       	 	tip_info();   	 
	        }
	    });  
}
function action_smtp(url,para){
    $.ajax({
        type:"POST",
        url: "ea_smtp_"+url,
        data:"beanname=Smtp&"+para,
        cache: false,
        success: function(html){
        	if(url=="update.do"){
        		document.getElementById('div_action_result').innerHTML=html;
        	}else{
        	    document.getElementById('div_smtp_table').innerHTML=html;
        	}
       	 	tip_info();   	 
        }
    });  
}

