
<#include "../../../common/freemarker/include_header.ftl">
<script>
	function polling()
	{
		MyMar=setInterval("ajax_polling('common_monitor_push_ajax_jvm.do','')",2000);   //没1S轮询一次
		MyMar=setInterval("ajax_polling('common_monitor_push_ajax_database.do','')",2000);   //没1S轮询一次
	}
	function ajax_polling(url,para){
	  $.ajax({
	         type:"POST",
	         url: url,
	         data:para,
	         cache: false,
	         success: function(html){
	              if(url=='common_monitor_push_ajax_jvm.do')
	              document.getElementById('div_action_result_jvm').innerHTML=html;
	              if(url=='common_monitor_push_ajax_database.do')
	              document.getElementById('div_action_result_database').innerHTML=html;

	         }
	           
	  });  
	}	
</script>

<body style="padding:10px" onload="ajax_polling('common_monitor_push_ajax_jvm.do','');polling()">
<div class="alert alert-success">
系统上次启动时刻：${rhs["startTime"]?string("yyyy-MM-dd  HH:mm:ss")}  &nbsp;已经健康运行：${javacall["com.utils.time.TimeUtil"].compareDate(rhs["startTime"]?string("yyyy-MM-dd"),null,0)}天
</div> 
<span class="label label-primary">JVM虚拟机状态</span> 
 <a href="monitoring?part=heaphisto" target=_blank>内存详细监控</a>
 <a href="monitoring?action=gc" target=_blank>内存垃圾回收</a>
 <a href="monitoring?part=sessions" target=_blank>当前在线会话</a>

<div id=div_action_result_jvm></div>



<br><span class="label label-primary">数据库</span>
<span id=div_action_result_database>
<br>当前活动连接数：${rhs["database"].getNumActive()?if_exists}
<br>当前空闲连接数：${rhs["database"].getNumIdle()?if_exists}
</span>
<br>数据库名：${rhs["database"].getUrl()?if_exists}
<br>数据库驱动：${rhs["database"].getDriverClassName()?if_exists}
<br>用户名：${rhs["database"].getUsername()?if_exists}
<br>密码：${rhs["database"].getPassword()?if_exists}
<br>数据库配置文件${rhs["hashmap_system"]["database-filename"]}
<#--
<br>ValidationQuery：${rhs["database"].getValidationQuery()?if_exists}
-->
<br>最大活动连接数：${rhs["database"].getMaxActive()?if_exists}
<br>最大空闲连接数：${rhs["database"].getMaxIdle()?if_exists}

<br>getDefaultCatalog：${rhs["database"].getDefaultCatalog()?if_exists}
<br>是否自动提交：${rhs["database"].getDefaultAutoCommit()?string}
<#assign h =rhs["eaSessionFactory"].getAllClassMetadata()>
<#assign keys = h?keys>
<#list keys as key><br>${key_index}_${key} </#list>  
<br>

<span class="label label-primary">web应用相关数据</span> 

<br>webroot(ServletActionContext.getRequest.getRealPath):${rhs["web-root-path"]}
<br>应用名称和路径：${rhs["servlet_context"]}
<br>web服务器：${rhs["servlet_context"].getServerInfo()}
<br>getMinorVersion：${rhs["servlet_context"].getMinorVersion()}
<br>servletMajorVersion：${rhs["servlet_context"].getMajorVersion()}
<br>getContextPath：${rhs["servlet_context"].getContextPath()}[${rhs["servlet_context"].getServletContextName()?if_exists}]

<br> <a href="monitoring?part=web.xml" target=_blank>web.xml文件</a>


<br>
<span class="label label-primary">spring-bean ${rhs["spring_beans"]?size}个</span> 
<#list  rhs["spring_beans"] as bean>
  <br>${bean}
</#list> 

<br><span class="label label-primary">后台框架版本</span> <br>
<b>spring :</b>${rhs["hashmap_system"]["spring-version"]}
<br><b>hibernate :</b>${rhs["hashmap_system"]["hibernate-version"]}
<br><b>struts :</b>${rhs["hashmap_system"]["struts-version"]}
<br><b>freemarker :</b>${rhs["hashmap_system"]["freemarker-version"]}
<br><b>h2 :</b>${rhs["hashmap_system"]["h2-version"]}
<br><b>jetty :</b>${rhs["hashmap_system"]["jetty-version"]}
<br><b>servlet :</b>${rhs["hashmap_system"]["servlet-version"]}
<br><b>xml-sax-parser :</b>${rhs["hashmap_system"]["xml-sax-parser-version"]}
<br><b>类：:</b>${javacall["com.utils.path.Path"].Path.getLocation("com.app.common.base.action。LoginAction")}





<br><span class="label label-primary">JDK配置</span> <br>
<#if rhs["hashmap_system"]["java_home"]?exists>
<b>JAVA_HOME:</b> ${rhs["hashmap_system"]["java_home"]}
<#else>
	<#if rhs["hashmap_system"]["JAVA_HOME"]?exists>
	<b>JAVA_HOME:</b> ${rhs["hashmap_system"]["JAVA_HOME"]}
	</#if>
</#if>

<br><b>lib:</b>${rhs["hashmap_system"]["classpath"]}

<br><span class="label label-primary">系统属性</span> <br>
<#list rhs["hashmap_system"]?keys as k>
 <br>   ${k}: ${rhs["hashmap_system"][k]}
</#list>
</body>
<#--
<br>runtime.totalMemory:${rhs["runtime"].totalMemory()}
<br>runtime.freeMemory:${rhs["runtime"].freeMemory()}
<br>runtime.maxMemory:${rhs["runtime"].maxMemory()}
<hr>
-->