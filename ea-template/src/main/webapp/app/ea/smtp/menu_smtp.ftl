<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>smtp.js"></script>
<body style="padding:10px">
	<a class="btn btn-xs btn-default"   onclick="javascript:action_smtp('create.do','');">添加邮件服务器</a>
	<a class="btn btn-xs btn-default" href="ea_ea_menu_mail_list.do" target="mainFrame">邮件列表发送工具</a>
	<br><br>
	<#include "ajax_smtp.ftl">
	

</body>

