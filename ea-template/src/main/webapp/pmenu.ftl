<#include "common/freemarker/include_header.ftl">
<#include "common/freemarker/include_custom.ftl">
<style>
strong {
	display: block;
	padding: 0 0 10px 20px;	
}
/* All levels of nav */
.bs-sidenav {
	margin: 10px 0 0 0;
	background-color: #fff;
}
.bs-sidebar .nav > li > a {
  display: block;
  color: #716b7a;
  padding: 5px 20px;
}
.bs-sidebar .nav > li > a:hover,
.bs-sidebar .nav > li > a:focus {
  text-decoration: none;
  background-color: #e5e3e9;
  border-right: 1px solid #dbd8e0;
}
.bs-sidebar .nav > .active > a,
.bs-sidebar .nav > .active:hover > a,
.bs-sidebar .nav > .active:focus > a {
  font-weight: bold;
  color: #563d7c;
  background-color: transparent;
  border-right: 1px solid #563d7c;
}

/* Nav: second level (shown on .active) */
.bs-sidebar .nav .nav {
  display: none; /* Hide by default, but at >768px, show it */
  margin-bottom: 8px;
}
.bs-sidebar .nav .nav > li > a {
  padding-top:    3px;
  padding-bottom: 3px;
  padding-left: 30px;
  font-size: 90%;
}


</style>
<body >
  <div class="bs-sidebar hidden-print" >
    <ul class="nav bs-sidenav">
    	<strong>通用后台</strong>
    	<li ><a href="ea_organize_index.do" target="mainFrame"><@i18n "menu_organize" /></a></li>
		<li ><a href="ea_user_menu_user.do" target="mainFrame"><@i18n "menu_user" /></a></li>
		<li ><a href="ea_resource_menu_resource.do" target="mainFrame">权限配置</a></li>
		<li ><a href="common_activiti_menu_process_definition.do" target="mainFrame">工作流管理</a></li>
		<li ><a href="ea_systempara_menu_systempara.do" target="mainFrame">系统参数</a></li>
 		<li ><a href="common_monitor_home.do" target="mainFrame">状态监控</a></li>
    </ul>
  </div>
</body> 
 