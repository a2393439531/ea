<#include "../../../common/freemarker/include_header.ftl">

<script type="text/javascript" src="<@context_module/>tpltb1.js"></script>
<body style="padding:10px">

<p class="p-normal-style">本界面模式适合一些配置信息的增加删除修改，“更新”“排序”操作维护比较方便， 但缺查询等功能</p>
<div class="row" style="padding:5px">
	<div class="span5">
		<!--
		<a class="btn btn-primary"  onclick="javascript:action_tpltb1('create.do','');">添加</a>
		-->
		<a class="btn-new"  onclick="javascript:action_tpltb1('create.do','');">添加</a>
	</div>
	<#include "ajax_tpltb1.ftl">
</div>
</body>


</body>
