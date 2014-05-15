<#include "../../../common/freemarker/include_header.ftl">
<form name="form_item" action="exam_item_import_itembyxls_save.do" method="post" enctype="multipart/form-data" >
<input type="hidden" mane="method" value="import" />
	<div class="panel panel-primary" style="margin-top: 18px;">
		<div class="panel-heading"><strong><@i18n "menu_item_import" /></strong></div>
		<div class="panel-body">
			<table class="table table-condensed table-bordered table-striped">
				<tr>
					<td colspan="2">
						1. 
						<br/>2.
						<br/>3.
						<br/>4.
					</td>
				</tr>
				<tr>
					<td colspan="2"><img src="<@context/>common/images/uploadtemplate.jpg" alt="Upload file template" /></td>
				</tr>
				<tr>
					<td colspan="2"><input type="File"  name="file" /> <input type="button" class="btn btn-xs btn-info" value="Save" id="submitButton"/>					
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>
<script>
	$('#submitButton').click(function () {
		var btn = $(this);
		btn.button('loading');
		$('#dialog').dialog('open');
		document.getElementsByName("form_item")[0].submit();
	});
</script>