
<#include "../../../common/freemarker/include_header.ftl">
<#include "../../../common/freemarker/include_select_users.ftl">

<div  style="margin:10px">
	 <div class="panel panel-default">
	    <div class="panel-heading">
	      <h3 class="panel-title">Web Service 调用规则</h3>
	    </div>
	    <div class="panel-body">
			1. 首先我们的Web Service的接口地址为：<span class="label label-danger"><@context/>service/</span>
			<br/>
			<br/>
			2. 根据安全的需要，调用我们的Web Service需要验证，现对验证进行说明：
			<pre>2.1 如果直接在浏览器中对我们的Web Service进行Get请求，我们首先会对当前用户进行验证，是否登录？
    如果否，则会跳转到登录页面在进行相关操作。演示方式：点击下面的按钮<button class="btn btn-xs btn-primary" onclick="javascript:demo('./service/management/tables','')">演示</button>(查询当前部署的工作流)

2.2 如果是进行远端的Web Service调用，同样需要对调用发起者进行验证，即需要调用者把用户名和密码进行base 64位加密，然后放入Post或者Get请求的头部信息中，发送给我们的Web Service。
    <button class="btn btn-xs btn-primary" onclick="javascript:showdemo()">演示</button>(查询指定用户所被分配的任务)
	<div style="display:none" id="demo" border="1px solid">
 a) 拿到base 64位加密字符串
  用户名:<input type="text" value="" id="username"/> 密码:<input type="password" value="" id="password"/> <button class="btn btn-xs btn-primary" onclick="javascript:getCode()">获得base 64位加密字符串</button><span id="code">code: ${rhs["BASE_64_CODE"]?if_exists}</span><br/>
 b) 向Web Service 发送请求
 <button class="btn btn-xs btn-primary" onclick="javascript:sendRequest()">查询用户的task</button>
 <br/> c) 向web service发送请求，上传一个文件，请求地址：/upload
<form id="upload_form" action="./service/upload" method="post" enctype="multipart/form-data"><input type="file" name="uploadfile" />
<button class="btn btn-xs btn-primary" onclick="javascript:document.getElementById('upload_form').submit()">发送Upload请求</button>
</form>
	</div>	
			</pre>
	 	<div class="panel panel-default">
	    	<div class="panel-heading">
	      	<h3 class="panel-title">结果显示</h3>
	    	</div>
	    	<div class="panel-body" id="result">
			
	    	</div>
	 	</div>
			<br/>
			3. JAVA后台调用的例子(Restlet):
			<pre>
public static void testClient() {
	Request request = new Request(Method.GET,"http://localhost:8080/demo/service/management/tables");

	ChallengeScheme scheme = ChallengeScheme.HTTP_BASIC;

	ChallengeResponse authentication = new ChallengeResponse(scheme,"hongbin", "abc1231");
	request.setChallengeResponse(authentication);

	Client client = new Client(Protocol.HTTP);
	Response response = client.handle(request);
	if (response.getStatus().isSuccess()) {
		try {
			response.getEntity().write(System.out);
		} catch (IOException e) {
			e.printStackTrace();
		}
	} else if (response.getStatus().equals(Status.CLIENT_ERROR_UNAUTHORIZED)) {
		System.out.println("Access authorized by the server, "+ "check your credentials");
	} else {
		System.out.println("An unexpected status was returned: "+ response.getStatus());
	}
}
			</pre>
	    </div>
	 </div>
</div>
<script language="javascript">
//var REST_URL = "http://localhost:8081/demo/service/";
function demo(url,para){ 
  $.ajax({
         type:"GET",
         url: url,
         data: para,
         cache: false,
         dataType : 'html',
         success: function(html){
         	$("#result").html(html);
         },
         error:function(XmlHttpRequest,textStatus, errorThrown)
  		{
  			$("#result").text(XmlHttpRequest.responseText);
  		}
  });  
}

function showdemo(){
	$("#demo").attr('style','display:block');

}

function getCode(){
	var username=$("#username").val();
	var password=$("#password").val();
	
	$.ajax({
         type:"POST",
         url: 'ea_ea_webservice_code.do',
         data: 'username=' + username + '&password=' + password,
         cache: false,
         dataType : 'html',
         success: function(html){
         	$("#code").text(html);
         }
  }); 
}

function sendRequest(){
	var username=$("#username").val();
	var basiccode=$("#code").text();
		$.ajax({
         type:"GET",
         url: './service/runtime/tasks',
         data: '',
         cache: false,
         beforeSend : function(xhr) {
				xhr.setRequestHeader('Authorization', basiccode);
		 },
         dataType : 'html',
         success: function(html){
         	$("#result").text(html);
         },
         error:function(XmlHttpRequest,textStatus, errorThrown)
  		{
  			$("#result").text(XmlHttpRequest.responseText);
  		}
  	});
}

function sendUploadRequest(){
	var basiccode=$("#code").text();
	$.ajax({
         type:"GET",
         url: './service/upload',
         data: '',
         cache: false,
         contentType: false,
         processData: false,
         beforeSend : function(xhr) {
				xhr.setRequestHeader('Authorization', basiccode);
		 },
         dataType : 'html',
         success: function(html){
         	$("#result").text(html);
         },
         error:function(XmlHttpRequest,textStatus, errorThrown)
  		{
  			$("#result").text(XmlHttpRequest.responseText);
  		}
  	});
}
</script>