<#include "../include_custom.ftl">
<style type="text/css">

</style>
<!--发布，　编辑任务页面-->
<div id="taskPage" class="panel" data-footer="none" data-load="loadTask">
	<!--
	<label for="taskName">任务名称: </label><input name="goldtask.title" maxlength="10" id="taskName" type="text" placeholder="请输入任务名称, 长度小于等于10">
	<label for="taskRemarks">任务说明:</label><textarea name="goldtask.detail"  id="taskRemarks" rows="6" placeholder="请输入任务说明"></textarea>
	<label for="endDate">截止日期: </label><input name="goldtask.endDate" readonly="readonly" id="endDate" class="Wdate" type="text" onClick="WdatePicker()">
	<label for="gold">悬赏金币:</label><input name="goldtask.goldNumber" id="gold" type="number" placeholder="请输入悬赏金币数">
	<div id="taskTmpDiv" ></div>
	-->
	
	
	<!--
	<div>
		任务名称：<input name="goldtask.title" maxlength="10" id="taskName" type="text" placeholder="请输入任务名称, 长度小于等于10">
	</div>
	<div>
		<div id="description" >任务说明：</div>
		<textarea name="goldtask.detail"  id="taskRemarks" rows="6" placeholder="请输入任务说明"></textarea>
	</div>
	<div>
		截止日期：<input name="goldtask.endDate" readonly="readonly" id="endDate" class="Wdate" type="text" onClick="WdatePicker()">
	</div>
	<div>
		<div id="rewardGold">悬赏金币：</div>
		<input name="goldtask.goldNumber" id="gold" type="number" placeholder="请输入悬赏金币数" >
	</div>
	<div id="taskTmpDiv" ></div>
	-->
	
	<table style="width: 100%;">
		<tr>
			<td>任务名称：</td>
			<td><input name="goldtask.title" maxlength="10" id="taskName" type="text" placeholder="请输入任务名称, 长度小于等于10"></td>
		</tr>
		<tr>
			<td id="description">任务说明：</td>
			<td><textarea name="goldtask.detail"  id="taskRemarks" rows="6" placeholder="请输入任务说明"></textarea></td>
		</tr>
		<tr>
			<td>截止日期：</td>
			<td><input name="goldtask.endDate" readonly="readonly" id="endDate" class="Wdate" type="text" onClick="WdatePicker()"></td>
		</tr>
		<tr>
			<td>悬赏金币：</td>
			<td><input name="goldtask.goldNumber" id="gold" type="number" placeholder="请输入悬赏金币数" ></td>
		</tr>
	</table>
</div>

<script>
	var tmpd = $("#endDate").val();
	if(!tmpd || tmpd == ""){
		$("#endDate").val(getDateStr().substring(0, 11));
	}
	
	function loadTask(){
		if(taskPageIsEdit == true){
			var url = "ea_goldtask_get_task.do?taskId=" + tmpTaskId;
			sendRequest(url, function(jsonstr){
				$("#taskTmpDiv").html("");
				var jsonobj = JSON.parse(jsonstr);
				jsonobj = jsonobj[0];
				$("#taskName").val(jsonobj.title);
				$("#taskRemarks").val(jsonobj.detail);
				$("#endDate").val(jsonobj.endDate);
				$("#gold").val(jsonobj.goldNumber);
				if(jsonobj.usrAccountArray && jsonobj.usrAccountArray.length >= 1){
					$("#taskPage").find("input").attr("disabled", "true");
					var array = jsonobj.usrAccountArray.split(",");
					var tmphtml = '<label>中标人员</label>';
					for(var j = 0; j < array.length; j++){
						var tmpaccount = array[j];
						tmphtml +='<input id="aa_'+j+'" type="radio" name="finishAccount" value="'+tmpaccount+'"><label for="aa_'+j+'">'+usrMap[tmpaccount].name+'</label>';
					}
					tmphtml += '<br style="clear:both">';
					$("#taskTmpDiv").append(tmphtml);
					var bidbtn = $('<a class="button" style="float: right;">结束投票</a>');
					bidbtn.bind("click", function(){
						var tmpaccount = $('input[name=finishAccount]:checked').val();
						if(!tmpaccount || tmpaccount.trim() == ""){
							popuMsg("操作失败: 没有选择中标人员");
							return;
						}
						optRequest("ea_goldtask_finish_bid.do?bidUsrAccount="+tmpaccount+"&taskId=" + tmpTaskId);
					});
					$("#taskTmpDiv").append(bidbtn);
					return;
				}
				var upateBtn = $('<a class="button" style="float: right;">修改</a>');
				var deleteBtn = $('<a class="button" style="float: right;">删除</a>');
				upateBtn.bind("click", function(){
					var formobj = validtionTask();
					if(!formobj)return;
					optRequest("ea_goldtask_update.do?goldtask.id="+tmpTaskId+"&goldtask.title="+formobj.title+"&goldtask.detail="+formobj.detail+"&goldtask.endDate="+formobj.endDate+"&goldtask.goldNumber="+formobj.goldNumber+"&goldtask.usrAccount="+formobj.usrAccount);
				});
				deleteBtn.bind("click", function(){
					optRequest("ea_goldtask_delete.do?goldtask.id="+tmpTaskId);
				});
				$("#taskTmpDiv").append(deleteBtn);
				$("#taskTmpDiv").append(upateBtn);
			});
			
			taskPageIsEdit = false;
			$("#header").find("h1").text("编辑任务["+currUsr.name+"]");		
		}else{
			$("#releaseTaskForm").find("input").removeAttr("disabled");
			$("#taskTmpDiv").html("");
			$("#taskTmpDiv").html('<input type="button" class="button" value="发布" style="float:right;" onclick="releaseTask()">');
			$("#header").find("h1").text("发布任务["+currUsr.name+"]");
		}
	}
	
	//发布任务
	function releaseTask(){	
		
		var formobj = validtionTask();
		if(!formobj) return;
		//oprationTask("ea_goldtask_release.do?goldtask.title="+formobj.title+"&goldtask.detail="+formobj.detail+"&goldtask.endDate="+formobj.endDate+"&goldtask.goldNumber="+formobj.goldNumber+"&goldtask.usrAccount="+formobj.usrAccount);
		optRequest("ea_goldtask_release.do?goldtask.title="+formobj.title+"&goldtask.detail="+formobj.detail+"&goldtask.endDate="+formobj.endDate+"&goldtask.goldNumber="+formobj.goldNumber+"&goldtask.usrAccount="+formobj.usrAccount);
		
	}
	
</script>