<#include "include_demo_header.ftl">
<body style="padding: 10px; ">
	<strong>警告信息</strong><br>
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
</body>


