<#include "include_demo_header.ftl">
<body style="padding: 10px; ">
	<strong>table表格</strong><br>
      .table-condensed：紧凑 table-striped:隔行底色不同      table-hover：鼠标移动选择行  table-bordered:网格
	<pre>
	${'
 	<table class="table table-condensed table-bordered table-striped ">
 	<div class="table-responsive"> 表格自动响应 ，    当屏幕宽度缩小时，表格可以出现滚动条（IE9在frame下不支持）
  	'?html} 
	</pre>
  	<#include "../bootstrap/table.ftl">
</body>




