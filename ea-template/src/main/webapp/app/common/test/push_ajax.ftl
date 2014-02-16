<#macro size_show  size_value>
	<#assign size_length= size_value?length>
	<#if size_length lt 6>
	       ${size_value?default("")} bety
	      <#else>
	       ${size_value[0..size_length-7]?default("")}M
	</#if>
</#macro>
<p id=result>
<br>runtime.totalMemory:<@size_show rhs["runtime"].totalMemory()  />	
<br>runtime.freeMemory:<@size_show rhs["runtime"].freeMemory()  />	
<br>runtime.maxMemory:<@size_show rhs["runtime"].maxMemory()  />	
<br>runtime.availableProcessors:${ rhs["runtime"].availableProcessors() }个
</p>
