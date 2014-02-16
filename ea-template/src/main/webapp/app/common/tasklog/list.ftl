
<form class="well">
	<fieldset>
	<legend>Log</legend>

	<#if rhs.taskId != ''>
		<textarea id="log_log" name="log" row="3" placeholder="Input your log here..."></textarea>
		<input type="hidden" id="log_taskId" name="taskId" value="${rhs.taskId?if_exists}"/>
		<input type="button" value="Add" class="btn" onclick="add_log();">
	</#if>
	<a class="btn" href="common_tasklog_export.do?taskId=${rhs.taskId?if_exists}&processInstanceId=${rhs.processInstanceId?if_exists}" target="_blank">Export</a>
	<hr>
	<div style="height:400px; overflow:auto">
	<#list rhs["list"] as x>
		<h5>
			${x.userName?if_exists}&nbsp;&nbsp;&nbsp;&nbsp;
			<#if x.taskId==rhs.taskId && x.userAccount==Session.userlogined.account>
			<small>
				<a href='javascript:void(0);' 
					onclick="javascript:del_log('${x.id?if_exists}')" >
						<i class='icon-remove'></i>&nbsp;Delete
				</a>
			</small>
			</#if>
			<br>
			<small>For Task '${x.taskName?if_exists}'</small>
		</h5>
		<blockquote>
			<p>${x.log?if_exists}</p>
			<small>${x.createTime?if_exists}</small>
		</blockquote>
		<hr>
	</#list> 
	</div>
	
	</fieldset>
</form>
<script type="text/javascript">
function add_log(){
	var log = $("#log_log").val();
	if(log == ''){
		$("#log_log").focus();
		return;
	}
	$.ajax({
		type: 'post',
		url: 'common_tasklog_save.do',
		data: 'log=' + log + '&taskId=${rhs.taskId?if_exists}',
		async: false,
		cache: false,
		success: function(data){
			$("#task_log_div").html(data);
		}
	});
}

function del_log(id){
	$.ajax({
		type: 'post',
		url: 'common_tasklog_delete.do',
		data: 'id=' + id + '&taskId=${rhs.taskId?if_exists}',
		async: false,
		cache: false,
		success: function(data){
			$("#task_log_div").html(data);
		}
	});
}
</script>