<#include "include_demo_header.ftl">
<body style="padding: 10px; ">
	<strong>嵌套背景</strong><br>
	<div class="bs-example">
      <div class="well">
        Look, I'm in a well!
      </div>
 
       <div class="well well-lg">
        Look, I'm in a large well!
      </div>
       <div class="well well-sm">
        Look, I'm in a small well!
      </div>          
      
    </div>
<#--不兼容IE9的部分
<#include "app/common/test/bootstrap/ico.ftl">
	${'     <span class="glyphicon glyphicon-adjust"></span>
	        <span class="glyphicon-class">adjust</span>
	'?html} 
-->
</body>



