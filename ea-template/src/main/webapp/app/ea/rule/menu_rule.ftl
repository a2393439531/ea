<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>rule.js"></script>
<body style="margin:10px">
<div class="row" style="padding-left:10px">

	<div class="btn-group btn-group-xs" style="padding-bottom:10px">
	<a class="btn btn-xs btn-info" href=# onclick="javascript:action_rule('create.do','id=root');">发布信息</a>

    </div>		


	<div id=div_rule_tree >
		<#include "ajax_rule.ftl">
	</div>
</div>
</body>