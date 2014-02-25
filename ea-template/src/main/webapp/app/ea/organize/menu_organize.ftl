
<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>organize.js"></script>
<body>

        
<div style="padding:10px">
	    <a class="btn btn-xs btn-primary" onclick="javascript:action_organize('create.do','id=root');">添加根节点</a>
	    <a class="btn btn-xs btn-primary"   href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">岗位定义</a>
	    <a  class="btn btn-xs btn-primary"    href="ea_viewhistory_menu_viewhistory.do" >组织架构历史</a>      
	    <a class="btn btn-xs btn-default"  href="ea_organizegroup_menu_organizegroup.do" title="类别定义" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" ><span class="ui-icon ui-icon-tag"></span></a> 
	    <a class="btn btn-xs btn-default"  href="ea_ea_menu_organize_to_organizegroup.do"  title="类别设置"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" ><span class="ui-icon ui-icon-gear"></span></a>

	
	 
	<br>
	<div id=div_organize_tree>
		<#include "ajax_organize.ftl">
	</div>	
</div>

</body>
</html>	 
	 

  