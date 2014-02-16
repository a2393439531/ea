
<html xmlns="http://www.w3.org/1999/xhtml">
<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>organize.js"></script>

<#--
<style type="text/css">
.scoll{
    margin-top:15px;
    margin-left:5px;
    position:absolute;
    padding:0px;
    left:5px;
	width:200px;
	height:10PX;
	z-index: -99998;
	opacity:.6;
	 
	background-color: #FFFFFF;
}
</style>

<script>
function scrolldiv(id,h)
{
	var MyMar='';
	var obj=document.getElementById(id);
	if(h==null)
	{
		h='10px';
	}
	if(obj.style.display!='none')
	{
		MyMar=setInterval('scrolldiv_("'+id+'",'+h+')',10);   ///控制层的移动
	}else{
		clearInterval(MyMar);
	}
}

function  scrolldiv_(id,h)
{  //定位层
   obj=document.getElementById(id);
   obj.style.top =  document.body.scrollTop+h;
}

function  show_dir()
{  //定位层
  if( document.getElementById('div_panel_control').style.display=='none'){
  	document.getElementById('div_panel_control').style.display='block';
  }else{
  document.getElementById('div_panel_control').style.display='none';
  }
}
</script>

<body onload="scrolldiv('div_scoll',5)">
-->
<body>

<div style="padding:10px">


	<a class="btn btn-xs btn-default" onclick="javascript:action_organize('create.do','id=root');">添加根节点</a>&nbsp;&nbsp;&nbsp;
    <a class="btn btn-xs btn-default" href="ea_rolegroup_menu_rolegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">岗位定义</a>&nbsp;&nbsp;&nbsp;
	<a class="btn btn-xs btn-default" href="ea_organizegroup_menu_organizegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">分类定义</a>&nbsp;&nbsp;&nbsp;
	<a class="btn btn-xs btn-default" href="ea_ea_menu_organize_to_organizegroup.do"  onclick="return hs.htmlExpand(this, { objectType: 'iframe' })">类别关联</a>&nbsp;&nbsp;
    <a class="btn btn-xs btn-default" href="ea_viewhistory_menu_viewhistory.do" target="mainFrame">组织架构历史</a>
	<br>	<br>
	<div id=div_organize_tree>
		<#include "ajax_organize.ftl">
	</div>	
</div>

</body>
</html>	 
	 

