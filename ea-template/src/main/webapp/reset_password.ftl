<#include "common/freemarker/include_header.ftl">

<link href="common/ui/css/text.css" rel="stylesheet" type="text/css" media="all" />
<script language="javascript">
    function check(){
	    if(document.getElementById("newpassword").value!=document.getElementById("newrepeatpassword").value){
	        document.getElementById('div_result').innerHTML='新密码两次输入不一致';
	        setTimeout( "document.getElementById('div_result').innerHTML=''", 2000);
	        return false;
	    }else{
	    	return true;
	    }
	 } 
    function ajax(){
     check();
     $.ajax({
         type:"POST",
         url: "login!ajaxResetPassword.do",
		 data:"oldpassword="+document.getElementById('oldpassword').value+"&newpassword="+document.getElementById('newpassword').value+"&userid=${Session["userlogined"].id}",
		 cache: false,
		 success: function(html){
		    
		     document.getElementById('div_result').innerHTML=html;
		     setTimeout( "document.getElementById('div_result').innerHTML=''", 2000);
         }
     });   
    
     }
</SCRIPT>
<body style="padding:20px">
    <table width=350px>
	    <tr>
	       <td>当前密码</td>
	       <td><input id="oldpassword"  type="password"   name="oldpassword" size="20"></td>
	    </tr>
	    <tr>
	       <td>新密码</td>
	       <td> <input id="newpassword"  type="password" name="newpassword" size="20" ></td>
	    </tr>
	    <tr>
	      <td>重新输入新密码</td>
	       <td> <input id="newrepeatpassword" type="password" name="newrepeatpassword"  onchange="check()"></td>    
	    </tr>
	    <tr>
	       <td  align="center" colspan="2" >
	       <br><div id=div_result style="color:#f00"></div>
	        <input type="submit" onclick="javascript:ajax()" class="button"  value="确定" name="B1" >
	       </td>
	    </tr>
  </table>
  
  
<table>
<#list Session["menuList"]?sort_by('sortNob')  as node>
    <tr><td>${node.name?if_exists}</td>
   
    <td><a href=${node.actionUrl?if_exists} target=_blank >${node.actionUrl?if_exists} </a></td>
    
    </tr>
</#list>

</table>
  
  
</body>