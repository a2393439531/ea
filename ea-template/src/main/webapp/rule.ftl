
<#include "common/freemarker/include_header.ftl">
<body style="padding: 10px; ">


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




