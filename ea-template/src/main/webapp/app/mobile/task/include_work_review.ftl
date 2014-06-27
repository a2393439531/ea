<div id="workReviewPage"  class="panel" data-load="loadWorkReview" data-footer="none"></div>
			
<script>
function loadWorkReview(what){
	var pageobj = $("#" + what.id);
	pageobj.html("");
	what.setAttribute("data-title", "表现排行榜["+currUsr.name+"]");
	
	if(!usrMap){
		console.log("userMap is empty...");
		return;
	}
	var cul = $('<ul class="list" ></ul>');
	var tmpUsrArray = [];
	for(var key in usrMap){
		tmpUsrArray.push(usrMap[key]);
	}
	tmpUsrArray.sort(function (usr1, usr2) {
		return usr2.praiseNumber - usr1.praiseNumber; //降序 
	　　//return f1 - f2;	//升序
	});
	
	for(var i = 0; i < tmpUsrArray.length; i++){
		var key = tmpUsrArray[i].account;
		//排除 管理员，
		if(key == "admin" || usrMap[key].parentModel.account == "admin"){
			continue;
		}
		
		var cli = $('<li style="padding: 10px 10px 5px 10px;"></li>');
		var gridDiv = $('<div class="grid"></div>');
		var praiseDaysTxt = "";
		var fecesDaysTxt = "";
		if(usrMap[key].praiseDate){
			praiseDaysTxt = "距离上次: " + usrMap[key].praiseDays + " 天";
		}
		if(usrMap[key].fecesDate){
			fecesDaysTxt = "距离上次: " + usrMap[key].fecesDays + " 天";
		}
		
		//管理员可以加赞或鄙视
		if(currUsr.account == "admin" || currUsr.parentModel.account == "admin"){
			gridDiv.append('<div style="width: 20%;float: left;padding: 10px;10px;">'+usrMap[key].name+'</div>');
			gridDiv.append('<div style="width: 25%;float: left;"><img src="common/images/android/praise.png" />'+usrMap[key].praiseNumber+'<br/><span style="color: #666666;">'+praiseDaysTxt+'</span></div>');
			gridDiv.append('<div style="width: 25%;float: left;"><img src="common/images/android/feces.png" />'+usrMap[key].fecesNumber+'<br/><span style="color: #666666;">'+fecesDaysTxt+'</span></div>');
			gridDiv.append('<div style="width: 30%;float: left;vertical-align: middle;"><a style="padding:4px 6px;margin:0;" class="button" onclick="addPraise(\''+usrMap[key].account+'\')">赞赏</a>&nbsp;<a style="padding:4px 6px;margin:0;" class="button" onclick="addFeces(\''+usrMap[key].account+'\')">鄙视</a></div>');	
		}else{
			gridDiv.append('<div style="width: 20%;float: left;padding: 10px;10px;">'+usrMap[key].name+'</div>');
			gridDiv.append('<div style="width: 25%;float: left;"><img src="common/images/android/praise.png" />'+usrMap[key].praiseNumber+'<br/><span style="color: #666666;">'+praiseDaysTxt+'</span></div>');
			gridDiv.append('<div style="width: 25%;float: left;"><img src="common/images/android/feces.png" />'+usrMap[key].fecesNumber+'<br/><span style="color: #666666;">'+fecesDaysTxt+'</span></div>');
			gridDiv.append('<div style="width: 30%;float: left;vertical-align: middle;">&nbsp;</div>');
		}
		
		
		cli.append(gridDiv);
		cul.append(cli);
	}
	pageobj.append(cul);
}

function addPraise(usraccount){
	var praiseNumber = Number(usrMap[usraccount].praiseNumber);
	var datestr = getDateStr().substring(0, 11);
	var url = "ea_goldtask_updateuser.do?user.praiseDate="+datestr+"&user.praisenumber="+(praiseNumber + 1)+"&user.account="+usraccount;
	optRequest(url,function(){
		usrMap[usraccount].praiseNumber = praiseNumber + 1;
		usrMap[usraccount].praiseDate = datestr;
		usrMap[usraccount].praiseDays = "0";
		loadWorkReview($("#workReviewPage").get(0));
	}, false);
}

function addFeces(usraccount){
	var fecesNumber = Number(usrMap[usraccount].fecesNumber);
	var datestr = getDateStr().substring(0, 11);
	var url = "ea_goldtask_updateuser.do?user.fecesDate="+datestr+"&user.fecesnumber="+(fecesNumber + 1)+"&user.account="+usraccount;
	optRequest(url,function(){
		usrMap[usraccount].fecesNumber = fecesNumber + 1;
		usrMap[usraccount].fecesDate = datestr;
		usrMap[usraccount].fecesDays = "0";
		loadWorkReview($("#workReviewPage").get(0));
	}, false);
}

</script>