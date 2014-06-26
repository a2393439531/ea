<#include "include_demo_header.ftl">
<body style="padding: 10px; ">
  	<strong>按钮</strong>
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
		
			<#include "/app/common/test/bootstrap/botton.ftl">  
			
		</div>
	</div> 