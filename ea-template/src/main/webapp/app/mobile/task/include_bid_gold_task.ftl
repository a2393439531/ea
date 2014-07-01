<!--可投标任务页面-->
<div id="bidTaskPage"  class="panel" data-load="loadBidTaskPage" data-header="taskHeader" data-footer="taskFooter" >
	<div id="contentList"></div>
</div>
<script>
	 function loadBidTaskPage(what){
    	$("#taskHeader").find("h1").text('可投标任务['+currUsr.name+']');
		curPage2 = 1;
		pageTask(what.id, "ea_goldtask_menu_bidgoldtask.do?&pageId=1&maxSize=" + maxSize, false);
    }
</script>