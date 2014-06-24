<#include "common/freemarker/include_header.ftl">
<body style="padding: 10px; ">
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
</body>