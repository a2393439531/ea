<#include "common/freemarker/include_header.ftl">
<#include "common/freemarker/include_custom.ftl">
<style>
strong {
	display: block;
	padding: 30px 0 10px 20px;	
}
</style>
<script type="text/javascript">
function changeArrow(currentId){
	document.getElementById(currentId).src ="common/images/arrow_blue.png"
}

function backArrow(currentId){
	document.getElementById(currentId).src ="common/images/arrow_grey.png"
}

$('a').bind('focus', function(){
	if(this.blur){    
		this.blur();   
    }   
}); 
</script>
<body >
  <div class="bs-sidebar hidden-print" >
    <ul class="nav bs-sidenav">
    	<strong>通用后台</strong>
    	<li ><a href="ea_organize_index.do" target="mainFrame" onMouseOver="changeArrow(1)" onMouseOut="backArrow(1)" onfocus="this.blur();"><img src="common/images/arrow_grey.png" id="1"/>&nbsp;&nbsp;<@i18n "menu_organize" /></a></li>
		<li ><a href="ea_user_menu_user.do" target="mainFrame" onMouseOver="changeArrow(2)" onMouseOut="backArrow(2)" onfocus="this.blur();"><img src="common/images/arrow_grey.png" id="2" />&nbsp;&nbsp;<@i18n "menu_user" /></a></li>
		<li ><a href="ea_resource_menu_resource.do" target="mainFrame" onMouseOver="changeArrow(3)" onMouseOut="backArrow(3)" onfocus="this.blur();"><img src="common/images/arrow_grey.png" id="3" />&nbsp;&nbsp;权限配置</a></li>
		<li ><a href="common_activiti_menu_process_definition.do" target="mainFrame" onMouseOver="changeArrow(4)" onMouseOut="backArrow(4)" onfocus="this.blur();"><img src="common/images/arrow_grey.png" id="4" />&nbsp;&nbsp;工作流管理</a></li>
		<li ><a href="ea_systempara_menu_systempara.do" target="mainFrame" onMouseOver="changeArrow(5)" onMouseOut="backArrow(5)" onfocus="this.blur();"><img src="common/images/arrow_grey.png" id="5" />&nbsp;&nbsp;系统参数</a></li>
 		<li ><a href="common_monitor_home.do" target="mainFrame" onMouseOver="changeArrow(6)" onMouseOut="backArrow(6)" onfocus="this.blur();"><img src="common/images/arrow_grey.png" id="6"/>&nbsp;&nbsp;状态监控</a></li>
    </ul>
  </div>
</body> 
 