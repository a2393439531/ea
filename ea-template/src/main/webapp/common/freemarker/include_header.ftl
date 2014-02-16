
<#include "macro_common.ftl">
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<@context/>common/jqueryui183/css/jqui1813/smoothness/jquery-ui-1.8.13.custom.css" media="screen" />
<link href="<@context/>common/bootstrap303/css/bootstrap.min.css" rel="stylesheet">
<link href="<@context/>common/bootstrap303/css/docs.css" rel="stylesheet">
<link href="<@context/>common/bootstrap303/css/pygments-manni.css" rel="stylesheet">
<script src="<@context/>common/jquery-1-10-2/jquery.min.js"></script> <#--jquery必须房子啊其它之前，下拉菜单-->
<script type="text/javascript" src="<@context/>common/juqeryui-1-10-3/jquery-ui.js"></script>

<script src="<@context/>common/bootstrap303/js/bootstrap.js"></script>

<!--[if lt IE 9]><script src="<@context/>common/bootstrap303/js/ie8-responsive-file-warning.js"></script><![endif]-->
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="<@context/>common/bootstrap303/js/html5shiv.js"></script>
  <script src="<@context/>common/bootstrap303/js/respond.min.js"></script>
<![endif]-->

<link rel="stylesheet" type="text/css" href="<@context/>common/jquery-plugins/zTree/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript" src="<@context/>common/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<@context/>common/jquery-plugins/zTree/js/jquery.ztree.core-3.5.js"></script>

<link rel="stylesheet" type="text/css" href="<@context/>common/highslide-4-1-13/highslide/highslide.css" />
<script type="text/javascript"          src="<@context/>common/highslide-4-1-13/highslide/highslide-with-html.js"></script>
<style type="text/css">
* {font-family:inherit,Arial,verdana,tahoma;margin:0px;padding:0px;font-size:12px;}
<#--juqery-ui图标-->
ul#icons li {cursor: pointer; float: left;  list-style: none;}
ul#icons span.ui-icon {float: left; margin: 0 2px;}
.ui-icon  { cursor: pointer; float: left;  }

<#--bootsrap-css-->
.table th{background:#efefef;}
.panel {margin: 10px;}
.panel-heading {padding: 2px;}
.input{height: 34px; padding: 1px;}

<#--
select, input[type="text"] {
	margin-bottom: 0px;
	border-style: none;
	box-shadow: none;
	text-align: center;
}
-->
</style>
<script type="text/javascript">
function rowOver(target) 
{ 
    target.bgColor='#efefef'; 
  //   target.style.borderColor="000";
} 
function rowOut(target) 
{ 
    target.bgColor='#ffffff'; 
  //  target.style.borderColor="";
} 
</script>
<script type="text/javascript" >

	hs.graphicsDir = '<@context/>common/highslide-4-1-13/highslide/graphics/';
	hs.outlineType = 'rounded-white';
	hs.wrapperClassName = 'draggable-header';
	hs.minWidth=600;
	hs.minHeight=870;
    hs.preserveContent=false;
	
	function tip_info() {
	    $('#div_action_result',window.parent.parent.frames['topFrame'].document).html(document.getElementById('div_action_result').innerHTML);
        setTimeout( "$('#div_action_result',window.parent.parent.frames['topFrame'].document).html('')", 2000);
       	 
	}	
		
	function action_common(url,para){
		$.ajax({
	        type:"POST",
	        url: url,
	        data:para,
	        cache: false,
	        success: function(html){
	            document.getElementById('div_action_result').innerHTML=html;
	        	tip_info();   	 
	        }
	    });  
	}
</script>	
</head>	
<body>