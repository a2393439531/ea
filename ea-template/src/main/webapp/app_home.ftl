
<!DOCTYPE html>
<html>
<head>
	<title>Gold Task </title>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/ios.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/icons.css" />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/main.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/appframework.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/lists.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/forms.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/buttons.css"  />
	
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/grid.css"  />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/plugins/css/af.actionsheet.css"  />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/plugins/css/af.popup.css"  />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/plugins/css/af.scroller.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/plugins/css/af.selectBox.css"  />
	
	
	<style>
		.tmpcol2_1{
			width: 30%;
    		float: left;
		}
		.tmpcol2_2{
			width:69%;
    		float: left;
		}
		
		#afui .button.blue{
			background-color:#889BB3;
		}
		
		#afui .col4{
			width: 25%;
    		float: left;
		}
			
	</style>
	
	
	
	<script type="text/javascript" charset="utf-8" src="common/appframework-2-1/appframework.js"></script>
	<script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.scroller.js"></script>
	<script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.actionsheet.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.css3animate.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.passwordBox.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.touchEvents.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.touchLayer.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.popup.js"></script>
	
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/appframework.ui.js"></script>
	<script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/transitions/flip.js"></script>
	<script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/transitions/fade.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/transitions/flip.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/transitions/pop.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/transitions/slide.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/transitions/slideDown.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/transitions/slideUp.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/theme.js"></script>
	
	<script language="javascript" type="text/javascript" src="common/My97DatePicker/WdatePicker.js"></script>
	
	<script>
		
		if (!((window.DocumentTouch && document instanceof DocumentTouch) || 'ontouchstart' in window)) {
			var script = document.createElement("script");
			script.src = "common/appframework-2-1/plugins/af.desktopBrowsers.js";
            var tag = $("head").append(script);
        }
		

		
	</script>
	
	
	
<script>	
	var loginedUsrAccount = '<#if Session?exists && Session["userlogined"]?exists>${Session["userlogined"].account?if_exists}</#if>';
	var allGoldTask, usrGoldTask, bidGoldTask;
	var allMaxSize = 10, allCurrPage = 0; allMaxPage = 0;
	var usrMaxSize = 10, usrCurrPage = 0; usrMaxPage = 0;
	var bidMaxSize = 10, bidCurrPage = 0; bidMaxPage = 0;
	var usrlist, usrMap; //用户列表 , 用户键(account)值(obj)对
	var goldIncome = 0, goldOutlay = 0; //金币收收, 金币支出
	var myGoldNum = 0;
	var taskPageIsEdit = false;
	
	var popoupobj; //弹框对象
	
	function getDateStr(date){
		if(!date) date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var day = date.getDate();
		var hour = date.getHours();
		var min = date.getMinutes();
		var sec = date.getSeconds();
		if(month <= 9) month = "0" + month + "";
		if(day <= 9) day = "0" + day + "";
		if(hour <= 9) hour = "0" + hour + "";
		if(min <= 9) min = "0" + min + "";
		if(sec <= 9) sec = "0" + sec + "";
		return year + "-" + month + "-" + day + " " + hour  + ":" + min + ":" + sec;
		
	}
	
	function showmask(text, isload){
		if (!text) text = "Loading content" || "";
		if(isload == false){
			$.query("#afui_mask").find("span").remove();	
		}else{
			$.query("#afui_mask").find("span").remove();
			$.query("#afui_mask").append("<span class='ui-icon ui-icon-loading spin'></span>");
		}
        $.query("#afui_mask>h1").html(text);
        $.query("#afui_mask").show();   
	}
	
	function showFullLoad(msg){
		$("#afui").popup({"message" : msg || "请稍后<br>","onShow":function(){
			var self = this;
			popoupobj = self;
			var $el = $.query("#" + this.id);
			$el.find("header").remove();
			$el.find("footer").remove();
			$el.find("div").append('<img src="common/images/android/ajax-loader.gif"/>');
		} });
	}
	
	function hideFullLoad(){
		if(popoupobj){
			popoupobj.hide();
			//popoupobj = null;
		}
	}
	
	

	
</script>

</head>

