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
	     <#--<li ><a href="common_activiti_menu_task_list.do" target="mainFrame">Task List</a></li>
		  <li ><a href="manager_wo_list.do" target="mainFrame">Work Order Manager</a></li>
		  <li ><a href="ea_organize_admin_by_user.do" target="mainFrame">Team Admin</a></li>	
		    -->
		  <li ><a href="exam_exam_exam_list.do" target="mainFrame"><@i18n "menu_exam_info" /></a></li>
		  <li ><a href="exam_exam_exam_record_list.do" target="mainFrame"><@i18n "menu_query_exam" /></a></li>
		 
    </ul>
  </div>
</body> 
 

  <#---
         <li class="nav-header">Report</li>
 		  <li onclick="menu_active(this)"><a href="manager_hrworkshop_menu_hrworkshop.do" target="mainFrame">workshop</a></li>

         <li onclick="menu_active(this)"><a href="ea_report_ipm.do" target="mainFrame">IPM</a></li>

         <li onclick="menu_active(this)"><a href="ea_report_assessment.do" target="mainFrame">Techical assessment</a></li>
         <li onclick="menu_active(this)"><a href="ea_report_tech_member.do" target="mainFrame">Technical Member Team</a></li>
         <li onclick="menu_active(this)"><a href="ea_ea_clean.do" target="mainFrame">清空缓存</a></li>
         <li onclick="menu_active(this)"><a href="ea_report_birt_user.do" target="mainFrame">birt数据源</a></li>
           -->


