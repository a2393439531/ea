<!--我的任务页面-->
<div id="usrTaskPage"  class="panel" data-load="loadUsrTask" data-header="taskHeader" data-footer="taskFooter" >
	<div id="contentList"></div>
</div>
<script>
	 function loadUsrTask(what){
    	$("#taskHeader").find("h1").text('我的任务['+currUsr.name+']');
		curPage3 = 1;
		pageTask(what.id, "ea_goldtask_menu_usrgoldtask.do?&pageId=1&maxSize=" + maxSize, false);
    }
</script>