<#include "../../../common/freemarker/include_header.ftl">

<input type="hidden" value="<#if rhs.method?exists >${rhs["method"]}</#if>" name="method" />
<input type="hidden" value="<#if rhs["task"]?exists >${rhs["task"].id}</#if>" name="taskId" />
<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong>Template List</strong></div>
      <div class="panel-body">
      </div>
</div>