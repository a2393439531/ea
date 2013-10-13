<#include "common/freemarker/include_header.ftl">
<div class="container-fluid">
	<div class="well" style="padding: 8px 0;">
		<ul class="nav nav-list">
		  <li class="nav-header">Syttem config</li>
		  <li onclick="menu_active(this)"><a href="ea_organize_menu_organize.do" target="mainFrame">organize manager</a></li>
		  <li onclick="menu_active(this)"><a href="ea_rolegroup_menu_rolegroup.do" target="mainFrame">position manager</a></li>
		  <li onclick="menu_active(this)"><a href="ea_ea_menu_relation.do" target="mainFrame">role manager</a></li>
		  <li onclick="menu_active(this)"><a href="ea_user_list.do" target="mainFrame">user manager</a></li>
	      <li onclick="menu_active(this)"><a href="ea_resource_menu_resource.do" target="mainFrame">resource manager</a></li>
		  <li onclick="menu_active(this)"><a href="ea_systempara_menu_systempara.do" target="mainFrame">system para</a></li>
	</ul>
	</div><!--/.well -->
</div>
<script>
function menu_active(obj){
	$(".active").removeClass("active");
	$(obj).addClass("active")
}
</script>

<#--
	      <a href="app/manager/organize_menu_organize.do" target="mainFrame" title="设置部门架构或者项目架构"><image   src=common/images/icon/org.ico  />&nbsp;企业架构定义</a>  <br>
          <a href="app/manager/rolegroup_menu_rolegroup.do" target="mainFrame" title="设置部门架构或者项目架构"><image   src=common/images/icon/rolegroup.ico  />&nbsp;岗位定义</a>  <br>
		  <a href="app/manager/ea_menu_relation.do" target="mainFrame"><image   src=common/images/icon/p.ico />&nbsp;职位管理</a>  <br>
		  <a href="app/manager/user_menu_user.do" target="mainFrame"><image   src=common/images/icon/u2.ico />&nbsp;员工信息</a>  <br>
		  <a href="app/manager/rule_menu_rule.do" target="mainFrame"><image   src=common/images/icon/new.gif />&nbsp;通告发布</a>  <br>
          <a href="app/manager/viewhistory_menu_viewhistory.do" target="mainFrame"><image   src=common/images/save.png />&nbsp;历史存档</a><br>
          <a href="app/manager/systempara_menu_systempara.do" target="mainFrame">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;系统参数</a><br/>
-->