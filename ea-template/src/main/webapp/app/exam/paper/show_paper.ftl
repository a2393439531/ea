<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>paper.js"></script>
<script type="text/javascript" src="<@context_module/>template.js"></script>
			<form name="form_item" action="exam_paper_create.do" metiod="post">
				<input type="hidden" name="method" value='setpaper' />
				<input type="hidden" name="paper.id" value='<#if rhs["paper"]?exists >${rhs["paper"].id?if_exists }</#if>' />
				<#--<input type="hidden" value="<#if rhs["paper"]?exists >${rhs["paper"].template.id}</#if>" name="template.id"/>-->
				<input type="hidden" name="paperid" value='<#if rhs["paper"]?exists>${rhs["paper"].id}</#if>' />
				<div class="panel panel-primary">
				    <div class="panel-heading">
				    	<@i18n "menu_paper_new" />
				    </div>
					<div class="panel-body">
					 <table class="table table-condensed table-bordered table-striped">
						<tr>
							<td> <@i18n "title_name" /> </td>
							<td style="width:300px;"> <input type="text" name="paper.name" value="<#if rhs["paper"]?exists >${rhs["paper"].name?if_exists}</#if>" style="width:300px;"/></td>
							<td><@i18n "title_knowledge" /></td>
							<td colspan="2">
								<#list rhs["knowledgeRootList"] as knowledge>
									<#if knowledge.getChildKnowledges()?exists >
										<#list knowledge.getChildKnowledges() as knowledgenode>
											<input type="checkbox" name="knowledgevalue" value="${knowledgenode.id}" 
											<#if rhs["paper"]?exists && rhs["paper"].knowledge?exists >
												<#list rhs["paper"].knowledge as paperknowledge>
													<#if paperknowledge.id == knowledgenode.id> checked</#if>
												</#list>
											</#if>
											/>&nbsp;&nbsp;${knowledgenode.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</#list>
									</#if>
								</#list>
							</td>
						</tr>
						<tr>
							<#--<td><@i18n "title_single" /></td>
							<td><@i18n "title_req" />:<input type="text" disabled name="paper.template.singlechoice" value="<#if rhs["paper"]?exists >${rhs["paper"].template.singlechoice}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_rmd" />:<input type="text" disabled name="paper.template.rmdsinglechoice" value="<#if rhs["paper"]?exists >${rhs["paper"].template.rmdsinglechoice}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>-->
							<td><@i18n "title_single_mark" /></td>
							<td><input type="text" name="paper.singlechoicemark" onchange="javascript:counttotalmark();" id="singlechoicemark" value="<#if rhs["paper"]?exists >${rhs["paper"].singlechoicemark?if_exists}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_multi_mark" /></td>
							<td><input type="text" name="paper.multichoicemark" onchange="javascript:counttotalmark();" id="multichoicemark" value="<#if rhs["paper"]?exists >${rhs["paper"].multichoicemark?if_exists}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
						</tr>
						<tr>
							<td><@i18n "title_single_rmd" /></td>
							<td><input type="text" name="paper.rmdsinglechoice" onchange="javascript:counttotalmark();" id="rmdsinglechoice" value="<#if rhs["paper"]?exists >${rhs["paper"].rmdsinglechoice?if_exists}</#if>" id="rmdsinglechoice" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_multi_rmd" /></td>
							<td><input type="text" name="paper.rmdmultichoice" onchange="javascript:counttotalmark();" id="rmdmultichoice" value="<#if rhs["paper"]?exists >${rhs["paper"].rmdmultichoice?if_exists}</#if>" id="rmdmultichoice" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
						</tr>
						<#if rhs["paper"]?exists >
						<tr>
							<td><@i18n "title_single_req" /> <br/> <button onclick="javascript:additem(1,${rhs["paper"].id?if_exists });return false;" class="btn btn-xs btn-info"><@i18n "menu_item_new" /></button></td>
							<td >
								<div style="height:150px;overflow:auto;" id="reqsinglechoice">
									<#assign i = 0 />
									<#if rhs["paper"]?exists && rhs["paper"].items?exists>
										<#list rhs["paper"].items as item>
											<#if item.type == 1>
												<a href="#" onclick="javascript:ajax_show_item('exam_item_load.do','method=show&id=${item.id}');" >${item.content}</a><br/>
												<input type="hidden" name="reqsinglechoice" value="${item.id}">
												<#assign i = i + 1/>
											</#if>
										</#list>
										<input type="hidden" id="reqsinglechoicecount" value="${i}" />
									</#if>
								</div>
							</td>
							<td><@i18n "title_multi_req" /><br/> <button onclick="javascript:additem(2,${rhs["paper"].id?if_exists });return false;" class="btn btn-xs btn-info"><@i18n "menu_item_new" /></button></td>
							<td >
								<div style="height:150px;overflow:auto;" id="reqmultichoice">
									<#assign i = 0 />
									<#if rhs["paper"]?exists && rhs["paper"].items?exists>
										<#list rhs["paper"].items as item>
											<#if item.type == 2>
												<a href="#" onclick="javascript:ajax_show_item('exam_item_load.do','method=show&id=${item.id}');" >${item.content}</a><br/>
												<input type="hidden" name="reqmultichoice" value="${item.id}">
												<#assign i = i + 1/>
											</#if>
										</#list>
										<input type="hidden" id="reqmultichoicecount" value="${i}" />
									</#if>
								</div>
							</td>
						</tr>
						</#if>
						<tr>
							<#--<td><@i18n "title_blank" /></td>
							<td><@i18n "title_req" />:<input type="text" disabled name="paper.template.blank" value="<#if rhs["paper"]?exists >${rhs["paper"].template.blank}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_rmd" />:<input type="text" disabled name="paper.template.rmdblank" value="<#if rhs["paper"]?exists >${rhs["paper"].template.rmdblank}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>-->
							<td><@i18n "title_blank_mark" /></td>
							<td><input type="text" name="paper.blankmark" onchange="javascript:counttotalmark();" id="blankmark" value="<#if rhs["paper"]?exists >${rhs["paper"].blankmark?if_exists}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_essay_mark" /></td>
							<td><input type="text" name="paper.essaymark" onchange="javascript:counttotalmark();" id="essaymark" value="<#if rhs["paper"]?exists >${rhs["paper"].essaymark?if_exists}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
						</tr>
						<tr>
							<td><@i18n "title_blank_rmd" /></td>
							<td><input type="text" name="paper.rmdblank" onchange="javascript:counttotalmark();" id="rmdblank" value="<#if rhs["paper"]?exists >${rhs["paper"].rmdblank?if_exists}</#if>" id="trmdblank" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_essay_rmd" /></td>
							<td><input type="text" name="paper.rmdessay" onchange="javascript:counttotalmark();" id="rmdessay" value="<#if rhs["paper"]?exists >${rhs["paper"].rmdessay?if_exists}</#if>" id="rmdessay" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
						</tr>
						<#if rhs["paper"]?exists >
						<tr>
							<td><@i18n "title_blank_req" /><br/> <button onclick="javascript:additem(3,${rhs["paper"].id?if_exists });return false;" class="btn btn-xs btn-info"><@i18n "menu_item_new" /></button></td>
							<td >
								<div style="height:150px;overflow:auto;" id="reqblank">
								<#assign i = 0 />
									<#if rhs["paper"]?exists && rhs["paper"].items?exists>
										<#list rhs["paper"].items as item>
											<#if item.type == 3>
												<a href="#" onclick="javascript:ajax_show_item('exam_item_load.do','method=show&id=${item.id}');" >${item.content}</a><br/>
												<input type="hidden" name="reqblank" value="${item.id}">
												<#assign i = i + 1/>
											</#if>
										</#list>
										<input type="hidden" id="reqblankcount" value="${i}" />
									</#if>
								</div>
							</td>
							<td><@i18n "title_essay_req" /><br/> <button onclick="javascript:additem(4,${rhs["paper"].id?if_exists });return false;" class="btn btn-xs btn-info"><@i18n "menu_item_new" /></button></td>
							<td >
								<div style="height:150px;overflow:auto;" id="reqessay">
								<#assign i = 0 />
									<#if rhs["paper"]?exists && rhs["paper"].items?exists>
										<#list rhs["paper"].items as item>
											<#if item.type == 4>
												<a href="#" onclick="javascript:ajax_show_item('exam_item_load.do','method=show&id=${item.id}');" >${item.content}</a><br/>
												<input type="hidden" name="reqessay" value="${item.id}">
												<#assign i = i + 1/>
											</#if>
										</#list>
										<input type="hidden" id="reqessaycount" value="${i}" />
									</#if>
								</div>
							</td>
						</tr>
						</#if>
						<tr>
							<td><@i18n "title_examtime" />(minutes)</td>
							<td><input type="text" name="paper.time" value="<#if rhs["paper"]?exists >${rhs["paper"].time}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td> <@i18n "title_totalmark" /></td><#--<@i18n "title_template" />-->
							<td><input readonly type="text" id="totalmark" name="paper.totalmark" value="<#if rhs["paper"]?exists >${rhs["paper"].totalmark}</#if>" /></td><#-- <input type="text" disabled name="paper.template.title" value="<#if rhs["paper"]?exists >${rhs["paper"].template.title}</#if>" />-->
						</tr>
						<tr>
							<td><@i18n "title_passmark" /></td>
							<td colspan="3"><input type="text" name="paper.passmark" value="<#if rhs["paper"]?exists >${rhs["paper"].passmark}</#if>" /></td>
						</tr>
						<tr>
							<td colspan="4" >
							    <input type="button" class="btn btn-xs btn-info" value="Submit" id="submitButton"/>
							    <#--<a  class="btn btn-xs btn-info" href="exam_paper_list.do">Return</a>-->
							</td>
						</tr>
					</table>
					</div>
				</div>
			</form>
			<div id="div_scoll" style="margin-left:150px;margin-top:-350px; cursor:hander;position:absolute;width:400px;z-index:10000;display:none;" class="panel panel-default"><!--style="border:2px solid #eee;"-->
			 	<div id="operation_title" class="panel-heading"><strong>选择题目</strong></div>
			 	<a class="pull-right" onclick="show_dir();" class="btn btn-xs  btn-default" ><span class=ui-icon ui-icon-close></span></a>
			 	<div class="panel-body" id="div_select_item" style="cursor:hander;"> 
			 	
			 	</div>
			</div>
<script>
	$(function() {$( "#div_scoll" ).draggable();});  
	$('#submitButton').click(function () {
		var btn = $(this);
		btn.button('loading');
		$('#dialog').dialog('open');
		document.getElementsByName("form_item")[0].submit();
	});
	
	function  show_dir(){  //定位层
	  if( document.getElementById('div_scoll').style.display=='none'){
	  	document.getElementById('div_scoll').style.display='block';
	  }else{
	    document.getElementById('div_scoll').style.display='none';
	  }
	}
	function counttotalmark(){
		var singlechoice = parseInt($('#reqsinglechoicecount').val()) + parseInt($('#rmdsinglechoice').val());
		var multichoice = parseInt($('#reqmultichoicecount').val()) + parseInt($('#rmdmultichoice').val());
		var blank = parseInt($('#reqblankcount').val()) + parseInt($('#rmdblank').val());
		var essay = parseInt($('#reqessaycount').val()) + parseInt($('#rmdessay').val());
		var singlechoicemark = parseInt($('#singlechoicemark').val());
		var multichoicemark = parseInt($('#multichoicemark').val());
		var blankmark = parseInt($('#blankmark').val());
		var essaymark = parseInt($('#essaymark').val());
		var totalmark = singlechoice * singlechoicemark + multichoice * multichoicemark + blank * blankmark + essay * essaymark;
		$('#totalmark').val(totalmark);
	}
</script>