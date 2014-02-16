<#include "../../../common/freemarker/include_header.ftl">

<script type="text/javascript" src="<@context_module/>/ruledetail.js"></script>

<div  style="padding:10px">
	<a href=# onclick="javascript:action_ruledetail('create.do','parentId=${rhs["rule"].id?if_exists}');">新增内容</a>
	&nbsp;&nbsp;&nbsp;
	<hr>
	<#include "ajax_ruledetail.ftl">
	
	<hr>
	<br>
	<br>预览：<br>
	<iframe id="previewFrame" name="previewFrame"  src="ea_rule_detail.do?id=${rhs["rule"].id?if_exists}" style="width:900px;height:600px;" frameborder="1"  noresize="noresize"  />
</div>
