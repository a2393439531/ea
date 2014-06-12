
<#include "common/freemarker/include_header.ftl">
<body style="padding: 10px; ">
&nbsp;&nbsp;&nbsp;<a href="lang.do?lang=en"  class="btn btn-sm btn-primary" target=_blank>login登录数据初始化</a> 

	<span class="label label-success">在进行demo测试前，请使用帐号： xixi  密码：abc123  进行登录.</span> 
<br>
	<div class="panel panel-default">
		<div class="panel-heading"><strong>项目说明</strong></div>
		<div class="panel-body">
			<p>企业架构基础开发平台适合软件开发团队迅速搭建企业级应用平台,主要功能包括:组织架构管理、工作流、权限控制、日报周报、在线支持、文档管理等
			 <br> <br>  
	         <a href="ea_ea_demo_data.do" target=_blank class="btn btn-xs btn-default">演示数据</a>
	         <a href="common_activiti_index_demo.do" target=_blank class="btn btn-xs btn-default">工作流</a>
	         <a href="ea_ea_webservice.do" target=_blank class="btn btn-xs btn-default">webservice访问接口</a>
	         <a href="rule.ftl" target=_blank class="btn btn-xs btn-default">开发规范</a>
  			 <a  href="common_monitor_home.do" target=_blank" class="btn btn-xs btn-default" title="https://code.google.com/p/javamelody/wiki/UserGuide">健壮性</a>
			 <a  href="" target=_blank" class="btn btn-xs btn-default">安全性</a>	           
	          <a  href="common_test_zxing.do" target=_blank" class="btn btn-xs btn-default">二维码</a>	    
              <a  href="common/appframework-2-1-0" target=_blank" class="btn btn-xs btn-default">appframework-2-1-0</a>
               <a  href="common/appframework-2-1-0/tom.html" target=_blank" class="btn btn-xs btn-default">appframework-2-1-0测试</a>
	         <a  href="app/common/test/mobile/jquerymobile/index.ftl" target=_blank" class="btn btn-xs btn-default">Jquery Mobile</a>
			 <a  href="app/common/test/mobile/jqm_index.ftl" target=_blank" class="btn btn-xs btn-default">Jquery Mobile</a>
			 
			 <a  href="app/common/test/mobile/af_index.ftl" target=_blank" class="btn btn-xs btn-default">JQmobi</a>
			 <a  href="app/common/test/mobile/touchdemo/index.ftl" target=_blank" class="btn btn-xs btn-default">Sencha touch</a>	 
	  		</p>
			</div>
		</div>
	</div>   
	
	<div class="panel panel-default">    
		<div class="panel-heading"><strong>业务系统</strong></div>
		<div class="panel-body">
			<strong>1. 考试系统</strong><br/>
				&nbsp;&nbsp;&nbsp;&nbsp;a). 生成试卷分为两种方式：通过在线生成模板和导入题目excel<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;b). 通过Excel导入题型。导入题型后，会默认以文件名来新建模板(所有题目会被添加为必做题并且不会有随机题)和试卷。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;c). 在线定义模板，包括模板名称、模板知识领域、必做和随机的各类题型。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;d). 在线定义试卷，首先选定模板，然后定义各类题型的分数、知识领域、考试时间、通过分。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;e). 能够在线分配试卷给用户考试。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;f). 能够在线定义试卷组，当用户所答的分数大于试卷组中试卷所定义的通过分，则系统会继续拿出试卷组中的下一张试卷来开始作答。否则考试结束。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;g). 能够在线答题，可以选择一次整张作答和一题一题作答，前者需要回答完毕并且提交，才有分数。后者每做一题则计算一次分数，可以中途退出，然后继续做，和试卷组概念挂钩。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;h). 能够在线阅卷，当所分配的试卷是含有填空和主观题的时候，系统并不会自动判卷，需要人工来进行打分。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;i). 能够查询考试的历史，结果根据试卷来分类，倒叙排序，即，最近一次考试成绩会排在最上面。<br/>
			<strong>2. 手机端任务悬赏系统</strong><br/>
			<a href="ea_app_show_scope.do" target=_blank class="btn btn-xs btn-default">显示势力范围ea_app_show_scope.do</a>
			<a href="ea_view_picture_organize_v.do?show=user" target=_blank class="btn btn-xs btn-default">部门地位ea_app_show_scope.do</a>
			<a href="ea_app_show_power.do?img=yes&width=50&height=80" target=_blank class="btn btn-xs btn-default">江湖地位ea_app_show_power.do?img=yes&width=50&height=80</a>
			<a href="ea_app_show_power.do?img=no" target=_blank class="btn btn-xs btn-default">江湖地位(无照片)ea_app_show_power.do?img=no</a>

		</div>
	</div>
	
	<div class="panel panel-default">    
		<div class="panel-heading"><strong>业务公共模块矩阵</strong></div>
		<div class="panel-body">
			<p>业务开发中会经常需要重复使用的公共模块，统一管理规划。
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
					    <td>组织架构操作： <a href="common_test_select_user.do" target=_blank class="btn btn-xs btn-default">选人</a> 
					        <a href="common_test_date.do" target=_blank class="btn btn-xs btn-default">如何获取当前用户的项目ID 公司ID</a>
					    </td>
					   
					</tr>
				<tr>
					    <td>树形组件：
					      <#include "app/common/test/jquery/ztree.ftl">
					    </td>
					   
					</tr>	
					<tr>
					    <td>添加删除：
					      <a href="manager_tpltb1_menu_tpltb1.do" target="_blank" class="btn btn-xs btn-default">table-ajax模式</a> 
						  <a href="manager_tpltb3_list.do" target="_blank" class="btn btn-xs btn-default">table-传统添加删除</a> 
						  <a href="manager_tpltb2_menu_tpltb2.do" target="_blank" class="btn btn-xs btn-default">table-对话框模式</a> 
						   <a href="manager_tpltree1_menu_tpltree1.do" target="_blank" class="btn btn-xs btn-default">tree-crud-ajax模式</a> 
					    </td>
					   
					</tr>
			        <tr><td>数据词典的使用： <a href="common_test_menu_para.do" target=_blank class="btn btn-xs btn-default">数据词典</a></td></tr>
			        
			        <tr><td>文件上传：<a href="common_test_upload.do" target=_blank class="btn btn-xs btn-default">文件上传</a>  <a href="common_test_upload.do" target=_blank class="btn btn-xs btn-default">图片上传</a></tr>
			        
			        <tr><td>编辑组件：<a href="common_test_ckeditor.do" target=_blank class="btn btn-xs btn-default">Ckedit</a>  <a href="common_test_upload.do" target=_blank class="btn btn-xs btn-default">boostrap</a></td></tr>
			        <tr><td>除去文本中的html标签: String noHtmlContent = content.replaceAll("<[^>]*>",""); </td></tr>
			        <tr><td>弹出框&对话框：<a href="common_test_upload.do" target=_blank class="btn btn-xs btn-default">DIV层</a>
			                       <a href="common_test_dialog_bootstrap.do" target=_blank class="btn btn-xs btn-default">boostrap-dialog</a>
			                      <a href="common_test_dialog_jquery.do" target=_blank class="btn btn-xs btn-default">jqeury-dialog</a>
			                      <a href="common_test_upload.do" target=_blank class="btn btn-xs btn-default">boostrap-dialog(不同action)</a>
			            </td>
			        </tr>
	
		        <tr><td>提交时间过长处理，解决表单重复提交：
		        1.按钮失效
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
						&nbsp;
						2. <a href="common_test_waitexe.do" ">显示等待页面execAndWait拦截器</a>
						3.struts.token拦截器
			          </td>
		
			                

			        <tr><td>div的显示：
			              <a href="common_test_div.do" target=_blank" class="btn btn-xs btn-default">隐藏&拖动定位显示</a>
			              <a href="common_test_div.do" target=_blank" class="btn btn-xs btn-default">鼠标下方显示</a>

			           </td>
			        </tr>		        

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
	<pre>代码：
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

	<br><br>
	<pre>代码：
	${'<span class="label label-primary">Primary</span>'?html} 
	</pre>
	
	
	
	<br><strong>图标</strong><br>
    <#include "app/common/test/jquery/ico.ftl">	 	
	<pre>代码
	${"<span class=ui-icon ui-icon-carat-1-e></span>"?html}
	</pre>
 
  	<br><strong>按钮</strong><br>
	<div class="panel panel-default">
		<div class="panel-heading"><strong>按钮</strong></div>
		<div class="panel-body">
		
        <a href=#  class="btn btn-xs btn-default">连接</a>
        <button type="button" class="btn btn-xs btn-default">Default</button>
        <button type="button" class="btn btn-xs btn-primary">primary-Primary</button>
        <button type="button" class="btn btn-xs btn-success">Success</button>
        <button type="button" class="btn btn-xs btn-info">Info</button>
        <button type="button" class="btn btn-xs btn-warning">Warning</button>
        <button type="button" class="btn btn-xs btn-danger">Danger</button>
        <button type="button" class="btn btn-xs btn-link">Link</button>		
		<br> 	代码参考
			<br> *.普通按钮${'<button type="button" class="btn btn-xs btn-danger">Default</button>'?html}
			<br> *.普通标签 ${'<span class="label label-success">Default</span>'?html}
			<br> *.大小设置：default，lg, sm,xs
			<br> *.颜色设置：default , primary ,success, warning ,info ,danger
			<br> *.按钮工具条
			<pre>
			${'
	        <a href=#  class="btn btn-xs btn-default">连接</a>
	        <button type="button" class="btn btn-xs btn-default">Default</button>
	        <button type="button" class="btn btn-xs btn-primary">primary-Primary</button>
	        <button type="button" class="btn btn-xs btn-success">Success</button>
	        <button type="button" class="btn btn-xs btn-info">Info</button>
	        <button type="button" class="btn btn-xs btn-warning">Warning</button>

			 '?html} 
			 </pre>   
			<br> *.按钮-符合父的大小
    
			      <div class="well" style="max-width: 200px; margin: 0 auto 10px;">
			        <button type="button" class="btn btn-primary btn-xs btn-block">Block level button</button>
			        <button type="button" class="btn btn-default btn-xs btn-block">Block level button</button>
			      </div>
						
			
			 <pre>代码
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



<br><strong>table表格</strong><br>
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


<br><br><strong>导航</strong><br>
<#include "app/common/test/bootstrap/nav.ftl">
<br><strong>对话框</strong><br>
<#include "app/common/test/bootstrap/model.ftl">


<#--
<br><strong>3.引用</strong><br> 
 	 <div class="row">
	  <blockquote class="pull-left">
		  <div >
		    EA企业架构
		        <small>version: beta-xxx</small> 
		  </div>
	  </blockquote>   
	  </div> 

-->
  <br>
<strong>5.列表</strong>

   <#---
  	<div class="bs-example">
      <dl>
        <dt>Description lists</dt>
        <dd>换行的描述is perfect for defining terms.</dd>
        <dt>Euismod</dt>
        <dd>Vestibulum id ligula porta felis euismod semper eget lacinia odio sem nec elit.</dd>
        <dd>Donec id elit non mi porta gravida at eget metus.</dd>
      </dl>
    </div>
  -->
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
  <#--
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
    
-->


   <#--   
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
    </div>
   -->
   <#--
<br><strong>8.form表单(ie9不正常)</strong><br>
<form class="navbar-form navbar-left" role="search">
  <div class="form-group">
    <input type="text" class="form-control" placeholder="Search">
  </div>
  <button type="submit" class="btn btn-default">Submit</button>
</form>
   -->
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





<br><strong>警告信息</strong><br>
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
	
	
<br><strong>嵌套背景</strong><br>
	
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








   
<#--不兼容IE9的部分
<#include "app/common/test/bootstrap/ico.ftl">
	${'     <span class="glyphicon glyphicon-adjust"></span>
	        <span class="glyphicon-class">adjust</span>
	'?html} 
-->



</body>
</html>




