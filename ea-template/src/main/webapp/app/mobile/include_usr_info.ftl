<!--所有任务页面-->
<div id="usrInfoPage" class="panel" data-load="loadUsrInfo" data-footer="mainFooter" >
	<label for="usrName">名称: </label><input id="usrName" type="text" >
	<label for="usrEmail">邮箱: </label><input id="usrEmail" type="email" >
	<label for="usrQQ">QQ: </label><input id="usrQQ" type="number" >
	<label for="usrPhoneNo">电话号码: </label><input id="usrPhoneNo" type="text" >
	<a class="button" style="float: right;" onclick="usrInfoClick($(this))">编辑个人资料</a>
</div>
<script>
	 function loadUsrInfo(what){
	 	if(!currUsr) return;
    	$("#header").find("h1").text("个人信息["+currUsr.name+"]");
		$("#usrName").val(currUsr.name);
		$("#usrEmail").val(currUsr.email);
		$("#usrQQ").val(currUsr.qq);
		$("#usrPhoneNo").val(currUsr.phoneNumber);
		$("#usrInfoPage").find("input").attr("disabled", "true");
    }
    
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
</script>