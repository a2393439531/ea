 window.location.reload();
  alert(document.getElementById('previewFrame').src);
    	<#--
		   	<a class="btn  btn-mini" onclick="window.location.reload();">关闭</a>
		   	-->
		   	
		   	
		   	总结一下，information.asp页面中某个函数的功能是让那个iframe重新加载。我验证了一下几种方法，原来不行的又行了。 
 
document.frames("refreshAlarm").location.reload(true); //ok
 document.frames("refreshAlarm").document.location.reload(true); //ok
 document.frames("refreshAlarm").document.location="/public/alarmsum.asp";//ok
 document.getElementById("refreshAlarm").src="/public/alarmsum.asp"; //ok
 document.frames("refreshAlarm").src="/public/alarmsum.asp"; //没变化，没动静
 