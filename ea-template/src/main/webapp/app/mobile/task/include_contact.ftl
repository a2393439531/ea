<!--通讯录页面-->
<style type="text/css">
.icon:before {
	line-height: 0;
	color: #00BDFF;
	left: 10px;
}
.grid {
	padding-left: 14px;
}
</style>
<div id="contactPage" class="panel" data-load="loadContact" data-footer="mainFooter" >
	<ul class="list"></ul>
</div>

<script>
	//加载通讯录页面
	function loadContact(){
		reloadUsrList(function(){
			if(!currUsr) return;
			$("#contactPage").find("ul").html("");
			//$("#header").find("h1").text("通讯录["+currUsr.name+"]");
			$("#header").find("h1").text("通讯录");
			for(var key in usrMap){
				var cli = $('<li style="padding: 10px 20px 10px 10px;"><div class="grid"></div></li>');
				var cgrid = $('<div class="grid"></div>');
				//cgrid.append('<div class="col3">'+usrMap[key].name+'</div>');
				//cgrid.append('<div class="col3" style="padding-left: 10px;">'+usrMap[key].phoneNumber+'</div>');
				//cgrid.append('<div class="col3"><a href="tel: '+usrMap[key].phoneNumber+'" class="icon phone" style="font-size: 12px;"></a><a href="sms: '+usrMap[key].phoneNumber+'" class="icon message" style="font-size: 12px; padding-left: 10px;"></a>&nbsp;</div>');
				
				cgrid.append('<div style="font-weight: bold; padding-bottom: 10px;">'+usrMap[key].name+'</div>');
				cgrid.append('<div style="color: #8693AC;"><span style="display: block; width: 180px; float: left;">Phone: '+usrMap[key].phoneNumber+'</span><a href="tel: '+usrMap[key].phoneNumber+'" class="icon phone" style="text-decoration: none;"></a><a href="sms: '+usrMap[key].phoneNumber+'" class="icon message" style="padding-left: 30px; text-decoration: none;"></a></div>');
				cgrid.append('<div style="color: #8693AC;">Email: '+usrMap[key].email+'</div>');
				
				//var cdemail = $('<div style="color: #8693AC;">Email: '+usrMap[key].email+'</div>');
				cli.append(cgrid);
				//cli.append(cdemail);
				$("#contactPage").find("ul").append(cli);
			}
		});
	}
</script>