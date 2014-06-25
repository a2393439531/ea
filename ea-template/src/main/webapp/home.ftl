<#include "common/freemarker/include_header.ftl">
<#include "common/freemarker/include_custom.ftl">
<body style="padding: 10px; ">
	<!--
	<a href="lang.do?lang=en" class="btn btn-sm btn-primary" style="margin:0 0 0 10px;" target="_blank">login登录数据初始化</a> 
	<span class="label label-default">在进行demo测试前，请使用帐号： xixi  密码：abc123  进行登录.</span> 
	<br>
	-->
	<div class="panel panel-default">
		<div class="panel-heading"><strong>团队开发环境</strong></div>
		<div class="panel-body">
	  		<table class="moduleDisplay">
	  			<tr>
	  				<td class="templateTitle" style="background-color:#5cb85c;">开发环境</td>
	  				<td class="templateTitle" style="background-color:#5cb85c;">技术框架</td>
	  				<td class="templateTitle" style="background-color:#5cb85c;">数据库</td>
	  				<td class="templateTitle" style="background-color:#5cb85c;">前台UI</td>
	  				<td class="templateTitle" style="background-color:#5cb85c;">源代码管理</td>
	  				<td class="templateTitle" style="background-color:#5cb85c;">项目构建工具</td>
	  				<td class="templateTitle" style="background-color:#5cb85c;">设计工具</td>
	  				<td class="templateTitle" style="background-color:#5cb85c;">项目管理</td>
	  			</tr>
	  			<tr class="templateEight">
	  				<td class="templateGreen">
	  					<ul>
  							<li><a href="#">JAVA 7.0</a></li>
  							<li><a href="#">Eclipse</a></li>
  							<li><a href="#">Jetty</a></li>
  							<li><a href="#">Tomcat</a></li>
						</ul>
	  				</td>	
	  				<td class="templateGreen">
	  					<ul>
  							<li><a href="#">Spring</a></li>
  							<li><a href="#">Struts</a></li>
  							<li><a href="#">Hiberbate</a></li>
  							<li><a href="#">Freemaker</a></li>
  							<li><a href="#" title="Workflow Engine">Activiti</a></li>
  							<li><a href="#" title="Report Engine">BIRT</a></li>
						</ul>
	  				</td>	
	  				<td class="templateGreen">
	  					<ul>
  							<li><a href="#">H2</a></li>
  							<li><a href="#">MYSQL</a></li>
						</ul>
	  				</td>	
	  				<td class="templateGreen">
	  					<ul>
  							<li><a href="#">Bootstrap</a></li>
  							<li><a href="#">Jquery</a></li>
  							<li><a href="#">Highslide</a></li>
  							<li><a href="#">CKEditor</a></li>					
						</ul>
	  				</td>	
	  				<td class="templateGreen">
	  					<ul>
  							<li><a href="#">GIT</a></li>
  							<li><a href="#">Subversion</a></li>
						</ul>
	  				</td>	
	  				<td class="templateGreen">
	  					<ul>
  							<li><a href="#">Maven</a></li>
  							<li><a href="#">Jenkins</a></li>						
						</ul>
	  				</td>	
	  				<td class="templateGreen">
	  					<ul>
  							<li><a href="#">EA 8.0</a></li>
						</ul>
	  				</td>	
	  				<td class="templateGreen">
	  					<ul>
  							<li><a href="#">Adile Strum</a></li>
  							<li><a href="#">SONAR</a></li>		
						</ul>
	  				</td>	
	  			</tr>
	  		</table>
		</div>
	</div>  
	
	<div class="panel panel-default">
		<div class="panel-heading"><strong>基础UI</strong></div>
			<div class="panel-body">
	  		<table class="moduleDisplay">
	  			<tr class="templateTen">
	  				<td class="templateOrange"><a href="app/common/test/UI_demo/UI_All.ftl" target="_blank">ALL</a></td>
	  				<td class="templateOrange"><a href="app/common/test/UI_demo/UI_navBar.ftl" target="_blank">导航</a></td>
	  				<td class="templateOrange"><a href="app/common/test/UI_demo/UI_panel.ftl" target="_blank">面板</a></td>
	  				<td class="templateOrange"><a href="app/common/test/UI_demo/UI_layout.ftl" target="_blank">布局</a></td>
	  				<td class="templateOrange"><a href="app/common/test/UI_demo/UI_label.ftl" target="_blank">标签</a></td>
	  				<td class="templateOrange"><a href="app/common/test/UI_demo/UI_demo/UI_botton.ftl" target="_blank">按钮</a></td>
	  				<td class="templateOrange"><a href="app/common/test/UI_demo/UI_icon.ftl" target="_blank">图标</a></td>
	  				<td class="templateOrange"><a href="app/common/test/UI_demo/UI_table.ftl" target="_blank">表格</a></td>
	  				<td class="templateOrange"><a href="app/common/test/UI_demo/UI_dialogBox.ftl" target="_blank">对话框</a></td>
	  				<td class="templateOrange"><a href="app/common/test/UI_demo/UI_list.ftl" target="_blank">列表</a></td>
	  				<td class="templateOrange"><a href="app/common/test/UI_demo/UI_dynamicDisplay.ftl" target="_blank">动态</a></td>
	  				<td class="templateOrange"><a href="app/common/test/UI_demo/UI_warning.ftl" target="_blank">警告</a></td>
	  				<td class="templateOrange"><a href="app/common/test/UI_demo/UI_nesting.ftl" target="_blank">嵌套</a></td>
	  			</tr>
	  		</table>
		</div>
	</div>
	
	<div class="panel panel-default">
		<div class="panel-heading"><strong>EA企业架构</strong></div>
			<div class="panel-body">
			<p>企业架构基础开发平台适合软件开发团队迅速搭建企业级应用平台,主要功能包括:组织架构管理、工作流、权限控制、日报周报、在线支持、文档管理等</p>
	  		<table class="moduleDisplay">
				<tr>   
					<td class="archiNam">开发架构</td>
					<td class="archiCon">
						<a href="common_monitor_home.do" target="_blank" class="btn btn-xs btn-default">健壮性</a>
						<a href="#" target="_blank" class="btn btn-xs btn-default">安全性</a>
						<a href="rule.ftl" target="_blank" class="btn btn-xs btn-default">后台规范</a> 
						<a href="#" target="_blank" class="btn btn-xs btn-default">UI规范</a>
						<a href="ea_ea_webservice.do" target="_blank" class="btn btn-xs btn-default">对外开放API(Webservice)</a>
					</td>  
				</tr>
				<tr>
					<td class="archiNam">手机开发架构</td>
					<td class="archiCon">
						<a  href="common_test_mobile.do" target=_blank" class="btn btn-xs btn-default">Mobile Web Framework</a>
					</td>   
				</tr>	
				<tr>
					<td class="archiNam">工作流框架</td>
					<td class="archiCon">
						<a href="ea_ea_demo_data.do" class="btn btn-xs btn-default"  target="_blank">演示数据</a>
						<a href="common_activiti_index_demo.do" target="_blank" class="btn btn-xs btn-default">ACITIVTI工作流引擎演示</a>
						<a href="" class="btn btn-xs btn-default"  target="_blank">BIRT</a> 
					</td>   
				</tr>
				<tr>
					<td class="archiNam">通用业务功能</td>
					<td class="archiCon">
						<a href="#" class="btn btn-xs btn-default" target="_blank">考试系统</a>
  						<a href="#" class="btn btn-xs btn-default" target="_blank">工作日报</a>
  						<a href="ea_smtp_menu_smtp.do" class="btn btn-xs btn-default" target="_blank">邮箱系统</a>
						<a href="ea_smtp_index_demo.do" class="btn btn-xs btn-default" target="_blank">邮件发送</a>
  						<a href="ea_rule_menu_rule.do" class="btn btn-xs btn-default" target="_blank">通告发布</a>
  						<a href="common_edit_list_file.do" class="btn btn-xs btn-default" target="_blank">多国语言配置</a>
					  	<a href="common_svn_svn_list.do" class="btn btn-xs btn-default" target="_blank">文档管理</a>
						<a href="common_chat_chat.do" class="btn btn-xs btn-default" target="_blank">在线支持</a>
					</td>   
				</tr>
		</table>
		</div>
	</div>
	
	<div class="panel panel-default">
		<div class="panel-heading"><strong>业务公共模块矩阵</strong></div>
			<div class="panel-body">
			<p>业务开发中会经常需要重复使用的公共模块，统一管理规划。</p>
	  		<table class="moduleDisplay">
				<tr>   
					<td class="pubModuNam">组织架构操作</td>
					<td class="pubModuCon"><a href="common_test_select_user.do" target="_blank" class="btn btn-xs btn-default">选人</a> 
						<a href="common_test_date.do" target="_blank" class="btn btn-xs btn-default">如何获取当前用户的项目ID 公司ID</a>
					</td>  
				</tr>
				<tr>
					<td class="pubModuNam">添加删除</td>
					<td class="pubModuCon">
						<a href="manager_tpltb1_menu_tpltb1.do" target="_blank" class="btn btn-xs btn-default">table-ajax模式</a> 
						<a href="manager_tpltb3_list.do" target="_blank" class="btn btn-xs btn-default">table-传统添加删除</a> 
						<a href="manager_tpltb2_menu_tpltb2.do" target="_blank" class="btn btn-xs btn-default">table-对话框模式</a> 
						<a href="manager_tpltree1_menu_tpltree1.do" target="_blank" class="btn btn-xs btn-default">tree-crud-ajax模式</a> 
					</td>   
				</tr>
			    <tr>
			    	<td class="pubModuNam">数据词典的使用</td> 
			    	<td class="pubModuCon">
			    		<a href="common_test_menu_para.do" target="_blank" class="btn btn-xs btn-default">数据词典</a>
			    	</td>
			   	</tr>
			    <tr>
			    	<td class="pubModuNam">文件上传</td>
			    	<td class="pubModuCon">
			    		<a href="common_test_upload.do" target="_blank" class="btn btn-xs btn-default">文件上传</a>  
			    		<a href="common_test_upload.do" target="_blank" class="btn btn-xs btn-default">图片上传</a>
			    	</td>
			    </tr>
			    <tr>
			    	<td class="pubModuNam">编辑组件</td>
			    	<td class="pubModuCon">
			    		<a href="common_test_ckeditor.do" target="_blank" class="btn btn-xs btn-default">Ckedit</a>  
			    		<a href="common_test_upload.do" target="_blank" class="btn btn-xs btn-default">boostrap</a>
			    	</td>
			   	</tr>
			    <tr>
			    	<td class="pubModuNam">弹出框&对话框</td>
			    	<td class="pubModuCon">
			    		<a href="common_test_upload.do" target="_blank" class="btn btn-xs btn-default">DIV层</a>
			            <a href="common_test_dialog_bootstrap.do" target="_blank" class="btn btn-xs btn-default">boostrap-dialog</a>
			            <a href="common_test_dialog_jquery.do" target="_blank" class="btn btn-xs btn-default">jqeury-dialog</a>
			            <a href="common_test_upload.do" target="_blank" class="btn btn-xs btn-default">boostrap-dialog(不同action)</a>
			        </td>
			    </tr>
		        <tr>
		        	<td class="pubModuNam">提交时间过长处理，解决表单重复提交</td>
		        	<td class="pubModuCon">
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
			    </tr>
			    <tr>
			    	<td class="pubModuNam">div的显示</td>
			        <td class="pubModuCon">     
			        	<a href="common_test_div.do" target="_blank"" class="btn btn-xs btn-default">隐藏&拖动定位显示</a>
			            <a href="common_test_div.do" target="_blank"" class="btn btn-xs btn-default">鼠标下方显示</a>
			        </td>
			    </tr>
			    <tr>
					<td class="pubModuNam">树形组件</td>
					<td class="pubModuCon"><#include "app/common/test/jquery/ztree.ftl"></td>   
				</tr>	
		</table>
		</div>
	</div>
	
</div>   
</body>
</html>




