<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>extp.js"></script>
<p>本界面模式适合一些配置信息的增加删除修改，因为操作维护比较方便， 但缺乏查询等功能</p>
<div class="row" style="padding-left:5px">
	<div class="span5">
	  <a class="btn btn-primary"  onclick="javascript:action_extp('create.do','');">添加</a>
	</div>
	<#include "ajax_extp.ftl">
	
</div>
</body>
<#---->
<hr>
<footer>
	<p>&copy; Company 2013</p>
</footer>

