<!--所有任务页面-->
<div id="allTaskPage"  class="panel" data-load="loadAllTaskPage" data-header="taskHeader" data-footer="taskFooter" data-tab="navbar_alltask">
	<div id="contentList"></div>
</div>
<script>
	 function loadAllTaskPage(what){
    	$("#taskHeader").find("h1").text('所有任务['+currUsr.name+']');
		curPage1 = 1;
		pageTask(what.id, "ea_goldtask_menu_allgoldtask.do?&pageId=1&maxSize=" + maxSize, false);
    }
</script>