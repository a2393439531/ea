
<!DOCTYPE html>
<html>
<head>
	<title>Gold Task </title>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/icons.css" />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/main.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/default.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/lists.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/forms.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/buttons.css"  />
	
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/css/grid.css"  />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/plugins/css/af.actionsheet.css"  />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/plugins/css/af.popup.css"  />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/plugins/css/af.scroller.css"  />
    <link rel="stylesheet" type="text/css" href="common/appframework-2-1/plugins/css/af.selectBox.css"  />
	<link rel="stylesheet" type="text/css" href="common/appframework-2-1/plugins/css/af.accordion.css"  />
	
	
	<style>
		body{
			font-size: 12px;
		}
		.tmpcol2_1{
			width: 30%;
    		float: left;
		}
		.tmpcol2_2{
			width:69%;
    		float: left;
		}
		
	
		
		#afui .col4{
			width: 25%;
    		float: left;
		}
	
		
		#afui .button {
			border:1px solid #D3DADE;
			border-radius:0px;
			color: #646464;
			
		}
		
		#afui .header h1 {
			font-size: 14px;
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
	<script type="text/javascript" charset="utf-8" src="common/appframework-2-1/plugins/af.accordion.js"></script>
	
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/appframework.ui.js"></script>
	<script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/transitions/flip.js"></script>
	<script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/transitions/fade.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/transitions/flip.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/transitions/pop.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/transitions/slide.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/transitions/slideDown.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/appframework-2-1/ui/transitions/slideUp.js"></script>
	
	<script language="javascript" type="text/javascript" src="common/My97DatePicker/WdatePicker.js"></script>
	
	
	
	
	<script>
	
		
		
		if (!((window.DocumentTouch && document instanceof DocumentTouch) || 'ontouchstart' in window)) {
			var script = document.createElement("script");
			script.src = "common/appframework-2-1/plugins/af.desktopBrowsers.js";
            var tag = $("head").append(script);
        }
		

		
	</script>
	
<script>
	function phonegapReady(){
		alert('phonegapReady.......');
	}
	
</script>
	
	
	
