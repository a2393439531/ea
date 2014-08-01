<title>Task Login</title>
<#include "app/mobile/include_header.ftl">
<style type="text/css">
/* delete login panel padding&border style */
#afui .panel {
	padding: 0;
	background-color: #fff;
}
#afui .input-group {
	border-radius: 0;
	border: none;
}

/* Cancel chrome input&textarea fault style */
input, button, select, textarea{
	outline: none;
}
textarea{
	resize: none;
}

.login {
	margin: 0px auto; 
	width: 260px;
	padding-top: 50px;
}
.username{
	height: 40px;
	background:url(common/images/User.png) no-repeat;
	border: 1px solid #ffef95;
}
.password{
	height: 40px;
	background:url(common/images/ClosedLock.png) no-repeat;
	border: 1px solid #ffef95;
}
#afui .login input[type=text] {
	width: 180px; 
	margin-left: 30px;
}
#afui .login input[type=password] {
	width: 180px; 
	margin-left: 30px;
}
#afui .login input[type=submit] {
	margin: 0px;
	width: 260px;
	height: 40px;
	background-color: #fe9744;
	border: none;
	border-radius: 3px;
	color: #fff;
	
}
</style>

<div id="afui">
	<div id="content">
		<div class="panel" id="loginPage" title="金钱游戏" data-footer="none" selected="true">
			<form id="loginform" name="loginForm" action="mobileLogin.do" method="post">
				<div class="input-group">
					<input type="hidden" name="terType" value="task" />
					<input type="hidden" name="saveCookie" value="true" />
					<!-- 
                    <label for="account">Account: </label><input id="account" name="account" type="text" placeholder="帐号" />
                    <label for="password">Password: </label><input  id="password" name="password" type="password" placeholder="请输入密码" />
                    -->
                    <div class="login">
	                    <div class="username">
	                    <input id="account" name="account" type="text" placeholder="帐号" autocomplete="off" />
	                    </div>
	                    
	                    <br/>
	                    
	                    <div class="password">
	                    <input  id="password" name="password" type="password" placeholder="请输入密码" autocomplete="off" />
	                    </div>
	                    
	                    <br/>
	                    
	                    <input type="submit" value="登录" class="button block" name="submitbtn" />
						<p style="color: #AA0000;"><#if rhs?exists>${rhs["tipInfo"]?if_exists}</#if></p>
					</div>
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
//			if(search != "changeaccount"){
//				console.log("submit....");
//				$("#loginform")[0].submit();
//			}
				
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