<div id="goldOrderPage"  class="panel" data-load="loadGoldOrder" data-footer="none">
				
</div>
			
<script>
function loadGoldOrder(){
	$("#header").find("h1").text("排行榜["+currUsr.name+"]");
	sendRequest("ea_goldtask_goldrecords.do", function(jsonstr){
		$("#goldOrderPage").html("");
		var allGoldTraRec = JSON.parse(jsonstr);
		var cul = $('<ul class="list accordion" ></ul>');
		for(var key in usrMap){
			//排除 管理员， 
			if(key == "admin" || usrMap[key].parentModel.account == "admin"){
				continue;
			}
			
			var cli = $('<li style="padding: 15px 20px 15px 10px;"></li>');
			var cdiv1 = $('<a>' + usrMap[key].name + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="common/images/android/gold.png" />&nbsp;'+usrMap[key].goldNumber + '</a>');
			var cdiv2 = $('<div style="color: #999999;"><br /></div>');
			var cdiv3 = $('<span class="grid" ></span>');
			cdiv3.append('<span class="col1-3" style="font-weight: bold;">支付人/金币</span><span class="col2-3" style="font-weight: bold;">说明</span>');
			var recFlag = 0;
			for(var i = 0; i < allGoldTraRec.length; i++){
				if(allGoldTraRec[i].toUsrAccount == key){
					recFlag = 1;
					cdiv3.append('<span class="col1-3">'+usrMap[allGoldTraRec[i].fromUsrAccount].name+'/&nbsp;'+allGoldTraRec[i].goldNumber+'</span>'+
							'<span class="col2-3">'+allGoldTraRec[i].payDate.substring(0,11)+'&nbsp;'+allGoldTraRec[i].payRemarks+'</span>');
				}
			}
			cdiv2.append(cdiv3);
			if(recFlag == 0){
				cdiv2.html("<br/>无记录");
			}
			cli.append(cdiv1);
			cli.append(cdiv2);
			cul.append(cli);
		}
		$("#goldOrderPage").append(cul);
		cul.accordion({time:"0.2s"});
		setTimeout(function(){cli.find("div").css("height", "40px");}, 1000);
	});
}
</script>