<div id="goldOrderPage"  class="panel" data-load="loadGoldOrder" data-footer="none">
				
</div>
			
<script>

function loadGoldOrder(){
	$("#header").find("h1").text("金币排行榜["+currUsr.name+"]");
	sendRequest("ea_goldtask_goldrecords.do", function(jsonstr){
		$("#goldOrderPage").html("");
		var allGoldTraRec = JSON.parse(jsonstr);
		var cul = $('<ul class="list accordion" ></ul>');
		for(var key in usrMap){
			//排除 管理员， 
			if(key == "admin" || usrMap[key].parentModel.account == "admin"){
				continue;
			}
			
			var praiseDaysTxt = "";
			var fecesDaysTxt = "";
			if(usrMap[key].praiseDate){
				praiseDaysTxt = usrMap[key].praiseDays == "0" ? "今天" : usrMap[key].praiseDays + " 天前";
			}
			if(usrMap[key].fecesDate){
				fecesDaysTxt = usrMap[key].fecesDays == "0" ? "今天" : usrMap[key].fecesDays + " 天前";
			}
			var cli = $('<li style="padding: 10px 15px 5px 10px;"></li>');
			var cdiv1 = $('<a></a>');
			cdiv1.append('<span style="vertical-align: middle;width: 40px; display:inline-block; ">' + usrMap[key].name + '</span>');
			cdiv1.append('<span style="vertical-align: middle;width: 60px; display:inline-block; "><img src="common/images/android/gold.png" />&nbsp;<span style="font-weight: bold;font-size: 14px;">' + usrMap[key].goldNumber + '</span></span>');
			cdiv1.append('<span style="vertical-align: middle;width: 70px; display:inline-block; "><img src="common/images/android/praise.png" />&nbsp;<span style="font-weight: bold;">' + usrMap[key].praiseNumber + '</span>&nbsp;&nbsp;<span style="color: #4B8005;font-size: 7px;">' +praiseDaysTxt+'</span></span>');
			cdiv1.append('<span style="vertical-align: middle;width: 70px; display:inline-block; "><img src="common/images/android/feces.png" />&nbsp;<span style="font-weight: bold;">' + usrMap[key].fecesNumber + '</span>&nbsp;&nbsp;<span style="color: #4B8005;font-size: 7px;">' +fecesDaysTxt+'</span></span>');
			//cdiv1.append('<span style="vertical-align: middle;width: 10px; display:inline-block; ">&nbsp;&nbsp;</span>');
			if(currUsr.account == "admin" || currUsr.parentModel.account == "admin"){
				cdiv1.append('<span style="vertical-align: middle;display:inline-block; "><a style="padding:4px 6px;margin:0;" class="button" onclick="addPraise(\''+usrMap[key].account+'\')">赞赏</a></span>');
				
				cdiv1.append('&nbsp;&nbsp;<span style="vertical-align: middle;display:inline-block; "><a style="padding:4px 6px;margin:0;" class="button" onclick="addFeces(\''+usrMap[key].account+'\')">鄙视</a></span>');
			}
			
			
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

function addPraise(usraccount){
	var praiseNumber = Number(usrMap[usraccount].praiseNumber);
	var datestr = getDateStr().substring(0, 11);
	var url = "ea_goldtask_updateuser.do?user.praiseDate="+datestr+"&user.praisenumber="+(praiseNumber + 1)+"&user.account="+usraccount + "&tipInfo=" + currUsr.name + "赞了" + usrMap[usraccount].name;
	
	
	optRequest(url,function(){
		usrMap[usraccount].praiseNumber = praiseNumber + 1;
		usrMap[usraccount].praiseDate = datestr;
		usrMap[usraccount].praiseDays = "0";
		loadGoldOrder();
	}, false);
}

function addFeces(usraccount){
	var fecesNumber = Number(usrMap[usraccount].fecesNumber);
	var datestr = getDateStr().substring(0, 11);
	var url = "ea_goldtask_updateuser.do?user.fecesDate="+datestr+"&user.fecesnumber="+(fecesNumber + 1)+"&user.account="+usraccount + "&tipInfo=" + currUsr.name + "鄙视了" + usrMap[usraccount].name;;
	optRequest(url,function(){
		usrMap[usraccount].fecesNumber = fecesNumber + 1;
		usrMap[usraccount].fecesDate = datestr;
		usrMap[usraccount].fecesDays = "0";
		loadGoldOrder();
	}, false);
}
</script>