<body>
	<div id="afui">
		<div id="splashscreen" class='ui-loader heavy'>
                <br>
                <br>    <span class='ui-icon ui-icon-loading spin'></span>
                <h1>努力加载中, 请稍后....</h1>
        </div>
		
		<header id="homeHeader">
			<a class="button" style="float:left" onclick="changeAccount()">账号切换</a>
			<h1>金钱游戏</h1>
			    
        </header>
		<header id="gainGoldHeader">
			
			<a id="backButton" onclick='$.ui.goBack();' class='button'>返回</a>
			<a href="#taskPage"  class="button icon add" style="float:right">发布任务</a>
		</header>
		<footer id="gainGoldFooter">
			<a href="#goldTaskPage" id="navbar_alltask" class="icon info" data-transition="slide">所有任务</a>
			<a href="#bidGoldTaskPage" class="icon info" data-transition="slide">可投标任务</a>
			<a href="#usrGoldTaskPage" id="navbar_usrtask" class="icon info" data-transition="slide">我的任务</a>
		</footer>
		<footer id="payGoldFooter">
			<a href="#goldTranRecPage" id="navbar_goldTranRec" class="icon info" data-transition="slide">交易记录</a>
			<a href="#payGoldPage" id="navbar_paygold" class="icon info" data-transition="slide">支付金币</a>
		</footer>
	
		
		
		<div id="content">
			<div  id="main" class="panel" selected="true" data-footer="none" data-header="homeHeader">
				
				<div id='main_info'>
					<span style="color: #C70505;font-weight: bold;" id="labLoginedName"></span>&nbsp;
					<img src="common/images/android/gold.png" /><span style="color: #C70505;font-weight: bold;" id="myGoldNum"></span>&nbsp;
					排名: 第<span style="color: #C70505;font-weight: bold;" id="myGoldOrder"></span>位
					<br><br>
					金币排行榜前10名:&nbsp;<span id="top10Gold"></span>
					<marquee scrolldelay="10" scrollamount="2" behavior="alternate"  direction="right"></marquee>
				</div><br />
				<marquee scrolldelay="10" scrollamount="2" behavior="alternate">
					<span>胡军支付了2元金币给习席</span>&nbsp;&nbsp;
					<span>胡军投标(task title)</span>&nbsp;&nbsp;
					<span>李丽上线</span>&nbsp;&nbsp;
					<span>李丽结束投标(task title)</span>&nbsp;&nbsp;
					
				</marquee>
				
					
				
				<ul class="list" >
					<li><a href="#goldTaskPage" >赚取金币</a></li>
					<li><a href="#goldTranRecPage" >金币交易</a></li>
					<li><a href="#usrGoldTaskPage" >我的任务</a></li>
					<li><a href="#goldOpenPage" >财产公开</a></li>
					<li><a href="#testpage" >组织架构</a></li>
					<li><a href="#workhomepage" >工作</a></li>
					<li><a href="testxx.ftl" target="_blank" >测试页面</a></li>
				</ul>
				
			</div>
			
			<div id="testpage" class="panel" title="组织架构图" data-footer="none"  data-load="loadPanel">
				<!--ea_view_picture_role_user_v.do?roleId=1&img=yes&width=50&height=80-->
				
				<iframe id="testIF" align='middle' frameborder='0' marginwidth='0' marginheight='50' width='100%' height="100%" scrolling='yes'  
          		style='margin-top:0px;' ></iframe>
				
			</div>
			<div id="workhomepage" class="panel" title="workhomepage" data-footer="none"  data-load="loadPanel">
				<!--ea_view_picture_role_user_v.do?roleId=1&img=yes&width=50&height=80-->
				
				<iframe id="workhomeIF" src="ea_ea_menu_workhomepage.do" align='middle' frameborder='0' marginwidth='0' marginheight='50' width='100%' height="100%" scrolling='yes'  
          		style='margin-top:0px;' ></iframe>
				
			</div>
						
			<!--所有任务页面 start--->
			<div id="goldTaskPage" title="所有任务" class="panel" data-load="loadPanel" data-header="gainGoldHeader" data-footer="gainGoldFooter" data-tab="navbar_alltask">
				
					
				<div id="allTaskList">
				</div>
			</div>
			<!--所有任务页面 end--->
			
			<!--可投标任务页面 start--->
			<div id="bidGoldTaskPage" title="可投标任务" class="panel" data-load="loadPanel" data-header="gainGoldHeader" data-footer="gainGoldFooter">	
				
				<div id="bidTaskList">
				</div>
			</div>
			<!--可投标任务页面 end--->
			
			<!--我的任务页面 start--->
			<div id="usrGoldTaskPage" title="我的任务" class="panel" data-load="loadPanel" data-header="gainGoldHeader" data-footer="gainGoldFooter" data-tab="navbar_usrtask">	
			
				<div id="usrTaskList">
				</div>
			</div>
			<!--我的任务页面 end--->
			
			
			
			<!--发布任务页面 start--->
			<div id="taskPage" title="任务页面" class="panel" data-footer="none" data-load="loadPanel">
				<form action="ea_goldtask_release_goldtask.do" method="post" id="releaseTaskForm">
				<br />
				<label for="taskName">任务名称: </label><input name="goldtask.title" maxlength="10" id="taskName" type="text" placeholder="请输入任务名称, 长度小于等于10">
				<label for="taskRemarks">任务说明:</label><textarea name="goldtask.detail"  id="taskRemarks" rows="6" placeholder="请输入任务说明"></textarea>
				<label for="endDate">截止日期: </label><input name="goldtask.endDate" readonly="readonly" id="endDate" class="Wdate" type="text" onClick="WdatePicker()">
				<label for="gold">悬赏金币:</label><input name="goldtask.goldNumber" id="gold" type="text" placeholder="请输入悬赏金币数">
				
				<div id="taskTmpDiv" >
					
				</div>
				
				</form>
				<script>
					
					$("#endDate").val(getDateStr().substring(0, 11));
				</script>
			</div>
			<!--发布任务页面 end--->
			
			<!--支出金币页面 start--->
			<div id="payGoldPage" title="金币交易" class="panel" data-footer="payGoldFooter" data-tab="navbar_paygold">
				<form action="" method="post">
				<br />
				<label for="payGoldNum">支出金币数: </label><input id="payGoldNum" type="text" placeholder="请输入金币数量">
				<label for="tousrlist">收金人:</label>
				<select id="tousrlist"></select>

				<label for="payRemarks">说明: </label><input id="payRemarks" type="text" placeholder="请输入说明" />
				<input type="button" class="button blue" value="提交" style='float:right;' onclick="payGold()">
				</form>
			</div>
			<!--支出金币页面 end--->
			
			<!--金币交易记录页面 start--->
			<div id="goldTranRecPage" title="金币交易" class="panel" data-footer="payGoldFooter" data-tab="navbar_goldTranRec">
				<p style="" align="center">收入: <span id="goldIncome" style="font-weight: bold; color: #C12E2A;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</span> 支出: <span id="goldOutlay" style="font-weight: bold; color: #C12E2A;"></span> 
				</p>
				<ul id="goldTranList" class="list"></ul>
				
			</div>
			<!--金币交易记录页面 end--->
			
			<!--财产公开页面 start--->
			<div id="goldOpenPage" title="财产公开" class="panel" data-load="loadPanel">
				<ul class="list" style="font-weight: bold;">
					<li style="padding: 10px 20px 10px 10px;">
					<div class="grid">
						<div class="col4">支付人</div>
						<div class="col4">收金人</div>
						<div class="col4">金币数量</div>
						<div class="col4">交易日期</div>
					</div>
					</li>
				</ul>
				<ul class="list" id="allGoldTranList">
					<li style="padding: 10px 20px 10px 10px;">
					<div class="grid">
						<div class="col3">胡军</div>
						<div class="col3">习席</div>
						<div class="col3">1</div>
					</div>
					</li>
				</ul>
			</div>
			<!--财产公开页面 end--->
				
				
				
				
		</div>
			
	</div>
	<style>
		
	</style>

