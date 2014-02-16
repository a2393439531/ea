
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="common/jqueryui183/css/jqui1813/smoothness/jquery-ui-1.8.13.custom.css" media="screen" />
<link href="common/bootstrap303/css/bootstrap.min.css" rel="stylesheet">
<link href="common/bootstrap303/css/docs.css" rel="stylesheet">
<link href="common/bootstrap303/css/pygments-manni.css" rel="stylesheet">
<script src="common/jquery-1-10-2/jquery.min.js"></script> 
<script type="text/javascript" src="common/juqeryui-1-10-3/jquery-ui.js"></script>

<script src="common/bootstrap303/js/bootstrap.js"></script>

<!--[if lt IE 9]><script src="common/bootstrap303/js/ie8-responsive-file-warning.js"></script><![endif]-->
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="common/bootstrap303/js/html5shiv.js"></script>
  <script src="common/bootstrap303/js/respond.min.js"></script>
<![endif]-->

<link rel="stylesheet" type="text/css" href="common/jquery-plugins/zTree/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript" src="common/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="common/jquery-plugins/zTree/js/jquery.ztree.core-3.5.js"></script>

<link rel="stylesheet" type="text/css" href="common/highslide-4-1-13/highslide/highslide.css" />
<script type="text/javascript"          src="common/highslide-4-1-13/highslide/highslide-with-html.js"></script>
<style type="text/css">
* {font-family:inherit,Arial,verdana,tahoma;margin:0px;padding:0px;font-size:12px;}
ul#icons li {cursor: pointer; float: left;  list-style: none;}
ul#icons span.ui-icon {float: left; margin: 0 2px;}
.ui-icon  { cursor: pointer; float: left;  }

.table th{background:#efefef;}
.panel {margin: 10px;}
.panel-heading {padding: 2px;}
.input{height: 34px; padding: 1px;}

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

	hs.graphicsDir = 'common/highslide-4-1-13/highslide/graphics/';
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
<body><script language="javascript" src="app/ea/view/view_organize.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<style>
*{font-size: 12px;}
.zz {
	height: 1200px;	width: 958px auto;border: 0px solid #CCCCCC;
	margin-top: 5px;margin-bottom: 5px;margin-left:auto;margin-right:auto; 
}
a {font-family: "宋体";font-size: 12px;color: #000;text-decoration: none;cursor:hand}
</style>

			<div class="highslide-html-content" id="win_2">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">fsdsdf
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   fsdsdf<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_2" onclick='return hs.htmlExpand(this, { contentId: "win_2" } )'  class=highslide>fsdsdf</a>
			
			<script>
				function win_2()
				{ document.getElementById("link_win_2").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_3">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">s
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   s<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_3" onclick='return hs.htmlExpand(this, { contentId: "win_3" } )'  class=highslide>s</a>
			
			<script>
				function win_3()
				{ document.getElementById("link_win_3").onclick();}
			</script>
		
	<div class="zz">
		<script language="javascript"> 
			var n1=new OrgNode();
			n1.Text="<span style='padding:4px;border:1px solid #000;'><b>sdfsd</b></span>";
			n1.Description="";
			n1.Link="";
   	        var organize2=new OrgNode(); 
     	    organize2.Text="<span style='padding:4px;border:1px solid #000;'><b>fsdsdf</b></span><div style='margin:10px;'></div> ";
			organize2.Description="fsdsdf";
			organize2.Link="win_2()";
			n1.Nodes.Add(organize2);
   	        var organize3=new OrgNode(); 
     	    organize3.Text="<span style='padding:4px;border:1px solid #000;'><b>s</b></span><div style='margin:10px;'></div> ";
			organize3.Description="s";
			organize3.Link="win_3()";
			n1.Nodes.Add(organize3);
	var OrgShows=new OrgShow(n1);
	OrgShows.Top=135;
	OrgShows.Left=20;
	OrgShows.IntervalWidth=2;
	OrgShows.IntervalHeight=50;
	OrgShows.ShowType=1; //2代表文字是竖的
	OrgShows.BoxHeight=22; //高度
	OrgShows.BoxWidth=174; //宽度
	OrgShows.LineSize=2;  //设置线条大小
	OrgShows.LineColor="#000";  //设置线条颜色
	OrgShows.Run();
		</script>
	</div>	    
</body>
