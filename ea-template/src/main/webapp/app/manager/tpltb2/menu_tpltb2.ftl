<#include "../../../common/freemarker/include_header.ftl">
<head>
<script type="text/javascript" src="<@context_module/>tpltb2.js"></script>
<style>
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

<div style="padding:10px">
	<!-- <p> -->
		<a class="btn-new" onclick="javascript:action_tpltb2_dialog('manager_tpltb2_load.do','id=');$('#dialog').dialog('open');">添加成员</a>
		<!-- 
		<a onclick="javascript:action_tpltb2_dialog('manager_tpltb2_load.do','id=');$('#dialog').dialog('open');">添加成员</a>
		-->
	<!-- </p> -->
	<div id="dialog" >
	    <div id=div_tpltb2_dialog></div>
	</div>
	<#include "ajax_tpltb2.ftl">
</div>