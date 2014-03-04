<#include "common/freemarker/include_header.ftl">
<style>
/* All levels of nav */
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
<body style="background-color: #f7f5fa;">
  <div class="bs-sidebar hidden-print" >
    <ul class="nav bs-sidenav">
      <li ><a href="common_activiti_menu_task_list.do" target="mainFrame">代办任务</a></li>
	    <li ><a href="ea_ea_menu_workhomepage.do" target="mainFrame">行政管理</a></li>
		  <li ><a href="ea_report_report.do" target="mainFrame">周报</a></li>
		  <li ><a href="ea_organize_admin_by_user.do" target="mainFrame">聊天室</a></li>	
		  <li ><a href="ea_organize_admin_by_user.do" target="mainFrame">文档管理</a></li>
				    
    </ul>
  </div>
</body> 
 
