<style type="text/css">
#afui .list li {
	padding: 10px 20px 20px 14px;
	border-bottom: 1px solid #efefef;
}
#afui .list > li > a {
	margin: 0px;
	text-decoration: none;
	padding: 14px 0 0 50px;
	font-size: 15px;
	}
#afui .list > li > a:after {
	padding-top: 7px;
	font-size: 15px;
}
.icon.info:before {
	content: "";
}
#afui footer>a:not(.button) {
	font-size: 15px;
	font-weight: bold;
	line-height: 45px;
}
</style>
<footer id="mainFooter">
	<a href="#main" id="navbar_main" class="icon info" data-transition="slide">首页</a>
	<a href="#contactPage" id="" class="icon info" data-transition="slide">通讯录</a>
	<a href="#usrInfoPage" id="" class="icon info" data-transition="slide">个人信息</a>
</footer>
<header id="mainHeader">
	<a class="button" style="float:left; box-shadow: none;" onclick="changeAccount()">账号切换</a>
	<h1></h1>
	<div style="float:right;" >
		<!-- <span class="button" style="box-shadow: none;" id="labLoginedName"></span>&nbsp; -->
		<img class="button" style="box-shadow: none; margin-right: 0; padding-right: 0;" src="common/images/android/coins.png" />
		<span class="button" style="box-shadow: none; margin-left: 0;" id="myGoldNum"></span>
		<#if Session["userlogined"]?exists && (Session["userlogined"].account=='admin' || (Session["userlogined"].getParentModel()?exists&&Session["userlogined"].getParentModel().account=='admin'))>
		<#else>
			排名: 第<span style="color: #C70505;font-weight: bold;" id="myGoldOrder"></span>位&nbsp;
			<br/><img src="common/images/android/praise.png" />
			<span style="color: #C70505;font-weight: bold;" id="myPraiseNum"></span>&nbsp;
			<img src="common/images/android/feces.png" />
			<span style="color: #C70505;font-weight: bold;" id="myFecesNum"></span>&nbsp;
		</#if>
	</div>
</header>

<div id="main" class="panel" data-load="loadMain" selected="true" data-footer="mainFooter" data-header="mainHeader" data-tab="navbar_main">
	<ul class="list" >
		<li><img src="common/images/android/Home_Reward.png" style="float:left;" /><a href="#allTaskPage" >悬赏任务</a></li>
		<li><img src="common/images/android/Home_Deal.png" style="float:left;" /><a href="#payGoldPage" >金币交易</a></li>
		<li><img src="common/images/android/Home_Ranking.png" style="float:left;" /><a href="#goldOrderPage" >金币排行榜</a></li>
		
		<!--
		<li><a href="#testpage" >组织架构</a></li>
		-->
	</ul>
	
	<marquee scrolldelay="10" scrollamount="1"  id="marquee" direction=up height="80px" style="float: right;color:#4B8005;"></marquee>
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
			$("#mainHeader").find("h1").text("金钱游戏");
			$("#labLoginedName").text(currUsr.name);
			$("#myGoldNum").text(currUsr.goldNumber);
			$("#myGoldOrder").text(currUsr.order);
			$("#myPraiseNum").text(currUsr.praiseNumber);
			$("#myFecesNum").text(currUsr.fecesNumber);
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