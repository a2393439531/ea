
<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>organize.js"></script>
<body>

        
<div style="padding:10px">

	<div class="btn-group btn-group-xs" style="padding-bottom:10px">
	    <button type="button" class="btn  btn-primary" onclick="javascript:action_organize('create.do','id=root');">添加根节点</button>
	    <a class="btn btn-warning" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">岗位定义</a>
	    <a type="button" class="btn btn-xs btn-info"    href="ea_viewhistory_menu_viewhistory.do" >组织架构历史</a>      
		
	      <div class="btn-toolbar " role="toolbar">
	        <div class="btn-group ">
	          <a  href="ea_organizegroup_menu_organizegroup.do" title="类别定义" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" class="btn btn-xs  btn-default"> <span class="glyphicon glyphicon-tag"></span></a>
	          <a  href="ea_ea_menu_organize_to_organizegroup.do"  title="类别设置"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" class="btn btn-xs  btn-default"><span class="glyphicon glyphicon-th-list"></span></a>
	          
	        </div>
	      </div>
	</div>

	 
	<br>
	<div id=div_organize_tree>
		<#include "ajax_organize.ftl">
	</div>	
</div>

</body>
</html>	 
	 

  