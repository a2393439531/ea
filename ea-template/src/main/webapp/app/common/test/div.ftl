<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" >
	$(function(){$( "#div_scoll" ).draggable();});  
	function showhide(id){
		if(document.getElementById(id).style.display=="block"){
			document.getElementById(id).style.display="none";
		}else{
			document.getElementById(id).style.display="block";
		}
		return true;
	}
</script>
<#--margin-left:350px;margin-top:100px;-->
<a  class="btn  btn-primary"  onclick="showhide('div_scoll');">显示</a>

<div class="scoll" id="div_scoll"  style="display:none;cursor:hander;width:300px;z-index:10000;background-color: #ffffff;">
	<div class="well">
	 	 <div id=div_panel_control style="padding:8px;border:1px solid #eee;cursor:hander; ">
	 	    <a  style="float:right" href="#" onclick="showhide('div_scoll');" ><span class="glyphicon glyphicon-remove"></span> </a>
	 	    <br>
	 		<div id=div_select_user style="cursor:hander;"> </div>
		    <div id=div_add_new_user style="display:none;cursor:hander;">
			    <b> 新用户身份登记 </b> 
					<br>姓名 <input id=name value="" style="WIDTH: 120px"   />
			       <br>英文帐号<input id=account value="" style="WIDTH: 120px"   />
		   </div>
	  </div>
	</div>  	 
</div>	
	
				
	

<#---
背景色：background: #EFEBDE;"
背景图片：
模板：font-size:12pt;padding:5px 5px 5px 5px;width:150px;border:0px; clear:left;float:left;text-align:center;position:absolute;
<img src="/ea/file/photo/zhanhuanhuan.jpg" style="border:1px #006699 solid;filter:progid:DXImageTransform.Microsoft.Shadow(strength=15);">
<img src="/ea/file/photo/zhanhuanhuan.jpg" style="width:100px ;height:100px;position:relative;display:block;top:-2px;left:-2px;border:1px solid #ccc;background:#fff;padding:4px;">

-->