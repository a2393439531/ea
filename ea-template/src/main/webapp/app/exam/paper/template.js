function additem(type,templateid) {
	var tagid = "";
	$("#div_select_item").html("Loading...");
	$("input:checkbox[name=knowledgevalue]:checked").each(function(i) {
		if (0 == i) {
			tagid = $(this).val();
		} else {
			tagid += ("," + $(this).val());
		}
	});
	if (tagid == "") {
		alert("请选择一个知识领域");
		return false;
	}
	$("#operation_title").text("添加题目");
	$('#div_scoll').attr("style","margin-left:150px;margin-top:-350px; cursor:hander;position:absolute;width:400px;z-index:10000;display:block;");
	$.ajax({
		type : "POST",
		url : "exam_item_listbycondition.do",
		data : "knowledgesid=" + tagid + "&type=" + type + "&templateid=" + templateid,
		cache : false,
		success : function(html) {
			document.getElementById('div_select_item').innerHTML = html;
		}
	});
}

function action_item_admin(templateid, itemid, itemtype){
	var divid="";
	switch(itemtype){
	case 1:
		divid="reqsinglechoice";
		break;
	case 2:
		divid="reqmultichoice";
		break;
	case 3:
		divid="reqblank";
		break;
	case 4:
		divid="reqessay";
		break;
	}
	$.ajax({
		type : "POST",
		url : "exam_template_addreqitem.do",
		data : "templateid=" + templateid + "&type=" + itemtype + "&itemid=" + itemid,
		cache : false,
		success : function(html) {
			document.getElementById(divid).innerHTML =  html;
		}
	});
}

function ajax_show_item(url, data){
	$("#operation_title").text("查看题目");
	$('#div_scoll').attr("style","margin-left:150px;margin-top:-350px; cursor:hander;position:absolute;width:700px;z-index:10000;display:block;");
	$("#div_select_item").html("Loading...");
	$.ajax({
		type : "POST",
		url : "exam_item_load.do",
		data : data,
		cache : false,
		success : function(html) {
			document.getElementById("div_select_item").innerHTML =  html;
		}
	});
}
