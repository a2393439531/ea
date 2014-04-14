<#include "../../../common/freemarker/include_header.ftl">
<script type="text/javascript" src="<@context_module/>paper.js"></script>
			<form name="form_item" action="exam_paper_save.do" metiod="post">
				<input type="hidden" name="method" value='choicetemplate' />
				<input type="hidden" name="paper.id" value='<#if rhs["paper"]?exists >${rhs["paper"].id?if_exists }</#if>' />
				<div class="panel panel-primary">
				    <div class="panel-heading">
				    	<@i18n "title_select_template" />
				    </div>
					<div class="panel-body">
					 <table class="table table-condensed table-bordered table-striped">
						<tr>
							<td><@i18n "title_template" /></td>
							<td>
								<select value="模板" name="templateid" style="width:300px;">
									<#list rhs["dataList"]?sort_by("id") as x>
										<option value="${x.id}">${x.title}</option>
					 				</#list>
								</select>
								<a style="margin-left:10px;margin-top:5px;" class="btn btn-xs btn-info "  href="exam_template_list.do"><@i18n "menu_template" /></a>
							</td>
						</tr>
						<tr>
							<td colspan="2" >
							    <input type="button" class="btn btn-xs btn-info" value="Save" id="submitButton"/>
							    <a  class="btn btn-xs btn-info" href="exam_paper_list.do">Return</a>
							</td>
						</tr>
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