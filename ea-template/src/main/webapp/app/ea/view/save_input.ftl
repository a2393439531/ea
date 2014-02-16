<#include "../../../common/freemarker/include_header.ftl">
<form action="../../../ea_view_save.do" method="post">
  <input name=t id=t type=hidden value="${RequestParameters["t"]}">
  <input name=id id=id type=hidden value="${RequestParameters["id"]}">
        架构图名称<input name=name id=name value=""></input><input type="submit" value="&nbsp;&nbsp;保&nbsp;&nbsp;&nbsp;存&nbsp;&nbsp;&nbsp;" />
</form>