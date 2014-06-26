<#include "../../../common/freemarker/include_header.ftl">
<div  style="margin:10px">
	 <div class="panel panel-default">
	    <div class="panel-heading">
	      <h3 class="panel-title">邮件发送</h3>
	    </div>
	    <div class="panel-body">
	    	在我们系统中，发送邮件，有三种途径：
	    	<br/>
	    	<br/>
	    	<strong>1. 使用多线程发送。</strong>
	    		<pre>
1.1 使用infEa类里面的sendMailTheadBySmtpList方法。该方法详细参数如下：

	public void sendMailTheadBySmtpList(String title,String content, String mailaddress, String cc, String bcc, String[] filename);
	
	该方法不会返回发送状态。即发送者无法知道邮件是否发送成功。同时，需要注意，使用该方法前，需在系统中配置发送邮件服务器。
	    		</pre>
	    	<strong>2. 使用mail webservice发送。</strong>
	    		<pre>
2.1 邮件发送的webservice 地址为： <span class="label label-danger"><@context/>service/mail</span>
	
	该接口没有进行身份验证，同事目前请求的方式为 Get 方式， 可以通过浏览器直接请求，传递参数为maillist和content。当需要发送的为多人时，使用英文逗号分隔。
	
	或者通过restlet的java代码来进行调用：
	
	ClientResource client = new ClientResource("http://localhost:5051/demo/service/mail?maillist="+ mail + "&content=" + content);
	try {
			Representation result = client.get();
		} catch (ResourceException e) {
			e.printStackTrace();
	}
	同时注意，该webservice会返回传递的maillist的发送成功与否的状态。
	    		</pre>
	    	<strong>3. 使用sendmail方式直接发送</strong>
	    		<pre>
3.1 使用infEa类里面的sendMailBySmtpList方法。该方法详细参数如下：

	public Map< String, String> sendMailBySmtpList(String title,String content, String mailaddress, String cc, String bcc, String[] filename);
	
	和第一种方式相比，该方法会返回发送状态。同时，需要注意，使用该方法前，需在系统中配置发送邮件服务器。
	    		</pre>
	    </div>
	 </div>
</div>