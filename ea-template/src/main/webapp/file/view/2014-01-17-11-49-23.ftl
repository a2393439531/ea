
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

			<div class="highslide-html-content" id="win_13">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">香港ehms
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   香港ehms<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_13" onclick='return hs.htmlExpand(this, { contentId: "win_13" } )'  class=highslide>香港ehms</a>
			
			<script>
				function win_13()
				{ document.getElementById("link_win_13").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_15">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">Billing-Report-DBA
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   Billing-Report-DBA<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_15" onclick='return hs.htmlExpand(this, { contentId: "win_15" } )'  class=highslide>Billing-Report-DBA</a>
			
			<script>
				function win_15()
				{ document.getElementById("link_win_15").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_21">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">billing
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   billing<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_21" onclick='return hs.htmlExpand(this, { contentId: "win_21" } )'  class=highslide>billing</a>
			
			<script>
				function win_21()
				{ document.getElementById("link_win_21").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_22">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">reporting
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   reporting<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_22" onclick='return hs.htmlExpand(this, { contentId: "win_22" } )'  class=highslide>reporting</a>
			
			<script>
				function win_22()
				{ document.getElementById("link_win_22").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_23">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">DBA
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   DBA<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_23" onclick='return hs.htmlExpand(this, { contentId: "win_23" } )'  class=highslide>DBA</a>
			
			<script>
				function win_23()
				{ document.getElementById("link_win_23").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_14">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">BSS
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   BSS<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_14" onclick='return hs.htmlExpand(this, { contentId: "win_14" } )'  class=highslide>BSS</a>
			
			<script>
				function win_14()
				{ document.getElementById("link_win_14").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_16">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">BSS
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <img src=file/20131029102837834.jpg />
				   <p>
				   BSS<br>
				   <p>Business Surpport System业务支撑系统，和记的营业厅销售系统，<br />主要使用powerbuilder,java,proc-c等技术</p>
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_16" onclick='return hs.htmlExpand(this, { contentId: "win_16" } )'  class=highslide>BSS</a>
			
			<script>
				function win_16()
				{ document.getElementById("link_win_16").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_237">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">CS-PS-VAS
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   CS-PS-VAS<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_237" onclick='return hs.htmlExpand(this, { contentId: "win_237" } )'  class=highslide>CS-PS-VAS</a>
			
			<script>
				function win_237()
				{ document.getElementById("link_win_237").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_240">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">CS-PS
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <img src=file/20131028040834702.png />
				   <p>
				   CS-PS<br>
				   product and service 组主要维护和记电信给客户介绍产品和服务的门户网站<br /><a href='http://www.three.com.hk'>http://www.three.com.hk</a> 
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_240" onclick='return hs.htmlExpand(this, { contentId: "win_240" } )'  class=highslide>CS-PS</a>
			
			<script>
				function win_240()
				{ document.getElementById("link_win_240").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_241">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">VAS
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   VAS<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_241" onclick='return hs.htmlExpand(this, { contentId: "win_241" } )'  class=highslide>VAS</a>
			
			<script>
				function win_241()
				{ document.getElementById("link_win_241").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_238">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">MD-Prov
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   MD-Prov<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_238" onclick='return hs.htmlExpand(this, { contentId: "win_238" } )'  class=highslide>MD-Prov</a>
			
			<script>
				function win_238()
				{ document.getElementById("link_win_238").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_242">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">MD-Prov
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   MD-Prov<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_242" onclick='return hs.htmlExpand(this, { contentId: "win_242" } )'  class=highslide>MD-Prov</a>
			
			<script>
				function win_242()
				{ document.getElementById("link_win_242").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_239">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">Surpporting
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   Surpporting<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_239" onclick='return hs.htmlExpand(this, { contentId: "win_239" } )'  class=highslide>Surpporting</a>
			
			<script>
				function win_239()
				{ document.getElementById("link_win_239").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_243">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">Surpporting
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   Surpporting<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_243" onclick='return hs.htmlExpand(this, { contentId: "win_243" } )'  class=highslide>Surpporting</a>
			
			<script>
				function win_243()
				{ document.getElementById("link_win_243").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_135">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">广州CGC
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   广州CGC<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_135" onclick='return hs.htmlExpand(this, { contentId: "win_135" } )'  class=highslide>广州CGC</a>
			
			<script>
				function win_135()
				{ document.getElementById("link_win_135").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_247">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">ECE产品
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   ECE产品<br>
				   对外端口
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_247" onclick='return hs.htmlExpand(this, { contentId: "win_247" } )'  class=highslide>ECE产品</a>
			
			<script>
				function win_247()
				{ document.getElementById("link_win_247").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_250">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">Exposer
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   Exposer<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_250" onclick='return hs.htmlExpand(this, { contentId: "win_250" } )'  class=highslide>Exposer</a>
			
			<script>
				function win_250()
				{ document.getElementById("link_win_250").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_251">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">MDN
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   MDN<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_251" onclick='return hs.htmlExpand(this, { contentId: "win_251" } )'  class=highslide>MDN</a>
			
			<script>
				function win_251()
				{ document.getElementById("link_win_251").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_252">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">IAM
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   IAM<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_252" onclick='return hs.htmlExpand(this, { contentId: "win_252" } )'  class=highslide>IAM</a>
			
			<script>
				function win_252()
				{ document.getElementById("link_win_252").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_248">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">MSDP产品
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   MSDP产品<br>
				   网上商城，B2B,B2C
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_248" onclick='return hs.htmlExpand(this, { contentId: "win_248" } )'  class=highslide>MSDP产品</a>
			
			<script>
				function win_248()
				{ document.getElementById("link_win_248").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_253">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">CA&Demo-team
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   CA&Demo-team<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_253" onclick='return hs.htmlExpand(this, { contentId: "win_253" } )'  class=highslide>CA&Demo-team</a>
			
			<script>
				function win_253()
				{ document.getElementById("link_win_253").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_254">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">R&D-team
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   R&D-team<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_254" onclick='return hs.htmlExpand(this, { contentId: "win_254" } )'  class=highslide>R&D-team</a>
			
			<script>
				function win_254()
				{ document.getElementById("link_win_254").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_283">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">PC-team
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   PC-team<br>
				   客户定制化开发
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_283" onclick='return hs.htmlExpand(this, { contentId: "win_283" } )'  class=highslide>PC-team</a>
			
			<script>
				function win_283()
				{ document.getElementById("link_win_283").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_284">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">DM-team
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   DM-team<br>
				   版本维护管理 对MSDP, 10几个，旧版本的发布管理
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_284" onclick='return hs.htmlExpand(this, { contentId: "win_284" } )'  class=highslide>DM-team</a>
			
			<script>
				function win_284()
				{ document.getElementById("link_win_284").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_285">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">release-team
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   release-team<br>
				   SCM 配置管理，3，管理git ，it环境，持续集成，环境
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_285" onclick='return hs.htmlExpand(this, { contentId: "win_285" } )'  class=highslide>release-team</a>
			
			<script>
				function win_285()
				{ document.getElementById("link_win_285").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_313">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">UX
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   UX<br>
				   用户体验，美工，demo的需求设计，只画界面，需要懂业务<br />6个左右
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_313" onclick='return hs.htmlExpand(this, { contentId: "win_313" } )'  class=highslide>UX</a>
			
			<script>
				function win_313()
				{ document.getElementById("link_win_313").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_249">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">MSP产品
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   MSP产品<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_249" onclick='return hs.htmlExpand(this, { contentId: "win_249" } )'  class=highslide>MSP产品</a>
			
			<script>
				function win_249()
				{ document.getElementById("link_win_249").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_255">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">sherdlock-3线surpport-team
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   sherdlock-3线surpport-team<br>
				   
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_255" onclick='return hs.htmlExpand(this, { contentId: "win_255" } )'  class=highslide>sherdlock-3线surpport-team</a>
			
			<script>
				function win_255()
				{ document.getElementById("link_win_255").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_281">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">CMS产品
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   CMS产品<br>
				   CMS
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_281" onclick='return hs.htmlExpand(this, { contentId: "win_281" } )'  class=highslide>CMS产品</a>
			
			<script>
				function win_281()
				{ document.getElementById("link_win_281").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_282">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">NPS产品服务支持
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   NPS产品服务支持<br>
				   NPS near product service 产品相关的SURPPORT
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_282" onclick='return hs.htmlExpand(this, { contentId: "win_282" } )'  class=highslide>NPS产品服务支持</a>
			
			<script>
				function win_282()
				{ document.getElementById("link_win_282").onclick();}
			</script>
		
			<div class="highslide-html-content" id="win_286">
				<div class="highslide-header">
					<ul>
						<li class="highslide-move">SI大产品的集成
							<a href="#" onclick="return false"></a>
						</li>
						<li class="highslide-close">
							<a href="#" onclick="return hs.close(this)">x</a>
						</li>
									
					</ul>
				</div>
				<div class="highslide-body">
				   <p>
				   SI大产品的集成<br>
				   大产品之间的 si ，solution级别，未来趋势，
				   </p>
				</div>
			    <div class="highslide-footer">
			        <div>
			            <span class="highslide-resize" title="Resize">
			            </span>
			        </div>
			    </div>
			</div>
			
			<a style="display:none" id="link_win_286" onclick='return hs.htmlExpand(this, { contentId: "win_286" } )'  class=highslide>SI大产品的集成</a>
			
			<script>
				function win_286()
				{ document.getElementById("link_win_286").onclick();}
			</script>
		
	<div class="zz">
		<script language="javascript"> 
			var n1=new OrgNode();
			n1.Text="<span style='padding:4px;border:1px solid #000;'><b>项目架构</b></span>";
			n1.Description="";
			n1.Link="";
   	        var organize13=new OrgNode(); 
     	    organize13.Text="<span style='padding:4px;border:1px solid #000;'><b>香港ehms</b></span><div style='margin:10px;'></div> ";
			organize13.Description="香港ehms";
			organize13.Link="win_13()";
			n1.Nodes.Add(organize13);
   	        var organize15=new OrgNode(); 
     	    organize15.Text="<span style='padding:4px;border:1px solid #000;'><b>Billing-Report-DBA</b></span><div style='margin:10px;'></div> ";
			organize15.Description="Billing-Report-DBA";
			organize15.Link="win_15()";
			organize13.Nodes.Add(organize15);
   	        var organize21=new OrgNode(); 
     	    organize21.Text="<span style='padding:4px;border:1px solid #000;'><b>billing</b></span><div style='margin:10px;'></div> ";
			organize21.Description="billing";
			organize21.Link="win_21()";
			organize15.Nodes.Add(organize21);
   	        var organize22=new OrgNode(); 
     	    organize22.Text="<span style='padding:4px;border:1px solid #000;'><b>reporting</b></span><div style='margin:10px;'></div> ";
			organize22.Description="reporting";
			organize22.Link="win_22()";
			organize15.Nodes.Add(organize22);
   	        var organize23=new OrgNode(); 
     	    organize23.Text="<span style='padding:4px;border:1px solid #000;'><b>DBA</b></span><div style='margin:10px;'></div> ";
			organize23.Description="DBA";
			organize23.Link="win_23()";
			organize15.Nodes.Add(organize23);
   	        var organize14=new OrgNode(); 
     	    organize14.Text="<span style='padding:4px;border:1px solid #000;'><b>BSS</b></span><div style='margin:10px;'></div> ";
			organize14.Description="BSS";
			organize14.Link="win_14()";
			organize13.Nodes.Add(organize14);
   	        var organize16=new OrgNode(); 
     	    organize16.Text="<span style='padding:4px;border:1px solid #000;'><b>BSS</b></span><table><tr><td width=150px align=center><image style='width:80px;height:90px;border:0px #006699 solid;border:solid 1px #aaa;display:block;padding:3px;margin:7px'  onmouseover='' src=file/20131029102837834.jpg  /></td></tr></table><div style='margin:10px;'><div style='overflow:hidden;width:130px;height:24px;'><p>Business Surpport System业务支撑系统，和记的营业厅销售系统，<br />主要使用powerbuilder,java,proc-c等技术</p></div></div> ";
			organize16.Description="BSS";
			organize16.Link="win_16()";
			organize14.Nodes.Add(organize16);
   	        var organize237=new OrgNode(); 
     	    organize237.Text="<span style='padding:4px;border:1px solid #000;'><b>CS-PS-VAS</b></span><div style='margin:10px;'></div> ";
			organize237.Description="CS-PS-VAS";
			organize237.Link="win_237()";
			organize13.Nodes.Add(organize237);
   	        var organize240=new OrgNode(); 
     	    organize240.Text="<span style='padding:4px;border:1px solid #000;'><b>CS-PS</b></span><table><tr><td width=150px align=center><image style='width:80px;height:90px;border:0px #006699 solid;border:solid 1px #aaa;display:block;padding:3px;margin:7px'  onmouseover='' src=file/20131028040834702.png  /></td></tr></table><div style='margin:10px;'><div style='overflow:hidden;width:130px;height:24px;'>product and service 组主要维护和记电信给客户介绍产品和服务的门户网站<br /><a href='http://www.three.com.hk'>http://www.three.com.hk</a> </div></div> ";
			organize240.Description="CS-PS";
			organize240.Link="win_240()";
			organize237.Nodes.Add(organize240);
   	        var organize241=new OrgNode(); 
     	    organize241.Text="<span style='padding:4px;border:1px solid #000;'><b>VAS</b></span><div style='margin:10px;'></div> ";
			organize241.Description="VAS";
			organize241.Link="win_241()";
			organize237.Nodes.Add(organize241);
   	        var organize238=new OrgNode(); 
     	    organize238.Text="<span style='padding:4px;border:1px solid #000;'><b>MD-Prov</b></span><div style='margin:10px;'></div> ";
			organize238.Description="MD-Prov";
			organize238.Link="win_238()";
			organize13.Nodes.Add(organize238);
   	        var organize242=new OrgNode(); 
     	    organize242.Text="<span style='padding:4px;border:1px solid #000;'><b>MD-Prov</b></span><div style='margin:10px;'></div> ";
			organize242.Description="MD-Prov";
			organize242.Link="win_242()";
			organize238.Nodes.Add(organize242);
   	        var organize239=new OrgNode(); 
     	    organize239.Text="<span style='padding:4px;border:1px solid #000;'><b>Surpporting</b></span><div style='margin:10px;'></div> ";
			organize239.Description="Surpporting";
			organize239.Link="win_239()";
			organize13.Nodes.Add(organize239);
   	        var organize243=new OrgNode(); 
     	    organize243.Text="<span style='padding:4px;border:1px solid #000;'><b>Surpporting</b></span><div style='margin:10px;'></div> ";
			organize243.Description="Surpporting";
			organize243.Link="win_243()";
			organize239.Nodes.Add(organize243);
   	        var organize135=new OrgNode(); 
     	    organize135.Text="<span style='padding:4px;border:1px solid #000;'><b>广州CGC</b></span><div style='margin:10px;'></div> ";
			organize135.Description="广州CGC";
			organize135.Link="win_135()";
			n1.Nodes.Add(organize135);
   	        var organize247=new OrgNode(); 
     	    organize247.Text="<span style='padding:4px;border:1px solid #000;'><b>ECE产品</b></span><div style='margin:10px;'><div style='overflow:hidden;width:130px;height:24px;'>对外端口</div></div> ";
			organize247.Description="ECE产品";
			organize247.Link="win_247()";
			organize135.Nodes.Add(organize247);
   	        var organize250=new OrgNode(); 
     	    organize250.Text="<span style='padding:4px;border:1px solid #000;'><b>Exposer</b></span><div style='margin:10px;'></div> ";
			organize250.Description="Exposer";
			organize250.Link="win_250()";
			organize247.Nodes.Add(organize250);
   	        var organize251=new OrgNode(); 
     	    organize251.Text="<span style='padding:4px;border:1px solid #000;'><b>MDN</b></span><div style='margin:10px;'></div> ";
			organize251.Description="MDN";
			organize251.Link="win_251()";
			organize247.Nodes.Add(organize251);
   	        var organize252=new OrgNode(); 
     	    organize252.Text="<span style='padding:4px;border:1px solid #000;'><b>IAM</b></span><div style='margin:10px;'></div> ";
			organize252.Description="IAM";
			organize252.Link="win_252()";
			organize247.Nodes.Add(organize252);
   	        var organize248=new OrgNode(); 
     	    organize248.Text="<span style='padding:4px;border:1px solid #000;'><b>MSDP产品</b></span><div style='margin:10px;'><div style='overflow:hidden;width:130px;height:24px;'>网上商城，B2B,B2C</div></div> ";
			organize248.Description="MSDP产品";
			organize248.Link="win_248()";
			organize135.Nodes.Add(organize248);
   	        var organize253=new OrgNode(); 
     	    organize253.Text="<span style='padding:4px;border:1px solid #000;'><b>CA&Demo-team</b></span><div style='margin:10px;'></div> ";
			organize253.Description="CA&Demo-team";
			organize253.Link="win_253()";
			organize248.Nodes.Add(organize253);
   	        var organize254=new OrgNode(); 
     	    organize254.Text="<span style='padding:4px;border:1px solid #000;'><b>R&D-team</b></span><div style='margin:10px;'></div> ";
			organize254.Description="R&D-team";
			organize254.Link="win_254()";
			organize248.Nodes.Add(organize254);
   	        var organize283=new OrgNode(); 
     	    organize283.Text="<span style='padding:4px;border:1px solid #000;'><b>PC-team</b></span><div style='margin:10px;'><div style='overflow:hidden;width:130px;height:24px;'>客户定制化开发</div></div> ";
			organize283.Description="PC-team";
			organize283.Link="win_283()";
			organize248.Nodes.Add(organize283);
   	        var organize284=new OrgNode(); 
     	    organize284.Text="<span style='padding:4px;border:1px solid #000;'><b>DM-team</b></span><div style='margin:10px;'><div style='overflow:hidden;width:130px;height:24px;'>版本维护管理 对MSDP, 10几个，旧版本的发布管理</div></div> ";
			organize284.Description="DM-team";
			organize284.Link="win_284()";
			organize248.Nodes.Add(organize284);
   	        var organize285=new OrgNode(); 
     	    organize285.Text="<span style='padding:4px;border:1px solid #000;'><b>release-team</b></span><div style='margin:10px;'><div style='overflow:hidden;width:130px;height:24px;'>SCM 配置管理，3，管理git ，it环境，持续集成，环境</div></div> ";
			organize285.Description="release-team";
			organize285.Link="win_285()";
			organize248.Nodes.Add(organize285);
   	        var organize313=new OrgNode(); 
     	    organize313.Text="<span style='padding:4px;border:1px solid #000;'><b>UX</b></span><div style='margin:10px;'><div style='overflow:hidden;width:130px;height:24px;'>用户体验，美工，demo的需求设计，只画界面，需要懂业务<br />6个左右</div></div> ";
			organize313.Description="UX";
			organize313.Link="win_313()";
			organize248.Nodes.Add(organize313);
   	        var organize249=new OrgNode(); 
     	    organize249.Text="<span style='padding:4px;border:1px solid #000;'><b>MSP产品</b></span><div style='margin:10px;'></div> ";
			organize249.Description="MSP产品";
			organize249.Link="win_249()";
			organize135.Nodes.Add(organize249);
   	        var organize255=new OrgNode(); 
     	    organize255.Text="<span style='padding:4px;border:1px solid #000;'><b>sherdlock-3线surpport-te...</b></span><div style='margin:10px;'></div> ";
			organize255.Description="sherdlock-3线surpport-team";
			organize255.Link="win_255()";
			organize249.Nodes.Add(organize255);
   	        var organize281=new OrgNode(); 
     	    organize281.Text="<span style='padding:4px;border:1px solid #000;'><b>CMS产品</b></span><div style='margin:10px;'><div style='overflow:hidden;width:130px;height:24px;'>CMS</div></div> ";
			organize281.Description="CMS产品";
			organize281.Link="win_281()";
			organize135.Nodes.Add(organize281);
   	        var organize282=new OrgNode(); 
     	    organize282.Text="<span style='padding:4px;border:1px solid #000;'><b>NPS产品服务支持</b></span><div style='margin:10px;'><div style='overflow:hidden;width:130px;height:24px;'>NPS near product service 产品相关的SURPPORT</div></div> ";
			organize282.Description="NPS产品服务支持";
			organize282.Link="win_282()";
			organize135.Nodes.Add(organize282);
   	        var organize286=new OrgNode(); 
     	    organize286.Text="<span style='padding:4px;border:1px solid #000;'><b>SI大产品的集成</b></span><div style='margin:10px;'><div style='overflow:hidden;width:130px;height:24px;'>大产品之间的 si ，solution级别，未来趋势，</div></div> ";
			organize286.Description="SI大产品的集成";
			organize286.Link="win_286()";
			organize282.Nodes.Add(organize286);
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
