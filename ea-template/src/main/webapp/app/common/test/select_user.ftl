<#include "../../../common/freemarker/include_header.ftl">
<#include "../../../common/freemarker/include_select_users.ftl">


单选选择用户 <input type="hidden" id="assignee" name="assignee"/>
		<input type="text" class="input-small" id="assigneeText" 
		onclick="javascript:open_select_users_dialog(document.getElementById('assigneeText'),document.getElementById('assignee'),1);" />

<br>
多选择用户   <input type="hidden" id="assigneeM" name="assigneeM"/>
		<input type="text" class="input-small" id="assigneeMText" 
		onclick="javascript:open_select_users_dialog(document.getElementById('assigneeMText'),document.getElementById('assigneeM'),2);" />
	
<#--
工作流中的 选人狂，是动态多个的，所以采取IFRAME形式先求出，再修改父窗口
-->
	
  <SCRIPT type="text/javascript" >
	var zTree;
	var setting = {
		view: {
			dblClickExpand: false,
			showLine: true,
			selectedMulti: false
		},
		data: {
			simpleData: {
				enable:true,
				idKey: "id",
				pIdKey: "pId",
				rootPId: ""
			}
		}
	};

	var zNodes =[
		{id:1, pId:0, name:"[core] 基本功能 演示", open:true},
		{id:101, pId:1, name:"最简单的树 -标准 JSON 数据"},
		{id:102, pId:1, name:"最简单的树 - 简单 JSON 数据"},
		
		
		{id:2, pId:0, name:"[excheck] 复/单选框功能 演示", open:false},
		{id:201, pId:2, name:"Checkbox 勾选操作"},
		{id:206, pId:2, name:"Checkbox nocheck 演示"},

		{id:6, pId:0, name:"其他扩展功能 演示", open:false},
		{id:601, pId:6, name:"隐藏普通节点"},
		{id:603, pId:6, name:"配合 radio 的隐藏"}
	];

	$(document).ready(function(){
		var t = $("#tree");
		t = $.fn.zTree.init(t, setting, zNodes);
		var zTree = $.fn.zTree.getZTreeObj("tree");
		zTree.selectNode(zTree.getNodeByParam("id", 101));
	});
  </SCRIPT>		
	<ul id="tree" class="ztree" style="width:260px; overflow:auto;"></ul>