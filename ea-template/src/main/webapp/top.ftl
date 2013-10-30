<#include "common/freemarker/include_header.ftl">
<head>
<style>
.navbar-inner {
	min-height: 61px;
	background-color: #FFF;
    background-image: none; 
    border-bottom-color: #224888;
}
.navbar-fixed-top .navbar-inner, .navbar-static-top .navbar-inner {
	border-bottom-width: 4px;
	box-shadow: none;
}
.navbar .nav > li > a {
	color: #224888;
}
.logo {
	padding-top:6px;
}
* {
	line-height: 40px;
}
</style>
</head>

<div class="navbar navbar-primary navbar-static-top">
  <div class="navbar-inner">
	<img class="logo" src="common/images/logo/template/your_logo_blue_1.png" />
    <ul class="nav pull-right">
	  <li><span id="div_action_result"></span></li>
	  <!-- <li class="divider-vertical"></li> -->
      <li><a href="login.ftl" target=_blank>login</a> </li>
      <!-- <li class="divider-vertical"></li> -->
      <li style="padding-top: 10px;"><span>|</span></li>
      <li><a href="reset_password.ftl" target="mainFrame">Change Password</a></li>
      <!-- <li class="divider-vertical"></li> -->
      <#--<li><a href="doc/frame.htm" target="_blank">Document</a></li>-->
      <!-- <li class="divider-vertical"></li> -->
	</ul>
  </div>
</div>
