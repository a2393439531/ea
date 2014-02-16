
<script language="javascript">
	  
	function  checkimgfile(){
		var name = document.userRegedit.file.value;
		if (name.length == 0){
		alert("文件地址不能为空");
		return false;
	    }
		if(/^.+\.(gif|jpg|ico|png|bmp)$/i.test(name)){
			document.getElementById('bt-sure').disabled=false;
		}
		else{
			uploadPicForm.reset();
			alert("支持的图片文件格式：gif|jpg|ico|png|bmp");}
		return true;
	}	
</script>
<#include "../../../common/freemarker/include_header.ftl">
<body style="padding:10px">
<b>员工信息登记</b>
<br><br><b>1.擅长的技术领域</b> *必填项目选，可以选择多项
<br>				
	<#list rhs["organizelist"]  as organize>
		<#list organize.getRoles() as role>	
			  <input type="checkbox" />${role.name?if_exists}
			   
		</#list> 	        		    
	</#list>	
<br><br><b>2.详细资料</b>	
	
<table>
    <tr>
	    <td width=600 valign=top >
	     
	    	<form  name=userRegedit action="user_regeditSave.do" onsubmit="javascript:return send();" method="POST" enctype="multipart/form-data">
	    		<input  name="user.id" value="${rhs["user"].id?if_exists}" type="hidden"  />
				
				<input  name="user.passwd" value="${rhs["user"].passwd?if_exists}" type="hidden"  />
				<input  name="user.account" value="${rhs["user"].account?if_exists}" type="hidden"  />
				<input  name="user.imgfilename" value="${rhs["user"].imgfilename?if_exists} " type="hidden"  />
				<br>毕业日期<input  name="user.graduateDate" type="text"  value='${rhs["user"].graduateDate?if_exists}'  onClick="WdatePicker()"/>*
				入职日期<input  name="user.rollDate" type="text"  value='${rhs["user"].rollDate?if_exists}'  onClick="WdatePicker()"/>*
				
				<br><br>中文姓名 <input  name="user.name" value="${rhs["user"].name?if_exists}"  />

			
			

				<br>ERICSSON邮箱<input  name="user.email" style="width:300"   type="text"  value='${rhs["user"].email?if_exists}'  />
			    <br>ERICSSON用户ID<input  name="user.ericssonid" style="width:300"   type="text"  value='${rhs["user"].ericssonid?if_exists}'  /> GTC员工才需要填写
			    
			    <br> 母公司邮箱<input  name="user.email2" style="width:300"   type="text"  value='${rhs["user"].email2?if_exists}'  />
				<br>电话<input  name="user.phoneNumber" type="text"  value='${rhs["user"].phoneNumber?if_exists}'  />
				<br> 身份证号<input  name="user.identityCard" type="text"  value='${rhs["user"].identityCard?if_exists}'  />
				<br>QQ号<input  name="user.qq" type="text"  value='${rhs["user"].qq?if_exists}'  />
				<br>籍贯<input  name="user.home"  style="width:400"  type="text"  value='${rhs["user"].home?if_exists}'  />
			    <br>现住地址<input  name="user.address" style="width:400" type="text"  value='${rhs["user"].address?if_exists}'  />
				<br>职业认证证书<input  name="user.certification" style="width:400"  type="text"  value='${rhs["user"].certification?if_exists}'  />
				<br>性别
				<select  name="user.sex">
					<option value="${rhs["user"].sex?if_exists}">${rhs["user"].sex?if_exists}</option>
				  	<option value="男">男</option>
				  	<option value="女">女</option>
				</select>
				<br>生日<input  name="user.birthDate" type="text"  value='${rhs["user"].birthDate?if_exists}'  onClick="WdatePicker()"/>
				<br>项目经验
				<br><textarea rows="8" cols="90" name="user.experience"  title="简单描述，用什么技术做过哪些项目" >${rhs["user"].experience?if_exists}</textarea>
				<br>
			</td>
			<td valign=top>	
			    <br>上传个人照片，分辨率小于800×600大头照
			    <input class=input type="File" name="file" size=20 onChange="javascript:checkimgfile();">
		         &nbsp;&nbsp;
		         
		         <input  name="account" value="${rhs["user"].account?if_exists}" type="hidden"  />
	
				&nbsp;&nbsp;
		
			   
		
			  
		        </form>	
					        
				<#if (rhs["user"].imgfilename?exists)>
					<img with=300 height=400 src=/ea/file/photo/${rhs["user"].imgfilename?if_exists}  />
				</#if>	      
		</td>
		<tr><td  align=top colspan=2>
		        <br>
		        <p  align=center>
		         <input   id=bt-sure class=bt type="button"  onclick="javascript:userRegedit.submit();"     value="确定"> 
		        <p>
		         <br>
		</td></tr>
	</tr>
</table>
</body>
	