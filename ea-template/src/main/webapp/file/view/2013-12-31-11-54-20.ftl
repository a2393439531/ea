
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="common/jqueryui183/css/jqui1813/smoothness/jquery-ui-1.8.13.custom.css" media="screen" />
<link href="common/bootstrap303/css/bootstrap.min.css" rel="stylesheet">
 
<link rel="stylesheet" type="text/css" href="common/jquery-plugins/zTree/css/zTreeStyle/zTreeStyle.css" />
	
<script type="text/javascript" src="common/jquery151/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="common/jqueryui183/jquery-ui-1.8.13.custom.min.js"></script>
<script type="text/javascript" src="common/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="common/jquery-plugins/zTree/js/jquery.ztree.core-3.5.js"></script>


<link rel="stylesheet" type="text/css" href="common/highslide-4-1-13/highslide/highslide.css" />
<script type="text/javascript"          src="common/highslide-4-1-13/highslide/highslide-with-html.js"></script>
<style type="text/css">
	* {font-family:inherit,Arial,verdana,tahoma;margin:0px;padding:0px;
		font-size:12px;
	}
	a{color: #224888;}
	ul#icons li {cursor: pointer; float: left;  list-style: none;}
		ul#icons span.ui-icon {float: left; margin: 0 2px;}
	.ui-icon  { cursor: pointer; float: left;  }


.table th{
	background:#efefef;
}


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
	//hs.graphicsDir = 'common/highslide/graphics/';
	hs.graphicsDir = 'common/highslide-4-1-13/highslide/graphics/';
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

			<div class="highslide-html-content" id="win_1">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">dsd
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   dsd<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_1" onclick='return hs.htmlExpand(this, { contentId: "win_1" } )'  class=highslide>dsd</a>
			
			<script>
				function win_1()
				{ document.getElementById("link_win_1").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_2">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">ds
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   ds<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_2" onclick='return hs.htmlExpand(this, { contentId: "win_2" } )'  class=highslide>ds</a>
			
			<script>
				function win_2()
				{ document.getElementById("link_win_2").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_3">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">ddd
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   ddd<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_3" onclick='return hs.htmlExpand(this, { contentId: "win_3" } )'  class=highslide>ddd</a>
			
			<script>
				function win_3()
				{ document.getElementById("link_win_3").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_4">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">ddd
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   ddd<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_4" onclick='return hs.htmlExpand(this, { contentId: "win_4" } )'  class=highslide>ddd</a>
			
			<script>
				function win_4()
				{ document.getElementById("link_win_4").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_5">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">ddd
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   ddd<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_5" onclick='return hs.htmlExpand(this, { contentId: "win_5" } )'  class=highslide>ddd</a>
			
			<script>
				function win_5()
				{ document.getElementById("link_win_5").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_6">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">d
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   d<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_6" onclick='return hs.htmlExpand(this, { contentId: "win_6" } )'  class=highslide>d</a>
			
			<script>
				function win_6()
				{ document.getElementById("link_win_6").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_7">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">dd
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   dd<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_7" onclick='return hs.htmlExpand(this, { contentId: "win_7" } )'  class=highslide>dd</a>
			
			<script>
				function win_7()
				{ document.getElementById("link_win_7").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_8">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">d
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   d<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_8" onclick='return hs.htmlExpand(this, { contentId: "win_8" } )'  class=highslide>d</a>
			
			<script>
				function win_8()
				{ document.getElementById("link_win_8").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_9">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   <br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_9" onclick='return hs.htmlExpand(this, { contentId: "win_9" } )'  class=highslide></a>
			
			<script>
				function win_9()
				{ document.getElementById("link_win_9").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_10">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   <br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_10" onclick='return hs.htmlExpand(this, { contentId: "win_10" } )'  class=highslide></a>
			
			<script>
				function win_10()
				{ document.getElementById("link_win_10").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_11">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   <br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_11" onclick='return hs.htmlExpand(this, { contentId: "win_11" } )'  class=highslide></a>
			
			<script>
				function win_11()
				{ document.getElementById("link_win_11").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_12">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   <br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_12" onclick='return hs.htmlExpand(this, { contentId: "win_12" } )'  class=highslide></a>
			
			<script>
				function win_12()
				{ document.getElementById("link_win_12").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_13">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   <br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_13" onclick='return hs.htmlExpand(this, { contentId: "win_13" } )'  class=highslide></a>
			
			<script>
				function win_13()
				{ document.getElementById("link_win_13").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_14">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   <br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_14" onclick='return hs.htmlExpand(this, { contentId: "win_14" } )'  class=highslide></a>
			
			<script>
				function win_14()
				{ document.getElementById("link_win_14").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_15">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   <br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_15" onclick='return hs.htmlExpand(this, { contentId: "win_15" } )'  class=highslide></a>
			
			<script>
				function win_15()
				{ document.getElementById("link_win_15").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_16">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   <br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_16" onclick='return hs.htmlExpand(this, { contentId: "win_16" } )'  class=highslide></a>
			
			<script>
				function win_16()
				{ document.getElementById("link_win_16").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_17">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   <br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_17" onclick='return hs.htmlExpand(this, { contentId: "win_17" } )'  class=highslide></a>
			
			<script>
				function win_17()
				{ document.getElementById("link_win_17").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_18">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   <br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_18" onclick='return hs.htmlExpand(this, { contentId: "win_18" } )'  class=highslide></a>
			
			<script>
				function win_18()
				{ document.getElementById("link_win_18").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_19">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   <br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_19" onclick='return hs.htmlExpand(this, { contentId: "win_19" } )'  class=highslide></a>
			
			<script>
				function win_19()
				{ document.getElementById("link_win_19").onclick();}
			</script>
		
	<div class="zz">
		<script language="javascript"> 
			var n1=new OrgNode();
			n1.Text="<span style='padding:4px;border:1px solid #000;'><b>架构图</b></span>";
			n1.Description="";
			n1.Link="";
   	        var organize1=new OrgNode(); 
     	    organize1.Text="<span style='padding:4px;border:1px solid #000;'><b>dsd</b></span><div style='margin:10px;'></div> ";
			organize1.Description="dsd";
			organize1.Link="win_1()";
			n1.Nodes.Add(organize1);
   	        var organize2=new OrgNode(); 
     	    organize2.Text="<span style='padding:4px;border:1px solid #000;'><b>ds</b></span><div style='margin:10px;'></div> ";
			organize2.Description="ds";
			organize2.Link="win_2()";
			organize1.Nodes.Add(organize2);
   	        var organize3=new OrgNode(); 
     	    organize3.Text="<span style='padding:4px;border:1px solid #000;'><b>ddd</b></span><div style='margin:10px;'></div> ";
			organize3.Description="ddd";
			organize3.Link="win_3()";
			organize1.Nodes.Add(organize3);
   	        var organize4=new OrgNode(); 
     	    organize4.Text="<span style='padding:4px;border:1px solid #000;'><b>ddd</b></span><div style='margin:10px;'></div> ";
			organize4.Description="ddd";
			organize4.Link="win_4()";
			organize3.Nodes.Add(organize4);
   	        var organize5=new OrgNode(); 
     	    organize5.Text="<span style='padding:4px;border:1px solid #000;'><b>ddd</b></span><div style='margin:10px;'></div> ";
			organize5.Description="ddd";
			organize5.Link="win_5()";
			organize3.Nodes.Add(organize5);
   	        var organize6=new OrgNode(); 
     	    organize6.Text="<span style='padding:4px;border:1px solid #000;'><b>d</b></span><div style='margin:10px;'></div> ";
			organize6.Description="d";
			organize6.Link="win_6()";
			organize3.Nodes.Add(organize6);
   	        var organize7=new OrgNode(); 
     	    organize7.Text="<span style='padding:4px;border:1px solid #000;'><b>dd</b></span><div style='margin:10px;'></div> ";
			organize7.Description="dd";
			organize7.Link="win_7()";
			n1.Nodes.Add(organize7);
   	        var organize8=new OrgNode(); 
     	    organize8.Text="<span style='padding:4px;border:1px solid #000;'><b>d</b></span><div style='margin:10px;'></div> ";
			organize8.Description="d";
			organize8.Link="win_8()";
			n1.Nodes.Add(organize8);
   	        var organize9=new OrgNode(); 
     	    organize9.Text="<span style='padding:4px;border:1px solid #000;'><b></b></span><div style='margin:10px;'></div> ";
			organize9.Description="";
			organize9.Link="win_9()";
			n1.Nodes.Add(organize9);
   	        var organize10=new OrgNode(); 
     	    organize10.Text="<span style='padding:4px;border:1px solid #000;'><b></b></span><div style='margin:10px;'></div> ";
			organize10.Description="";
			organize10.Link="win_10()";
			n1.Nodes.Add(organize10);
   	        var organize11=new OrgNode(); 
     	    organize11.Text="<span style='padding:4px;border:1px solid #000;'><b></b></span><div style='margin:10px;'></div> ";
			organize11.Description="";
			organize11.Link="win_11()";
			n1.Nodes.Add(organize11);
   	        var organize12=new OrgNode(); 
     	    organize12.Text="<span style='padding:4px;border:1px solid #000;'><b></b></span><div style='margin:10px;'></div> ";
			organize12.Description="";
			organize12.Link="win_12()";
			n1.Nodes.Add(organize12);
   	        var organize13=new OrgNode(); 
     	    organize13.Text="<span style='padding:4px;border:1px solid #000;'><b></b></span><div style='margin:10px;'></div> ";
			organize13.Description="";
			organize13.Link="win_13()";
			n1.Nodes.Add(organize13);
   	        var organize14=new OrgNode(); 
     	    organize14.Text="<span style='padding:4px;border:1px solid #000;'><b></b></span><div style='margin:10px;'></div> ";
			organize14.Description="";
			organize14.Link="win_14()";
			n1.Nodes.Add(organize14);
   	        var organize15=new OrgNode(); 
     	    organize15.Text="<span style='padding:4px;border:1px solid #000;'><b></b></span><div style='margin:10px;'></div> ";
			organize15.Description="";
			organize15.Link="win_15()";
			n1.Nodes.Add(organize15);
   	        var organize16=new OrgNode(); 
     	    organize16.Text="<span style='padding:4px;border:1px solid #000;'><b></b></span><div style='margin:10px;'></div> ";
			organize16.Description="";
			organize16.Link="win_16()";
			n1.Nodes.Add(organize16);
   	        var organize17=new OrgNode(); 
     	    organize17.Text="<span style='padding:4px;border:1px solid #000;'><b></b></span><div style='margin:10px;'></div> ";
			organize17.Description="";
			organize17.Link="win_17()";
			n1.Nodes.Add(organize17);
   	        var organize18=new OrgNode(); 
     	    organize18.Text="<span style='padding:4px;border:1px solid #000;'><b></b></span><div style='margin:10px;'></div> ";
			organize18.Description="";
			organize18.Link="win_18()";
			n1.Nodes.Add(organize18);
   	        var organize19=new OrgNode(); 
     	    organize19.Text="<span style='padding:4px;border:1px solid #000;'><b></b></span><div style='margin:10px;'></div> ";
			organize19.Description="";
			organize19.Link="win_19()";
			n1.Nodes.Add(organize19);
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
