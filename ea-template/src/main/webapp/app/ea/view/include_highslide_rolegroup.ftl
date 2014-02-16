<span style="color:green">【岗位说明】</span>
<#list rhs["rolegrouplist"] as rolegroup>
	<#if rolegroup.positiondescription?exists&&rolegroup.positiondescription!=''>
	<a href="#" onclick="return hs.htmlExpand(this, { contentId: 'rolegroupid_${rolegroup.id?if_exists}' } )" class="highslide"> ${rolegroup.name}</a>
	</#if>
</#list>
<#list rhs["rolegrouplist"] as rolegroup>
	<#if rolegroup.positiondescription?exists&&rolegroup.positiondescription!=''>
		<div class="highslide-html-content" id="rolegroupid_${rolegroup.id?if_exists}">
			<div class="highslide-header">
				<ul>
					<li class="highslide-move">${rolegroup.name?if_exists}
						<a href="#" onclick="return false"></a>
					</li>
				</ul>
			</div>
			<div class="highslide-body">
			     <br>
			     ${rolegroup.positiondescription?if_exists}<br>
			</div>
		    <div class="highslide-footer">
		        <div>
		            <span class="highslide-resize" title="Resize">
		            </span>
		        </div>
		    </div>
		</div>
	</#if>
</#list>
