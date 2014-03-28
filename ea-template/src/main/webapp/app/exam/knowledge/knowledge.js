function action_knowledge(url,para){
  $.ajax({
         type:"POST",
         url: "exam_knowledge_"+url,
         data:"beanname=Knowledge&"+para,
         cache: false,
         success: function(html){
        	 document.getElementById('div_knowledge_tree').innerHTML=html;
       		 location.reload();
        	 tip_info();
           }
  });  
}


