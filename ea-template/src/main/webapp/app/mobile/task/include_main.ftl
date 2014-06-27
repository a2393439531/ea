<footer id="mainFooter">
	<a href="#main" id="navbar_main" class="icon info" data-transition="slide">首页</a>
	<a href="#contactPage" id="" class="icon info" data-transition="slide">通讯录</a>
	<a href="#usrInfoPage" id="" class="icon info" data-transition="slide">个人信息</a>
</footer>
<header id="mainHeader">
	<a class="button" style="float:left" onclick="changeAccount()">账号切换</a>
	<h1></h1>
</header>

<div  id="main" class="panel" data-load="loadMain" selected="true" data-footer="mainFooter" data-header="mainHeader" data-tab="navbar_main">
	<div>
		<span style="color: #C70505;font-weight: bold;" id="labLoginedName"></span>&nbsp;<img src="common/images/android/gold.png" />
		<span style="color: #C70505;font-weight: bold;" id="myGoldNum"></span>&nbsp;
		<#if Session["userlogined"]?exists && Session["userlogined"].getParentModel()?exists&&Session["userlogined"].getParentModel().account=='admin'>
		<#else>
			排名: 第<span style="color: #C70505;font-weight: bold;" id="myGoldOrder"></span>位
		</#if>
	</div>
	<marquee scrolldelay="10" scrollamount="1"  id="marquee" direction=up height="40px" style="float: right;color:#4B8005;"></marquee>
	<br/>&nbsp;<br/>&nbsp;
				
	<ul class="list" >
		<li><a href="#allTaskPage" >赚取金币</a></li>
		<li><a href="#payGoldPage" >金币交易</a></li>
		<li><a href="#goldOrderPage" >排行榜</a></li>
		<li><a href="#workReviewPage" >表现排行榜</a></li>
		<!--
		<li><a href="#testpage" >组织架构</a></li>
		-->
	</ul>
</div>

<script>
	//切换账号
	function changeAccount(){
		document.cookie.length = 0;
		window.location="m_task_login.ftl?changeaccount";
	}
	
	//加载主页面, 
	function loadMain(what){
		
		reloadUsrList(function(){
			if(!currUsr) return;
			$("#mainHeader").find("h1").text("金钱游戏["+currUsr.name+"]");
			$("#labLoginedName").text(currUsr.name);
			$("#myGoldNum").text(currUsr.goldNumber);
			$("#myGoldOrder").text(currUsr.order);
		});
	}
	
	function loadmarquee(){
		//加载滚动条
		if($.ui.activeDiv.getAttribute("id") == "main"){
			$("#marquee").html("");
			var url = "ea_goldtask_menu_log.do";
			sendRequest(url, function(jsonstr){
				var msgList = JSON.parse(jsonstr).options;
				for(var i = 0; i < msgList.length; i++){
					$("#marquee").append('<span>'+msgList[i]+'</span><br/>');
				}
			});
		}
		setTimeout(function(){loadmarquee();}, 10*1000); //１０秒刷新一次滚动条i
	}
</script>