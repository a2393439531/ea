        $("input[name='parentRoleId']:radio").each(function(){ 
                if($(this).attr("checked")){
                  parentRoleId=$(this).val();
                  return;
                }
        })  