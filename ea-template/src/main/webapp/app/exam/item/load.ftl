<#include "../../../common/freemarker/include_header.ftl">
			<form name="form_wo" action="exam_item_save.do" metiod="post">
				<div class="panel panel-primary">
				    <div class="panel-heading">
				    	<#if rhs.readonly?exists> 题目详情<#else>编辑题目</#if>
				    </div>
					<div class="panel-body">
				 	<table class="table table-condensed table-bordered table-striped">
				 		<input type="hidden" id="objectid" name="item.id" value='<#if rhs["item"]?exists>${rhs["item"].id?if_exists}</#if>' />
						<tr>
							<td>题目类型 </td>
							<td>
								<input type="radio" name="item.type" value="1" onclick="javascript:generateitem(1)" <#if rhs["item"].type == 1> checked</#if> <#if rhs.readonly>disabled</#if>/>单选
								<input type="radio" name="item.type" value="2" onclick="javascript:generateitem(2)" <#if rhs["item"].type == 2> checked</#if> <#if rhs.readonly>disabled</#if>/>多选
								<input type="radio" name="item.type" value="3" onclick="javascript:generateitem(3)" <#if rhs["item"].type == 3> checked</#if> <#if rhs.readonly>disabled</#if>/>填空
								<input type="radio" name="item.type" value="4" onclick="javascript:generateitem(4)" <#if rhs["item"].type == 4> checked</#if> <#if rhs.readonly>disabled</#if>/>主观
							</td>
						</tr>
						<tr>
							<td>题目内容</td>
							<td id="itemcontent">
								<#if rhs["item"].type == 1>
									<input class='input' style='width:400px;' type='text' name='item.content' value='${ rhs["item"].content}' <#if rhs.readonly>disabled</#if>/><br/>
									<#if !rhs.readonly>
										<button style='margin-top:6px;' class='btn btn-xs btn-info' onclick='javascript:addoption(1);return false;'>添加选项</button>
									</#if>
									<div id='choice' >
										<#list rhs["item"].choiceitem?sort_by("id") as choiceitems>
											<input type='radio' name='item.refkey' value='${choiceitems_index+1}' <#if rhs.readonly>disabled</#if><#if rhs["item"].refkey?number==choiceitems.refid> checked</#if> /><input style='margin-left:3px;' type='text' name='choiceitemvalue' value='${choiceitems.value}' <#if rhs.readonly>disabled</#if>/><br/>
											<input type="hidden" name="choiceitemid" value='${choiceitems.id}' />
										</#list>
									</div>
								</#if>
								<#if rhs["item"].type == 2>
									<input class='input' style='width:400px;' type='text' name='item.content' value='${ rhs["item"].content?if_exists}' <#if rhs.readonly>disabled</#if>/><br/>
									<#if !rhs.readonly>
										<button style='margin-top:6px;' class='btn btn-xs btn-info' onclick='javascript:addoption(1);return false;'>添加选项</button>
									</#if>
									<div id='choice' >
										<#list rhs["item"].choiceitem?sort_by("id") as choiceitems>
											<input type='checkbox' name='item.refkey' value='${choiceitems_index+1}' <#if rhs.readonly>disabled</#if><#list rhs["item"].refkey?split(",") as key><#if (key?trim)?number==choiceitems.refid> checked</#if> </#list>/><input style='margin-left:3px;' type='text' name='choiceitemvalue' value='${choiceitems.value?if_exists}' <#if rhs.readonly>disabled</#if>/><br/>
											<input type="hidden" name="choiceitemid" value='${choiceitems.id}' />
										</#list>
									</div>
								</#if>
								<#if rhs["item"].type == 3>
									<input class='input' style='width:400px;' type='text' value='${rhs["item"].content?if_exists}' name='item.content' <#if rhs.readonly>disabled</#if>/><br/>
									<div class='btn btn-xs btn-info'>参考答案<input class='input' style='width:340px;' type='text' value='${rhs["item"].refkey?if_exists}' name='item.refkey' <#if rhs.readonly>disabled</#if>/></div>
								</#if>
								<#if rhs["item"].type == 4>
									<textarea class='input' style='width:400px;height:100px' type='text' name='item.content' <#if rhs.readonly>disabled</#if> > ${rhs["item"].content?if_exists} </textarea><br/>
									<div class='btn btn-xs btn-info'>参考答案<input class='input' style='width:340px;' type='text' value='${rhs["item"].refkey?if_exists}' name='item.refkey' <#if rhs.readonly>disabled</#if>/></div>
								</#if>
							</td>
						</tr>
						
						<tr>
							<td>知识领域</td>
							<td>
								<#list rhs["knowledgeRootList"] as knowledge>
									<#if knowledge.getChildKnowledges()?exists >
										<#list knowledge.getChildKnowledges() as knowledgenode>
											<input type="checkbox" name="knowledgevalue" value="${knowledgenode.id}" 
											<#list rhs["item"].knowledge as itemknowledge>
												<#if itemknowledge.id == knowledgenode.id> checked</#if>
											</#list>
											<#if rhs.readonly>
												disabled
											</#if>
											/>&nbsp;&nbsp;${knowledgenode.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</#list>
									</#if>
								</#list>
							</td>
						</tr>
						<tr>
							<td colspan="2" >
								<#if !rhs.readonly>
								    <input type="button" class="btn btn-xs btn-info" value="Save" id="submitButton"/>
								</#if>
							    <a  class="btn btn-xs btn-info" href="exam_item_list.do">Return</a>
							</td>
						</tr>
					</table>
					</div>
				</div>
			</form>
<script>
	var option_input_num = 4;
	$('#submitButton').click(function () {
		var btn = $(this);
		btn.button('loading');
		$('#dialog').dialog('open');
		document.getElementsByName("form_wo")[0].submit();
	});
	
	
	function generateitem(type){
		option_input_num = 4;
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