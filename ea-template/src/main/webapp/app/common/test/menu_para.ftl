<a  href="ea_systempara_menu_systempara.do" target=_blank>数据词典的设置界面  </a>

<pre>在action方法中，通过下面方式将 数据词典存入
rhs.put("system_para_map", 	infEa.getParaMap());   见TestAction的menu_para方法
前台通过rhs["system_para_map"] 得到一个map数据格式的参数值
展示效果如下：
</pre>
	
	<BR>1.下拉框
	<select class=input name="service-function" size="1" <#---onchange="javascript:update_user_property();"--> value="">
	    <#list  rhs["system_para_map"]["service-function"]?keys as key>
		   <option value="${key}">${rhs["system_para_map"]["service-function"][key]?if_exists}</option>
		</#list> 
	</select> 
	

	
	<br>2.单选
		<#list  rhs["system_para_map"]["busniess-type"]?keys as key>
		 业务类型  <input type="radio" name=businesstype value="${key}" onclick="alert(this.value)" checked>${rhs["system_para_map"]["busniess-type"][key]?if_exists}</input>
		</#list> 
	
	<br>3.多选
		<#list  rhs["system_para_map"]["busniess-type"]?keys as key>
		   业务类型  <input type="checkbox" name=businesstype value="${key}" >${rhs["system_para_map"]["busniess-type"][key]?if_exists}</input>
		</#list> 
	
	