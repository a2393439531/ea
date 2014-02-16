<!-- CSS -->
<style type="text/css">
	.select_users_top{
		height:33px;
	}
	.select_users_div{
		float:left;
		width:300px;
	}
	.select_users_div_center{
		float:left;
		width:100px;
		text-align:center;
	}
	.select_users_content{
		width: 300px; 
		height: 293px;
	}
	.select_users_content_border{
		border: 1px solid #7E7D68;
	}
	.radio_div{
		height: 33px;
	}
	ul.ztree{
		width: 290px; 
		height: 250px;
		overflow-y: scroll;
		overflow-x: auto;
	}

</style>

<!--  script  -->
<script type="text/javascript"> 

function open_select_users_dialog(textObj, valueObj, flag){
	window.returnTextObj = textObj;
	window.returnValueObj = valueObj;
	window.selectFlag = flag;
	var title = "用户多选";
	if(flag && flag == 1)
		title = "用户单选";
	$("#include_select_users_div").dialog("option", "title", title);
	$("#include_select_users_div").dialog("open");
}

function init_select_users(){ 
	window.returnTextObj; // 返回显示值时的赋值对象
	window.returnValueObj; // 返回真实值时的赋值对象
	window.selectFlag = 2; // 1：单选，2：多选，默认多选
	$('#include_select_users_div').dialog({
		autoOpen: false,
		modal: true,
		width: 750,
		height: 462,
		buttons: {
	        "确定": function(){
	        	var options = document.getElementById("users_selected").options;
	        	var optionValues = new Array();
	        	var optionTexts = new Array();
	        	for(var i = 0; i < options.length; i++){
	        		optionValues.push(options[i].value);
	        		optionTexts.push(options[i].text);
	        	}
				var s = optionValues.join(",");
				window.returnValueObj.value = s;
				
				if(optionTexts.length > 2)
					window.returnTextObj.value = optionTexts[0] + "," + optionTexts[1] + ",...";
				else
					window.returnTextObj.value = optionTexts.join(",");
					
				$(this).dialog("close");
				
				// 保存到常选用户数据库
				$.ajax({
					type: 'post',
					url: 'common_selectuser_save.do',
					data: 'selectedUserAccount=' + window.returnValueObj.value + '&selectedUserName=' + window.returnTextObj.value,
					async: false,
					cache: false,
					success: function(data){
					}
				});
	        },
	        "取消": function(){
	        	$(this).dialog("close");
	        }
      	},
    
      	open: function(){
      		document.getElementById("include_select_users_div").style.display = "block";
      		
      		$.ajax({
				type: 'post',
				url: 'common_selectuser_oftenselectlist.do',
				data: '',
				async: false,
				cache: false,
				dataType: 'json',
				success: function(data){
					window.usuallyNodes = data;
				}
			});
      	 
			$.ajax({
				type: 'post',
				url: 'common_selectuser_select_userlist_by_organize.do',
				data: '',
				async: false,
				cache: false,
				dataType: 'json',
				success: function(data){
					window.departmentNodes = data;
				}
			});
			$.fn.zTree.init($("#usuallyTree"), window.setting, window.usuallyNodes);
			$.fn.zTree.init($("#departmentTree"), window.setting, window.departmentNodes);
			
      	},
	    close: function() {
	    	//allFields.val("").removeClass( "ui-state-error" );
	    }
	});
	
	init_autocomplete();
	
	init_tree();
}; 

function init_autocomplete(){
	$("#auto_text").autocomplete({ 
		minLength: 1, 
		source: function(request, response) { 
			$.ajax({ 
				url: "common_selectuser_users_for_select.do", 
				data: request, 
				success: function(h) { 
					document.getElementById("all_users").style.display = "none";
					document.getElementById("search_users").style.display = "block";
					$("#users_for_select").html(h);
				} 
			}); 
		}
	}); 
}

function _clear(){
	$("#users_for_select").empty();
	$("#auto_text").val("");
	$("#auto_text").autocomplete("destroy");
	init_autocomplete();
	document.getElementById("auto_text").focus();
	
	document.getElementById("search_users").style.display = "none";
	document.getElementById("all_users").style.display = "block";
	document.getElementById("usually_tree_div").style.display = "block";
}

function add_to_selected(){
	var h = '';
	if(window.selectFlag == 1){// 单选
		if(document.getElementById("users_selected").options.length == 1){
			alert("已经选有用户了。");
			return;
		}
		if(document.getElementById("search_users").style.display == 'block'){
			var v = $("#users_for_select").val() || [];
			if(v.length > 1){
				alert("只能选择一个用户。");
				return;
			}
			$("#users_for_select option:selected").each(function(index, obj){
				if($("#users_selected option[value='" + obj.value + "']").length == 0){
					h += "<option value='" + obj.value + "'>" + obj.text + "</option>";
				}
			});
		}else{
			if(window.selectNodeIds.length > 1){
				alert("只能选择一个用户。");
				return;
			}
			for(var i = 0; i < window.selectNodeIds.length; i++){
				if($("#users_selected option[value='" + window.selectNodeIds[i] + "']").length == 0){
					h += "<option value='" + window.selectNodeIds[i] + "'>" + window.selectNodeNames[i] + "</option>";
				}
			}
		}
	}else{// 多选
	    if(document.getElementById("search_users").style.display == 'block'){
			$("#users_for_select option:selected").each(function(index, obj){
				if($("#users_selected option[value='" + obj.value + "']").length == 0){
					h += "<option value='" + obj.value + "'>" + obj.text + "</option>";
				}
			});
		}else{
			for(var i = 0; i < window.selectNodeIds.length; i++){
				if($("#users_selected option[value='" + window.selectNodeIds[i] + "']").length == 0){
					h += "<option value='" + window.selectNodeIds[i] + "'>" + window.selectNodeNames[i] + "</option>";
				}
			}
		}
	}

	$("#users_selected").append(h);
}

