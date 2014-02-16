
<#include "common/freemarker/include_header.ftl">
<body style="padding: 10px; ">
<a href="login.ftl"  class="btn btn-sm btn-primary" target=_blank>login登录数据初始化</a>
<br>
	<div class="panel panel-default">
		<div class="panel-heading"><strong>项目说明</strong></div>
		<div class="panel-body">
			<p>企业架构基础开发平台,主要功能包括:
			   <br>企业组织架构管理、工作流、权限控制、报表引擎等
	           <br>本项目适合软件开发团队迅速搭建企业级应用平台.
	           <a href="ea_ea_demo_data.do" target=_blank>演示数据</a>
	  		</p>
			</div>
		</div>
	</div>   
	
	<div class="panel panel-default">    
		<div class="panel-heading"><strong>业务公共模块矩阵</strong></div>
		<div class="panel-body">
			<p>我们平时在开发中会经常通用的界面场景，本表进行一个说明，进行统一规划管理。
			</p>
			</div>
			<!-- Table -->
			<table class="table">
			    <thead>
				    <tr>
				        <th>场景demo</th>
				    </tr>
			    </thead>
			  	<tbody>
					<tr>
					    <td>组织架构操作： <a href="common_test_select_user.do" target=_blank>选人</a> 
					        <a href="common_test_date.do" target=_blank>如何获取当前用户的项目ID 公司ID</a>
					    </td>
					   
					</tr>
				<tr>
					    <td>树形组件：
					      <#include "app/common/test/jquery/ztree.ftl">
					    </td>
					   
					</tr>	
					<tr>
					    <td>添加删除：
					      <a href="manager_tpltb1_menu_tpltb1.do" target="_blank">table-ajax模式</a> 
						  <a href="manager_tpltb3_list.do" target="_blank">table-传统添加删除</a> 
						  <a href="manager_tpltb2_menu_tpltb2.do" target="_blank">table-对话框模式</a> 
						   <a href="manager_tpltree1_menu_tpltree1.do" target="_blank">tree-crud-ajax模式</a> 
					    </td>
					   
					</tr>
			        <tr><td>数据词典的使用： <a href="common_test_menu_para.do" target=_blank>数据词典</a></td></tr>
			        
			        <tr><td>文件上传：<a href="common_test_upload.do" target=_blank>文件上传</a>  <a href="common_test_upload.do" target=_blank>图片上传</a></tr>
			        
			        <tr><td>编辑组件：<a href="common_test_upload.do" target=_blank>Ckedit</a>  <a href="common_test_upload.do" target=_blank>boostrap</a></td></tr>
			        
			        <tr><td>弹出框&对话框：<a href="common_test_upload.do" target=_blank>DIV层</a>
			                       <a href="common_test_dialog_bootstrap.do" target=_blank>boostrap-dialog</a>
			                      <a href="common_test_dialog_jquery.do" target=_blank>jqeury-dialog</a>
			                      <a href="common_test_upload.do" target=_blank>boostrap-dialog(不同action)</a>
			            </td>
			        </tr>
	
		        <tr><td>提交时间过长处理：
			            <button id="loading-example-btn" type="button" class="btn btn-xs btn-primary" data-loading-text="正在请求数据...">...</button>
						<script>
						  $('#loading-example-btn').click(function () {
						    var btn = $(this);
						    btn.button('loading');
							//$.ajax(...).always(function () {
							//      btn.button('reset');
							//    });

						  });
						</script>
			          </td>
		
			        <tr><td>健壮性&安全性：
			              <a  href="https://code.google.com/p/javamelody/wiki/UserGuide" target=_blank">健壮性</a>
			              <a  href="https://code.google.com/p/javamelody/wiki/UserGuide" target=_blank">SSL</a>
 			            </td>
			        </tr>		        

			        <tr><td>div的显示：
			              <a href="common_test_div.do" target=_blank">隐藏&拖动定位显示</a>
			              <a href="common_test_div.do" target=_blank">鼠标下方显示</a>

			           </td>
			        </tr>		        

			  	</tbody>
			</table>
		</div>
	</div>   

	<div class="panel panel-default">
		<div class="panel-heading"><strong>WEB项目代码架构规范</strong></div>
		<div class="panel-body">
			<pre>
				【ea-core】基础公共模块项目
				├── src/main/java/com <button type="button" class="btn btn-xs btn-warning">公共模块目录架构</button>
				│   ├──app
				│   ├───├─common<button type="button" class="btn btn-xs btn-default">通用界面功能模块目录</button>
				│   ├───├─ea          
				│   ├──utils<button type="button" class="btn btn-xs btn-default">通用工具类目录</button>
				
				【ea-template】 业务项目工程 依赖于基础公共模块项目ea-core
				├── src/main/java/com <button type="button" class="btn btn-xs btn-warning">后台代码架构</button>
				│   ├──app
				│   ├───├─manager
				│   ├─────────├─action
				│   ├─────────├─init
				│   ├─────────├─model
				├── src/webapp <button type="button" class="btn btn-xs btn-warning">前台代码架构</button>
				│   ├── app/common <button type="button" class="btn btn-xs btn-default">通用前台框架组件</button>
				│   ├── app/ea <button type="button" class="btn btn-xs btn-info">系统模块 EA的前台模块</button>
				│   ├── app/manager/  <button type="button" class="btn btn-xs btn-info">系统模块 manger的前台代码</button>
				│   ├────────────├─mode<button type="button" class="btn btn-xs btn-success">表名</button>
				│   ├────────────├────├─way.ftl<button type="button" class="btn btn-xs btn-danger">方法名.ftl</button>
				│   ├────────────├────├─way.ftl<button type="button" class="btn btn-xs btn-danger">方法名.ftl</button>
				│   ├────────────├────├─way.ftl<button type="button" class="btn btn-xs btn-danger">方法名.ftl</button>
				│   ├────────────├─mode<button type="button" class="btn btn-xs btn-success">表名</button>
				│   ├────────────├─...
				
				
				<br><strong>web应用开发的本质： 接受http请求（action）返回结果： </strong>
				1.用户在浏览器输入url
				2.服务器端根据URL解析出下面信息：执行 哪个JAVA类的哪个方法进行计算，用那个结果页面进行
				3.浏览器通过结果页面显示计算结果，反馈给客户信息
				例如：ea_organize_index.do
				ea_organize_index.do
				<button type="button" class="btn btn-xs btn-info">ea模块</button>_<button type="button" class="btn btn-xs btn-success">organize类</button>_<button type="button" class="btn btn-xs btn-danger">index方法名</button>
				
				 
				struts-common.xml 的关键定义：
				${'<action name="*_*_*"   class="{2}Action"  method="{3}" >
				    <result name="success">app/{1}/{2}/{3}.ftl</result>
				 </action> 
				 '?html}
				 {1}<button type="button" class="btn btn-xs btn-info">模块名</button>_{2}<button type="button" class="btn btn-xs btn-success">表名</button>_{3}<button type="button" class="btn btn-xs btn-danger">方法名</button>
			
				
			 </pre>  
			</div>
		</div>
	</div>   



	<div class="panel panel-default">
	<div class="panel-heading"><strong>前台公共模块矩阵</strong></div>
	<div class="panel-body">
		<p>前台主要使用比较轻量级UI和插件，好处是修改升级更换比较方便，但缺点是滥用比较难以管理，本矩阵表格可以记录各前台组件的场景和版本。
		                            主风格框架选择Boostrap，利用Boostrap开发者可以节省大量的时间修复跨浏览器布局问题，实现各种形式的Web界面
		</p>
		</div>
		<!-- Table -->
		<table class="table">
		    <thead>
			    <tr>
			        <th>场景</th><th>jquery</th> <th>bootrap</th><th>highslide</th><th>ckeditor</th><th>My97DatePicker</th>
			    </tr>
		    </thead>
		  	<tbody>
		        <tr><td>官网&版本</td>
		      	  	<td><a href="http://jqueryui.com/draggable/" target=_blank>jquery-1-10-2，juqeryui-1-10-3</a></td>
		      	  	<td><a href="http://getbootstrap.com/getting-started/" target=_blank>bootstrap303</a>
		      	        <a href="http://bootsnipp.com" target=_blank>bootsnipp.com</a>
		      	        <a href="http://aozora.github.io/bootmetro/" target=_blank>win8风格</a>
		      	 	    <a href="http://www.chinaz.com/design/2013/0726/310899.shtml" target=_blank>扩展</a>
		      	    </td> 
		      	    <td><a href="http://www.highslide.com/" target=_blank>highslide-4-1-13 </a></td>
		      	    <td><a href="http://www.ckeditor.com//" target=_blank>ckeditor363 </a></td>
		      	    <td>no version</td>
		      	</tr>
		        <tr><td>ajax,拖拽层效果</td><td><span class="glyphicon glyphicon-ok"/></td><td></td> <td></td><td></td><td></td></tr>
		        <tr><td>基本的样式风格</td><td></td><td><span class="glyphicon glyphicon-ok"/></td> <td></td><td></td><td></td></tr>
		        <tr><td>弹出窗体</td><td></td><td></td><td><span class="glyphicon glyphicon-ok"/></td><td></td><td></td></tr>
		        <tr><td><a href="common_test_date.do" target=_blank>日期选择框</a></td><td></td><td></td><td></td><td></td><td><span class="glyphicon glyphicon-ok"/></td></tr>
		        <tr><td>文本编辑</td><td></td><td></td><td></td><td><span class="glyphicon glyphicon-ok"/></td><td></td></tr>
		        <tr><td>dialog对话框</td><td><a href="common_test_dialog.do" target=_blank>jqurey</a>></td><td></td><td></td><td></td><td></td></tr>
	           <tr><td><a href="app/common/test/bootstrap/stick.ftl" target=_blank title="如果有使用hs弹出窗口，就不适合使用，会被遮挡">顶部固定效果【用来做页头页尾】</a></td><td></td><td><span class="glyphicon glyphicon-ok"/></td> <td></td><td></td><td></td></tr>
		        
			  	</tbody>
			</table>
		</div>
	</div>    


		        

<strong>面板</strong>
      <table>
         <tr>
           <td width=300px valign=top>
		         <div class="panel panel-default">
		            <div class="panel-heading">
		              <h3 class="panel-title">Panel title</h3>
		            </div>
		            <div class="panel-body">
		              Panel content
		            </div>
		          </div>
		       
		          <div class="panel panel-primary">
		            <div class="panel-heading">
		              <h3 class="panel-title">Panel title</h3>
		            </div>
		            <div class="panel-body">
		              Panel content
		            </div>
		          </div>           
  	      </td>
          <td width=500px valign=top>

	          <div class="panel panel-success">
	            <div class="panel-heading">
	              <h3 class="panel-title">Panel title</h3>
	            </div>
	            <div class="panel-body">
	              Panel content
	            </div>
	          </div>
	          <div class="panel panel-info">
	            <div class="panel-heading">
	              <h3 class="panel-title">Panel title</h3>
	            </div>
	            <div class="panel-body">
	              Panel content
	            </div>
	          </div>

          </td>
		</tr>
   </table>
<br> 
<pre>
${'
      <div class="panel panel-default">
       
        <div class="panel-heading"><strong>标题</strong></div>
        <div class="panel-body">
          <p>摘要说明</p>
        </div>
      </div>
  '?html} 
  </pre>


<br><strong>底色标签</strong><br>  

<span class="label label-default">Default</span>
<span class="label label-primary">Primary</span>
<span class="label label-success">Success</span>
<span class="label label-info">Info</span>
<span class="label label-warning">Warning</span>
<span class="label label-danger">Danger</span>
${'<span class="label label-primary">Primary</span>'?html} 

<br><strong>图标</strong><br>
<pre>
${'     <span class="glyphicon glyphicon-adjust"></span>
        <span class="glyphicon-class">adjust</span>
'?html} 
</pre>
    

<#include "app/common/test/bootstrap/ico.ftl">


	<div class="panel panel-default">
		<div class="panel-heading"><strong>按钮</strong></div>
		<div class="panel-body">
			代码参考
			<br> *.普通按钮${'<button type="button" class="btn btn-xs btn-danger">Default</button>'?html}
			<br> *.普通标签 ${'<span class="label label-success">Default</span>'?html}
			<br> *.大小设置：default，lg, sm,xs
			<br> *.颜色设置：default , primary ,success, warning ,info ,danger
			<br> *.按钮工具条
			<pre>
			${'
			      <div class="btn-toolbar " role="toolbar">
			        <div class="btn-group ">
			          <button type="button" class="btn btn-xs  btn-default"><span class="glyphicon glyphicon-align-left"></span></button>
			          <button type="button" class="btn btn-xs  btn-default"><span class="glyphicon glyphicon-align-center"></span></button>
			          <button type="button" class="btn btn-xs  btn-default"><span class="glyphicon glyphicon-align-right"></span></button>
			          <button type="button" class="btn btn-xs  btn-default"><span class="glyphicon glyphicon-align-justify"></span></button>
			        </div>
			      </div>
			 '?html} 
			 </pre>   
			<br> *.按钮-符合父的大小
			 <pre>
			${'     
			      <div class="well" style="max-width: 300px; margin: 0 auto 10px;">
			        <button type="button" class="btn btn-primary btn-xs btn-block">Block level button</button>
			        <button type="button" class="btn btn-default btn-xs btn-block">Block level button</button>
			      </div>
			  '?html} 
			 </pre> 
		
			<#include "app/common/test/bootstrap/botton.ftl">  
			
		</div>
	</div> 



<br><strong>table</strong><br>
      .table-condensed：紧凑 table-striped:隔行底色不同      table-hover：鼠标移动选择行  table-bordered:网格
<pre>
${'
 <table class="table table-condensed table-bordered table-striped ">
 <div class="table-responsive"> 表格自动响应 ，    当屏幕宽度缩小时，表格可以出现滚动条（IE9在frame下不支持）

  '?html} 
  
    </pre>
    
  
  
<#include "app/common/test/bootstrap/table.ftl">
 
      
<br><strong>排版布局</strong><br>
<#include "app/common/test/bootstrap/grid.ftl">


<br><strong>导航</strong><br>
<#include "app/common/test/bootstrap/nav.ftl">
<br><strong>对话框</strong><br>
<#include "app/common/test/bootstrap/model.ftl">

<br><strong>3.引用</strong><br> 
 	 <div class="row">
	  <blockquote class="pull-left">
		  <div >
		    EA企业架构
		        <small>version: beta-xxx</small> 
		  </div>
	  </blockquote>   
	  </div> 


  
<strong>5.列表</strong>
  	<div class="bs-example">
      <dl>
        <dt>Description lists</dt>
        <dd>换行的描述is perfect for defining terms.</dd>
        <dt>Euismod</dt>
        <dd>Vestibulum id ligula porta felis euismod semper eget lacinia odio sem nec elit.</dd>
        <dd>Donec id elit non mi porta gravida at eget metus.</dd>
      </dl>
    </div>
  
     <div class="bs-example">
      <dl class="dl-horizontal">
        <dt>Description lists</dt>
        <dd>同行注释 ，无需用table来进行排版is perfect for defining terms.</dd>
        <dt>Euismod</dt>
        <dd>Vestibulum id ligula porta felis euismod semper eget lacinia odio sem nec elit.</dd>
        <dd>Donec id elit non mi porta gravida at eget metus.</dd>
        <dt>Malesuada porta</dt>
        <dd>Etiam porta sem malesuada magna mollis euismod.</dd>
      </dl>
    </div>
  
	<ul>
  	    <li>竖向</li>
	    <li>首页</li>
	    <li>about</li>
	</ul>
	   
	<ul class="list-inline">
	  <li>横向</li>
	  <li>首页</li>
	   <li>about</li>
	</ul>	   
	   
    <div class="bs-example">
      <ol>
        <li>有序列号列表</li>
        <li>Consectetur adipiscing elit</li>
        <li>Integer molestie lorem at massa</li>
      </ol>
    </div>  
    

    
<strong>7.input输入框</strong>
    
    <div class="input-group input-group-sm">
	  <span class="input-group-addon">$</span>
	  <input type="text" class="form-control ">
	  <span class="input-group-addon">.00</span>
	</div>
    
    <br>
<input class="form-control input-lg" type="text" placeholder=".input-lg">
<input class="form-control" type="text" placeholder="Default input">
<input class="form-control input-sm" type="text" placeholder=".input-sm">  
      
 <div class="row">
  <div class="col-xs-2">
    <input type="text" class="form-control" placeholder=".col-xs-2">
  </div>
  <div class="col-xs-3">
    <input type="text" class="form-control" placeholder=".col-xs-3">
  </div>
  <div class="col-xs-4">
    <input type="text" class="form-control" placeholder=".col-xs-4">
  </div>
</div>     

<strong>下拉菜单</strong>

    <div class="bs-example">
      <div class="dropdown clearfix">
        <button class="btn dropdown-toggle sr-only" type="button" id="dropdownMenu1" data-toggle="dropdown">
          Dropdown
          <span class="caret"></span>
        </button>
        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
           <li role="presentation" class="dropdown-header">标题</li>
          <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Action</a></li>
          <li role="presentation" class="disabled"><a role="menuitem" tabindex="-1" href="#">无效Disabled link</a></li>
          <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Another action</a></li>
          <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Something else here</a></li>
          <li role="presentation" class="divider"></li>
          <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Separated link</a></li>
        </ul>
      </div>
    </div><!-- /example -->

<br><strong>8.form表单(ie9不正常)</strong><br>
<form class="navbar-form navbar-left" role="search">
  <div class="form-group">
    <input type="text" class="form-control" placeholder="Search">
  </div>
  <button type="submit" class="btn btn-default">Submit</button>
</form>

<br><br>
<br><strong>动态显示的状态数据</strong><br>

   <div class="bs-example">
      <ul class="nav nav-pills">
        <li class="active"><a href="#">Home <span class="badge">42</span></a></li>
        <li><a href="#">Profile</a></li>
        <li><a href="#">Messages <span class="badge">3</span></a></li>
      </ul>
      <br>
      <ul class="nav nav-pills nav-stacked" style="max-width: 260px;">
        <li class="active">
          <a href="#">
            <span class="badge pull-right">42</span>
            Home
          </a>
        </li>
        <li><a href="#">Profile</a></li>
        <li>
          <a href="#">
            <span class="badge pull-right">3</span>
            Messages
          </a>
        </li>
      </ul>
      <br>
      <button class="btn btn-primary" type="button">
        Messages <span class="badge">4</span>
      </button>
    </div>





<br><strong>8.警告信息</strong><br>
${' <div class="alert alert-success"> <strong>Well done!</strong> </div>'?html}
  <div class="bs-example">
      <div class="alert alert-success">
        <strong>Well done!</strong> You successfully read <a href="#" class="alert-link">this important alert message</a>.
      </div>
      <div class="alert alert-info">
        <strong>Heads up!</strong> This <a href="#" class="alert-link">alert needs your attention</a>, but it's not super important.
      </div>
      <div class="alert alert-warning">
        <strong>Warning!</strong> Best check yo self, you're <a href="#" class="alert-link">not looking too good</a>.
      </div>
      <div class="alert alert-danger">
        <strong>Oh snap!</strong> <a href="#" class="alert-link">Change a few things up</a> and try submitting again.
      </div>
  </div>
   
	<div class="alert alert-warning alert-dismissable">
	  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	  <strong>Warning!</strong> Best check yo self, you're not looking too good.
	</div>
	
	
<br><strong>8.嵌套背景</strong><br>
	
	<div class="bs-example">
      <div class="well">
        Look, I'm in a well!
      </div>
 
       <div class="well well-lg">
        Look, I'm in a large well!
      </div>
       <div class="well well-sm">
        Look, I'm in a small well!
      </div>          
      
    </div>



<br><strong>bootsrap官方的标准模板</strong><br>

<pre>
${ '<!DOCTYPE html>
<html>
  <head>
    <title>Bootstrap 101 Template</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">


    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
    <h1>Hello, world!</h1>


    <script src="https://code.jquery.com/jquery.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>

'?html}
</pre>

<br><strong>EA官方的网页标准模板</strong><br>

<pre>
${ '<!DOCTYPE html>
<html>
  <head>
    <title>Bootstrap 101 Template</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="<@context/>common/bootstrap303/css/bootstrap.min.css" rel="stylesheet">
		<link href="<@context/>common/bootstrap303/css/docs.css" rel="stylesheet">
		<link href="<@context/>common/bootstrap303/css/pygments-manni.css" rel="stylesheet">
		<script src="<@context/>common/jquery-1-10-2/jquery.min.js"></script> 
		<script type="text/javascript" src="<@context/>common/juqeryui-1-10-3/jquery-ui.js"></script>
		
		<script src="<@context/>common/bootstrap303/js/bootstrap.js"></script>
		
		<!--[if lt IE 9]><script src="<@context/>common/bootstrap303/js/ie8-responsive-file-warning.js"></script><![endif]-->
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		  <script src="<@context/>common/bootstrap303/js/html5shiv.js"></script>
		  <script src="<@context/>common/bootstrap303/js/respond.min.js"></script>
		<![endif]-->
  </head>
  <body>
    <h1>Hello, world!</h1>


    <script src="https://code.jquery.com/jquery.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>

'?html}
</pre>




</body>
</html>




