<#include "../../../common/freemarker/include_header.ftl">
<div class="container-fluid" style="padding:10px">
	<form class="form-inline" action="common_activiti_upload_process_file.do" method="post" enctype="multipart/form-data">
		<fieldset>
			<legend>Upload Process File</legend>
			<input name="file" class="input-file" type="file">
			<br>
			<input type="submit" class="btn btn-xs btn-primary" value="Upload" />
		</fieldset>
	</form>
	<hr>
	<table class="table table-condensed table-hover">
	    <thead>
		<tr>
			<th>File Name</th>
			<th>Upload Time</th>
		</tr>
		</thead>
		<#list rhs["list"] as item>
			<tr>
				<td>${item.name}</td>
				<td>${item.deploymentTime?datetime}</td>
			</tr>
		</#list>
	</table>
</div>