<script>	
	
	
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
			<h1></h1>
        </header>
		<header id="gainGoldHeader">
			<a id="backButton" onclick='$.ui.goBack();' class='button'>返回</a>
			<h1></h1>
			<a href="#taskPage"  class="button icon add" style="float:right">发布任务</a>
		</header>
		<footer id="gainGoldFooter">
			<a href="#goldTaskPage" id="navbar_alltask" class="icon info" data-transition="slide">所有任务</a>
			<a href="#bidGoldTaskPage" class="icon info" data-transition="slide">可投标任务</a>
			<a href="#usrGoldTaskPage" id="navbar_usrtask" class="icon info" data-transition="slide">我的任务</a>
		</footer>
		<footer id="payGoldFooter">
			<a href="#payGoldPage"  id="navbar_paygold" class="icon info" data-transition="slide">支付金币</a>
			<a href="#goldTranRecPage" id="navbar_goldTranRec" class="icon info" data-transition="slide">交易记录</a>
		</footer>
		
		<footer id="mainFooter">
			<a href="#main" id="navbar_main" class="icon info" data-transition="slide">首页</a>
			<a href="#contactPage" id="" class="icon info" data-transition="slide">通讯录</a>
			<a href="#usrInfoPage" id="" class="icon info" data-transition="slide">个人信息</a>
			
		</footer>
	
		
		
		<div id="content">
			<div  id="main" class="panel" data-load="loadPanel" selected="true" data-footer="mainFooter" data-header="homeHeader" data-tab="navbar_main">
				<div >
					
					<span style="color: #C70505;font-weight: bold;" id="labLoginedName"></span>&nbsp;
					<img src="common/images/android/gold.png" />
					<span style="color: #C70505;font-weight: bold;" id="myGoldNum"></span>&nbsp;
					<#if Session["userlogined"]?exists && Session["userlogined"].getParentModel()?exists&&Session["userlogined"].getParentModel().account=='admin'>
					<#else>
					      排名: 第<span style="color: #C70505;font-weight: bold;" id="myGoldOrder"></span>位
					</#if>
				</div>
				<marquee scrolldelay="10" scrollamount="1"  id="marquee" direction=up height="40px" style="float: right;color:#4B8005;">
				</marquee>
				<br/>&nbsp;<br/>&nbsp;
					
				
				<ul class="list" >
					<li><a href="#goldTaskPage" >赚取金币</a></li>
					<li><a href="#payGoldPage" >金币交易</a></li>
					<li><a href="#goldOrderPage" >排行榜</a></li>
					<li><a href="#testpage" >组织架构</a></li>
				
				</ul>
				
			</div>
			
			<div id="testpage" class="panel" title='组织架构图[<#if Session?exists && Session["userlogined"]?exists>${Session["userlogined"].name?if_exists}</#if>]' data-footer="none"  data-load="loadPanel">
				<!--ea_view_picture_role_user_v.do?roleId=1&img=yes&width=50&height=80-->
				
				<iframe id="testIF" align='middle' frameborder='0' marginwidth='0' marginheight='50' width='100%' height="100%" scrolling='yes'  
          		style='margin-top:0px;' ></iframe>
				
			</div>
			
			<!--所有任务页面 start--->
			<div id="goldTaskPage"  class="panel" data-load="loadPanel" data-header="gainGoldHeader" data-footer="gainGoldFooter" data-tab="navbar_alltask">
				<div id="contentList"></div>
			</div>
			<!--所有任务页面 end--->
			
			<!--可投标任务页面 start--->
			<div id="bidGoldTaskPage" class="panel" data-load="loadPanel" data-header="gainGoldHeader" data-footer="gainGoldFooter">	
				<div id="contentList"></div>
			</div>
			<!--可投标任务页面 end--->
			
			<!--我的任务页面 start--->
			<div id="usrGoldTaskPage"  class="panel" data-load="loadPanel" data-header="gainGoldHeader" data-footer="gainGoldFooter" data-tab="navbar_usrtask">	
				<div id="contentList"></div>
			</div>
			<!--我的任务页面 end--->
			
			
			
			<!--发布任务页面 start--->
			<div id="taskPage"  class="panel" data-footer="none" data-load="loadPanel">
				<form action="ea_goldtask_release_goldtask.do" method="post" id="releaseTaskForm">
				<br />
				<label for="taskName">任务名称: </label><input name="goldtask.title" maxlength="10" id="taskName" type="text" placeholder="请输入任务名称, 长度小于等于10">
				<label for="taskRemarks">任务说明:</label><textarea name="goldtask.detail"  id="taskRemarks" rows="6" placeholder="请输入任务说明"></textarea>
				<label for="endDate">截止日期: </label><input name="goldtask.endDate" readonly="readonly" id="endDate" class="Wdate" type="text" onClick="WdatePicker()">
				<label for="gold">悬赏金币:</label><input name="goldtask.goldNumber" id="gold" type="number" placeholder="请输入悬赏金币数">
				
				<div id="taskTmpDiv" >
					
				</div>
				
				</form>
				<script>
					$("#endDate").val(getDateStr().substring(0, 11));
				</script>
			</div>
			<!--发布任务页面 end--->
			
			<!--支出金币页面 start--->
			<div id="payGoldPage" data-load="loadPanel" class="panel" data-footer="payGoldFooter" data-tab="navbar_paygold">
				<div align="center">可用金币:  <span style="color: #C70505;font-weight: bold;" id="pay_goldnum"></span>&nbsp;</div>
				<form action="" method="post">
				<br />
				<label for="payGoldNum">支出金币数: </label><input id="payGoldNum" type="number" placeholder="请输入金币数量">
				<label for="tousrlist">收金人:</label>
				<select id="tousrlist"></select>

				<label for="payRemarks">说明: </label><input id="payRemarks" type="text" placeholder="请输入说明" onclick="payRemarksClick()" />
				
				
				
				
				<input type="button" class="button" value="提交" style='float:right;' onclick="payGold()">
				</form>
			</div>
			<!--支出金币页面 end--->
			
			<!--金币交易记录页面 start--->
			<div id="goldTranRecPage" class="panel" data-load="loadPanel" data-footer="payGoldFooter" data-tab="navbar_goldTranRec">
				<p style="" align="center">收入: <span id="goldIncome" style="font-weight: bold; color: #C12E2A;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</span> 支出: <span id="goldOutlay" style="font-weight: bold; color: #C12E2A;"></span> 
				</p>
				<ul id="goldTranList" class="list"></ul>
				
			</div>
			<!--金币交易记录页面 end--->
			
			<!--排行榜 start--->
			<div id="goldOrderPage"  class="panel" data-load="loadPanel" data-footer="none">
				
			</div>
			<!--排行榜 end--->
			
			<!--个人信息页面 start--->
			<div id="usrInfoPage" class="panel" data-load="loadPanel" data-footer="mainFooter">
				<label for="usrName">名称: </label><input id="usrName" type="text" >
				<label for="usrEmail">邮箱: </label><input id="usrEmail" type="email" >
				<label for="usrQQ">QQ: </label><input id="usrQQ" type="number" >
				<label for="usrPhoneNo">电话号码: </label><input id="usrPhoneNo" type="text" >
				<a class="button" style="float: right;" onclick="usrInfoClick($(this))">编辑个人资料</a>
				
			</div>
			<!--个人信息页面 end--->
			
			<!--通讯录页面 start--->
			<div id="contactPage"  class="panel" data-load="loadPanel" data-footer="mainFooter" data-load="loadPanel">
				<ul class="list">
				</ul>
			</div>
			<!--通讯录页面 end--->
				
		</div>
			
	</div>
	<style>
		
	</style>

