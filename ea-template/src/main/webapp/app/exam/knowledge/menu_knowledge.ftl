<#include "../../../common/freemarker/include_header.ftl">
<head>
<script type="text/javascript" src="<@context_module/>knowledge.js"></script>
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
<body style="padding-left:30px">
<div class="row">
	<div class="span5">
	<a class="btn btn-xs btn-primary"  onclick="javascript:action_knowledge('create.do','id=root');"><@i18n "menu_knowledge_new" /></a>
	<a class="btn btn-xs btn-primary"  onclick="javascript:window.location.href='exam_item_list.do';"><@i18n "return" /></a>
	</div>
	<div id="div_knowledge_tree" class="span11">
		<#include "ajax_knowledge.ftl">
	</div>
</div>
</body>