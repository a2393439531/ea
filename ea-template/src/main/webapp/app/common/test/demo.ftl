<#include "../../../common/freemarker/include_header.ftl">
<#include "../../../common/freemarker/macro_demo.ftl">

<p>当前月收入情况</p>

收入明细
<@table ["日期","水费", "电费", "房费", " 网费", "押金"] ,3/>


支出明细
<@table ["日期","押金返还", "电视费", "水费", "电费","网费", "税","卫生费","配置购买"] ,4/>

