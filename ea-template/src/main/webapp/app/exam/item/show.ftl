<#include "../../../common/freemarker/include_header.ftl">
			<form name="form_item" action="exam_item_save.do?method=show" metiod="post">
				<div class="panel panel-primary">
				    <div class="panel-heading">
				    	添加题目
				    </div>
					<div class="panel-body">
				 <table class="table table-condensed table-bordered table-striped">
					<tr>
						<td>题目类型 </td>
						<td>
							<input type="radio" name="item.type" value="1" onclick="javascript:generateitem(1)"/>单选
							<input type="radio" name="item.type" value="2" onclick="javascript:generateitem(2)"/>多选
							<input type="radio" name="item.type" value="3" onclick="javascript:generateitem(3)"/>填空
							<input type="radio" name="item.type" value="4" onclick="javascript:generateitem(4)"/>主观
						</td>
					</tr>
					<tr>
						<td>题目内容</td>
						<td id="itemcontent">
						</td>
					</tr>
					
					<tr>
						<td>知识领域</td>
						<td>
							<#list rhs["knowledgeRootList"] as knowledge>
								<#if knowledge.getChildKnowledges()?exists >
									<#list knowledge.getChildKnowledges() as knowledgenode>
										<input type="checkbox" name="knowledgevalue" value="${knowledgenode.id}" />&nbsp;&nbsp;${knowledgenode.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</#list>
								</#if>
							</#list>
						</td>
					</tr>
					<tr>
						<td colspan="2" >
						    <input type="button" class="btn btn-xs btn-info" value="Save" id="submitButton"/>
						    <a  class="btn btn-xs btn-info" href="exam_item_list.do">Return</a>
						</td>
					</tr>
				</table>
				</div>
				</div>
			</form>
<script>
	$('#submitButton').click(function () {
		var btn = $(this);
		btn.button('loading');
		$('#dialog').dialog('open');
		document.getElementsByName("form_item")[0].submit();
	});
	
	
	function generateitem(type){
		switch(type){
			case 1:
				$("#itemcontent").html("<input class='input' style='width:400px;' type='text' value='' name='item.content' /><br/><button style='margin-top:6px;' class='btn btn-xs btn-info' onclick='javascript:addoption(1);return false;'>添加选项</button><div id='choice' ><input type='radio' name='item.refkey' value='1'/><input style='margin-left:3px;' type='text' name='choiceitemvalue' /><br/><input type='radio' value='2' name='item.refkey' /><input type='text' style='margin-left:3px;' name='choiceitemvalue' /><br/><input type='radio' value='3' name='item.refkey' /><input style='margin-left:3px;' type='text' name='choiceitemvalue' /><br/><input type='radio'  value='4' name='item.refkey' /><input style='margin-left:3px;' type='text' name='choiceitemvalue' /><br/></div>");
				break;
			case 2:
				$("#itemcontent").html("<input class='input' style='width:400px;' type='text' value='' name='item.content' /><br/><button style='margin-top:6px;' class='btn btn-xs btn-info' onclick='javascript:addoption(2);return false;'>添加选项</button><div id='choice' ><input type='checkbox' name='item.refkey' value='1'/><input style='margin-left:3px;' type='text' name='choiceitemvalue' /><br/><input type='checkbox' value='2' name='item.refkey' /><input type='text' style='margin-left:3px;' name='choiceitemvalue' /><br/><input type='checkbox' value='3' name='item.refkey' /><input style='margin-left:3px;' type='text' name='choiceitemvalue' /><br/><input type='checkbox' value='4' name='item.refkey' /><input style='margin-left:3px;' type='text' name='choiceitemvalue' /><br/></div>");
				break;
			case 3:
				$("#itemcontent").html("<input class='input' style='width:400px;' type='text' value='' name='item.content' /><br/><div class='btn btn-xs btn-info'>参考答案<input class='input' style='width:340px;' type='text' value='' name='item.refkey' /></div>");
				break;
			case 4:
				$("#itemcontent").html("<textarea class='input' style='width:400px;height:100px' type='text' value='' name='item.content' /><br/><div class='btn btn-xs btn-info'>参考答案<input class='input' style='width:340px;' type='text' value='' name='item.refkey' /></div>");
				break;	
		}
	}
	
	var option_input_num = 4;
	function addoption(type){
		option_input_num += 1;
		var content = $("#choice").html();
		switch(type){
			case 1:
				$("#choice").html(content + "<input type='radio' name='item.refkey' value='"+ option_input_num +"'/><input style='margin-left:3px;' type='text' name='choiceitemvalue' /><br/>");
				break;
				
			case 2:
				$("#choice").html(content + "<input type='checkbox' name='item.refkey' value='"+ option_input_num +"'/><input style='margin-left:3px;' type='text' name='choiceitemvalue' /><br/>");
				break;
		
		}
		
		
	
	}
	
	$(function(){
		$('#dialog').dialog({
			autoOpen: false,
			modal: true,
			width: 400
		});
	});
</script>