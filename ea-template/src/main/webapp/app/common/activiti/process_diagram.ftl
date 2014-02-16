<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<#include "../../../common/freemarker/include_highslide.ftl">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>	

<body style="text-align:center;">
	<h2>Process Diagram
	    <a href="app/common/activiti/simple_solution_big.jpg" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" >
		MSTOP offcie process diagram
	    </a>	
	</h2> 
	<#if rhs.processInstanceId == ''>
		<img id="green_monster1" width="${rhs.imgWidth}px"
			src="common_activiti_process_diagram_simple.do?processDefinitionId=${rhs.processDefinitionId}" />
	<#else>
		<img id="green_monster1" width="${rhs.imgWidth}px"
			src="common_activiti_process_diagram_complex.do?processInstanceId=${rhs.processInstanceId}" />
	</#if>	
</body>
</html>