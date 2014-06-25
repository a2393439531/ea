<#include "include_af_header.ftl">
<div id="afui"><div id="content">
<div id="myscroller" title="scroller" class="panel"  selected="true">
	
	<script>
		var myScroller;
		var isAppend = false;
		var curPage = 1, pageSize=-1; maxSize=2;
		$.ui.ready(function () {
			myScroller = $("#myscroller").scroller();
			myScroller.addInfinite();
			myScroller.addPullToRefresh();
			myScroller.refreshContent="加载中...";
			myScroller.refreshHangTimeout=700;
			
			$.bind(myScroller, "refresh-release", function () {
				console.log("refresh-release.....");
				myScroller.setRefreshContent("加载中...");
				$.unbind(myScroller, "infinite-scroll-end");
				curPage = 1;
				isAppend = false;
				requestPageData();
			});
			$.bind(myScroller, "infinite-scroll", function () {
				var self = this;
				$.bind(myScroller, "infinite-scroll-end", function () {
					console.log("infinite-scroll-end.....");
					$.unbind(myScroller, "infinite-scroll-end");
					curPage += 1;
					isAppend = true;
					requestPageData();
				});
			});
		});
		
		function requestPageData(){
			var url="../../../../../common_test_pagedata.do?pageId="+curPage + "&maxSize=" + maxSize;
			if(pageSize >= 0 && curPage > pageSize) return;
			$.ajax({
				type: "post",
				url: url,
				timeout: 4000,
				async: true,
				success: function(data){
					console.log("isAppend:" + isAppend);
					if(isAppend == false){
						$("#myscroller").find("ul").html("");
					}
					data = JSON.parse(data);
					for(var i = 1; i < data.length; i++){
						$("#myscroller").find("ul").append("<li>"+data[i].content+"</li>");
					}
					myScroller.clearInfinite();
					myScroller.scrollToBottom();
				},
				error: function(xhr, txt){
					$.ui.showMask("请求出错");
					setTimeout(function(){$.ui.hideMask();}, 1000);
					myScroller.clearInfinite();
				}
			});
					
		}
				
    </script>
    
	<ul class="list" >
		
	</ul>	
</div>
</div></div>