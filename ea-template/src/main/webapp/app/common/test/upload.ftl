
<#include "../../../common/freemarker/include_header.ftl">
<#include "../uploadfile/macro_uploadfile.ftl"/>
<@uploadfile 'demo_1' ,'activiti', ''/>
<br>demo说明：
上传到了webapp/file/activiti文件夹下


<pre>

设计关键点：

1.系统的文件保存表  OA_UPLOADFILE 
ID   FILEDESCRIPTION   FILENAME   FILETYPE   FOREIGNID   URL
---------------------------------------------------------------------------------------------------
1     SDR.bpmn          SDR.bpmn    bpmn       demo_1    file/activiti/1.368585329398821E12.bpmn    

<pre>




<form class="well form-search">
        <input type="text" class="input-medium search-query">
        <button type="submit" class="btn">搜索</button>
</form>