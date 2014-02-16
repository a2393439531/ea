<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>systempara.js"></script>
<body style="padding:20px">
	<a class="btn btn-xs btn-default"  href=# onclick="javascript:action_systempara('create.do','id=root');">添加系统参数类别</a>
    <br> <br>
        <table >
        <tr>
        <#---
        //1.all-see-all-edit  2，all-see-owner-edit，3.ower-see-owner-edit
        -->
	        <td valign=top>
	        <div id=div_systempara_tree>
	        <#include "ajax_systempara.ftl">
	        </div>
	        </td>
	        <#--
		    <td valign=top width=300px>WO SETTING
			    <br> <input type="radio" name=woEditModel  value="all-see-all-edit"     onclick="javascript:update_system_config('woEditModel','all-see-all-edit');"  <#if rhs["system_config"].woEditModel=="all-see-all-edit" >  checked </#if>/>数据可见可编辑
			    <br> <input type="radio" name=woEditModel  value="all-see-owner-edit"   onclick="javascript:update_system_config('woEditModel','all-see-owner-edit');"  <#if rhs["system_config"].woEditModel=="all-see-owner-edit" >  checked </#if>/>数据可见，只可编辑自己的数据
			    <br> <input type="radio" name=woEditModel  value="owner-see-owner-edit" onclick="javascript:update_system_config('woEditModel','owner-see-owner-edit');"  <#if rhs["system_config"].woEditModel=="owner-see-owner-edit" >  checked </#if>/>仅自己的数据数据可见可编辑  
			 </td>
			 -->
	    </tr>
</body>