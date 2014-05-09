<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>edit.js"></script>
<div class="panel panel-primary">
    <div class="panel-heading">
    	<@i18n "menu_papergroup_view" />
    </div>
	<div class="panel-body">
		<table class="table table-condensed table-bordered table-striped">
			<#list rhs["datalist"] as file>
				<tr>
					<td width="200px;">
						<a href="#" onclick="javascript:load_content('${file.getName()}');return false;">${file.getName()}</a>
					</td>
					<#if file_index < 1 >
						<td rowspan="${rhs["datalist"]?size}">
						<form name="form_item" action="common_edit_file_save.do" metiod="post">
							<div id = "div_content">
								<textarea disabled="disabled" id='file_content' style="width:800px;height:200px;">Select one file from left side</textarea>
							</div>
							<input type="hidden" value="" name="file_name" id="file_name"/>
							<br/><input type='button' disabled="disabled" class='btn btn-xs btn-info' value='Save' id='submitButton'/>
		 					<input type='button' disabled="disabled" class='btn btn-xs btn-info' value='Reload' id='reloadButton'/>
						</form>
						</td>
					</#if>
				</tr>
			</#list>
		</table>
	</div>
</div>
<script>
$('#submitButton').click(function () {
		var btn = $(this);
		btn.button('loading');
		document.getElementsByName("form_item")[0].submit();
});
$('#submitButton').click(function () {
		var btn = $(this);
		btn.button('loading');
});
</script>