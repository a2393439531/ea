<#include "../../../common/freemarker/include_header.ftl">
<head>
<script type="text/javascript" src="<@context_module/>tpltb1.js"></script>
<style>
p {
	padding: 15px 0 0 10px;
	font-size: 13px;
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
.table {
	margin-left: 10px;
}
.table th, .table td {
	vertical-align: middle;
	text-align: center;
}
select, input[type="text"] {
	margin-bottom: 0px;
}
</style>
</head>
<p>本界面模式适合一些配置信息的增加删除修改，因为操作维护比较方便， 但缺乏查询等功能</p>
<div class="row" style="padding-left:5px">
	<div class="span5">
		<!--
		<a class="btn btn-primary"  onclick="javascript:action_tpltb1('create.do','');">添加</a>
		-->
		<a class="btn-new"  onclick="javascript:action_tpltb1('create.do','');">添加</a>
	</div>
	<#include "ajax_tpltb1.ftl">
</div>
</body>
<#---->
<!-- <hr> -->
<div style="float:right; margin-right: 20px;">
	<p>&copy; Company 2013</p>
</div>