<script>
	
	
</script>
	

	
<script>
	
	function loadPanel(what){
		$("#gainGoldHeader").find("h1").remove();
		if(what && what.id == "goldTaskPage"){
			$("#gainGoldHeader").append("<h1>所有任务</h1>");	
		}else if(what && what.id == "bidGoldTaskPage"){
			$("#gainGoldHeader").append("<h1>可投标任务</h1>");
		}else if(what && what.id == "usrGoldTaskPage"){
			$("#gainGoldHeader").append("<h1>我的任务</h1>");
		}else if (what && what.id == "testpage") {
			$("#testIF").attr("src", "ea_view_picture_role_user_v.do?roleId=1&img=yes&width=50&height=80");
		}else if (what && what.id == "workhomepage") {
			console.log($("#workhomeIF").attr("src"));
			$("#workhomeIF").attr("src", $("#workhomeIF").attr("src"));
		}else if (what && what.id == "taskPage") {
			if(taskPageIsEdit == true){
				taskPageIsEdit = false;
			}else{
				$("#taskTmpDiv").html("");
				$("#taskTmpDiv").html('<input type="button" class="button blue" value="发布" style="float:right;" onclick="releaseTask()">');
			}
		}else if(what && what.id == "goldTranRecPage"){
			
		}else if(what && what.id == "goldOpenPage"){
			console.log("财产公开.....");
			sendRequest("ea_goldtask_allgoldrecords.do", function(jsonstr){
				$("#allGoldTranList").html("");
				
				var jsonobj = $.parseJSON(jsonstr);
				
				for (var i = 0; i < jsonobj.length; i++) {
					
					$("#allGoldTranList").append('<li style="padding: 10px 20px 10px 10px;"><div class="grid"><div class="col4">'+usrMap[jsonobj[i].fromUsrAccount].name+
					'</div><div class="col4">'+usrMap[jsonobj[i].toUsrAccount].name+'</div><div class="col4">'+jsonobj[i].goldNumber+
					'</div><div class="col4">'+jsonobj[i].payDate.substring(0,11)+'</div></div></li>');
					
				}
				
			});
		}
		
			
	}
	
	
	
	function initdata(){
		allMaxSize = 10, allCurrPage = 1; allMaxPage = 0;
		usrMaxSize = 10, usrCurrPage = 1; usrMaxPage = 0;
		bidMaxSize = 10, bidCurrPage = 1; bidMaxPage = 0;
	}
	$.ui.ready(function(){
		$("#allTaskList").html("");
		$("#usrTaskList").html("");
		$("#bidTaskList").html("");
		allGoldTask = null;
		usrGoldTask = null;
		bidGoldTask = null;
		goldIncome = 0, goldOutlay = 0;
		myGoldNum = 0;
		
		
//		var tmpGoldnum = '<#if Session?exists && Session["userlogined"]?exists>${Session["userlogined"].goldnumber?if_exists}</#if>';
//		if(tmpGoldnum != "" && tmpGoldnum.length >= 1){
//			myGoldNum = Number(tmpGoldnum);
//		}
//		$("#myGoldNum").text(myGoldNum);
		
		initdata();
		console.log("ready....");
		refUsrList();
		
		setTimeout(readyData, 200); //后续需要用到usrmap, 延缓2毫秒用于usrmap获取到所有的值 
		
		
		
	});
	
	//请求所有用户列表
	function refUsrList(){
		sendRequest("ea_goldtask_menu_usr.do", function(jsonstr){
			$("#tousrlist").html("");
			$("#top10Gold").html("");
			var jsonobj = $.parseJSON(jsonstr);
			usrlist = jsonobj;
			usrMap = {};
			for(var i = 0; i < jsonobj.length; i++){
				jsonobj[i].goldOrder = Number(i + 1);
				if(!jsonobj[i].goldnumber) jsonobj[i].goldnumber = 0;
				var tmpaccount = jsonobj[i].account;
				usrMap[tmpaccount] = jsonobj[i];
				if(tmpaccount != loginedUsrAccount){
					$("#tousrlist").append('<option value="'+jsonobj[i].account+'">'+jsonobj[i].name+'</option>');	
				}else{
					$("#myGoldNum").text(jsonobj[i].goldnumber);
					$("#myGoldOrder").text(Number(i+1));	
				}
				if(i <= 9){
					$("#top10Gold").append(jsonobj[i].name + " " + jsonobj[i].goldnumber + "  ");
				}
			}
		});
	}
	
	function readyData(){
		if(usrMap[loginedUsrAccount]){
			$("#labLoginedName").text(usrMap[loginedUsrAccount].name);
			
		}
		
		
		sendRequest("ea_goldtask_menu_allgoldtask.do?&pageId=" + allCurrPage + "&maxSize=" + allMaxSize, function(jsonstr){readData("0", jsonstr);});
		sendRequest("ea_goldtask_menu_usrgoldtask.do?&pageId=" + usrCurrPage + "&maxSize=" + usrMaxSize, function(jsonstr){readData("1", jsonstr);});
		sendRequest("ea_goldtask_menu_bidgoldtask.do?&pageId=" + bidCurrPage + "&maxSize=" + bidMaxSize, function(jsonstr){readData("2", jsonstr);});
		
		sendRequest("ea_goldtask_goldrecords.do", function(jsonstr){
			$("#goldTranList").html("");
			
			var jsonobj = $.parseJSON(jsonstr);
			
			for (var i = 0; i < jsonobj.length; i++) {
				appendGoldTran(jsonobj[i]);
			}
			$("#goldIncome").text(goldIncome);
			$("#goldOutlay").text(goldOutlay);
			
		});
		
		$.ui.backButtonText = "返回";
		//var tmpscroller =  $("#allTaskList").scroller();
		//tmpscroller.addInfinite();
		bindscroller($("#goldTaskPage"), 0);
		bindscroller($("#usrGoldTaskPage"), 1);
		bindscroller($("#bidGoldTaskPage"), 2);
	}
	
	function appendGoldTran(data, isFirst){
		var tmpaccount, tmpicon;
		if(data.fromUsrAccount == loginedUsrAccount){
			tmpaccount = data.toUsrAccount; 
			tmpicon = '-';
			goldOutlay += Number(data.goldNumber);
		}else if(data.toUsrAccount == loginedUsrAccount){
			tmpaccount = data.fromUsrAccount;
			tmpicon = '+';
			goldIncome += Number(data.goldNumber);
		}
		var tmpremarks = data.payRemarks.length > 12 ? data.payRemarks.substring(0,12) + "..." : data.payRemarks;
		var tmpHtml = '<li style="padding: 10px 20px 10px 10px;"><font style="font-weight: bold;">'+tmpaccount+'</font>&nbsp;&nbsp;&nbsp;<font style="font-size: 10px; color: #696969;">'+tmpremarks+'</font><span style="float: right; color: #F00308;"> <img src="common/images/android/gold.png" /> &nbsp;'+tmpicon + data.goldNumber+'</span><br><font style="color: #919191; font-size: 10px;padding-left: 20px;">'+data.payDate.substring(0,11)+'</font></li>';
		
		if (isFirst == true) {
			$("#goldTranList").prepend(tmpHtml);
		}else{
			$("#goldTranList").append(tmpHtml);	
		}
		
		
		
	}
	//绑定刷新下下拉加载数据
	function bindscroller(elobj, type){
		var myScroller = elobj.scroller();
		myScroller.addInfinite();
		myScroller.addPullToRefresh();
		myScroller.refreshHangTimeout=700;
		myScroller.refreshContent="加载中...";

		$.bind(myScroller, "refresh-release", function () {
			myScroller.setRefreshContent("加载中...");
			console.log("refresh-release.==> type=" + type);
			refData(type, myScroller);
		});
	
		$.bind(myScroller, "infinite-scroll", function () {
			console.log("infinite-scroll.....");
			$.bind(myScroller, "infinite-scroll-end", function () {
				console.log("infinite-scroll-end.....");
				$.unbind(myScroller, "infinite-scroll-end");
				var action, curpage, maxsize, maxpage;
				if(type == "0") {
					action = "ea_goldtask_menu_allgoldtask.do";
					curpage = allCurrPage;
					maxsize = allMaxSize;
					maxpage = allMaxPage;
				}
				else if(type == "1") {
					action = "ea_goldtask_menu_usrgoldtask.do";
					curpage = usrCurrPage;
					maxsize = usrMaxSize;
					maxpage = usrMaxPage;
				}
				else if(type == "2") {
					action = "ea_goldtask_menu_bidgoldtask.do";
					curpage = bidCurrPage;
					maxsize = bidMaxSize;
					maxpage = bidMaxPage;
				}
				
				if(curpage > maxpage){
					showmask("没有数据了....", false);
					setTimeout(function(){$.ui.hideMask();myScroller.clearInfinite();}, 2000);
					return;
				}
				var url = action + "?pageId=" + curpage + "&maxSize=" + maxsize;
				sendRequest(url, function(jsonstr){
					readData(type, jsonstr);
					myScroller.clearInfinite();
				});
			});
		});
	}
	
	function refData(type, scrollerObj){
		initdata();
		var action;
		if(type == "0") {
			action = "ea_goldtask_menu_allgoldtask.do";
			$("#allTaskList").html("");
		}
		else if(type == "1") {
			action = "ea_goldtask_menu_usrgoldtask.do";
			$("#usrTaskList").html("");
		}
		else if(type == "2") {
			action = "ea_goldtask_menu_bidgoldtask.do";
			$("#bidTaskList").html("");
		}
		var url = action + "?pageId=1&maxSize=10";
		sendRequest(url, function(jsonstr){
			readData(type, jsonstr);
			showmask("刷新成功....", false);
			
			if(scrollerObj){
				setTimeout(function(){$.ui.hideMask();scrollerObj.clearInfinite();}, 1000);
			}else{
				setTimeout(function(){$.ui.hideMask();}, 1000);
			}
			
		});
	}
	
	//数据请求
	function sendRequest(url, callback){
		console.log("sendRequest===> " + url);
		$.ajax({
				type: "post",
				url: url,
				timeout: 2000,
				async: false,
				success: function(data){
					console.log("sendrequest success....");
					if(callback) callback(data);
					
				},
				error: function(xhr, txt){
					hideFullLoad();
					showmask("请求出错....", false);
					setTimeout(function(){$.ui.hideMask();}, 1000);
					console.log("error===> status: " + xhr.status);
					console.log("error===> txt: " + txt);
					
				},
				complete: function(xhr, txt){
					console.log("complete.....");
					if(xhr.status != 200){
						
					}
					
				}
			});
	}	
	
	
	function readData(type, jsonstr){
		
		var jsonobj = $.parseJSON(jsonstr);
		var elObj;
		if(type == "0"){ //all
			elObj = $("#allTaskList");
			allGoldTask = jsonobj;
			allMaxSize = allGoldTask[0].maxSize;
			allCurrPage = ++allGoldTask[0].currentPage;
			allMaxPage = allGoldTask[0].maxPage;
		}else if(type == "1"){
			elObj = $("#usrTaskList");
			usrGoldTask = jsonobj;
			usrMaxSize = usrGoldTask[0].maxSize;
			usrCurrPage = ++usrGoldTask[0].currentPage;
			usrMaxPage = usrGoldTask[0].maxPage;
		}else if(type == "2"){
			elObj = $("#bidTaskList");
			bidGoldTask = jsonobj;
			bidMaxSize = bidGoldTask[0].maxSize;
			bidCurrPage = ++bidGoldTask[0].currentPage;
			bidMaxPage = bidGoldTask[0].maxPage;
		}
		for(var i = 1; i < jsonobj.length; i++){
			appendTaskItem(type, jsonobj[i], elObj);
		}
		
	}
	
	//添加任务(所有任务, 我的任务, 可投标任务)
	function appendTaskItem(type, data, elobj, isFirst){
		var usrAccountArray = data.usrAccountArray;
		var curUsr = "",otherUsr = "";
		var index = elobj.find("div").length + 1;
		if(usrAccountArray){
			var array = usrAccountArray.split(",");
			for(var j = 0; j < array.length; j++){
				if(loginedUsrAccount == array[j]){
					curUsr = loginedUsrAccount;
				}else {
					if(otherUsr != "") otherUsr += "," + array[j];
					else  otherUsr += usrMap[array[j]].name;
				}
			}	
		}
		var canbid = "";
		
		
		var btnhtml = "<button class='button blue' onclick=bidTask("+type+","+data.id+","+index+") id='"+type+"_binbtn_"+index+"' >投我</button>";
		if(((curUsr == loginedUsrAccount || loginedUsrAccount == data.usrAccount) && loginedUsrAccount != "") || data.bidUsrAccount != ""){
			btnhtml = "";
		}
		if((!data.bidUsrAccount || data.bidUsrAccount.trim() == "") && data.usrAccount == loginedUsrAccount){
			btnhtml += "<a class='button blue' onclick=editTask("+type+","+data.id+","+index+") href='#taskPage' >编辑</a>"
		}
		var tmpbidusr = usrMap[data.bidUsrAccount] ? usrMap[data.bidUsrAccount].name : "";
		var tmpcurusr =  usrMap[curUsr] ? usrMap[curUsr].name : "";
		var tmpbid = "";
		
	
		var childDiv = $('<div  style="background-color:#FFFFFF; position: relative; top: 10px; padding: 10px 20px 20px 20px; border-radius: 15px;border:2px ridge;" >'+
				'<span ><font style="font-size: 10px;">'+data.createDate.substring(0,11) +'</font>&nbsp;'+ data.title+'&nbsp; <font color="green" style="font-size: 10px;">'+canbid+'</font><br/><span style="font-size: 10px;color: #999999;"> 悬赏人: '+usrMap[data.usrAccount].name+'&nbsp;<img src="common/images/android/gold.png"/>&nbsp;<font color="#C70505">'+data.goldNumber+'</font>&nbsp;</span></span>'+
				'<div class="grid" style="font-size: 10px;color: #999999;">'+
				'	<div class="tmpcol2_1"><span style="float: right;">任务说明:&nbsp;&nbsp;</span></div>'+
				'	<div class="tmpcol2_2">'+data.detail+'&nbsp;</div>'+
				'	<div class="tmpcol2_1"><span style="float: right;">悬赏截止日期:&nbsp;&nbsp;</span></div>'+
				'	<div class="tmpcol2_2">'+data.endDate+'&nbsp;</div>'+
				'	<div class="tmpcol2_1"><span style="float: right;">已投标成员:&nbsp;&nbsp;</span></div>'+
				'	<div class="tmpcol2_2">'+otherUsr+'&nbsp;<font color="#C70505">'+tmpcurusr+'</font></div>'+
				'	<div class="tmpcol2_1"><span style="float: right;">中标成员:&nbsp;&nbsp;</span></div>'+
				'	<div class="tmpcol2_2">'+tmpbidusr+'&nbsp;</div>'+
				'	<div style="width: 100%;">'+btnhtml+'&nbsp;</div>'+
	            '</div>'+
				'</div><br />');
		if(isFirst == true){
			elobj.prepend(childDiv);
		}else {
			elobj.append(childDiv);
		}
	}
	
	
	//操作task (增,删,改, 投标)
	function oprationTask(url){
		showFullLoad("");
		setTimeout(function(){
			sendRequest(url,function(resstr){
				hideFullLoad();
				if(resstr && resstr.trim() == "0000"){
					showmask("操作成功", false);
					refData(0);
					refData(1);
					refData(2);
					$.ui.goBack();
				}else{
					showmask("操作失败: " + resstr, false);
				}
				setTimeout(function(){$.ui.hideMask();},700);
			});
		},1000);
	}
	
	//编辑task 打开task页面
	function editTask(type, taskId, index){
		taskPageIsEdit = true;
		console.log("编辑任务: type: " + type + " taskId: " + taskId + " index: " + index);
		var obj;
		if(type == 0) obj = allGoldTask;
		else if(type == 1) obj = usrGoldTask;
		if(!obj) {
			console.log("出错  obj is null");
			return;
		}
		var flag = false;
		for(var i = 0; i < obj.length; i++){
			if(obj[i].id == taskId){
				obj = obj[i];
				flag = true;
				break;
			}
		}
		if(!flag){
			console.log("找不到id为: " + taskId);
			return;
		}
		
		$("#taskName").val(obj.title);
		$("#taskRemarks").val(obj.detail);
		$("#endDate").val(obj.endDate);
		$("#gold").val(obj.goldNumber);
		$("#taskTmpDiv").html("");
		
		//如果已经有人投过标, 就显示结束投标按钮
		if(obj.usrAccountArray && obj.usrAccountArray.length >= 1){
			var usrAccountArray = obj.usrAccountArray;
			var array = usrAccountArray.split(",");
			var tmphtml = '<label>中标人员</label>';
			for(var j = 0; j < array.length; j++){
				var tmpaccount = array[j];
				tmphtml +='<input id="aa_'+j+'" type="radio" name="finishAccount" value="'+tmpaccount+'"><label for="aa_'+j+'">'+usrMap[tmpaccount].name+'</label>';
			}
			
			tmphtml += "<br />&nbsp;<br />&nbsp;";
			$("#taskTmpDiv").append( tmphtml);
				
			var bidbtn = $('<a class="button blue" style="float: right;">结束投票</a>');
			bidbtn.bind("click", function(){
				var tmpaccount = $('input[name=finishAccount]:checked').val();
				if(!tmpaccount || tmpaccount.trim() == ""){
					popuMsg("操作失败: 没有选择中标人员");
					return;
				}
				oprationTask("ea_goldtask_finish_bid.do?bidUsrAccount="+tmpaccount+"&taskId=" + taskId);
			});
			$("#taskTmpDiv").append(bidbtn);
			return;	
		}
		
		
		var upateBtn = $('<a class="button blue" style="float: right;">修改</a>');
		var deleteBtn = $('<a class="button blue" style="float: right;">删除</a>');
		upateBtn.bind("click", function(){
			var formobj = validtionTask();
			if(!formobj)return;
			oprationTask("ea_goldtask_update.do?goldtask.createDate="+obj.createDate+"&goldtask.id="+taskId+"&goldtask.title="+formobj.title+"&goldtask.detail="+formobj.detail+"&goldtask.endDate="+formobj.endDate+"&goldtask.goldNumber="+formobj.goldNumber+"&goldtask.usrAccount="+formobj.usrAccount);
		});
		deleteBtn.bind("click", function(){
			console.log("delete....");
			oprationTask("ea_goldtask_delete.do?goldtask.id="+taskId);
		
		});
		
		$("#taskTmpDiv").append(deleteBtn);
		$("#taskTmpDiv").append(upateBtn);
	}
	
	//验证任务表单
	function validtionTask(){
		var taskName = $("#taskName").val();
		var taskRemarks = $("#taskRemarks").val();
		var endDate = $("#endDate").val();
		var goldNumber = $("#gold").val();
		if(!taskName || taskName.trim() == ""){
			popuMsg("任务名称不能为空!");
			return;
		}
		
		if(!endDate || endDate == ""){
			popuMsg("截止日期不能为空!");
			return;
		}
		var reg = /^\d{4}-[0-9]{1,2}-\d{1,2}$/;
		if(!endDate.trim().match(reg)){
			popuMsg("请输入合法的日期(yyyy-mm-dd)");
			return;
		}
		if(!goldNumber || goldNumber.trim() == ""){
			popuMsg("悬赏金币不能为空!");
			return;
		}
		if(isNaN(goldNumber)){
			popuMsg("悬赏金币必需为数字");
			return;
		}
		var obj = {title: taskName, detail: taskRemarks, endDate: endDate, goldNumber: goldNumber, usrAccount : loginedUsrAccount};
		return obj;
	}
	
	
	
	
	
	//投标
	function bidTask(type,taskId, index){
		//doFinishBidTask("ea_goldtask_bid.do?taskId=" + taskId);
		oprationTask("ea_goldtask_bid.do?taskId=" + taskId);
	}
	
	function popuMsg(msg){
		$("#afui").popup({message: msg, cancelText: "确定", cancelOnly: true, title: "提示消息"});
	}
	
	//发布任务
	function releaseTask(){	
		var formobj = validtionTask();
		if(!formobj) return;
		oprationTask("ea_goldtask_release.do?goldtask.createDate="+obj.createDate+"&goldtask.title="+formobj.title+"&goldtask.detail="+formobj.detail+"&goldtask.endDate="+formobj.endDate+"&goldtask.goldNumber="+formobj.goldNumber+"&goldtask.usrAccount="+formobj.usrAccount);
		
	}
	
	//支付
	function payGold(){

		var payGoldNum = $("#payGoldNum").val();
		var tousrlist = $("#tousrlist").val();
		var payRemarks = $("#payRemarks").val();
		if(!payGoldNum || payGoldNum.trim() == ""){
			popuMsg("金币数不能为空!");
			return;
		}
		if(isNaN(payGoldNum)){
			popuMsg("金币必需为数字");
			return;
		}
		showFullLoad("");
		setTimeout(function(){
			sendRequest("ea_goldtask_pay.do?goldtran.goldNumber="+payGoldNum+"&goldtran.toUsrAccount="+tousrlist+"&goldtran.payRemarks="+payRemarks,
			function(resstr){
				hideFullLoad();
				if(resstr && resstr.trim() == "0000"){
					showmask("操作成功",false);
					refUsrList();
					var data={goldNumber: payGoldNum, toUsrAccount: tousrlist, payRemarks: payRemarks, payDate: getDateStr(), fromUsrAccount: loginedUsrAccount};
					appendGoldTran(data, true);
//					myGoldNum -= Number(payGoldNum);
					$("#goldIncome").text(goldIncome);
					$("#goldOutlay").text(goldOutlay);
//					$("#myGoldNum").text(myGoldNum);
					$.ui.goBack();
				}else{
					showmask("操作失败: " + resstr ,false);
				}
				setTimeout(function(){$.ui.hideMask();},700);
			});
		}, 1000);
		
		
		
	}

	
	//切换账号
	function changeAccount(){
		document.cookie.length = 0;
		window.location="app_login.ftl?changeaccount";
	}
</script>
</body>
</html>
