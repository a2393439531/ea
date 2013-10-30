<#include "../../../common/freemarker/include_header.ftl">
<head>
<script type="text/javascript" src="<@context_module/>tpltree1.js"></script>
<style>
.span5 {
	padding-top: 10px; 
}
.btn-new {
	background-color: #45A0F3;
    background-image: none; 
    border: none;
    color: #FFFFFF;
    padding: 3px 12px;
    margin: 0 0 5px 5px;
    cursor: pointer;
    display: inline-block;
    font-size: 14px;
    line-height: 20px;
    text-align: center;
    vertical-align: middle;
    }
a:hover {
	text-decoration: none;
	color: #FFFFFF;
}
.btn-new:hover {
	background-color: #73B8F9;
}
.table th, .table td {
	border-top-style: none;
}
select, input[type="text"] {
	margin-bottom: 0px;
}
</style>
</head>

<div class="row" style="padding-left:10px">
	<div class="span5">
	<a class="btn-new" href=# onclick="javascript:action_tpltree1('create.do','id=root');">添加根节点</a>
	</div>
	<div id=div_tpltree1_tree class="span11">
		<#include "ajax_tpltree1.ftl">
	</div>
</div>
</body>