function remove_from_selected(){
	$("#users_selected option:selected").remove();
}


//<!-- 树状结构 -->

function init_tree(){
	window.setting = {
		data: {
			key: {
				title: "t"
			},
			simpleData: {
				enable: true
			}
		},
		callback: {
			onClick: on_click_node
		}
	};
	
	window.usuallyNodes;
	window.departmentNodes;
	window.projectNodes;
	
	window.selectNodeIds = new Array();
	window.selectNodeNames = new Array();
	
	Array.prototype.indexOf = function (val) {  
	    for (var i = 0; i < this.length; i++) {  
	        if (this[i] == val) {  
	            return i;  
	        }  
	    }  
	    return -1;  
	};  
	Array.prototype.removevalue = function (val) {  
	    var index = this.indexOf(val);  
	    if (index > -1) {  
	        this.splice(index, 1);  
	    }  
	};
}

function on_click_node(event, treeId, treeNode, clickFlag) {
	if(clickFlag == 1){
		window.selectNodeIds.length = 0;
		window.selectNodeNames.length = 0;
		window.selectNodeIds.push(treeNode.account);
		window.selectNodeNames.push(treeNode.name);
	}else if(clickFlag == 0){
		window.selectNodeIds.remove(treeNode.account);
		window.selectNodeNames.remove(treeNode.name);
	}else{
		window.selectNodeIds.push(treeNode.account);
		window.selectNodeNames.push(treeNode.name);
	}
}

function change_tree(obj){
	if(obj.id == 'usually_radio'){
		document.getElementById("usually_tree_div").style.display = "block";
		document.getElementById("department_tree_div").style.display = "none";
		document.getElementById("project_tree_div").style.display = "none";
	}else if(obj.id == 'department_radio'){
		document.getElementById("usually_tree_div").style.display = "none";
		document.getElementById("department_tree_div").style.display = "block";
		document.getElementById("project_tree_div").style.display = "none";
	}else{
		document.getElementById("usually_tree_div").style.display = "none";
		document.getElementById("department_tree_div").style.display = "none";
		document.getElementById("project_tree_div").style.display = "block";
	}
}

$(document).ready(function(){
	init_select_users();
});

function menu_active(obj){
	$(".disabled").removeClass("disabled");
	$(obj).addClass("disabled");
}
</script> 
<!--  html  -->
<div id="include_select_users_div" style="display:none;">
	<div class="select_users_div">
		<div class="select_users_top">按拼音搜索
			<input style="width:150px;" id="auto_text" type="text" class="search-query"/>
		
		
			 <a  href="#" onclick="javascript:_clear();" ><span class="label label-default">X</span>  </a>
			
		</div>
		
		<div id="all_users" class="select_users_content select_users_content_border">
			<div class="radio_div">
				<ul class="nav nav-pills">
				  <li id="usually_radio" class="disabled" onclick="change_tree(this);menu_active(this);"><a href="javascript:void(0);">常选</a></li>
				  <li id="department_radio" onclick="change_tree(this);menu_active(this);"><a href="javascript:void(0);">部门</a></li>
				  <#--<li id="project_radio" onclick="change_tree(this);menu_active(this);"><a href="javascript:void(0);">项目</a></li>-->
				</ul>
			</div>
			<div id="usually_tree_div" style="display:none;">
				<ul id="usuallyTree" class="ztree"></ul>
			</div>
			<div id="department_tree_div" >
				<ul id="departmentTree" class="ztree"></ul>
			</div>
			<div id="project_tree_div" style="display:none;">
				<ul id="projectTree" class="ztree"></ul>
			</div>
		</div>
		
		<div id="search_users" style="display:none;">
			<select class="select_users_content select_users_content_border" id="users_for_select" multiple="multiple" size="15">
			</select>
		</div>
	</div>
	<div class="select_users_div_center">
		<br>
		<br>
		<br>
		<br>
		<br>
		<button class="btn btn-info btn-xs " onclick="javascript:add_to_selected();">添加 ></button>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<button class="btn btn-info btn-xs " onclick="javascript:remove_from_selected();">< 删除</button>
	</div>
	<div class="select_users_div">
		<div class="select_users_top">
		已选：
		</div>
		<select class="select_users_content select_users_content_border" id="users_selected" multiple="multiple" size="15">
		</select>
	</div>

</div>