<script>
	
	
</script>
	

	
<script>
	var loginedAccount = '<#if Session?exists && Session["userlogined"]?exists>${Session["userlogined"].account?if_exists}</#if>';
	var serverReqTimeout = 2000; //超时时间
	var currUsr; //当前用户
	var curPage1 = 1, pageSize1 = 0; //所有任务页面 当前页数， 总页数
	var curPage2 = 1, pageSize2 = 0; //可投标任务页面 当前页数， 总页数
	var curPage3 = 1, pageSize3 = 0; //我的任务页面 当前页数， 总页数
	var maxSize = 10;
	var taskPageIsEdit = false; //发布任务页面是否为编辑
	var usrMap; //所有用户
	var tmpTaskId; //任务ID （用于编辑）
	
	//处理请求， 会显示等待框.. 过800毫秒才发送请求
	function optRequest(url, callback){
		showFullLoad("");
		setTimeout(function(){
			sendRequest(url,function(resstr){
				hideFullLoad();
				if(callback){
					callback(resstr);
				}
				if(resstr && resstr.trim() == "0000"){
					showmask("操作成功", false);
				}else{
					showmask("操作失败: " + resstr, false);
				}
				
				setTimeout(function(){$.ui.hideMask();},700);
				
				if(resstr && resstr.trim() == "0000"){
					$.ui.goBack();
				}
				
			});
		}, 800);
	}
	
	//个人信息页面点击按， 
	function usrInfoClick(obj){
		var txt = obj.text();
		if(txt == "编辑个人资料"){
			$("#usrInfoPage").find("input").removeAttr("disabled", "true");
			obj.text("修改");
			return;
		}
		
		if(txt == "修改"){
			var url = "ea_goldtask_updateuser.do?user.name="+$("#usrName").val()+"&user.email="+$("#usrEmail").val()+"&user.qq="+$("#usrQQ").val()+"&user.phoneNumber="+$("#usrPhoneNo").val()+"&user.id="+currUsr.id;
			optRequest(url,null);
		}
		
		
	}
	
	function loadmarquee(){
		//加载滚动条
		$("#marquee").html("");
		var url = "ea_goldtask_menu_log.do";
		sendRequest(url, function(jsonstr){
			var msgList = JSON.parse(jsonstr).options;
			for(var i = 0; i < msgList.length; i++){
				$("#marquee").append('<span>'+msgList[i]+'</span><br/>');
			}
			
		});
		setTimeout(function(){loadmarquee();}, 10*1000); //１０秒刷新一次滚动条i
	}
	
	function loadPanel(what){
		
		if(what && (what.id != "main" && what.id != "contactPage") && !currUsr){
			return;
		}
		
		//首页， 通讯录  请求所有用户
		if(what && (what.id == "main" || what.id == "contactPage")){
			//首页加载
			var url = "ea_goldtask_menu_usr.do";
			sendRequest(url, function(jsonstr){
				if(!jsonstr || jsonstr.trim() == "") return;
				var jsonobj = JSON.parse(jsonstr);
				if(what.id == "contactPage"){
					$("#contactPage").find("ul").html("")
				}
				usrMap = {};
				for(var i = 0; i < jsonobj.length; i++){
					usrMap[jsonobj[i].account] = jsonobj[i];
					if(jsonobj[i].account == loginedAccount){
						currUsr = jsonobj[i];
						if(what.id == "main"){
							$("#homeHeader").find("h1").text("金钱游戏["+jsonobj[i].name+"]");
							$("#labLoginedName").text(jsonobj[i].name);
							$("#myGoldNum").text(jsonobj[i].goldNumber);
							$("#myGoldOrder").text(Number(i));
						}else{
							$("#header").find("h1").text("通讯录["+jsonobj[i].name+"]");
						}
					}
					//通讯录添加 元素
					if(what.id == "contactPage"){
						
						var childLi = '<li style="padding: 10px 20px 10px 10px;"><div class="grid">'+
							'<div class="col3">'+jsonobj[i].name+'</div>'+
							'<div class="col3">'+jsonobj[i].phoneNumber+'</div>'+
							'<div class="col3">'+
							'	<a href="tel: '+jsonobj[i].phoneNumber+'" class="icon phone" style="font-size: 12px;"></a>&nbsp;'+
							'	<a href="tel: '+jsonobj[i].phoneNumber+'" class="icon message" style="font-size: 12px;"></a>&nbsp;'+
							'</div></div><div style="color: #8693AC;">email: '+jsonobj[i].email+'</div></li>';
			
						$("#contactPage").find("ul").append(childLi);
						
					}
				}
			});
		}
		else if(what && what.id == "usrInfoPage"){
			
			$("#header").find("h1").text("个人信息["+currUsr.name+"]");
			$("#usrName").val(currUsr.name);
			$("#usrEmail").val(currUsr.email);
			$("#usrQQ").val(currUsr.qq);
			$("#usrPhoneNo").val(currUsr.phoneNumber);	
			
			$("#usrInfoPage").find("input").attr("disabled", "true");
			
			
			 
		}
		else if(what && what.id == "goldTaskPage"){
		//所有任务
			$("#gainGoldHeader").find("h1").text('所有任务['+currUsr.name+']');
			curPage1 = 1;
			pageTask(what.id, "ea_goldtask_menu_allgoldtask.do?&pageId=1&maxSize=" + maxSize, false);
			
		}
		else if (what && what.id == "taskPage") {
		///发布任务
			if(taskPageIsEdit == true){
				
				var url = "ea_goldtask_get_task.do?taskId=" + tmpTaskId;
				sendRequest(url, function(jsonstr){					
					if(!jsonstr) return;
					$("#taskTmpDiv").html("");
					var jsonobj = JSON.parse(jsonstr);
					jsonobj = jsonobj[0];
					
					$("#taskName").val(jsonobj.title);
					$("#taskRemarks").val(jsonobj.detail);
					$("#endDate").val(jsonobj.endDate);
					$("#gold").val(jsonobj.goldNumber);
					
					
					if(jsonobj.usrAccountArray && jsonobj.usrAccountArray.length >= 1){
						$("#releaseTaskForm").find("input").attr("disabled", "true");
					
						var array = jsonobj.usrAccountArray.split(",");
						var tmphtml = '<label>中标人员</label>';
						for(var j = 0; j < array.length; j++){
							var tmpaccount = array[j];
							tmphtml +='<input id="aa_'+j+'" type="radio" name="finishAccount" value="'+tmpaccount+'"><label for="aa_'+j+'">'+usrMap[tmpaccount].name+'</label>';
						}
						tmphtml += '<br style="clear:both">';
						$("#taskTmpDiv").append(tmphtml);
						var bidbtn = $('<a class="button" style="float: right;">结束投票</a>');
						bidbtn.bind("click", function(){
							var tmpaccount = $('input[name=finishAccount]:checked').val();
							if(!tmpaccount || tmpaccount.trim() == ""){
								popuMsg("操作失败: 没有选择中标人员");
								return;
							}
							optRequest("ea_goldtask_finish_bid.do?bidUsrAccount="+tmpaccount+"&taskId=" + tmpTaskId);
						});
						$("#taskTmpDiv").append(bidbtn);
						return;
					}
					var upateBtn = $('<a class="button" style="float: right;">修改</a>');
					var deleteBtn = $('<a class="button" style="float: right;">删除</a>');
					upateBtn.bind("click", function(){
						var formobj = validtionTask();
						if(!formobj)return;
						optRequest("ea_goldtask_update.do?goldtask.id="+tmpTaskId+"&goldtask.title="+formobj.title+"&goldtask.detail="+formobj.detail+"&goldtask.endDate="+formobj.endDate+"&goldtask.goldNumber="+formobj.goldNumber+"&goldtask.usrAccount="+formobj.usrAccount);
					});
					deleteBtn.bind("click", function(){
						optRequest("ea_goldtask_delete.do?goldtask.id="+tmpTaskId);
					
					});
					
					$("#taskTmpDiv").append(deleteBtn);
					$("#taskTmpDiv").append(upateBtn);
					
				});
				
			
				taskPageIsEdit = false;
				$("#header").find("h1").text("编辑任务["+currUsr.name+"]");
			}else{
				$("#releaseTaskForm").find("input").removeAttr("disabled");
				$("#taskTmpDiv").html("");
				$("#taskTmpDiv").html('<input type="button" class="button" value="发布" style="float:right;" onclick="releaseTask()">');
				$("#header").find("h1").text("发布任务["+currUsr.name+"]");
			}
			
		}
		else if(what && what.id == "bidGoldTaskPage"){
		//可投标任务
			$("#gainGoldHeader").find("h1").text('可投标任务['+currUsr.name+']');
			curPage2 = 1;
			pageTask(what.id, "ea_goldtask_menu_bidgoldtask.do?&pageId=1&maxSize=" + maxSize, false);
		}
		else if(what && what.id == "usrGoldTaskPage"){
		//我的任务
			$("#gainGoldHeader").find("h1").text('我的任务['+currUsr.name+']');
			curPage3 = 1;
			pageTask(what.id, "ea_goldtask_menu_usrgoldtask.do?&pageId=1&maxSize=" + maxSize, false);
			
		}else if(what && what.id == "goldTranRecPage"){
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
			
		}else if(what && what.id == "payGoldPage"){
			$("#header").find("h1").text("金币支出["+currUsr.name+"]");
			if(!usrMap){
				return;
			}
			$("#pay_goldnum").text(currUsr.goldNumber);
			
			$("#tousrlist").html("");
			for(var key in usrMap){
				if(key != currUsr.account){
					$("#tousrlist").append('<option value="'+key+'">'+usrMap[key].name+'</option>');
				}
			}
			
			
		}else if(what && what.id == "goldOrderPage"){
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
					
					cdiv3.append('<span class="col1-3" style="font-weight: bold;">支付人/金币</span>'+
							'<span class="col2-3" style="font-weight: bold;">说明</span>');
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
		
		else if (what && what.id == "testpage") {
			$("#testIF").attr("src", "ea_view_picture_role_user_v.do?roleId=1&img=yes&width=50&height=80");
		}else if (what && what.id == "workhomepage") {
			$("#workhomeIF").attr("src", $("#workhomeIF").attr("src"));
		}else if(what && what.id == "goldTranRecPage"){
			
		}else if(what && what.id == "goldOrderPage"){
			
		}
		
			
	}
	
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
		optRequest(url, null);
	
	}
	
	
	$.ui.ready(function(){
		$.ui.backButtonText = "返回";
		
		bindscroller($("#goldTaskPage"));
		bindscroller($("#bidGoldTaskPage"));
		bindscroller($("#usrGoldTaskPage"));
		
		setTimeout(function(){loadmarquee();}, 3*1000); //3秒后加载滚动条
		
	});
	
	
	//请求每页任务 LIST (页对象 ， URl)
	function pageTask(pageId, url, isAppend){
		var pageObj = $("#" + pageId);
		
		if(isAppend == false){
			pageObj.find("div[id=contentList]").html("");
		}
		sendRequest(url, function(jsonstr){
			if(!jsonstr || jsonstr == "") return;
			var jsonobj = JSON.parse(jsonstr);
			if(pageId == "goldTaskPage") pageSize1 =jsonobj[0].maxPage;
			else if(pageId == "bidGoldTaskPage") pageSize2 =jsonobj[0].maxPage;
			else if(pageId == "usrGoldTaskPage") pageSize3 =jsonobj[0].maxPage;
			for(var i = 1; i < jsonobj.length; i++){
				appendTaskItem(jsonobj[i], pageObj.find("div[id=contentList]"));
			}
		});
	}
	
	//绑定页面刷新， 加载事件
	function bindscroller(elobj){
		
		var myScroller = elobj.scroller();
		myScroller.addInfinite();
		myScroller.addPullToRefresh();
		myScroller.refreshHangTimeout=700;
		myScroller.refreshContent="加载中...";
		
		$.bind(myScroller, 'scrollend', function () {
			console.log("scroll end");
			myScroller.setRefreshContent("加载中...");
		});
		$.bind(myScroller, 'scrollstart', function () {
			console.log("scroll start");
			myScroller.setRefreshContent("加载中...");
		});
		$.bind(myScroller, 'refresh-trigger', function () {
			console.log("Refresh trigger");
			myScroller.setRefreshContent("加载中...");
		});
		
		
		
		//绑定下拉刷新事件 
		$.bind(myScroller, "refresh-release", function () {
			console.log("refresh-release.....");
			myScroller.setRefreshContent("加载中...");
			var url;
			if(elobj.attr("id") == "goldTaskPage"){
				url = "ea_goldtask_menu_allgoldtask.do?pageId=1&maxSize=" + maxSize;
				curPage1 = 1;
			}
			else if(elobj.attr("id") == "bidGoldTaskPage"){
				url = "ea_goldtask_menu_bidgoldtask.do?pageId=1&maxSize=" + maxSize;
				curPage2 = 1;
			}
			else if(elobj.attr("id") == "usrGoldTaskPage"){
				url = "ea_goldtask_menu_usrgoldtask.do?pageId=1&maxSize=" + maxSize;
				curPage3 = 1;
			}
			
			pageTask(elobj.attr("id"), url, false);
			
			
		});
		
		//绑定上拉加载事件
		$.bind(myScroller, "infinite-scroll", function () {
			console.log("infinite-scroll.....");
			$.bind(myScroller, "infinite-scroll-end", function () {
				$.unbind(myScroller, "infinite-scroll-end");
				var url;
				if(elobj.attr("id") == "goldTaskPage"){
					curPage1 += 1;
					console.log("curPage1: " + curPage1 + " pageSize1: " + pageSize1);
					if(isLastPage(curPage1, pageSize1, myScroller)) return;
					url = "ea_goldtask_menu_allgoldtask.do?pageId=" + curPage1 + "&maxSize="+maxSize;
					
				}
				else if(elobj.attr("id") == "bidGoldTaskPage"){
					curPage2 += 1;
					if(isLastPage(curPage2, pageSize2, myScroller)) return;
					url = "ea_goldtask_menu_bidgoldtask.do?pageId=" + curPage2 + "&maxSize="+maxSize;
					
				}
				else if(elobj.attr("id") == "usrGoldTaskPage"){
					curPage3 += 1;
					if(isLastPage(curPage3, pageSize3, myScroller)) return;
					url = "ea_goldtask_menu_usrgoldtask.do?pageId=" + curPage3 + "&maxSize="+maxSize;
					
				}
				
				pageTask(elobj.attr("id"), url, true);
				setTimeout(function (){myScroller.clearInfinite();}, serverReqTimeout);
				
			});
		});
	
	}
	
	function isLastPage(curPageIndex, pageSize, scrollerobj){
		if(curPageIndex > pageSize){
			showmask("没有数据了....", false);
			setTimeout(function(){$.ui.hideMask();scrollerobj.clearInfinite();}, 2000);
			return true;
		}
		return false;
	}
	
	
	
	//数据请求
	function sendRequest(url, callback){
		
		$.ajax({
				type: "post",
				url: url,
				timeout: serverReqTimeout,
				async: false,
				success: function(data){
					if(callback) callback(data);
				},
				error: function(xhr, txt){
					hideFullLoad();
					showmask("请求出错....", false);
					setTimeout(function(){$.ui.hideMask();}, 1000);
					console.log("error--> url=" + url + " status=" + xhr.status);
					
				}
				
			});
	}	
	
	
	
	
	//添加任务(所有任务, 我的任务, 可投标任务)
	function appendTaskItem(data, elobj, isFirst){
		//var usrAccountArray = data.usrAccountArray;
		
		
		var btnhtml = '';
		
		if(data.usrAccountArray.indexOf(currUsr.account) < 0 && !data.bidUsrAccount && data.usrAccount != currUsr.account){
			btnhtml = "<a class='button' onclick=bidTask("+data.id+") style='border:1px solid #D3DADE;border-radius:0px;color: #646464;'>投我</a>"
		}else if((!data.bidUsrAccount || data.bidUsrAccount.trim() == "") && data.usrAccount == currUsr.account){
			btnhtml = "<a class='button' onclick=editTask("+data.id+") href='#taskPage' style='border:1px solid #D3DADE;border-radius:0px;color: #646464;'>编辑</a>"
		}
		
		
		var tmpbidusr = usrMap[data.bidUsrAccount] ? usrMap[data.bidUsrAccount].name : "";
		
		var tmpBidNames = "";
		var accountarray = data.usrAccountArray.split(",");
		for (var i=0; i < accountarray.length; i++){
			if(!accountarray[i] || accountarray[i] == "") continue;
			if(accountarray[i] == currUsr.account){
				tmpBidNames +="<span style='color: red;'>"+currUsr.name+"</span>&nbsp;&nbsp;";
			}else{
				tmpBidNames += usrMap[accountarray[i]].name + "&nbsp;&nbsp;";
			}
			
		}
		
		
		
		var childDiv = $('<div style="background-color:#FFFFFF;border-radius: 1px;border:1px solid #D3DADE;position: relative; top: 10px;">'+
						'	<div  style=" padding: 10px 20px 10px 20px; " ><img src="common/images/android/gold.png" />&nbsp;'+data.goldNumber+'&nbsp;&nbsp;&nbsp;'+
						data.createDate.substring(0,11) + '&nbsp;' + data.title + '&nbsp; <br />'+
						//'		<span style="font-size: 10px;color: #999999;">&nbsp;<br/>悬赏人: '+usrMap[data.usrAccount].name+' <img src="common/images/android/gold.png" />'+data.goldNumber+'</span><br />'+
						'		<div class="grid" style="font-size: 10px;color: #999999;">'+
						'			<div class="tmpcol2_1"><span style="float: right;">悬赏人:&nbsp;&nbsp;</span></div>'+
						'			<div class="tmpcol2_2">'+usrMap[data.usrAccount].name+'&nbsp;</div>'+
						'			<div class="tmpcol2_1"><span style="float: right;">任务说明:&nbsp;&nbsp;</span></div>'+
						'			<div class="tmpcol2_2">'+data.detail+'&nbsp;</div>'+
						'			<div class="tmpcol2_1"><span style="float: right;">悬赏截止日期:&nbsp;&nbsp;</span></div>'+
						'			<div class="tmpcol2_2">'+data.endDate+'&nbsp;</div>'+
						'			<div class="tmpcol2_1"><span style="float: right;">已投标成员:&nbsp;&nbsp;</span></div>'+
						'			<div class="tmpcol2_2">'+tmpBidNames+'&nbsp;</div>'+
						'			<div class="tmpcol2_1"><span style="float: right;">中标成员:&nbsp;&nbsp;</span></div>'+
						'			<div class="tmpcol2_2">'+tmpbidusr+'&nbsp;</div>'+
						'       </div> </div>'+
						'	<div class="button-grouped" style="width:100%;margin-left: 10px;">'+ btnhtml + '</div></div><br /> ');


		
		if(isFirst == true){
			elobj.prepend(childDiv);
		}else {
			elobj.append(childDiv);
		}
		
	}
	
	
	
	//编辑task 打开task页面
	function editTask(taskId){
		taskPageIsEdit = true;
		tmpTaskId = taskId;
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
		var obj = {title: taskName, detail: taskRemarks, endDate: endDate, goldNumber: goldNumber, usrAccount : currUsr.account};
		return obj;
	}
	
	
	
	
	
	//投标
	function bidTask(taskId){
		//oprationTask("ea_goldtask_bid.do?taskId=" + taskId);
		optRequest("ea_goldtask_bid.do?taskId=" + taskId, null);
		
	}
	
	function popuMsg(msg){
		$("#afui").popup({message: msg, cancelText: "确定", cancelOnly: true, title: "提示消息"});
	}
	
	//发布任务
	function releaseTask(){	
		
		var formobj = validtionTask();
		if(!formobj) return;
		//oprationTask("ea_goldtask_release.do?goldtask.title="+formobj.title+"&goldtask.detail="+formobj.detail+"&goldtask.endDate="+formobj.endDate+"&goldtask.goldNumber="+formobj.goldNumber+"&goldtask.usrAccount="+formobj.usrAccount);
		optRequest("ea_goldtask_release.do?goldtask.title="+formobj.title+"&goldtask.detail="+formobj.detail+"&goldtask.endDate="+formobj.endDate+"&goldtask.goldNumber="+formobj.goldNumber+"&goldtask.usrAccount="+formobj.usrAccount);
		
	}
	
	

	
	//切换账号
	function changeAccount(){
		document.cookie.length = 0;
		window.location="app_login.ftl?changeaccount";
	}
</script>
</body>
</html>
