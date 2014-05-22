
<!DOCTYPE html>
<html>
<head>
	<title>EA Login</title>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/icons.css" />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/main.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/appframework.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/forms.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/buttons.css"  />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/ios.css"  />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/plugins/css/af.actionsheet.css"  />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/plugins/css/af.popup.css"  />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/plugins/css/af.scroller.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/plugins/css/af.selectBox.css"  />
	
	<script type="text/javascript" charset="utf-8" src="common/appframework-2-1/appframework.js"></script>
	<script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.scroller.js"></script>
	<script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.actionsheet.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.css3animate.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.passwordBox.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.touchEvents.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.touchLayer.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.popup.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/appframework.ui.js"></script>

	
	
	<script>
		$.ui.useOSThemes=true;
		var search=document.location.search.toLowerCase().replace("?","");
		var tipInfo = '<#if rhs?exists>${rhs["tipInfo"]?if_exists}</#if>';
		if(tipInfo && tipInfo.trim() != ""){
			search = "changeaccount";
		}
		
		
		$.ui.ready(function(){
			$("#afui").get(0).className="ios";
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
		$.ui.ready(function(){
			console.log("document.cookie.length: " + document.cookie.length);
			var account = getCookie("accountInfo");
			var pwd = getCookie("pwdInfo");
			console.log("search:" + search );
			if(account && pwd){
				$("#account").val(account);
				$("#password").val(pwd);
				if(search != "changeaccount"){
					$("#loginform")[0].submit();
					$.ui.showMask("登录中....");
				}
				
			}
			console.log("account: " + account);
			console.log("pwd: " + pwd);
		});
		
	</script>
	

</head>

<body>
	<div id="afui">
		<div id="header">
			<h1>登录</h1>
			<a href="file:///android_asset/www/ee.html"  class="button icon home" target="_blank" style="float:right">返回手机</a>         
        </div>
		<div id="content">
			<div id="main" class="panel" selected="true">
				<br />
				<form action="login.do" method="post" id="loginform">
					<div class="input-group">
						<input type="hidden" name="saveCookie" value="true" />
						<input type="hidden" name="type" value="app" />
                    <label for="account">Account: </label><input id="account" name="account" type="text" placeholder="Account" />
                    <label for="password">Password: </label><input  id="password" name="password" type="password" placeholder="Password" />
                    <input type="submit" value="登录" class="button green" style="float: right;" name="submitbtn"/>
					<label style="color: #AA0000;"><#if rhs?exists>${rhs["tipInfo"]?if_exists}</#if></label>
					</div>
                </form>
			</div>
		</div>
			
	</div>

</body>
</html>
