<#include "common/freemarker/include_header.ftl">
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">

    <style type="text/css">
      body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
      }

      .form-signin {
        max-width: 300px;
        padding: 19px 29px 29px;
        margin: 0 auto 20px;
        background-color: #fff;
        border: 1px solid #e5e5e5;
       
      }
      
      .form-signin input[type="text"],
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
        padding: 7px 9px;
      }

    </style>


  </head>

  <body>
<script>  
  
  	function changlang(value){
	    document.getElementById('formlanmuadmin').submit();
	}		
</script>

<body>

			    

    <div class="container">
	<form name="formlang" id="formlang" action="lang.do" method="post" >
                            language
	    <select class=input name="lang" size="1" onchange="document.getElementById('formlang').submit();" value="${Session["lang"]}">
			    <option value="${Session["lang"]}">${language_name[Session["lang"]]}</option>
			    <#list language_name?keys as key>
				   <option value="${key}">${language_name[key]}</option>
				</#list> 
		</select> 	
		&nbsp;&nbsp;<a href="ea_ea_home.do">二维码</a>		                            
    </form>
                            
      <form class="form-signin" name="loginForm" action="login.do" method="post">
        <#-- -->

       
        <hr>
        <input type="hidden" class="text" name=sysName value="oa">
        <input type="text" placeholder="Input your log here..." class="input-block-level" placeholder="Account" name=account value= >
        <input type="password" class="input-block-level" placeholder="Password" name=password value=abc123 >
        <!--
        <label class="checkbox">
          <input type="checkbox" value="remember-me"> Remember me
        </label>
        -->
        <br>
        
      
        <button class="btn btn-lg  btn-primary" type="submit"> <@i18n "submit" /></button> 
        <#if rhs?exists>${rhs["tipInfo"]?if_exists}</#if>
      </form>
    </div> <!-- /container -->

  </body>
</html>
