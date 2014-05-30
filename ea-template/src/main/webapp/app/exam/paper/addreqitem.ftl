<#assign i = 0 />
<#assign j = 0 />
<#assign k = 0 />
<#assign l = 0 />
<#list rhs["datalist"] as item>
	<a href="#" onclick="javascript:ajax_show_item('exam_item_load.do','method=show&id=${item.id}');" >${item.content}</a><br/>
	<#if rhs["itemtype"] == "1" >
		<input type="hidden" name="reqsinglechoice" value="${item.id}"/>
		<#assign i = i + 1 />
	</#if>
	<#if rhs["itemtype"] == "2" >
		<input type="hidden" name="reqmultichoice" value="${item.id}"/>
		<#assign j = j + 1 />
	</#if>
	<#if rhs["itemtype"] == "3" >
		<input type="hidden" name="reqblank" value="${item.id}"/>
		<#assign k = k + 1 />
	</#if>
	<#if rhs["itemtype"] == "4" >
		<input type="hidden" name="reqessay" value="${item.id}"/>
		<#assign l = l + 1 />
	</#if>
</#list>
<#if rhs["itemtype"] == "1" >
	<input type="hidden" id="reqsinglechoicecount" value="${i}"/>
</#if>
<#if rhs["itemtype"] == "2" >
	<input type="hidden" id="reqmultichoicecount" value="${j}"/>
</#if>
<#if rhs["itemtype"] == "3" >
	<input type="hidden" id="reqblankcount" value="${k}"/>
</#if>
<#if rhs["itemtype"] == "4" >
	<input type="hidden" id="reqessaycount" value="${l}"/>
</#if>