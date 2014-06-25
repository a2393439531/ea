<!--通讯录页面-->
<div id="contactPage" class="panel" data-load="loadContact" data-footer="mainFooter" >
	<ul class="list"></ul>
</div>

<script>
	//加载通讯录页面
	function loadContact(){
		reloadUsrList(function(){
			if(!currUsr) return;
			$("#contactPage").find("ul").html("");
			$("#header").find("h1").text("通讯录["+currUsr.name+"]");
			for(var key in usrMap){
				var cli = $('<li style="padding: 10px 20px 10px 10px;"><div class="grid"></div></li>');
				var cgrid = $('<div class="grid"></div>');
				cgrid.append('<div class="col3">'+usrMap[key].name+'</div>');
				cgrid.append('<div class="col3">'+usrMap[key].phoneNumber+'</div>');
				cgrid.append('<div class="col3"><a href="tel: '+usrMap[key].phoneNumber+'" class="icon phone" style="font-size: 12px;"></a>&nbsp;<a href="tel: '+usrMap[key].phoneNumber+'" class="icon message" style="font-size: 12px;"></a>&nbsp;</div>');
				var cdemail = $('<div style="color: #8693AC;">email: '+usrMap[key].email+'</div>');
				cli.append(cgrid);
				cli.append(cdemail);
				$("#contactPage").find("ul").append(cli);
			}
		});
	}
</script>