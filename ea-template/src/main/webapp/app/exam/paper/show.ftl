<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>paper.js"></script>
			<form name="form_item" action="exam_paper_save.do" metiod="post">
				<input type="hidden" name="method" value='save' />
				<input type="hidden" name="paper.id" value='<#if rhs["paper"]?exists >${rhs["paper"].id?if_exists }</#if>' />
				<div class="panel panel-primary">
				    <div class="panel-heading">
				    	<@i18n "menu_paper_new" />
				    </div>
					<div class="panel-body">
					 <table class="table table-condensed table-bordered table-striped">
						<tr>
							<td> <@i18n "title_name" /> </td>
							<td style="width:300px;" colspan="2"> <input type="text" name="paper.name" value="<#if rhs["paper"]?exists >${rhs["paper"].name?if_exists}</#if>" style="width:300px;"/></td>
							<td><@i18n "title_knowledge" /></td>
							<td>
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
							<td><@i18n "title_single" /></td>
							<td><@i18n "title_req" />:<input type="text" disabled name="paper.template.singlechoice" value="<#if rhs["paper"]?exists >${rhs["paper"].template.singlechoice}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_rmd" />:<input type="text" disabled name="paper.template.rmdsinglechoice" value="<#if rhs["paper"]?exists >${rhs["paper"].template.rmdsinglechoice}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_single_mark" /></td>
							<td><input type="text" name="paper.singlechoicemark" value="<#if rhs["paper"]?exists >${rhs["paper"].singlechoicemark?if_exists}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
						</tr>
						<tr>
							<td><@i18n "title_multi" /></td>
							<td><@i18n "title_req" />:<input type="text" disabled name="paper.template.multichoice" value="<#if rhs["paper"]?exists >${rhs["paper"].template.multichoice}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_rmd" />:<input type="text" disabled name="paper.template.rmdmultichoice" value="<#if rhs["paper"]?exists >${rhs["paper"].template.rmdmultichoice}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_multi_mark" /></td>
							<td><input type="text" name="paper.multichoicemark" value="<#if rhs["paper"]?exists >${rhs["paper"].multichoicemark?if_exists}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
						</tr>
						<tr>
							<td><@i18n "title_blank" /></td>
							<td><@i18n "title_req" />:<input type="text" disabled name="paper.template.blank" value="<#if rhs["paper"]?exists >${rhs["paper"].template.blank}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_rmd" />:<input type="text" disabled name="paper.template.rmdblank" value="<#if rhs["paper"]?exists >${rhs["paper"].template.rmdblank}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_blank_mark" /></td>
							<td><input type="text" name="paper.blankmark" value="<#if rhs["paper"]?exists >${rhs["paper"].blankmark?if_exists}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
						</tr>
						<tr>
							<td><@i18n "title_essay" /></td>
							<td><@i18n "title_req" />:<input type="text" disabled name="paper.template.essay" value="<#if rhs["paper"]?exists >${rhs["paper"].template.essay}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_rmd" />:<input type="text" disabled name="paper.template.rmdessay" value="<#if rhs["paper"]?exists >${rhs["paper"].template.rmdessay}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_essay_mark" /></td>
							<td><input type="text" name="paper.essaymark" value="<#if rhs["paper"]?exists >${rhs["paper"].essaymark?if_exists}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
						</tr>
						<tr>
							<td><@i18n "title_examtime" />(minutes)</td>
							<td colspan="2"><input type="text" name="paper.time" value="<#if rhs["paper"]?exists >${rhs["paper"].time}</#if>" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td> <@i18n "title_template" /></td>
							<td> <input type="text" disabled name="paper.template.title" value="<#if rhs["paper"]?exists >${rhs["paper"].template.title}</#if>"<td>
							<input type="hidden" value="<#if rhs["paper"]?exists >${rhs["paper"].template.id}</#if>" name="templateid"/>
						</tr>
						<tr>
							<td><@i18n "title_passmark" /></td>
							<td colspan="4"><input type="text" name="paper.passmark" value="<#if rhs["paper"]?exists >${rhs["paper"].passmark}</#if>" /></td>
						</tr>
						<tr>
							<td colspan="5" >
							    <input type="button" class="btn btn-xs btn-info" value="Save" id="submitButton"/>
							    <a  class="btn btn-xs btn-info" href="exam_paper_list.do">Return</a>
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
</script>