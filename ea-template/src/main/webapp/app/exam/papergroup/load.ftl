<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>papergroup.js"></script>
			<form name="form_item" action="exam_papergroup_save.do" metiod="post">
				<input type="hidden" name="method" value='edit' />
				<input type="hidden" name="papergroup.id" value='<#if rhs["papergroup"]?exists >${rhs["papergroup"].id?if_exists }</#if>' />
				<div class="panel panel-primary">
				    <div class="panel-heading">
				    	<@i18n "menu_papergroup_view" />
				    </div>
					<div class="panel-body">
					 <table class="table table-condensed table-bordered table-striped">
						<tr>
							<td> <@i18n "title_name" /> </td>
							<td > <input type="text" <#if rhs.readonly>disabled</#if> name="papergroup.name" value="<#if rhs["papergroup"]?exists >${rhs["papergroup"].name?if_exists}</#if>" style="width:300px;"/></td>
						</tr>
						<tr>
							<td><@i18n "title_paper" /> <br/> 
								<button <#if rhs.readonly>disabled</#if> onclick="javascript:addpaper(${rhs["papergroup"].id?if_exists });return false;" class="btn btn-xs btn-info"><@i18n "menu_paper_new" /></button>
							</td>
							<td>
								<div style="height:150px;overflow:auto;" id="paperid">
									<#if rhs["papergroup"].getPapers()?exists>
										<#list rhs["papergroup"].getPapers()?sort_by("id") as paper>
												<a href="#" onclick="javascript:ajax_show_paper('exam_paper_load.do','method=show&id=${paper.id}');" >${paper.name}</a><br/>
												<input type="hidden" name="paperid" value="${paper.id}">
										</#list>
									</#if>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" >
							    <#if !rhs.readonly>
								    <input type="button" class="btn btn-xs btn-info" value="Save" id="submitButton"/>
								</#if>
							    <a  class="btn btn-xs btn-info" href="exam_papergroup_list.do">Return</a>
							</td>
						</tr>
					</table>
					</div>
				</div>
			</form>
			<div id="div_scoll" style="margin-left:150px;margin-top:-250px; cursor:hander;position:absolute;width:400px;z-index:10000;display:none;" class="panel panel-default"><!--style="border:2px solid #eee;"-->
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