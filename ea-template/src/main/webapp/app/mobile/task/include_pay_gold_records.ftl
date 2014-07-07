<!--金币交易记录-->
<div id="goldTranRecPage" class="panel" data-load="loadPayGoldRec" data-footer="payGoldFooter" data-tab="navbar_goldTranRec">
	<p style="" align="center">
		收入: <span id="goldIncome" style="font-weight: bold; color: #C12E2A;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> 
		支出: <span id="goldOutlay" style="font-weight: bold; color: #C12E2A;"></span> 
	</p>
	<ul id="goldTranList" class="list"></ul>
				
</div>

<script>
	function loadPayGoldRec(){
		$("#header").find("h1").text("交易记录["+currUsr.name+"]");
		sendRequest("ea_goldtask_goldrecords.do?isCurrr=1", function(jsonstr){
			$("#goldTranList").html("");
			var jsonobj = $.parseJSON(jsonstr);
			var goldOutlay = 0, goldIncome = 0;
			for (var i = 0; i < jsonobj.length; i++) {
				var tmpName, tmpicon;
				var data = jsonobj[i];
				if(data.fromUsrAccount == currUsr.account){
					tmpName = usrMap[data.toUsrAccount].name; 
					tmpicon = '-';
					goldOutlay += Number(data.goldNumber);
				}else if(data.toUsrAccount == currUsr.account){
					tmpName = usrMap[data.fromUsrAccount].name; 
					tmpicon = '+';
					goldIncome += Number(data.goldNumber);
				}
				var tmpremarks = data.payRemarks.length > 12 ? data.payRemarks.substring(0,12) + "..." : data.payRemarks;
				var tmpHtml = '<li style="padding: 10px 20px 10px 10px;"><font style="font-weight: bold;">'+tmpName+'</font>&nbsp;&nbsp;&nbsp;<font style="font-size: 10px; color: #696969;">'+tmpremarks+'</font><span style="float: right; color: #F00308;"> <img src="common/images/android/gold.png" /> &nbsp;'+tmpicon + data.goldNumber+'</span><br><font style="color: #919191; font-size: 10px;padding-left: 20px;">'+data.payDate.substring(0,11)+'</font></li>';
				$("#goldTranList").append(tmpHtml);
			}
			$("#goldIncome").text(goldIncome);
			$("#goldOutlay").text(goldOutlay);
		});
	}
</script>