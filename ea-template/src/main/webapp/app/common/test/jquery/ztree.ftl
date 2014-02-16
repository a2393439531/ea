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
		{id:1, pId:0, name:" 基本功能 演示", open:true},
		{id:101, pId:1, name:"最简单的树 -标准 JSON 数据"},
		{id:102, pId:1, name:"最简单的树 - 简单 JSON 数据"},
		
		
		{id:2, pId:0, name:"功能 演示", open:false},
		{id:201, pId:2, name:"Checkbox勾选操作"},


	
	];

	$(document).ready(function(){
		var t = $("#tree");
		t = $.fn.zTree.init(t, setting, zNodes);
		var zTree = $.fn.zTree.getZTreeObj("tree");
		zTree.selectNode(zTree.getNodeByParam("id", 101));
	});
  </SCRIPT>		
<ul id="tree" class="ztree" style="width:260px; overflow:auto;"></ul>