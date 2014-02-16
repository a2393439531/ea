
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style type="text/css">
<!--
.c4s_add{
    position:absolute;
    padding:0px;
   left:5px;
	width:200px;
	height:10PX;
	z-index: -99998;
	opacity:.6;
	background-color: #FFFFFF;
	border: 1px solid #fff;
}

-->
</style>
<script>
/*随屏幕滚动层*/
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
		MyMar=setInterval('scrolldiv_("'+id+'",'+h+')',50);   ///控制层的移动
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
</head>



<body onload="scrolldiv('choice1',5)">


<div style="margin:5px">

	<div class="c4s_add" id="choice1"  style="padding-top:0px;">
		 			
	   <div id=div_panel_control style="border:1px solid #fff;padding:1px;display:block">
		aaaaaaaaaaaaaaaaaaaaaaaa
		</div>
		
		
	</div>
<br><br> <br><br> <br><br> <br><br> <br><br> <br><br> <br><br> 
<br><br> <br><br> <br><br> <br><br> <br><br> <br><br> <br><br> 
<br><br> <br><br> <br><br> <br><br> <br><br> <br><br> <br><br> 
<br><br> <br><br> <br><br> <br><br> <br><br> <br><br> <br><br> 
</div>
</body>
</html>