<#include "../../../common/freemarker/include_header.ftl">
<body id=result>
<form name="form_item" id="form_item" action="exam_exam_complete_task_single.do" method="post">
<input type="hidden" value="<#if rhs.examrecordId?exists >${rhs["examrecordId"]}</#if>" name="examrecordId" />
<input type="hidden" value="<#if rhs["task"]?exists >${rhs["task"].id}</#if>" name="taskId" />
<div class="panel panel-primary" style="margin-top: 18px;">
      <div class="panel-heading"><strong>Start Exam</strong></div>
      <div class="panel-body">
      	<table class="table table-condensed table-bordered table-striped">
      	<tr><td colspan="8"><font color="red"><strong>考试中请勿关闭浏览器，否则会导致考试失败</strong></font></td></tr>
      		<tr>
      			<td><strong><@i18n "title_name" /></strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].name}</#if></td>
      			<td><strong><@i18n "title_examtime" /></strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].time}</#if></td>
      			<td><strong><@i18n "title_totalmark" /></strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].totalmark}</#if></td>
      			<td><strong><@i18n "title_passmark" /></strong></td>
      			<td><#if rhs["paper"]?exists > ${rhs["paper"].passmark}</#if></td>
      		</tr>
      	</table>
  		<table class="table table-condensed table-bordered table-striped">
		  	<strong><@i18n "title_single" /></strong>(total:${rhs["paper"].singlechoice + rhs["paper"].rmdsinglechoice}, each: ${rhs["paper"].singlechoicemark})
					<tr>
						<td><strong>#.&nbsp;${rhs["item"].content}</strong></td>
					<tr>
					<#if rhs["item"].type == 1>
						<#list rhs["item"].getChoiceitem()?sort_by("id") as choiceitem>
							<tr>
								<td><input type="radio" value="${choiceitem.refid}" name="result[${rhs["index"]}].answer"/> ${choiceitem.value}</td>
							</tr>
						</#list>
						<input type="hidden" value="<#if rhs["item"].mark?exists >${rhs["item"].mark}<#else>${rhs["paper"].singlechoicemark}</#if>" name="result[${rhs["index"]}].mark" />
					</#if>
					<#if rhs["item"].type == 2>
						<#list rhs["item"].choiceitem?sort_by("id") as choiceitem>
							<tr>
								<td><input type="checkbox" value="${choiceitem.refid}" name="result[${rhs["index"]}].answer"/> ${choiceitem.value}</td>
							</tr>
						</#list>
						<input type="hidden" value="<#if rhs["item"].mark?exists >${rhs["item"].mark}<#else>${rhs["paper"].multichoicemark}</#if>" name="result[${rhs["index"]}].mark" />
					</#if>
					<#if rhs["item"].type == 3>
						<tr>
							<td><input type="text"  name="result[${rhs["index"]}].answer"/></td>
						</tr>
						<input type="hidden" value="<#if rhs["item"].mark?exists >${rhs["item"].mark}<#else>${rhs["paper"].blankmark}</#if>" name="result[${rhs["index"]}].mark" />
					</#if>
					<#if rhs["item"].type == 4>
						<tr>
							<td><textarea name="result[${rhs["index"]}].answer" style="width:400px;height:100px;"> </textarea></td>
						</tr>
						<input type="hidden" value="<#if rhs["item"].mark?exists >${rhs["item"].mark}<#else>${rhs["paper"].essaymark}</#if>" name="result[${rhs["index"]}].mark" />
					</#if>
				<input type="hidden" value="${rhs["item"].id}" name="result[${rhs["index"]}].item.id" />
				<input type="hidden" value="${rhs["index"]}" name="index" />
				<input type="hidden" value="${rhs["score"]?if_exists}" name="score" />
      	</table>
	    <table class="table table-condensed table-bordered table-striped">
	    	<tr>
      			<td><input type="button" class="btn btn-xs btn-info" value="Next" id="submitButton"/></td>
      		</tr>
	    </table>
      </div>
</div>
</form>
</body>
<script>
	$('#submitButton').click(function () {
		var btn = $(this);
		btn.button('loading');
		$.ajax({
                cache: true,
                type: "POST",
                url:"exam_exam_complete_task_single.do",
                data:$('#form_item').serialize(),// 你的formid
                async: true,
                error: function(request) {
                    alert("Connection error");
                },
                success: function(data) {
                    $("#result").html(data);
                }
            });
		//window.close();
	});
	$(document).ready(function(){

	});
	//document.oncontextmenu=function(){
    	//alert('禁止鼠标右键菜单!');
    	//return false;
	//}
	document.onkeydown=function(e){
	    e=e||event;
	    //alert(e.keyCode);//可查看各个按键的keyCode是多少
		//屏蔽F5刷新键
	    if(e.keyCode==116){
	        alert('禁止F5刷新!');
	        e.keyCode = 0;
	        return false;
	    }
		//屏蔽esc键
		if(e.keyCode == 27){
			alert('禁止ESC！');
			e.keyCode = 0;
			 return false;
		}
		//屏蔽alt
		if(e.keyCode == 18){
			alert('禁止ALT！');
			e.keyCode = 0;
			return false;
		}
		//屏蔽F11
		if(e.keyCode == 122){
			//alert('禁止F11！');
			e.keyCode = 0;
			return false;
		}
		if((e.ctrlKey)&&(e.keyCode==78)){
			alert('禁止Ctrl + N！');
			e.keyCode = 0;
			return false;
		}
	}
	//失去焦点后的动作
	//function c(){  
       // window.close();  
    //}
	//为窗口注册失去焦点事件  
    //window.onblur = c;
    
    //当关闭窗口时提示是否提交考试 
   // window.onbeforeunload = function()  {  
       // return "当前数据还没有保存，关闭、刷新或切换窗口会自动完成考试，是否继续?";       
    //}
    
    //窗口关闭后给出提示  
    window.onunload = function()  {
    	//document.getElementsByName("form_item")[0].submit();
        alert("已成功提交考试！");  
    }
</script>