<#include "macro_common.ftl">
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<@context/>common/jqueryui183/css/jqui1813/smoothness/jquery-ui-1.8.13.custom.css" media="screen" />

<link href="<@context/>common/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="<@context/>common/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
<!--[if lte IE 6]>
<link rel="stylesheet" type="text/css" href="<@context/>common/ddouble-bsie-v1.05/bootstrap/css/bootstrap-ie6.css">
<![endif]-->
<!--[if lte IE 7]>
<link rel="stylesheet" type="text/css" href="<@context/>common/ddouble-bsie-v1.05/bootstrap/css/ie.css">
<![endif]-->
<link rel="stylesheet" type="text/css" href="<@context/>common/jquery-plugins/zTree/css/zTreeStyle/zTreeStyle.css" />
<style type="text/css">
	* {font-family:inherit,Arial,verdana,tahoma;margin:0px;padding:0px;line-height:20px;
		font-size:12px;
	}
	ul#icons li {cursor: pointer; float: left;  list-style: none;}
		ul#icons span.ui-icon {float: left; margin: 0 2px;}
	.ui-icon  { cursor: pointer; float: left;  }

</style>	
<script type="text/javascript" src="<@context/>common/jquery151/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="<@context/>common/jqueryui183/jquery-ui-1.8.13.custom.min.js"></script>
<script type="text/javascript" src="<@context/>common/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<@context/>common/jquery-plugins/zTree/js/jquery.ztree.core-3.5.js"></script>
<!--
<link rel="stylesheet" type="text/css" href="<@context/>common/highslide/highslide.css" />
<script type="text/javascript"          src="<@context/>common/highslide/highslide-with-html.js"></script>
-->
<link rel="stylesheet" type="text/css" href="<@context/>common/highslide-4-1-13/highslide/highslide.css" />
<script type="text/javascript"          src="<@context/>common/highslide-4-1-13/highslide/highslide-with-html.js"></script>
<script type="text/javascript" >
	//hs.graphicsDir = '<@context/>common/highslide/graphics/';
	hs.graphicsDir = '<@context/>common/highslide-4-1-13/highslide/graphics/';
	hs.outlineType = 'rounded-white';
	hs.wrapperClassName = 'draggable-header';
	
	hs.minWidth=800;
	hs.minHeight=800;
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