<#include "common/freemarker/include_header.ftl">
<head>
<style>
body{
	padding:0;
	width:100%;  
	height:100%;  
	margin: 0px auto;  
	background-color:#F5F5F5; 
}
a {
	color: #224888;

}
.container-fluid {
	padding: 0 10px 0 10px;
	margin: 0;
}
.nav-header {
	color: #224888;
	font-size: 14px;
	font-weight: bold;
}
.nav-list > .active > a, .nav-list > .active > a:hover {
	background-color: #456086;
}
</style>
</head>
<div class="container-fluid">
	<!-- <div class="well" style="padding: 12px 0;"> -->
	<div style="padding: 12px 0;">
		<ul class="nav nav-list">
		  <li class="nav-header">AAA-TEAM</li>
		  <li onclick="menu_active(this)"> <a href="manager_tpltb1_menu_tpltb1.do" target="mainFrame">table-crud-ajax模式</a></li>
		  <li onclick="menu_active(this)"> <a href="manager_tpltb2_menu_tpltb2.do" target="mainFrame">table-crud-对话框模式</a></li>
		  <li onclick="menu_active(this)"> <a href="manager_tpltb3_list.do" target="mainFrame">table-crud-常见</a></li>
		  <li onclick="menu_active(this)"> <a href="manager_tpltree1_menu_tpltree1.do" target="mainFrame">tree-crud-ajax模式</a></li>
		  <li onclick="menu_active(this)"> <a href="demo.ftl" target="mainFrame">tab</a></li>
		  <li onclick="menu_active(this)"> <a href="manager_smtp_menu_smtp.do" target="mainFrame">smtp</a></li>
		</ul>
	</div><!--/.well -->
</div>
<script>
function menu_active(obj){
	$(".active").removeClass("active");
	$(obj).addClass("active")
}
</script>


