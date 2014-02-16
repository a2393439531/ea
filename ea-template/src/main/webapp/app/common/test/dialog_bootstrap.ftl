<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" >
 $('#myModal').modal('show')  
</script>


<a data-toggle="modal" href="http://www.baidu.com" data-target="#modal">Click me</a>



<button class="btn btn-primary " data-toggle="modal" data-target="#myModal">启动对话框</button>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
                                      内容体
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<button class="btn btn-primary" data-toggle="modal" data-target=".bs-modal-lg">Large modal</button>

<div class="modal fade bs-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
                                      内容体
      </div>
    </div>
  </div>
</div>

<!-- Small modal -->
<button class="btn btn-primary" data-toggle="modal" data-target=".bs-modal-sm">Small modal</button>

<div class="modal fade bs-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
	      </div>
	      <div class="modal-body">
	                                      内容体
	      </div>
    </div>
  </div>
</div>



