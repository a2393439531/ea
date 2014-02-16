<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<link href="../../common/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="../../common/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
<style>
*{font-size: 12px;line-height:20px;}
p{display:inline;}
</style>
<script language="javascript" src="../../app/manager/view/view_organize.js"></script>
<#macro digui_organize organizeNodes  flag >
	<#list organizeNodes as organize>
	    <tr >
	    	<td valign=top style="width:40%">
	    		${flag}<#if flag="" ><image   src=../../common/images/icon/org.ico title="架构类型" /></#if>
	    		<b>${organize.name?if_exists}</b>
	    	</td>
			<td valign=top >		 	     
				${organize.organizedescription?if_exists}
			</td>
		  <#if !(organize.getChildOrganizes()?size<1)> 
		      <@digui_organize organize.getChildOrganizes()?sort_by('sortNob'),flag+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />	
		  </#if>
	</#list> 
</#macro>
<a href="view/save_input.ftl?t=t_organize_v&id=${rhs["id"]?if_exists}" onclick="return hs.htmlExpand(this, { objectType: 'iframe' })" ><image title=保存 style="border:0px solid #ddd;"  src=../../common/images/save2.png /></a>	
<#assign organizeRootList=rhs["organizeRootList"]/>
<#assign rootname=rhs["rootname"]/>
<table class="table table-striped table-condensed" style="width:700px;padding:0px;margin:0px">
	<@digui_organize organizeRootList?sort_by('sortNob'),"" />	
</table>