<form name=form_tpltb2 action="manager_tpltb2_save.do"  metiod="post" enctype="multipart/form-data">
	<input type="hidden" id="objectid" name="id" value='<#if rhs["tpltb2"]?exists>${rhs["tpltb2"].id?if_exists}</#if>' />
	<br>姓名 <input type="text" style="margin-bottom:7px;" name="tpltb2object.name" value='<#if rhs["tpltb2"]?exists>${rhs["tpltb2"].name?if_exists}</#if>' />
	<br>生日 <input type="text" style="margin-bottom:10px;" name="tpltb2object.birthDate" value='<#if rhs["tpltb2"]?exists>${rhs["tpltb2"].birthDate?if_exists}</#if>' onClick="WdatePicker()"/>
	<br><button class="btn  btn-mini" onclick="javascript:form_tpltb2.submit();">保存数据</button>
</form>
