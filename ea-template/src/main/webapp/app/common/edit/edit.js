function load_content(file) {
	$("#content").attr("disabled","");
	$("#submitButton").attr("disabled",null);
	$("#reloadButton").attr("disabled",null);
	$("#file_name").val(file);
	//$('#div_scoll').attr("style","margin-left:250px;margin-top:-250px; cursor:hander;position:absolute;width:400px;z-index:10000;display:block;");
	$.ajax({
		type : "POST",
		url : "common_edit_file_load.do",
		data : "file=" + file,
		cache : false,
		success : function(html) {
			document.getElementById('div_content').innerHTML = "<textarea name='file_content' style='width:800px;height:200px;'>" + html + "</textarea>";
		}
	});
}

function action_paper_admin(papergroupid, paperid){
	var divid="paperid";
	$.ajax({
		type : "POST",
		url : "exam_papergroup_addreqpaper.do",
		data : "papergroupid=" + papergroupid + "&paperid=" + paperid,
		cache : false,
		success : function(html) {
			document.getElementById(divid).innerHTML =  html;
		}
	});
}

function ajax_show_paper(url, data){
	$("#operation_title").text("View Paper");
	$('#div_scoll').attr("style","margin-left:250px;margin-top:-250px; cursor:hander;position:absolute;width:900px;z-index:10000;display:block;");
	$("#div_select_item").html("Loading...");
	$.ajax({
		type : "POST",
		url : "exam_paper_load.do",
		data : data,
		cache : false,
		success : function(html) {
			document.getElementById("div_select_item").innerHTML =  html;
		}
	});
}
