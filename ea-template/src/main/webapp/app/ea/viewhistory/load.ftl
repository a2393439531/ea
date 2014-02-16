<form name=form_viewhistory action="viewhistory_save.do"  metiod="post" enctype="multipart/form-data">
	<input type="hidden" id="objectid" name="id" value='<#if rhs["viewhistory"]?exists>${rhs["viewhistory"].id?if_exists}</#if>' />
	<br>名称 <input style="width:400px" type="text" name="viewhistoryobject.name" value='<#if rhs["viewhistory"]?exists>${rhs["viewhistory"].name?if_exists}</#if>' />
    <input type="hidden" name="viewhistoryobject.inputtime" value='${rhs["viewhistory"].inputtime?if_exists}' />
	<input type="hidden" name="viewhistoryobject.filename" value='${rhs["viewhistory"].filename?if_exists}' />

	<br><button class="btn  btn-mini" onclick="javascript:form_viewhistory.submit();">保存数据</button>
</form>
