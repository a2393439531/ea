<footer id="payGoldFooter">
	<a href="#payGoldPage"  id="navbar_paygold" class="icon info" data-transition="slide">支付金币</a>
	<a href="#goldTranRecPage" id="navbar_goldTranRec" class="icon info" data-transition="slide">交易记录</a>
</footer>

<div id="payGoldPage" data-load="loadPayGold" class="panel" data-footer="payGoldFooter" data-tab="navbar_paygold">
	
	<form action="" method="post">
		<br />
		<label for="payGoldNum">支出金币数: </label><input id="payGoldNum" type="number" placeholder="">
		<label for="tousrlist">收金人:</label><select id="tousrlist"></select>
		<label for="payRemarks">说明: </label><input id="payRemarks" type="text" placeholder="请输入说明" onclick="payRemarksClick()" />
		<input type="button" class="button" value="提交" style='float:right;' onclick="payGold()">
	</form>
</div>


<script>
//页面加载事件　
function loadPayGold(){
	if(!currUsr) return;
	$("#header").find("h1").text("金币支出["+currUsr.name+"]");
	$("#payGoldNum").attr("placeholder", "最多可支付 " + currUsr.goldNumber + " 金币");
	if(!usrMap) return;
	
	
	$("#tousrlist").html("");
	for(var key in usrMap){
		if(key != currUsr.account){
			$("#tousrlist").append('<option value="'+key+'">'+usrMap[key].name+'</option>');
		}
	}
}

//说明点击事件
function payRemarksClick (){
	if($("#payRemarks").val() && $("#payRemarks").val() != ""){
		return;
	}
	
	sendRequest("ea_goldtask_menu_usrgoldtask.do?isUsrRel=1&maxSize=-1", function(jsonstr){
		var jsonobj = $.parseJSON(jsonstr);
		var msg = '';
		for (var i = 1; i < jsonobj.length; i++) {
			msg += '<input id="aa_'+i+'" type="radio" name="taskTitle" value="'+jsonobj[i].title+'=='+jsonobj[i].goldNumber+'"><label for="aa_'+i+'">'+jsonobj[i].title+'</label>';
		}
		if(msg == ""){
			return;
		}
		msg += "<br />&nbsp;<br />&nbsp;";
		$("#afui").popup({message:  msg, cancelText: "确定", cancelOnly: true, title: "Task 选择",
			cancelCallback: function () {
				var val = $('input[name="taskTitle"]:checked').val();
				if(val && val != ""){
					if(!$("#payGoldNum").val()) $("#payGoldNum").val(val.split("==")[1]);
					$("#payRemarks").val(val.split("==")[0]);
				}
			}
		});
		
	});
}

//支付金币
function payGold (){
	var payGoldNum = $("#payGoldNum").val();
	var toUsr = $("#tousrlist").val();
	var payRemarks = $("#payRemarks").val();
	if(!payGoldNum || payGoldNum.trim() == ""){
		popuMsg("金币数不能为空!");
		return;
	}
	if(isNaN(payGoldNum)){
		popuMsg("金币必需为数字");
		return;
	}
	var url = "ea_goldtask_pay.do?goldtran.goldNumber="+payGoldNum+"&goldtran.toUsrAccount="+toUsr+"&goldtran.payRemarks="+payRemarks;
	optRequest(url, function(){
		$.ui.loadContent('goldTranRecPage',false,false,'flip');
	}, false);
	
}
</script>