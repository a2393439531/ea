<#include "include_af_header.ftl">

<div id="afui"><div id="content">
<div id="testpage" title="测试" class="panel"  selected="true">
 
	
 
</div></div></div>

<script>
	var webSocketExist = true;
	try{
		var mySocket = new WebSocket("ws://localhost:8080/demo/service/management/tables");
		mySocket.onopen = function(event){
			mySocket.send("test xxx");
			mySocket.onmessage = function (e) {
				console.log("e: " + e);
			};
			mySocket.onclose = function(event){
				console.log("socket 关闭");
			};
		};
		
		
	}
	catch(ex){webSocketExist = false;}
</script>