function addpaper(papergroupid) {
	$("#operation_title").text("Add Paper");
	$('#div_scoll').attr("style","margin-left:250px;margin-top:-250px; cursor:hander;position:absolute;width:400px;z-index:10000;display:block;");
	$.ajax({
		type : "POST",
		url : "exam_papergroup_listpaper.do",
		data : "papergroupid=" + papergroupid,
		cache : false,
		success : function(html) {
			document.getElementById('div_select_item').innerHTML = html;
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
function action_paper(url,para){
	var divid="paperid";
	  $.ajax({
	         type:"POST",
	         url: "exam_papergroup_"+url,
	         data:"beanname=Paper&"+para,
	         cache: false,
	         success: function(html){
		        document.getElementById(divid).innerHTML =  html;
	         }
	           
	  });  
	}