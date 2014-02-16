<#macro size_show  size_value>
	<#assign size_length= size_value?length>
	<#if size_length lt 6 ||size_length== 6>
	       ${size_value?default("")} bety
	      <#else>
	       ${size_value[0..size_length-7]?default("")}M
	</#if>
</#macro>
<b>runtime.freeMemory:</b><span class="label label-danger "><@size_show rhs["runtime"].freeMemory()  /></span> 	
<br><b>runtime.totalMemory:</b><@size_show rhs["runtime"].totalMemory()  />	
<br><b>runtime.maxMemory:</b><@size_show rhs["runtime"].maxMemory()  />	
<br><b>runtime.availableProcessors:</b>${ rhs["runtime"].availableProcessors() }个

