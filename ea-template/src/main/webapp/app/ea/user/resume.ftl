<#include "../../../common/freemarker/include_header.ftl">
<body style="padding:10px">

<b>简历预览</b>

<div class="panel panel-default">
<div class="panel-heading">
	<h3 class="panel-title">基本资料</h3>
</div>
<div class="panel-body">
	 <table class="table table-bordered table-striped">

	 <tr>
	 <td>
	<table class="table table-bordered table-striped">
        <tbody>
        <tr>
            <td><strong>中文姓名 :</strong></td>
            <td>${rhs["user"].name?if_exists}</td>
            <td><strong>邮箱:</strong></td>
            <td>${rhs["user"].email?if_exists}</td>
          </tr>
         
          <tr>
            <td><strong>手机号码:</strong></td>
            <td>${rhs["user"].phoneNumber?if_exists}</td>
            <td><strong>QQ号:</strong></td>
            <td>${rhs["user"].qq?if_exists}</td>
          </tr>
          <tr>
            <td><strong>生日:</strong></td>
            <td>${rhs["user"].birthDate?if_exists}</td>
            <td><strong>毕业日期:</strong></td>
            <td>${rhs["user"].graduateDate?if_exists}</td>
          </tr>
          <tr>
            <td><strong>入职日期:</strong></td>
            <td>${rhs["user"].rollDate?if_exists}</td>
            
          </tr>
          </tbody>
      </table>
	 </td>
	 <td width=120px valign=top>
		  <#if  rhs["user"].imgfilename?exists&&rhs["user"].imgfilename!='' ><br><img style="width:100px; height:120px" src="<@context/>file/photo/${rhs["user"].imgfilename?if_exists}" />   
		  <#else> <br><img style="width:100px; height:120px" src="<@context/>common/images/face.jpg" />   
		  </#if>
	 </td>
	 </tr>
	 </table>
</div>
</div>
	    
<td width=300px valign=top>
	<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">擅长的技术领域:</h3>
	</div>
	<div class="panel-body">
		计算机
	</div>
	</div> 
</td>		         
    
<td width=300px valign=top>
	<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">项目经验：</h3>
	</div>
	<div class="panel-body">
		${rhs["user"].experience?if_exists}
	</div>
	</div> 
</td>

<td width=300px valign=top>
	<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">日常工作：</h3>
	</div>
	<div class="panel-body">
		${rhs["user"].positiondescription?if_exists}
	</div>
	</div> 
</td>
    