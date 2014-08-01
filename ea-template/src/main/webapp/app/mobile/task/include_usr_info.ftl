<!--所有任务页面-->
<style type="text/css">
input, button, select, textarea{
	outline: none;
}
textarea{
	resize: none;
}
#afui .panel{
	background-color: #fff;
}
#afui input[type="text"], #afui input[type="email"] {
	width: 80%;
	height: auto;
	border: none;
	border-radius: 0px;
}
.infoGroup {
	margin: 0px auto; 
	width: 80%;
	padding-top: 20px;
}
.usrName{
	height: 40px;
	background:url(common/images/User_blue.png) no-repeat;
	border: 1px solid #00BDFF;
}
.usrEmail{
	height: 40px;
	background:url(common/images/Mail.png) no-repeat;
	border: 1px solid #00BDFF;
}
.usrQQ{
	height: 40px;
	background:url(common/images/Users.png) no-repeat;
	border: 1px solid #00BDFF;
}
.usrPhoneNo{
	height: 40px;
	background:url(common/images/Phone.png) no-repeat;
	border: 1px solid #00BDFF;
}
#afui .infoGroup a {
	height: 40px;
	background-color: #00BDFF;
	border: none;
	border-radius: 3px;
	font-size: 14px;
	color: #fff;
	line-height: 24px;
}
</style>
<div id="usrInfoPage" class="panel" data-load="loadUsrInfo" data-footer="mainFooter">
<!--
	<label for="usrName">名称: </label><input id="usrName" type="text" >
	<label for="usrEmail">邮箱: </label><input id="usrEmail" type="email" >
	<label for="usrQQ">QQ: </label><input id="usrQQ" type="text" >
	<label for="usrPhoneNo">电话: </label><input id="usrPhoneNo" type="text" >
-->
	<div class="infoGroup">
		<div class="usrName">
			<input style="margin-left: 30px;" id="usrName" type="text" placeholder="名称：" autocomplete="off"  />
		</div>
		<br/>	                    
		<div class="usrEmail">
			<input  id="usrEmail" type="email" placeholder="邮箱：" autocomplete="off" style="margin-left: 30px;"/>                
		</div>
		<br/>
		<div class="usrQQ">
			<input  id="usrQQ" type="text" placeholder="QQ：" autocomplete="off" style="margin-left: 30px;"/>                
		</div>
		<br/>
		<div class="usrPhoneNo">
			<input  id="usrPhoneNo" type="text" placeholder="电话：" autocomplete="off" style="margin-left: 30px;"/>                
		</div>
		<br/>
		<a class="button block" onclick="usrInfoClick($(this))">确定</a>
	</div>
</div>
<script>
	 function loadUsrInfo(what){
	 	if(!currUsr) return;
    	//$("#header").find("h1").text("个人信息["+currUsr.name+"]");
    	$("#header").find("h1").text("个人信息");
		$("#usrName").val(currUsr.name);
		$("#usrEmail").val(currUsr.email);
		$("#usrQQ").val(currUsr.qq);
		$("#usrPhoneNo").val(currUsr.phoneNumber);
		//$("#usrInfoPage").find("input").attr("disabled", "true");
    }
    
    function usrInfoClick(obj){
    	var url = "ea_goldtask_updateuser.do?user.account="+currUsr.account+"&user.name="+$("#usrName").val()+"&user.email="+$("#usrEmail").val()+"&user.qq="+$("#usrQQ").val()+"&user.phoneNumber="+$("#usrPhoneNo").val()+"&user.id="+currUsr.id;
		optRequest(url,null);
		/*
    	var txt = obj.text();
		if(txt == "编辑个人资料"){
			$("#usrInfoPage").find("input").removeAttr("disabled", "true");
			obj.text("修改");
			return;
		}
		
		if(txt == "修改"){
			
		}*/
    }
</script>