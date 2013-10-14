<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>smtp.js"></script>
<div class="row" style="padding-left:5px">
	<div class="span5">
	  <a class="btn btn-primary"  onclick="javascript:action_smtp('create.do','');">添加</a>
	</div>
	<#include "ajax_smtp.ftl">
	
</div>
</body>
<#---->
<hr>
<footer>
	<p>&copy; Company 2013</p>
</footer>

