<#include "../include_header.ftl">
<script type="text/javascript" charset="utf-8" src="common/common.js"></script>
<script>
	var loginedAccount = '<#if Session?exists && Session["userlogined"]?exists>${Session["userlogined"].account?if_exists}</#if>';

/**
 * 获取日期string型 (yyyy-mm-dd hh:MM:ss)
 * @param {Object} date
 */
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
</script>
<div id="afui">
	<div id="splashscreen" class='ui-loader heavy'>
		<br><br>    <span class='ui-icon ui-icon-loading spin'></span>
		<h1>努力加载中, 请稍后....</h1>
	</div>
	
	<header id="taskHeader">
		<a id="backButton" onclick='$.ui.goBack();' class='button'>返回</a>
		<h1></h1>
		<a href="#taskPage"  class="button icon add" style="float:right">发布任务</a>
	</header>
	
	<footer id="taskFooter">
		<a href="#allTaskPage" id="navbar_alltask" class="icon info" data-transition="slide">所有任务</a>
		<a href="#bidTaskPage" class="icon info" data-transition="slide">可投标任务</a>
		<a href="#usrTaskPage" id="navbar_usrtask" class="icon info" data-transition="slide">我的任务</a>
	</footer>
	
	
	<div id="content">
		<#include "include_main.ftl">
		<#include "include_contact.ftl">
		<#include "include_usr_info.ftl">
		<#include "include_all_gold_task.ftl">
		<#include "include_task.ftl">
		<#include "include_bid_gold_task.ftl">
		<#include "include_usr_gold_task.ftl">
		<#include "include_pay_gold.ftl">
		<#include "include_pay_gold_records.ftl">
		<#include "include_gold_order.ftl">
		<#include "include_work_review.ftl">
	</div>
</div>
<script>
	$.ui.ready(function(){
		
		$.ui.backButtonText = "返回";
		
		bindscroller($("#allTaskPage"));
		bindscroller($("#bidTaskPage"));
		bindscroller($("#usrTaskPage"));
		
		setTimeout(function(){loadmarquee();}, 2*1000); //2秒后加载滚动条
		
	});
	
var popoupobj;  //弹框对象
var usrMap; //所有用户信息
var currUsr; //当前用户信息 
var serverReqTimeout = 4000; //请求超时　
var curPage1 = 1, pageSize1 = 0; //所有任务页面 当前页数， 总页数
var curPage2 = 1, pageSize2 = 0; //可投标任务页面 当前页数， 总页数
var curPage3 = 1, pageSize3 = 0; //我的任务页面 当前页数， 总页数
var maxSize = 1; //每页显示的行数
var taskPageIsEdit = false;


/**
 *绑定页面上拉加载　，　下拉刷新事件　 
 * @param {Object} elobj
 */

