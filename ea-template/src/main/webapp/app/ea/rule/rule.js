function action_rule(url,para){
  $.ajax({
         type:"POST",
         url: "ea_rule_"+url,
         data:"beanname=Rule&"+para,
         cache: false,
         success: function(html){
        	 document.getElementById('div_rule_tree').innerHTML=html;
        	 $('#div_action_result',window.parent.frames['topFrame'].document).html(document.getElementById('div_action_result').innerHTML);
        	 setTimeout( " $('#div_action_result',window.parent.frames['topFrame'].document).html('')", 2000);

           }
  });  
}


