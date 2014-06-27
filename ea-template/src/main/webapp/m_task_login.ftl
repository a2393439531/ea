<title>Task Login</title>
<#include "app/mobile/include_header.ftl">
<div id="afui">
	<div id="content">
		
		<div class="panel" id="loginPage" title="登录" data-footer="none" selected="true">
			<form id="loginform" name="loginForm" action="mobileLogin.do" method="post">
				<div class="input-group">
					<input type="hidden" name="terType" value="task" />
					<input type="hidden" name="saveCookie" value="true" />
					
                    <label for="account">Account: </label><input id="account" name="account" type="text" placeholder="Account" />
                    <label for="password">Password: </label><input  id="password" name="password" type="password" placeholder="Password" />
                    
                    <input type="submit" value="登录" class="button block" style="float: right;" name="submitbtn"/>
					<label style="color: #AA0000;"><#if rhs?exists>${rhs["tipInfo"]?if_exists}</#if></label>
				</div>
			</form>
		</div>
		
	</div>
</div>

<script>
	var search=document.location.search.toLowerCase().replace("?","");
	var tipInfo = '<#if rhs?exists>${rhs["tipInfo"]?if_exists}</#if>';
	if(tipInfo && tipInfo.trim() != ""){
		search = "changeaccount";
	}
		
	$.ui.ready(function(){
		var account = getCookie("accountInfo");
		var pwd = getCookie("pwdInfo");
		
		if(account && pwd){
			$("#account").val(account);
			$("#password").val(pwd);
			if(search != "changeaccount"){
				console.log("submit....");
				$("#loginform")[0].submit();
			}
				
		}
	});
	
	function getCookie(cname){
		if (document.cookie.length > 0) {
			var cstart = document.cookie.indexOf(cname + "=");
			if(cstart != -1){
				var cend=document.cookie.indexOf(";",cstart);
				if(cend == -1) cend = document.cookie.length;
				var cookiestr = document.cookie.substring(cstart,cend);
				return cookiestr.split("=")[1];
			}
		}
	}
</script>