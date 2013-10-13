<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>extp.js"></script>


<a  onclick="javascript:action_extp('create.do','id=root&modelname=${rhs["modelname"]?if_exists}');">添加根节点</a>
<hr>
<div id=div_extp_tree>
	<#include "ajax_extp.ftl">
</div>
</div>