function bindscroller(elobj){
		
	var myScroller = elobj.scroller();
	myScroller.addInfinite();
	myScroller.addPullToRefresh();
	myScroller.refreshHangTimeout=700;
	myScroller.refreshContent="加载中...";
		
		
	//绑定下拉刷新事件 
	$.bind(myScroller, "refresh-release", function () {
		console.log("refresh-release.....");
		myScroller.setRefreshContent("加载中...");
		$.unbind(myScroller, "infinite-scroll-end");
		var url;
		if(elobj.attr("id") == "allTaskPage"){
			url = "ea_goldtask_menu_allgoldtask.do?pageId=1&maxSize=" + maxSize;
			curPage1 = 1;
		}
		else if(elobj.attr("id") == "bidTaskPage"){
			url = "ea_goldtask_menu_bidgoldtask.do?pageId=1&maxSize=" + maxSize;
			curPage2 = 1;
		}
		else if(elobj.attr("id") == "usrTaskPage"){
			url = "ea_goldtask_menu_usrgoldtask.do?pageId=1&maxSize=" + maxSize;
			curPage3 = 1;
		}
			
		pageTask(elobj.attr("id"), url, false);
		setTimeout(function (){myScroller.clearInfinite();}, serverReqTimeout);
			
	});
		
	//绑定上拉加载事件
	$.bind(myScroller, "infinite-scroll", function () {
		$.bind(myScroller, "infinite-scroll-end", function () {
			console.log("infinite-scroll-end.....");
			$.unbind(myScroller, "infinite-scroll-end");
			var url;
			if(elobj.attr("id") == "allTaskPage"){
				curPage1 += 1;
				if(isLastPage(curPage1, pageSize1, myScroller)) return;
				url = "ea_goldtask_menu_allgoldtask.do?pageId=" + curPage1 + "&maxSize="+maxSize;
				
			}
			else if(elobj.attr("id") == "bidTaskPage"){
				curPage2 += 1;
				if(isLastPage(curPage2, pageSize2, myScroller)) return;
				url = "ea_goldtask_menu_bidgoldtask.do?pageId=" + curPage2 + "&maxSize="+maxSize;
				
			}
			else if(elobj.attr("id") == "usrTaskPage"){
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

/**
 *重新加载所有用户信息, 主要用于主页面和通讯录 
 * @param {Object} callback
 */
function reloadUsrList(callback){
	var url = "ea_goldtask_menu_usr.do";
	sendRequest(url, function(jsonstr){
		
		if(!jsonstr || jsonstr.trim() == "") return;
		var jsonobj = JSON.parse(jsonstr);
		usrMap = {};
		for (var i = 0; i < jsonobj.length; i++) {
			jsonobj[i].order=i;
			usrMap[jsonobj[i].account] = jsonobj[i];
			if (jsonobj[i].account == loginedAccount) {
				currUsr = jsonobj[i];
				currUsr.order = Number(i);
			}
		}
		if(callback) callback();
	});
}

/**
 * 分页数据，　主要用于所有任务，　我的任务，　可投标任务
 * @param {string} pageId
 * @param {string} url
 * @param {boolean} isAppend
 */
function pageTask(pageId, url, isAppend){
	var pageObj = $("#" + pageId);
	if(isAppend == false){
		pageObj.find("div[id=contentList]").html("");
	}
	sendRequest(url, function(jsonstr){
		if(!jsonstr || jsonstr == "") return;
		var jsonobj = JSON.parse(jsonstr);
		if(pageId == "allTaskPage") pageSize1 =jsonobj[0].maxPage;
		else if(pageId == "bidTaskPage") pageSize2 =jsonobj[0].maxPage;
		else if(pageId == "usrTaskPage") pageSize3 =jsonobj[0].maxPage;
		for(var i = 1; i < jsonobj.length; i++){
			appendTaskItem(jsonobj[i], pageObj.find("div[id=contentList]"));
		}
	});
}

/**
 * 添加任务元素(所有任务, 我的任务, 可投标任务)
 * @param {json obj} data
 * @param {Object} elobj
 
 */
function appendTaskItem(data, elobj){
	var btn = $('');
	var bidCurName = $("<span style='color: red;'></span>");
	var bidOtherNames = $("<span ></span>");
	
	if(data.usrAccountArray.indexOf(currUsr.account) < 0 && !data.bidUsrAccount && data.usrAccount != currUsr.account){
		btn = $("<a class='button' style='border:1px solid #D3DADE;border-radius:0px;color: #646464;'>投我</a>");
		btn.bind("click", function(){
			optRequest("ea_goldtask_bid.do?taskId=" + data.id, function(){
				setTimeout(function(){btn.remove();bidCurName.text(currUsr.name + " ");},100);
			}, false);
		});
	}else if((!data.bidUsrAccount || data.bidUsrAccount.trim() == "") && data.usrAccount == currUsr.account){
		btn = $("<a class='button' href='#taskPage' style='border:1px solid #D3DADE;border-radius:0px;color: #646464;'>编辑</a>");
		btn.bind("click", function(){
			taskPageIsEdit = true;
			tmpTaskId = data.id;
		});
	}
	var tmpbidusr = usrMap[data.bidUsrAccount] ? usrMap[data.bidUsrAccount].name : "";
	var accountarray = data.usrAccountArray.split(",");
	
	for (var i=0; i < accountarray.length; i++){
		if(!accountarray[i] || accountarray[i] == "") continue;
		if(accountarray[i] == currUsr.account){
			bidCurName.text(currUsr.name + " ");
		}else{
			var tmptxt = bidOtherNames.text() ? bidOtherNames.text() : "";
			bidOtherNames.text(tmptxt + usrMap[accountarray[i]].name + " ");
		}
	}
	var childDiv = $('<div style="background-color:#FFFFFF;border-radius: 1px;border:1px solid #D3DADE;position: relative; top: 10px;"></div>');
	var c1 = $('<div  style=" padding: 10px 20px 10px 20px; " ></div>');
	c1.append('<img src="common/images/android/gold.png" />&nbsp;'+data.goldNumber+'&nbsp;&nbsp;&nbsp;' + data.createDate.substring(0,11) + '&nbsp;' + data.title + '&nbsp; <br />');
	var cgrid = $('<div class="grid" style="font-size: 10px;color: #999999;"></div>');
	cgrid.append('<div class="tmpcol2_1"><span style="float: right;">悬赏人:&nbsp;&nbsp;</span></div>');
	cgrid.append('<div class="tmpcol2_2">'+usrMap[data.usrAccount].name+'&nbsp;</div>');
	cgrid.append('<div class="tmpcol2_1"><span style="float: right;">任务说明:&nbsp;&nbsp;</span></div>');
	cgrid.append('<div class="tmpcol2_2">'+data.detail+'&nbsp;</div>');
	cgrid.append('<div class="tmpcol2_1"><span style="float: right;">悬赏截止日期:&nbsp;&nbsp;</span></div>');
	cgrid.append('<div class="tmpcol2_2">'+data.endDate+'&nbsp;</div>');
	cgrid.append('<div class="tmpcol2_1"><span style="float: right;">已投标成员:&nbsp;&nbsp;</span></div>');
	var cbid = $('<div class="tmpcol2_2">&nbsp;</div>');
	cbid.append(bidCurName);
	cbid.append(bidOtherNames);
	cgrid.append(cbid);
	cgrid.append('<div class="tmpcol2_1"><span style="float: right;">中标成员:&nbsp;&nbsp;</span></div>');
	cgrid.append('<div class="tmpcol2_2">'+tmpbidusr+'&nbsp;</div>');
	c1.append(cgrid);
	var cbtndiv = $('<div class="button-grouped" style="width:100%;margin-left: 10px;"></div>');
	cbtndiv.append(btn);
	c1.append(cbtndiv);
	childDiv.append(c1);
	elobj.append(childDiv);
	elobj.append("<br />&nbsp;");
}

/**
 * 操作请求，　在发送请求之前会先弹出等待框．
 * @param {string} url
 * @param {function Object} callback　请求成功的回调函数
 * @param {boolean} gb 是否要返回上一页面
 */
function optRequest(url, callback, gb){
	showFullLoad("");
	sendRequest(url,function(resstr){
		hideFullLoad();
		if(resstr && resstr.trim() == "0000"){
			showmask("操作成功", false);
		}else{
			showmask("操作失败: " + resstr, false);
		}
		setTimeout(function(){$.ui.hideMask();},700);
		if(resstr && resstr.trim() == "0000" && gb != false){
			$.ui.goBack();
		}
		if(callback){
			callback(resstr);
		}
	});
}

/**发送ajax请求
 * @param  {string} url 
 * @param  {function obj} callback 
 */
function sendRequest(url, callback){
	$.ajax({
		type: "post",
		url: url,
		timeout: serverReqTimeout,
		async: true,
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

/**
 * 显示普通等待框，　显示时页面还可以操作
 * @param {string} text 
 * @param {boolean} isload true：　显示加载框，　false: 只显示文字
 */
function showmask(text, isload){
	if (!text) text = "Loading content" || "";
	$.query("#afui_mask").find("span").remove();
	if(isload != false){
		$.query("#afui_mask").append("<span class='ui-icon ui-icon-loading spin'></span>");	
	}
	$.query("#afui_mask>h1").html(text);
    $.query("#afui_mask").show();   
}

/**
 * 显示等待框, 显示时，　页面不可以操作
 * @param {string} msg
 */
function showFullLoad(msg){
	$("#afui").popup({"message" : msg || "请稍后<br>","onShow":function(){
		var self = this;
		popoupobj = self;
		var $el = $.query("#" + this.id);
		$el.find("header").remove();
		$el.find("footer").remove();
		$el.find("div").append('<img src="common/images/android/ajax-loader.gif"/>');
	}});
}

/**
 * 隐藏等待框
 */
function hideFullLoad(){
	if(popoupobj) popoupobj.hide();
}

function popuMsg(msg){
	$("#afui").popup({"message" : msg, title: "提示消息", cancelOnly: true, cancelText: "确定"});
}

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

	

</script>
