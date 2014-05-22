<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>template.js"></script>
			<form name="form_item" action="exam_paper_create.do" metiod="post">
				<input type="hidden" name="method" value='setitem' />
				<input type="hidden" name="template.id" value='<#if rhs["template"]?exists >${rhs["template"].id?if_exists }</#if>' />
				<input type="hidden" name="paperid" value='<#if rhs["paper"]?exists>${rhs["paper"].id}</#if>' />
				<div class="panel panel-primary">
				    <div class="panel-heading">
				    	<@i18n "menu_template_new" />
				    </div>
					<div class="panel-body">
					 <table class="table table-condensed table-bordered table-striped">
						<tr>
							<td><@i18n "title_knowledge" /></td>
							<td>
								<#list rhs["knowledgeRootList"] as knowledge>
									<#if knowledge.getChildKnowledges()?exists >
										<#list knowledge.getChildKnowledges() as knowledgenode>
											<input type="checkbox" name="knowledgevalue" value="${knowledgenode.id}" 
											<#if rhs["template"]?exists >
												<#list rhs["template"].knowledge as templateknowledge>
													<#if templateknowledge.id == knowledgenode.id> checked</#if>
												</#list>
											</#if>
											/>&nbsp;&nbsp;${knowledgenode.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<#--onclick="javascript:addtemplatetotag(${knowledgenode.id});"-->
										</#list>
									</#if>
								</#list>
							</td>
							<td> </td>
							<td style="width:300px;"> </td>
							
						</tr>
						<tr>
							<td><@i18n "title_single_rmd" /></td>
							<td><input type="text" name="template.rmdsinglechoice" value="<#if rhs["template"]?exists >${rhs["template"].rmdsinglechoice?if_exists}</#if>" id="rmdsinglechoice" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_multi_rmd" /></td>
							<td><input type="text" name="template.rmdmultichoice" value="<#if rhs["template"]?exists >${rhs["template"].rmdmultichoice?if_exists}</#if>" id="rmdmultichoice" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
						</tr>
						<#if rhs["template"]?exists >
						<tr>
							<td><@i18n "title_single_req" /> <br/> <button onclick="javascript:additem(1,${rhs["template"].id?if_exists });return false;" class="btn btn-xs btn-info"><@i18n "menu_item_new" /></button></td>
							<td >
								<div style="height:150px;overflow:auto;" id="reqsinglechoice">
									<#if rhs["template"]?exists && rhs["template"].items?exists>
										<#list rhs["template"].items as item>
											<#if item.type == 1>
												<a href="#" onclick="javascript:ajax_show_item('exam_item_load.do','method=show&id=${item.id}');" >${item.content}</a><br/>
												<input type="hidden" name="reqsinglechoice" value="${item.id}">
											</#if>
										</#list>
									</#if>
								</div>
							</td>
							<td><@i18n "title_multi_req" /><br/> <button onclick="javascript:additem(2,${rhs["template"].id?if_exists });return false;" class="btn btn-xs btn-info"><@i18n "menu_item_new" /></button></td>
							<td >
								<div style="height:150px;overflow:auto;" id="reqmultichoice">
									<#if rhs["template"]?exists && rhs["template"].items?exists>
										<#list rhs["template"].items as item>
											<#if item.type == 2>
												<a href="#" onclick="javascript:ajax_show_item('exam_item_load.do','method=show&id=${item.id}');" >${item.content}</a><br/>
												<input type="hidden" name="reqmultichoice" value="${item.id}">
											</#if>
										</#list>
									</#if>
								</div>
							</td>
						</tr>
						</#if>
						<tr>
							<td><@i18n "title_blank_rmd" /></td>
							<td><input type="text" name="template.rmdblank" value="<#if rhs["template"]?exists >${rhs["template"].rmdblank?if_exists}</#if>" id="trmdblank" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
							<td><@i18n "title_essay_rmd" /></td>
							<td><input type="text" name="template.rmdessay" value="<#if rhs["template"]?exists >${rhs["template"].rmdessay?if_exists}</#if>" id="rmdessay" onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]}"/></td>
						</tr>
						<#if rhs["template"]?exists >
						<tr>
							<td><@i18n "title_blank_req" /><br/> <button onclick="javascript:additem(3,${rhs["template"].id?if_exists });return false;" class="btn btn-xs btn-info"><@i18n "menu_item_new" /></button></td>
							<td >
								<div style="height:150px;overflow:auto;" id="reqblank">
									<#if rhs["template"]?exists && rhs["template"].items?exists>
										<#list rhs["template"].items as item>
											<#if item.type == 3>
												<a href="#" onclick="javascript:ajax_show_item('exam_item_load.do','method=show&id=${item.id}');" >${item.content}</a><br/>
												<input type="hidden" name="reqblank" value="${item.id}">
											</#if>
										</#list>
									</#if>
								</div>
							</td>
							<td><@i18n "title_essay_req" /><br/> <button onclick="javascript:additem(4,${rhs["template"].id?if_exists });return false;" class="btn btn-xs btn-info"><@i18n "menu_item_new" /></button></td>
							<td >
								<div style="height:150px;overflow:auto;" id="reqessay">
									<#if rhs["template"]?exists && rhs["template"].items?exists>
										<#list rhs["template"].items as item>
											<#if item.type == 4>
												<a href="#" onclick="javascript:ajax_show_item('exam_item_load.do','method=show&id=${item.id}');" >${item.content}</a><br/>
												<input type="hidden" name="reqessay" value="${item.id}">
											</#if>
										</#list>
									</#if>
								</div>
							</td>
						</tr>
						</#if>
						<tr>
							<td colspan="4" >
							    <input type="button" class="btn btn-xs btn-info" value="Save" id="submitButton"/>
							    <#--<a  class="btn btn-xs btn-info" href="exam_template_list.do">Return</a>-->
							</td>
						</tr>
					</table>
					</div>
				</div>
			</form>
			<div id="div_scoll" style="margin-left:150px;margin-top:-350px; cursor:hander;position:absolute;width:400px;z-index:10000;display:none;" class="panel panel-default"><!--style="border:2px solid #eee;"-->
			 	<div id="operation_title" class="panel-heading"><strong><@i18n "title_select_item" /></strong></div>
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