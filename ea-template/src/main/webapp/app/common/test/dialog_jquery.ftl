<#include "../../../common/freemarker/include_header.ftl">
<script>
	$(function(){
		$('#dialog').dialog({
			autoOpen: false,
			modal: true,
			width: 600
		});
	});


</script>
	<div id="dialog" >
	    <div id=div_tpltb2_dialog> </div>
	</div>

	<a onclick="javascript:$('#dialog').dialog('open');">添加成员</a>
	